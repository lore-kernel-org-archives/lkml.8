Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB498C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6075206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAODnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:43:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:50257 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgAODnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:43:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 19:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,321,1574150400"; 
   d="scan'208";a="273519332"
Received: from unknown (HELO [10.239.161.118]) ([10.239.161.118])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2020 19:43:20 -0800
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <8f9acfb3-28e0-8d3e-08e0-77f04410cf38@linux.intel.com>
Date:   Wed, 15 Jan 2020 11:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/14 23:40, Vineeth Remanan Pillai wrote:
> On Mon, Jan 13, 2020 at 8:12 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> 
>> I also encountered kernel panic with the v4 code when taking cpu offline or online
>> when core scheduler is running.  I've refreshed the previous patch, along
>> with 3 other patches to fix problems related to CPU online/offline.
>>
>> As a side effect of the fix, each core can now operate in core-scheduling
>> mode or non core-scheduling mode, depending on how many online SMT threads it has.
>>
>> Vineet, are you guys planning to refresh v4 and update it to v5?  Aubrey posted
>> a port to the latest kernel earlier.
>>
> Thanks for the updated patch Tim.
> 
> We have been testing with v4 rebased on 5.4.8 as RC kernels had given us
> trouble in the past. v5 is due soon and we are planning to release v5 when
> 5.5 comes out. As of now, v5 has your crash fixes and Aubrey's changes
> related to load balancing.

It turns out my load balancing related changes need to be refined.
For example, we don't migrate task if the task's core cookie does not match
with CPU's core cookie, but if the entire core is idle, we should allow task
migration, something like the following:

I plan to do this after my Chinese New Year holiday(Feb 3rd).

Thanks,
-Aubrey

----------------------------------------------------------------------------------
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4728f5e..75e0172 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7366,8 +7366,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 3) running (obviously), or
-	 * 4) are cache-hot on their current CPU.
+	 * 3) task's cookie does not match with this CPU's core cookie
+	 * 4) running (obviously), or
+	 * 5) are cache-hot on their current CPU.
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
@@ -7402,6 +7403,25 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	if (sched_core_enabled(cpu_rq(env->dst_cpu))) {
+		bool idle_core = true;
+		int cpu;
+
+		for_each_cpu(cpu, cpu_smt_mask(env->dst_cpu)) {
+			if (!available_idle_cpu(cpu))
+				idle_core = false;
+		}
+		/*
+		 * Don't migrate task if task's cookie does not match
+		 * with core cookie, unless the entire core is idle.
+		 */
+		if (!idle_core && p->core_cookie !=
+		    cpu_rq(env->dst_cpu)->core->core_cookie)
+			return 0;
+	}
+#endif
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-- 
2.7.4
