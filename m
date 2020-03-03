Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2163D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgCCMG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:06:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729061AbgCCMG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:06:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0E6F5C8ACCE3BF70899;
        Tue,  3 Mar 2020 20:06:23 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 20:06:22 +0800
Subject: Re: [PATCH 1/2] f2fs: Fix mount failure due to SPO after a successful
 online resize FS
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1582799978-22277-1-git-send-email-stummala@codeaurora.org>
 <c39e0cf1-dbb1-5f60-50b5-e0eb246782bc@huawei.com>
 <20200302043948.GE20234@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4d228adb-7038-1c03-e877-93221b920104@huawei.com>
Date:   Tue, 3 Mar 2020 20:06:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200302043948.GE20234@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sahitya,

On 2020/3/2 12:39, Sahitya Tummala wrote:
> Hi Chao,
> 
> On Fri, Feb 28, 2020 at 04:35:37PM +0800, Chao Yu wrote:
>> Hi Sahitya,
>>
>> Good catch.
>>
>> On 2020/2/27 18:39, Sahitya Tummala wrote:
>>> Even though online resize is successfully done, a SPO immediately
>>> after resize, still causes below error in the next mount.
>>>
>>> [   11.294650] F2FS-fs (sda8): Wrong user_block_count: 2233856
>>> [   11.300272] F2FS-fs (sda8): Failed to get valid F2FS checkpoint
>>>
>>> This is because after FS metadata is updated in update_fs_metadata()
>>> if the SBI_IS_DIRTY is not dirty, then CP will not be done to reflect
>>> the new user_block_count.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>  fs/f2fs/gc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index a92fa49..a14a75f 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -1577,6 +1577,7 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>>>  
>>>  	update_fs_metadata(sbi, -secs);
>>>  	clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
>>
>> Need a barrier here to keep order in between above code and set_sbi_flag(DIRTY)?
> 
> I don't think a barrier will help here. Let us say there is a another context
> doing CP already, then it races with update_fs_metadata(), so it may or may not
> see the resize updates and it will also clear the SBI_IS_DIRTY flag set by resize
> (even with a barrier).

I agreed, actually, we didn't consider race condition in between CP and
update_fs_metadata(), it should be fixed.

> 
> I think we need to synchronize this with CP context, so that these resize changes
> will be reflected properly. Please see the new diff below and help with the review.
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a14a75f..5554af8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1467,6 +1467,7 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>         long long user_block_count =
>                                 le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
> 
> +       clear_sbi_flag(sbi, SBI_IS_DIRTY);

Why clear dirty flag here?

And why not use cp_mutex to protect update_fs_metadata() in error path of
f2fs_sync_fs() below?

>         SM_I(sbi)->segment_count = (int)SM_I(sbi)->segment_count + segs;
>         MAIN_SEGS(sbi) = (int)MAIN_SEGS(sbi) + segs;
>         FREE_I(sbi)->free_sections = (int)FREE_I(sbi)->free_sections + secs;
> @@ -1575,9 +1576,12 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
>                 goto out;
>         }
> 
> +       mutex_lock(&sbi->cp_mutex);
>         update_fs_metadata(sbi, -secs);
>         clear_sbi_flag(sbi, SBI_IS_RESIZEFS);
>         set_sbi_flag(sbi, SBI_IS_DIRTY);
> +       mutex_unlock(&sbi->cp_mutex);
> +
>         err = f2fs_sync_fs(sbi->sb, 1);
>         if (err) {
>                 update_fs_metadata(sbi, secs);

		  ^^^^^^^^^^^^^^

In addition, I found that we missed to use sb_lock to protect f2fs_super_block
fields update, will submit a patch for that.

Thanks,

> 
> thanks,
> 
>>
>>> +	set_sbi_flag(sbi, SBI_IS_DIRTY);
>>>  	err = f2fs_sync_fs(sbi->sb, 1);
>>>  	if (err) {
>>>  		update_fs_metadata(sbi, secs);
>>
>> Do we need to add clear_sbi_flag(, SBI_IS_DIRTY) into update_fs_metadata(), so above
>> path can be covered as well?
>>
>> Thanks,
>>
>>>
> 
