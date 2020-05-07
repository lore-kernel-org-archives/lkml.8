Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC5C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095C320838
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEGPv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgEGPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:51:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E93FC05BD43;
        Thu,  7 May 2020 08:51:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWioR-0005UP-4K; Thu, 07 May 2020 17:51:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 520B61C03AB;
        Thu,  7 May 2020 17:51:50 +0200 (CEST)
Date:   Thu, 07 May 2020 15:51:50 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/apic: Convert the TSC deadline timer matching to
 steppings macro
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200506071516.25445-4-bp@alien8.de>
References: <20200506071516.25445-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <158886671029.8414.16424008517888325755.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     66abf2388331b800f290e854cca3ae71de7977fe
Gitweb:        https://git.kernel.org/tip/66abf2388331b800f290e854cca3ae71de7977fe
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 05 May 2020 19:27:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 May 2020 13:50:32 +02:00

x86/apic: Convert the TSC deadline timer matching to steppings macro

... and get rid of the function pointers which would spit out the
microcode revision based on the CPU stepping.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mark Gross <mgross.linux.intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200506071516.25445-4-bp@alien8.de
---
 arch/x86/kernel/apic/apic.c | 57 +++++++-----------------------------
 1 file changed, 12 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e53dda2..4b1d31b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -544,46 +544,20 @@ static struct clock_event_device lapic_clockevent = {
 };
 static DEFINE_PER_CPU(struct clock_event_device, lapic_events);
 
-static __init u32 hsx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x02: return 0x3a; /* EP */
-	case 0x04: return 0x0f; /* EX */
-	}
-
-	return ~0U;
-}
-
-static __init u32 bdx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x02: return 0x00000011;
-	case 0x03: return 0x0700000e;
-	case 0x04: return 0x0f00000c;
-	case 0x05: return 0x0e000003;
-	}
-
-	return ~0U;
-}
-
-static __init u32 skx_deadline_rev(void)
-{
-	switch (boot_cpu_data.x86_stepping) {
-	case 0x03: return 0x01000136;
-	case 0x04: return 0x02000014;
-	}
+static const struct x86_cpu_id deadline_match[] __initconst = {
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 0x2), 0x3a), /* EP */
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 0x4), 0x0f), /* EX */
 
-	if (boot_cpu_data.x86_stepping > 4)
-		return 0;
+	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
 
-	return ~0U;
-}
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 0x2), 0x00000011),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 0x3), 0x0700000e),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x4, 0x4), 0x0f00000c),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x5, 0x5), 0x0e000003),
 
-static const struct x86_cpu_id deadline_match[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_X,		&hsx_deadline_rev),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_D,	&bdx_deadline_rev),
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_X,		&skx_deadline_rev),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x3, 0x3), 0x01000136),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 0x4), 0x02000014),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 0xf), 0),
 
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
 	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
@@ -615,14 +589,7 @@ static __init bool apic_validate_deadline_timer(void)
 	if (!m)
 		return true;
 
-	/*
-	 * Function pointers will have the MSB set due to address layout,
-	 * immediate revisions will not.
-	 */
-	if ((long)m->driver_data < 0)
-		rev = ((u32 (*)(void))(m->driver_data))();
-	else
-		rev = (u32)m->driver_data;
+	rev = (u32)m->driver_data;
 
 	if (boot_cpu_data.microcode >= rev)
 		return true;
