Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD3C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58368206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgCKWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:04:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63006 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgCKWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:04:44 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02BM4PjA051123;
        Thu, 12 Mar 2020 07:04:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Thu, 12 Mar 2020 07:04:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02BM4K9b051090
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 12 Mar 2020 07:04:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com>
 <7a6170fc-b247-e327-321a-b99fb53f552d@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003111235080.171292@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
Date:   Thu, 12 Mar 2020 07:04:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003111235080.171292@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/12 4:38, David Rientjes wrote:
> On Wed, 11 Mar 2020, Tetsuo Handa wrote:
> 
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>>>>>  		unsigned long reclaimed;
>>>>>  		unsigned long scanned;
>>>>>  
>>>>> +		cond_resched();
>>>>> +
>>>>
>>>> Is this safe for CONFIG_PREEMPTION case? If current thread has realtime priority,
>>>> can we guarantee that the OOM victim (well, the OOM reaper kernel thread rather
>>>> than the OOM victim ?) gets scheduled?
>>>>
>>>
>>> I think it's the best we can do that immediately solves the issue unless 
>>> you have another idea in mind?
>>
>> "schedule_timeout_killable(1) outside of oom_lock" or "the OOM reaper grabs oom_lock
>> so that allocating threads guarantee that the OOM reaper gets scheduled" or "direct OOM
>> reaping so that allocating threads guarantee that some memory is reclaimed".
>>
> 
> The cond_resched() here is needed if the iteration is lengthy depending on 
> the number of descendant memcgs already.

No. cond_resched() here will become no-op if CONFIG_PREEMPTION=y and current
thread has realtime priority.

> 
> schedule_timeout_killable(1) does not make any guarantees that current 
> will be scheduled after the victim or oom_reaper on UP systems.

The point of schedule_timeout_*(1) is to guarantee that current thread
will yield CPU to other threads even if CONFIG_PREEMPTION=y and current
thread has realtime priority case. There is no guarantee that current
thread will be rescheduled immediately after a sleep is irrelevant.

> 
> If you have an alternate patch to try, we can test it.  But since this 
> cond_resched() is needed anyway, I'm not sure it will change the result.

schedule_timeout_killable(1) is an alternate patch to try; I don't think
that this cond_resched() is needed anyway.

> 
>>>
>>>>>  		switch (mem_cgroup_protected(target_memcg, memcg)) {
>>>>>  		case MEMCG_PROT_MIN:
>>>>>  			/*
>>>>>
>>>>
>>
>>
