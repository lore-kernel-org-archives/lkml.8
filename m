Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF19FC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A875520774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCWCLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:11:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbgCWCLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:11:08 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 977822BEDAB46AD93768;
        Mon, 23 Mar 2020 10:09:52 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 10:09:49 +0800
Subject: Re: [PATCH v3] f2fs: fix potential .flags overflow on 32bit
 architecture
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>, <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200323012519.41536-1-yuchao0@huawei.com>
 <20200323015036.pniupuucfl3dug4m@core.my.home>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1d861a2e-0045-af0c-1f5b-c45b774c83f6@huawei.com>
Date:   Mon, 23 Mar 2020 10:09:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200323015036.pniupuucfl3dug4m@core.my.home>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ondřej,

On 2020/3/23 9:50, Ondřej Jirman wrote:
> Hello Chao Yu,
> 
> On Mon, Mar 23, 2020 at 09:25:19AM +0800, Chao Yu wrote:
>> [snip]
>>  
>> +static inline void __set_inode_flag(struct inode *inode, int flag)
>> +{
>> +	test_and_set_bit(flag % BITS_PER_LONG,
>> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> This can simply be:
> 
>     test_and_set_bit(flag, F2FS_I(inode)->flags);
> 
> all of these bitmap manipulation functions already will do the
> right thing to access the correct location in the flags array:
> 
>   https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bitops/atomic.h#L32
> 
> see BIT_MASK and BIT_WORD use in that function.

Oops, most f2fs bitmap check uses the same form, I missed this case....

> 
>> +}
>> +
>>  static inline void set_inode_flag(struct inode *inode, int flag)
>>  {
>> -	if (!test_bit(flag, &F2FS_I(inode)->flags))
>> -		set_bit(flag, &F2FS_I(inode)->flags);
>> +	__set_inode_flag(inode, flag);
>>  	__mark_inode_dirty_flag(inode, flag, true);
>>  }
>>  
>>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>>  {
>> -	return test_bit(flag, &F2FS_I(inode)->flags);
>> +	return test_bit(flag % BITS_PER_LONG,
>> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> ditto
> 
>>  }
>>  
>>  static inline void clear_inode_flag(struct inode *inode, int flag)
>>  {
>> -	if (test_bit(flag, &F2FS_I(inode)->flags))
>> -		clear_bit(flag, &F2FS_I(inode)->flags);
>> +	test_and_clear_bit(flag % BITS_PER_LONG,
>> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> ditto
> 
> I'm going to test the patch. It looks like that this was really
> the root cause of all those locking issues I was seeing on my
> 32-bit tablet. It seems to explain why my 64-bit systems were
> not affected, and why reverting compession fixed it too.
> Great job figuring this out.
> 
> I'll let you know soon.

Great, hoping this patch can fix the issue this time.

Thanks anyway for supporting on troubleshooting this issue.

Thanks,

> 
> thank you and regards,
> 	o.
> 
>>  	__mark_inode_dirty_flag(inode, flag, false);
>>  }
>>  
> .
> 
