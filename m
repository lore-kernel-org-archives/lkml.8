Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3892242C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgGNMgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:36:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbgGNMgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:36:40 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E489B6DA7482A55E837A;
        Tue, 14 Jul 2020 20:36:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 14 Jul
 2020 20:36:32 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change the way of handling range.len
 in F2FS_IOC_SEC_TRIM_FILE
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
CC:     Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200713031252.3873546-1-daeho43@gmail.com>
 <20200713181152.GC2910046@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com>
Date:   Tue, 14 Jul 2020 20:36:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200713181152.GC2910046@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/14 2:11, Jaegeuk Kim wrote:
> Hi Daeho,
> 
> Please take a look at this.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=35245180459aebf6d70fde88a538f0400a794aa6

I'm curious about what will happen if we call
sec_trim_file(F2FS_TRIM_FILE_ZEROOUT) on an encrypted file, will
it use zero bits covering encrypted data on disk?

Thanks,

> 
> Thanks,
> 
> On 07/13, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>>  1. Added -1 value support for range.len to secure trim the whole blocks
>>     starting from range.start regardless of i_size.
>>  2. If the end of the range passes over the end of file, it means until
>>     the end of file (i_size).
>>  3. ignored the case of that range.len is zero to prevent the function
>>     from making end_addr zero and triggering different behaviour of
>>     the function.
>>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> ---
>> Changes in v2:
>>  - Changed -1 range.len option to mean the whole blocks starting from
>>    range.start regardless of i_size
>> ---
>>  fs/f2fs/file.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 368c80f8e2a1..2485841e3b2d 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3792,7 +3792,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>  	pgoff_t index, pg_end;
>>  	block_t prev_block = 0, len = 0;
>>  	loff_t end_addr;
>> -	bool to_end;
>> +	bool to_end = false;
>>  	int ret = 0;
>>  
>>  	if (!(filp->f_mode & FMODE_WRITE))
>> @@ -3813,23 +3813,23 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>  	file_start_write(filp);
>>  	inode_lock(inode);
>>  
>> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
>> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
>> +			range.start >= inode->i_size) {
>>  		ret = -EINVAL;
>>  		goto err;
>>  	}
>>  
>> -	if (range.start >= inode->i_size) {
>> -		ret = -EINVAL;
>> +	if (range.len == 0)
>>  		goto err;
>> -	}
>>  
>> -	if (inode->i_size - range.start < range.len) {
>> -		ret = -E2BIG;
>> -		goto err;
>> +	if (inode->i_size - range.start > range.len) {
>> +		end_addr = range.start + range.len;
>> +	} else {
>> +		end_addr = range.len == (u64)-1 ?
>> +			sbi->sb->s_maxbytes : inode->i_size;
>> +		to_end = true;
>>  	}
>> -	end_addr = range.start + range.len;
>>  
>> -	to_end = (end_addr == inode->i_size);
>>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
>>  			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
>>  		ret = -EINVAL;
>> @@ -3846,7 +3846,8 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>  
>> -	ret = filemap_write_and_wait_range(mapping, range.start, end_addr - 1);
>> +	ret = filemap_write_and_wait_range(mapping, range.start,
>> +			to_end ? LLONG_MAX : end_addr - 1);
>>  	if (ret)
>>  		goto out;
>>  
>> -- 
>> 2.27.0.383.g050319c2ae-goog
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
