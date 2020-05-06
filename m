Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E985C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1978F206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEFGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:48:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3858 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727812AbgEFGsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:48:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42B22F69CB94B7516A49;
        Wed,  6 May 2020 14:48:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 May 2020
 14:48:19 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant check in
 f2fs_force_buffered_io
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200504143538.159967-1-jaegeuk@kernel.org>
 <b18c4be5-b56d-6b6e-3f99-d2fe05d330eb@kernel.org>
 <20200505032358.GA136485@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3b13c020-74a2-d351-15a8-261f6901b3da@huawei.com>
Date:   Wed, 6 May 2020 14:48:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200505032358.GA136485@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/5 11:23, Jaegeuk Kim wrote:
> On 05/05, Chao Yu wrote:
>> On 2020-5-4 22:35, Jaegeuk Kim wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> We already checked whether the file is compressed or not in
>>> f2fs_post_read_required(). So removed f2fs_compressed_file()
>>> in f2fs_force_buffered_io().
>>
>> Agreed, since I have sent similar patch before:
>>
>> https://lkml.org/lkml/2020/3/24/1819
> 
> Heh, as I couldn't find yours, I was actually waiting for you to point out. :)

Well, all patches sent to f2fs mailing list have been archived in
lore.kernel.org/linux-f2fs-devel. :)

https://lore.kernel.org/linux-f2fs-devel/20200229104906.12061-1-yuchao0@huawei.com/

> 
>>
>> Just want to know what's the change of backport concern now.
> 
> Old ICE support had to decouple f2fs_post_read_required() and
> f2fs_forced_buffered_io(). Now, I decide to manage this as we

Copied.

> need to manage this for one kernel version only.

Okay, thanks for the explanation.

Thanks,

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/f2fs.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 6b7b963641696..01a00fc808361 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -4064,8 +4064,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>>>  		return true;
>>>  	if (f2fs_is_multi_device(sbi))
>>>  		return true;
>>> -	if (f2fs_compressed_file(inode))
>>> -		return true;
>>>  	/*
>>>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>>>  	 * all IOs can be serialized by log-structured write.
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
