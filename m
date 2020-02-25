Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5003C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C5B2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 02:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBYCYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 21:24:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728776AbgBYCYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 21:24:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C865638C72DDFA78731F;
        Tue, 25 Feb 2020 10:24:20 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Feb
 2020 10:24:17 +0800
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: skip migration only when BG_GC is
 called
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
 <20200214185855.217360-3-jaegeuk@kernel.org>
 <9c497f3e-3399-e4a6-f81c-6c4a1f35e5bb@huawei.com>
 <20200218232714.GB10213@google.com>
 <117a927f-7128-b5a1-a961-22934bb62ec5@huawei.com>
 <20200219030425.GA102063@google.com>
 <266f233b-e084-cccd-d07e-96d8438d5b74@huawei.com>
 <20200224215341.GB77839@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <141fb1b0-b527-1ef8-0fce-dcdf0170a987@huawei.com>
Date:   Tue, 25 Feb 2020 10:24:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200224215341.GB77839@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/25 5:53, Jaegeuk Kim wrote:
> On 02/19, Chao Yu wrote:
>> On 2020/2/19 11:04, Jaegeuk Kim wrote:
>>> On 02/19, Chao Yu wrote:
>>>> On 2020/2/19 7:27, Jaegeuk Kim wrote:
>>>>> On 02/17, Chao Yu wrote:
>>>>>> On 2020/2/15 2:58, Jaegeuk Kim wrote:
>>>>>>> FG_GC needs to move entire section more quickly.
>>>>>>>
>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>> ---
>>>>>>>  fs/f2fs/gc.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>>>>>> index bbf4db3f6bb4..1676eebc8c8b 100644
>>>>>>> --- a/fs/f2fs/gc.c
>>>>>>> +++ b/fs/f2fs/gc.c
>>>>>>> @@ -1203,7 +1203,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>>>>>>>  
>>>>>>>  		if (get_valid_blocks(sbi, segno, false) == 0)
>>>>>>>  			goto freed;
>>>>>>> -		if (__is_large_section(sbi) &&
>>>>>>> +		if (gc_type == BG_GC && __is_large_section(sbi) &&
>>>>>>>  				migrated >= sbi->migration_granularity)
>>>>>>
>>>>>> I knew migrating one large section is a more efficient way, but this can
>>>>>> increase long-tail latency of f2fs_balance_fs() occasionally, especially in
>>>>>> extreme fragmented space.
>>>>>
>>>>> FG_GC requires to wait for whole section migration which shows the entire
>>>>> latency.
>>>>
>>>> That will cause long-tail latency for single f2fs_balance_fs() procedure,
>>>> which it looks a very long hang when userspace call f2fs syscall, so why
>>>> not splitting total elapsed time into several f2fs_balance_fs() to avoid that.
>>>
>>> Then, other ops can easily make more dirty segments. The intention of FG_GC is
>>
>> Yup, that's a problem, if there are more dirty datas being made, reserved segments
>> may be ran out during FG_GC.
>>
>>> to block everything and make min. free segments as a best shot.
>>
>> I just try to simulate write GC's logic in FTL to mitigate single op's max latency,
>> otherwise benchmark looks hang during FG_GC (in a 500mb+ section).

Oh, if we want to FG_GC only migrate on segment on time, it needs to change
has_not_enough_free_secs() condition as well, so previous logic is broken.

Nvm, please add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> 
> Hmm, I think we may need to think another way like doing BG_GC more aggressively.

Agreed, I guess SMR scenario may need such policy: higher trigger frequency on bggc
when free space decreases, but less block migration for each bggc cycle.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>  			goto skip;
>>>>>>>  		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
>>>>>>>
>>>>> .
>>>>>
>>> .
>>>
> .
> 
