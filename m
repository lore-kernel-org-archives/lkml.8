Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211A320716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xEquLsmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgC3Mwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:52:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60776 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgC3Mwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGKaLeDpGs0O1PNOT8rcH83PcS6ZRiY7IdQWb6sdvVY=; b=xEquLsmLEOCjbRvfhJ94v0jXWt
        mIQfxEzElIcDtyW1dnIL0LjLdXPg4TtroB4iRxZ4Q7Wh//65rd4tJbYEFr7B0a9Gq60Nk1zjlLm3i
        8vdckgDfnCJGrQAXAkFB6oOX6cMR1d6k3vV2MJpJj64RWoVVCfA41vt7qitRzeX58NX472QxWCYi/
        RZLarhwVdavVDTpvkshaN+QsJS/Vlmwheoq7AxrEhbj7s8F4kbGKNLtjKNs0P8oUQ1qvnN+WQKcZF
        gPl+1H3BYgdT91q58SlwMkt6pV5DvR9/rbKBRwSrpsv/RX+28Gczz5u0Jhh6It6xqr3fHYGdZw0p5
        5OdcxuzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIttu-0003x5-Oh; Mon, 30 Mar 2020 12:52:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72F8330015A;
        Mon, 30 Mar 2020 14:52:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35C0B29D04D76; Mon, 30 Mar 2020 14:52:19 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:52:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency
 invariance
Message-ID: <20200330125219.GM20696@hirez.programming.kicks-ass.net>
References: <20200122151617.531-2-ggherdovich@suse.cz>
 <158029757853.396.10568128383380430250.tip-bot2@tip-bot2>
 <158556634294.3228.4889951961483021094@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158556634294.3228.4889951961483021094@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:05:42PM +0100, Chris Wilson wrote:
> Quoting tip-bot2 for Giovanni Gherdovich (2020-01-29 11:32:58)
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     1567c3e3467cddeb019a7b53ec632f834b6a9239
> > Gitweb:        https://git.kernel.org/tip/1567c3e3467cddeb019a7b53ec632f834b6a9239
> > Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
> > AuthorDate:    Wed, 22 Jan 2020 16:16:12 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 28 Jan 2020 21:36:59 +01:00
> > 
> > x86, sched: Add support for frequency invariance
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 69881b2..28696bc 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -147,6 +147,8 @@ static inline void smpboot_restore_warm_reset_vector(void)
> >         *((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
> >  }
> >  
> > +static void init_freq_invariance(void);
> > +
> >  /*
> >   * Report back to the Boot Processor during boot time or to the caller processor
> >   * during CPU online.
> > @@ -183,6 +185,8 @@ static void smp_callin(void)
> >          */
> >         set_cpu_sibling_map(raw_smp_processor_id());
> >  
> > +       init_freq_invariance();
> > +
> >         /*
> >          * Get our bogomips.
> >          * Update loops_per_jiffy in cpu_data. Previous call to
> > @@ -1337,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
> >         set_sched_topology(x86_topology);
> >  
> >         set_cpu_sibling_map(0);
> > -
> > +       init_freq_invariance();
> >         smp_sanity_check();
> >  
> >         switch (apic_intr_mode) {
> 
> Since this has become visible via linux-next [20200326?], we have been
> deluged by oops during cpu-hotplug.

Ooh, you're doing CPU-0 hotplug, yuck!

I think something like the below ought to work; let me go see if I can
get that cpu-0 hotplug crud working on my machines.

---

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..681f96f05619 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -147,7 +147,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(void);
+static void init_freq_invariance(bool secondary);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -185,7 +185,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance();
+	init_freq_invariance(true);
 
 	/*
 	 * Get our bogomips.
@@ -1341,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance();
+	init_freq_invariance(false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2002,13 +2002,20 @@ static void init_counter_refs(void *arg)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(void)
+static void init_freq_invariance(bool secondary)
 {
 	bool ret = false;
 
-	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
+	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (secondary) {
+		if (static_branch_likely(&arch_scale_freq_key)) {
+			init_counter_refs(NULL);
+		}
+		return;
+	}
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
