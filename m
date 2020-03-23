Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6198C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846C820732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCWDWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:22:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbgCWDWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:22:20 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4129B9EA7CDED3C0FD5D;
        Mon, 23 Mar 2020 11:22:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 11:22:02 +0800
Subject: Re: [PATCH v4] f2fs: fix potential .flags overflow on 32bit
 architecture
To:     Joe Perches <joe@perches.com>, <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200323024109.60967-1-yuchao0@huawei.com>
 <8d435607bd79f518bd9420d68894ddda521bac5a.camel@perches.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aaa065c4-5c15-38a1-f2ea-73b4226fb203@huawei.com>
Date:   Mon, 23 Mar 2020 11:22:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8d435607bd79f518bd9420d68894ddda521bac5a.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/23 10:57, Joe Perches wrote:
> On Mon, 2020-03-23 at 10:41 +0800, Chao Yu wrote:
>> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
>> in 32bit architecture, since we introduced FI_MMAP_FILE flag
>> when we support data compression, we may access memory cross
>> the border of .flags field, corrupting .i_sem field, result in
>> below deadlock.
> []
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> []
>> @@ -682,6 +682,47 @@ enum {
> []
>> +/* used for f2fs_inode_info->flags */
>> +enum {
> []
>> +	FI_MAX,			/* max flag, never be used */
>> +};
>> +
>> +/* f2fs_inode_info.flags array size */
>> +#define FI_ARRAY_SIZE		(BITS_TO_LONGS(FI_MAX))
> 
> Perhaps FI_ARRAY_SIZE isn't necessary.
> 
>> +
>>  struct f2fs_inode_info {
>>  	struct inode vfs_inode;		/* serve a vfs inode */
>>  	unsigned long i_flags;		/* keep an inode flags for ioctl */
>> @@ -694,7 +735,7 @@ struct f2fs_inode_info {
>>  	umode_t i_acl_mode;		/* keep file acl mode temporarily */
>>  
>>  	/* Use below internally in f2fs*/
>> -	unsigned long flags;		/* use to pass per-file flags */
>> +	unsigned long flags[FI_ARRAY_SIZE];	/* use to pass per-file flags */
> 
> and BITS_TO_LONGS should be used here.
> 
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> []
>> @@ -362,7 +363,8 @@ static int do_read_inode(struct inode *inode)
>>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>>  	if (S_ISREG(inode->i_mode))
>>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
>> -	fi->flags = 0;
>> +	for (i = 0; i < FI_ARRAY_SIZE; i++)
>> +		fi->flags[i] = 0;
> 
> And this could become
> 
> 	bitmap_zero(fi->flags, BITS_TO_LONG(FI_MAX));
> 
> Is FI_ARRAY_SIZE used anywhere else?

Updated in v5, thanks.

Thanks,

> 
> .
> 
