Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF20C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FF320774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCWCTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:19:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbgCWCTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:19:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 725CCD8523A1F9EF112E;
        Mon, 23 Mar 2020 10:19:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 10:19:44 +0800
Subject: Re: [PATCH v3] f2fs: fix potential .flags overflow on 32bit
 architecture
To:     Joe Perches <joe@perches.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200323012519.41536-1-yuchao0@huawei.com>
 <ed37a2a18060f71accb202c05724c0b66d0aa9f7.camel@perches.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <68bc1967-8772-d04a-1209-d919bf122f9f@huawei.com>
Date:   Mon, 23 Mar 2020 10:19:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ed37a2a18060f71accb202c05724c0b66d0aa9f7.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/23 10:00, Joe Perches wrote:
> On Mon, 2020-03-23 at 09:25 +0800, Chao Yu wrote:
>> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
>> in 32bit architecture, since we introduced FI_MMAP_FILE flag
>> when we support data compression, we may access memory cross
>> the border of .flags field, corrupting .i_sem field, result in
>> below deadlock.
>>
>> To fix this issue, let's expand .flags as an array to grab enough
>> space to store new flags.
> []
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> []
>> @@ -2586,22 +2590,28 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>>  	}
>>  }
>>  
>> +static inline void __set_inode_flag(struct inode *inode, int flag)
>> +{
>> +	test_and_set_bit(flag % BITS_PER_LONG,
>> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> I believe this should just use
> 
> 	test_and_set_bit(flag, F2FS_I(inode)->flags);
> 
>>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>>  {
>> -	return test_bit(flag, &F2FS_I(inode)->flags);
>> +	return test_bit(flag % BITS_PER_LONG,
>> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> here too.
> 
> 	test_bit(flag, F2FS_I(inode)->flags);
> 
>>  static inline void clear_inode_flag(struct inode *inode, int flag)
>>  {
>> -	if (test_bit(flag, &F2FS_I(inode)->flags))
>> -		clear_bit(flag, &F2FS_I(inode)->flags);
>> +	test_and_clear_bit(flag % BITS_PER_LONG,
>> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> 
> and here.

My bad, Ondřej Jirman also reminded me this issue, will fix this soon.

Thanks,

> 
> I also don't know why these functions are used at all.
> 
> 
> .
> 
