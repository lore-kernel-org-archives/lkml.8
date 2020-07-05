Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F06C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE922074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGEXoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 19:44:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:35071 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728021AbgGEXoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 19:44:55 -0400
IronPort-SDR: eRqrtfPlf1exqTUAjpOD0L+BFZPV9xL8nanIIHX62MdxMrkhrKL+nFdUyq8ATtIvN/Tc2EchMD
 jI0KlKe1WE/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="165402034"
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="scan'208";a="165402034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 16:44:54 -0700
IronPort-SDR: EXnZ3l8P3mrB8AxI48ilizlUWIleNGX89YxkKgIp6dNblRFr8jiYZN+7mOjjDTw1q1lKkJvTVE
 HVOx3RnsiL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="scan'208";a="282873598"
Received: from ivillega-mobl.amr.corp.intel.com (HELO schen9-mobl.amr.corp.intel.com) ([10.254.12.154])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2020 16:44:52 -0700
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and
 scheduling.
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        mingo@kernel.org, fweisbec@gmail.com, keescook@chromium.org,
        kerrnel@google.com, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>, paulmck@kernel.org
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
 <200c81ef-c961-dcd5-1221-84897c459b05@linux.intel.com>
 <20200702125757.GB439212@google.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <0fd27cfd-4fe3-9b33-c583-45e6e71e18b7@linux.intel.com>
Date:   Sun, 5 Jul 2020 16:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200702125757.GB439212@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/20 5:57 AM, Joel Fernandes wrote:
> On Wed, Jul 01, 2020 at 05:54:11PM -0700, Tim Chen wrote:
>>
>>
>> On 7/1/20 4:28 PM, Joel Fernandes wrote:
>>> On Tue, Jun 30, 2020 at 09:32:27PM +0000, Vineeth Remanan Pillai wrote:
>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>
>>>> Instead of only selecting a local task, select a task for all SMT
>>>> siblings for every reschedule on the core (irrespective which logical
>>>> CPU does the reschedule).
>>>>
>>>> There could be races in core scheduler where a CPU is trying to pick
>>>> a task for its sibling in core scheduler, when that CPU has just been
>>>> offlined.  We should not schedule any tasks on the CPU in this case.
>>>> Return an idle task in pick_next_task for this situation.
>>>>
>>>> NOTE: there is still potential for siblings rivalry.
>>>> NOTE: this is far too complicated; but thus far I've failed to
>>>>       simplify it further.
>>>>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
>>>> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
>>>> Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
>>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>>
>>> Hi Peter, Tim, all, the below patch fixes the hotplug issue described in the
>>> below patch's Link tag. Patch description below describes the issues fixed
>>> and it applies on top of this patch.
>>>
>>> ------8<----------
>>>
>>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>> Subject: [PATCH] sched: Fix CPU hotplug causing crashes in task selection logic
>>>
>>> The selection logic does not run correctly if the current CPU is not in the
>>> cpu_smt_mask (which it is not because the CPU is offlined when the stopper
>>> finishes running and needs to switch to idle).  There are also other issues
>>> fixed by the patch I think such as: if some other sibling set core_pick to
>>> something, however the selection logic on current cpu resets it before
>>> selecting. In this case, we need to run the task selection logic again to
>>> make sure it picks something if there is something to run. It might end up
>>> picking the wrong task.  Yet another issue was, if the stopper thread is an
> 
> "It might end up picking the wrong task" needs to be: "We might end up
> picking a different task but that's Ok".
> 
>>> unconstrained pick, then rq->core_pick is set. The next time task selection
>>> logic runs when stopper needs to switch to idle, the current CPU is not in
>>> the smt_mask. This causes the previous ->core_pick to be picked again which
>>> happens to be the unconstrained task! so the stopper keeps getting selected
>>> forever.
>>>
>>> That and there are a few more safe guards and checks around checking/setting
>>> rq->core_pick. To test it, I ran rcutorture and made it tag all torture
>>> threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
>>> issue. Now it runs for an hour or so without issue. (Torture testing debug
>>> changes: https://bit.ly/38htfqK ).
>>>
>>> Various fixes were tried causing varying degrees of crashes.  Finally I found
>>> that it is easiest to just add current CPU to the smt_mask's copy always.
>>> This is so that task selection logic always runs on the current CPU which
>>> called schedule().
>>
>>
>> It looks good to me. 
> 
> Thank you for your review! Could I add your Reviewed-by tag to the patch?
> 

Sure.

Tim
