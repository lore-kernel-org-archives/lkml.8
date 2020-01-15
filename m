Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3147BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F132081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgAOJSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:18:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgAOJSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:18:46 -0500
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00F9IWri066843;
        Wed, 15 Jan 2020 18:18:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Wed, 15 Jan 2020 18:18:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00F9ISbV066781
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 15 Jan 2020 18:18:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [patch] mm, oom: dump stack of victim when reaping failed
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com>
 <20200115084336.GW19428@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <9a7cbbf0-4283-f932-e422-84b4fb42a055@I-love.SAKURA.ne.jp>
Date:   Wed, 15 Jan 2020 18:18:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115084336.GW19428@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/15 17:43, Michal Hocko wrote:
> On Tue 14-01-20 15:20:04, David Rientjes wrote:
>> When a process cannot be oom reaped, for whatever reason, currently the
>> list of locks that are held is currently dumped to the kernel log.
>>
>> Much more interesting is the stack trace of the victim that cannot be
>> reaped.  If the stack trace is dumped, we have the ability to find
>> related occurrences in the same kernel code and hopefully solve the
>> issue that is making it wedged.
>>
>> Dump the stack trace when a process fails to be oom reaped.
> 
> Yes, this is really helpful.

tsk would be a thread group leader, but the thread which got stuck is not
always a thread group leader. Maybe dump all threads in that thread group
without PF_EXITING (or something) ?

> 
>> Signed-off-by: David Rientjes <rientjes@google.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
> 
>> ---
>>  mm/oom_kill.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/sched/mm.h>
>>  #include <linux/sched/coredump.h>
>>  #include <linux/sched/task.h>
>> +#include <linux/sched/debug.h>
>>  #include <linux/swap.h>
>>  #include <linux/timex.h>
>>  #include <linux/jiffies.h>
>> @@ -620,6 +621,7 @@ static void oom_reap_task(struct task_struct *tsk)
>>  
>>  	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
>>  		task_pid_nr(tsk), tsk->comm);
>> +	sched_show_task(tsk);
>>  	debug_show_all_locks();
>>  
>>  done:
> 

