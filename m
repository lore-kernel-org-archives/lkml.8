Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C40C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BCC208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 00:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgBWA0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 19:26:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:48120 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgBWA0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 19:26:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Feb 2020 16:26:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,474,1574150400"; 
   d="scan'208";a="435554544"
Received: from spandruv-mobl3.jf.intel.com ([10.254.107.199])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2020 16:26:00 -0800
Message-ID: <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Sat, 22 Feb 2020 16:25:59 -0800
In-Reply-To: <20200222175151.GD11284@zn.tnic>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
         <20200222175151.GD11284@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-22 at 18:51 +0100, Borislav Petkov wrote:
> On Sat, Feb 22, 2020 at 08:24:32AM -0800, Srinivas Pandruvada wrote:
> > During cpu-hotplug test with CONFIG_PREEMPTION and
> > CONFIG_DEBUG_PREEMPT
> > enabled, Chris reported error:
> > 
> > BUG: using smp_processor_id() in preemptible [00000000] code:
> > kworker/1:0/17
> > caller is throttle_active_work+0x12/0x280
> > 
> > Here throttle_active_work() is a work queue callback scheduled with
> > schedule_delayed_work_on(). This will not cause this error for the
> > use
> > of smp_processor_id() under normal conditions as there is a check
> > for
> > "current->nr_cpus_allowed == 1".
> > But when the target CPU is offline the workqueue becomes unbound.
> > Then the work queue callback can be scheduled on another CPU and
> > the
> > error is printed for the use of smp_processor_id() in preemptible
> > context.
> 
> So what's wrong with simply doing:
> 
> 	if (cpu_is_offline(this_cpu))
> 		return;
> 
> ?
> 
If the condition is false, will it prevent offline CPU before executing
next statement and reschedule on another CPU? Although It will not
cause any error or crash but in rare circumstance may print premature
warning/normal message based on the current CPU's state.

So I can submit something like this:

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
b/arch/x86/kernel/cpu/mce/therm_throt.c
index b38010b541d6..7aa7c9d1df2a 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -239,11 +239,14 @@ static void throttle_active_work(struct
work_struct *work)
 {
        struct _thermal_state *state =
container_of(to_delayed_work(work),
                                                struct _thermal_state,
therm_work);
-       unsigned int i, avg, this_cpu = smp_processor_id();
+       unsigned int i, avg, this_cpu = state->cpu;
        u64 now = get_jiffies_64();
        bool hot;
        u8 temp;
 
+       if (cpu_is_offline(this_cpu))
+               return;
+
        get_therm_status(state->level, &hot, &temp);
        /* temperature value is offset from the max so lesser means
hotter */
        if (!hot && temp > state->baseline_temp) {

Thanks,
Srinivas

> You don't need to run the callback on an offlined CPU anyway...
> 

