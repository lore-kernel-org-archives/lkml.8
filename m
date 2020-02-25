Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F798C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F067320656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgBYGKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:10:15 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgBYGKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:10:15 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 647837751992D0EB2F3D;
        Tue, 25 Feb 2020 14:10:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Feb
 2020 14:10:06 +0800
Subject: Re: [PATCH 3/3] f2fs: avoid unneeded barrier in do_checkpoint()
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200218102136.32150-1-yuchao0@huawei.com>
 <20200218102136.32150-3-yuchao0@huawei.com>
 <20200219025154.GB96609@google.com>
 <576f8389-ba27-b461-5466-cc62e84b5c92@huawei.com>
 <20200224220031.GC77839@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b4c4f60f-ada5-55c9-7d16-45cecad4d433@huawei.com>
Date:   Tue, 25 Feb 2020 14:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200224220031.GC77839@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/25 6:00, Jaegeuk Kim wrote:
> On 02/19, Chao Yu wrote:
>> On 2020/2/19 10:51, Jaegeuk Kim wrote:
>>> On 02/18, Chao Yu wrote:
>>>> We don't need to wait all dirty page submitting IO twice,
>>>> remove unneeded wait step.
>>>
>>> What happens if checkpoint and other meta writs are reordered?
>>
>> checkpoint can be done as following:
>>
>> 1. All meta except last cp-park of checkpoint area.
>> 2. last cp-park of checkpoint area
>>
>> So we only need to keep barrier in between step 1 and 2, we don't need
>> to care about the write order of meta in step 1, right?
> 
> Ah, let me integrate this patch into Sahitya's patch.>
> f2fs: fix the panic in do_checkpoint()

No problem.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/checkpoint.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 751815cb4c2b..9c88fb3d255a 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -1384,8 +1384,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>>>  
>>>>  	/* Flush all the NAT/SIT pages */
>>>>  	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>>> -	/* Wait for all dirty meta pages to be submitted for IO */
>>>> -	f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META);
>>>>  
>>>>  	/*
>>>>  	 * modify checkpoint
>>>> -- 
>>>> 2.18.0.rc1
>>> .
>>>
> .
> 
