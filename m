Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB49C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4662B206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgD0Pbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728156AbgD0Pbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:31:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8D5C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:31:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT5j8-0006Yg-LG; Mon, 27 Apr 2020 17:31:22 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0FCF0100606; Mon, 27 Apr 2020 17:31:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between console and hrtimer locks
In-Reply-To: <20200427134130.GE134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org> <20200414054836.GA956407@unreal> <20200414062454.GA84326@gmail.com> <87tv15qj5u.fsf@nanos.tec.linutronix.de> <20200427113218.GB134660@unreal> <87h7x5qe3v.fsf@nanos.tec.linutronix.de> <20200427134130.GE134660@unreal>
Date:   Mon, 27 Apr 2020 17:31:21 +0200
Message-ID: <87y2qhoshi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> writes:
> OK, I consulted with verification people and back then the trigger was:
> Reproduce when run "echo 1 > /sys/kernel/debug/clear_warn_once" after
> reboot

That explains it.

> [    0.937310] Freeing SMP alternatives memory: 32K
> [    0.940471] TSC deadline timer enabled

So here is the first one which sets 'once'. Of course if you clear 'once'
afterwards then this triggers because the context is completely
different.

So the right thing to do is to move this out of __setup_APIC_LVTT() and
be done with it.

Thanks

        tglx

8<-------------------
Subject: x86/apic: Move TSC deadline timer debug printk
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 27 Apr 2020 16:55:57 +0200

Leon reported that the printk_once() in __setup_APIC_LVTT() triggers a
lockdep splat due to a lock order violation between hrtimer_base::lock and
console_sem, when the 'once' condition is reset via
/sys/kernel/debug/clear_warn_once after boot.

The initial printk cannot trigger this because that happens during boot
when the local APIC timer is set up on the boot CPU.

Prevent it by moving the printk to a place which is guaranteed to be only
called once during boot.

Mark the deadline timer check related functions and data __init while at
it.

Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -352,8 +352,6 @@ static void __setup_APIC_LVTT(unsigned i
 		 * According to Intel, MFENCE can do the serialization here.
 		 */
 		asm volatile("mfence" : : : "memory");
-
-		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
 		return;
 	}
 
@@ -546,7 +544,7 @@ static struct clock_event_device lapic_c
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-static u32 hsx_deadline_rev(void)
+static __init u32 hsx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x3a; /* EP */
@@ -556,7 +554,7 @@ static u32 hsx_deadline_rev(void)
 	return ~0U;
 }
 
-static u32 bdx_deadline_rev(void)
+static __init u32 bdx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x02: return 0x00000011;
@@ -568,7 +566,7 @@ static u32 bdx_deadline_rev(void)
 	return ~0U;
 }
 
-static u32 skx_deadline_rev(void)
+static __init u32 skx_deadline_rev(void)
 {
 	switch (boot_cpu_data.x86_stepping) {
 	case 0x03: return 0x01000136;
@@ -581,7 +579,7 @@ static u32 skx_deadline_rev(void)
 	return ~0U;
 }
 
-static const struct x86_cpu_id deadline_match[] = {
+static const struct x86_cpu_id deadline_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
 	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
 	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
@@ -603,18 +601,19 @@ static const struct x86_cpu_id deadline_
 	{},
 };
 
-static void apic_check_deadline_errata(void)
+static __init bool apic_validate_deadline_timer(void)
 {
 	const struct x86_cpu_id *m;
 	u32 rev;
 
-	if (!boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER) ||
-	    boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return;
+	if (!boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return false;
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return true;
 
 	m = x86_match_cpu(deadline_match);
 	if (!m)
-		return;
+		return true;
 
 	/*
 	 * Function pointers will have the MSB set due to address layout,
@@ -626,11 +625,12 @@ static void apic_check_deadline_errata(v
 		rev = (u32)m->driver_data;
 
 	if (boot_cpu_data.microcode >= rev)
-		return;
+		return true;
 
 	setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 	pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
 	       "please update microcode to version: 0x%x (or later)\n", rev);
+	return false;
 }
 
 /*
@@ -2092,7 +2092,8 @@ void __init init_apic_mappings(void)
 {
 	unsigned int new_apicid;
 
-	apic_check_deadline_errata();
+	if (apic_validate_deadline_timer())
+		pr_debug("TSC deadline timer available\n");
 
 	if (x2apic_mode) {
 		boot_cpu_physical_apicid = read_apic_id();
