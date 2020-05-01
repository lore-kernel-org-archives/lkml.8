Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C99C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723C424961
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbgEASXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730675AbgEASW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103DDC061A0C;
        Fri,  1 May 2020 11:22:29 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIt-0003j2-EH; Fri, 01 May 2020 20:22:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C7101C0330;
        Fri,  1 May 2020 20:22:24 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/apic: Move TSC deadline timer debug printk
Cc:     Leon Romanovsky <leon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87y2qhoshi.fsf@nanos.tec.linutronix.de>
References: <87y2qhoshi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158835734441.8414.16139957090362735390.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c84cb3735fd53c91101ccdb191f2e3331a9262cb
Gitweb:        https://git.kernel.org/tip/c84cb3735fd53c91101ccdb191f2e3331a9262cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Apr 2020 16:55:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 01 May 2020 19:15:41 +02:00

x86/apic: Move TSC deadline timer debug printk

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
Link: https://lkml.kernel.org/r/87y2qhoshi.fsf@nanos.tec.linutronix.de

---
 arch/x86/kernel/apic/apic.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 81b9c63..e53dda2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -352,8 +352,6 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
 		 * According to Intel, MFENCE can do the serialization here.
 		 */
 		asm volatile("mfence" : : : "memory");
-
-		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
 		return;
 	}
 
@@ -546,7 +544,7 @@ static struct clock_event_device lapic_clockevent = {
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
@@ -603,18 +601,19 @@ static const struct x86_cpu_id deadline_match[] = {
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
@@ -626,11 +625,12 @@ static void apic_check_deadline_errata(void)
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
