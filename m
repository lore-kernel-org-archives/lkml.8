Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D87C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A534C20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGJMTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:19:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:42024 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:19:33 -0400
IronPort-SDR: r5V7AY1Ez+IZjKMK49C0ydTMZeo3YD6IR0pohmyKhTVIWVl6giHbKhWVhOtXhQs/6XsRnzFCBB
 keg/7vO/Ut8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213073204"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="213073204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 05:19:32 -0700
IronPort-SDR: R8IRRN7fc1v9hVSd2D1kzUJdeV3EX7GTQ+he1aBMQLevX97oAj/5h5jSQ+qxg808IkMPa0GQxx
 3ahXZAr9gW0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="298417723"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2020 05:19:25 -0700
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
Date:   Fri, 10 Jul 2020 20:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel/Vineeth,

On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> With current core scheduling patchset, non-threaded IRQ and softirq
> victims can leak data from its hyperthread to a sibling hyperthread
> running an attacker.
> 
> For MDS, it is possible for the IRQ and softirq handlers to leak data to
> either host or guest attackers. For L1TF, it is possible to leak to
> guest attackers. There is no possible mitigation involving flushing of
> buffers to avoid this since the execution of attacker and victims happen
> concurrently on 2 or more HTs.
> 
> The solution in this patch is to monitor the outer-most core-wide
> irq_enter() and irq_exit() executed by any sibling. In between these
> two, we mark the core to be in a special core-wide IRQ state.
> 
> In the IRQ entry, if we detect that the sibling is running untrusted
> code, we send a reschedule IPI so that the sibling transitions through
> the sibling's irq_exit() to do any waiting there, till the IRQ being
> protected finishes.
> 
> We also monitor the per-CPU outer-most irq_exit(). If during the per-cpu
> outer-most irq_exit(), the core is still in the special core-wide IRQ
> state, we perform a busy-wait till the core exits this state. This
> combination of per-cpu and core-wide IRQ states helps to handle any
> combination of irq_entry()s and irq_exit()s happening on all of the
> siblings of the core in any order.
> 
> Lastly, we also check in the schedule loop if we are about to schedule
> an untrusted process while the core is in such a state. This is possible
> if a trusted thread enters the scheduler by way of yielding CPU. This
> would involve no transitions through the irq_exit() point to do any
> waiting, so we have to explicitly do the waiting there.
> 
> Every attempt is made to prevent a busy-wait unnecessarily, and in
> testing on real-world ChromeOS usecases, it has not shown a performance
> drop. In ChromeOS, with this and the rest of the core scheduling
> patchset, we see around a 300% improvement in key press latencies into
> Google docs when Camera streaming is running simulatenously (90th
> percentile latency of ~150ms drops to ~50ms).
> 
> This fetaure is controlled by the build time config option
> CONFIG_SCHED_CORE_IRQ_PAUSE and is enabled by default. There is also a
> kernel boot parameter 'sched_core_irq_pause' to enable/disable the
> feature at boot time. Default is enabled at boot time.

We saw a lot of soft lockups on the screen when we tested v6.

[  186.527883] watchdog: BUG: soft lockup - CPU#86 stuck for 22s! [uperf:5551]
[  186.535884] watchdog: BUG: soft lockup - CPU#87 stuck for 22s! [uperf:5444]
[  186.555883] watchdog: BUG: soft lockup - CPU#89 stuck for 22s! [uperf:5547]
[  187.547884] rcu: INFO: rcu_sched self-detected stall on CPU
[  187.553760] rcu: 	40-....: (14997 ticks this GP) idle=49a/1/0x4000000000000002 softirq=1711/1711 fqs=7279 
[  187.564685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 14
[  187.564723] NMI watchdog: Watchdog detected hard LOCKUP on cpu 38

The problem is gone when we reverted this patch. We are running multiple
uperf threads(equal to cpu number) in a cgroup with coresched enabled.
This is 100% reproducible on our side.

Just wonder if anything already known before we dig into it.

Thanks,
-Aubrey

 


