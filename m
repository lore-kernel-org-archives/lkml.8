Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62FBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD21E20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGJDWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:22:05 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbgGJDWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:22:05 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FDB4283E771936722A9;
        Fri, 10 Jul 2020 11:22:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 10 Jul
 2020 11:21:57 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
CC:     Daeho Jeong <daehojeong@google.com>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200710021505.2405872-1-daeho43@gmail.com>
 <20200710030246.GA545837@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <62c9dd7a-5d18-8bb6-8e43-c055fcff51cc@huawei.com>
Date:   Fri, 10 Jul 2020 11:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200710030246.GA545837@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/10 11:02, Jaegeuk Kim wrote:
> On 07/10, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
>>  1. Added -1 value support for range.len to signify the end of file.
>>  2. If the end of the range passes over the end of file, it means until
>>     the end of file.
>>  3. ignored the case of that range.len is zero to prevent the function
>>     from making end_addr zero and triggering different behaviour of
>>     the function.
>>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>> ---
>>  fs/f2fs/file.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 368c80f8e2a1..1c4601f99326 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
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
>> -	}
>> -	end_addr = range.start + range.len;
>> +	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
>> +		end_addr = inode->i_size;

We can remove 'range.len == (u64)-1' condition since later condition can cover
this?

> 
> Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for

The blocks beyond i_size will never be written, there won't be any valid message
there, so we don't need to worry about that.

Thanks,

> ending criteria?
> 
>> +	else
>> +		end_addr = range.start + range.len;
>>  
>>  	to_end = (end_addr == inode->i_size);
>>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
>> -- 
>> 2.27.0.383.g050319c2ae-goog
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
