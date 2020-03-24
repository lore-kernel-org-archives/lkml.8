Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E50C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C80208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgCXOYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45078 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbgCXOYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:03 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGkTF-0006zS-7c; Tue, 24 Mar 2020 15:23:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C82EE1C0451;
        Tue, 24 Mar 2020 15:23:56 +0100 (CET)
Date:   Tue, 24 Mar 2020 14:23:56 -0000
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Remove vmware_sched_clock_setup()
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323195707.31242-3-amakhalov@vmware.com>
References: <20200323195707.31242-3-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <158505983648.28353.2870003990478698787.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     dd735f4707e603ac5b541b5f30de87c3c7bd60dd
Gitweb:        https://git.kernel.org/tip/dd735f4707e603ac5b541b5f30de87c3c7bd60dd
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 23 Mar 2020 19:57:04 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 09:31:06 +01:00

x86/vmware: Remove vmware_sched_clock_setup()

Move cyc2ns setup logic to separate function.
This separation will allow to use cyc2ns mult/shift pair
not only for the sched_clock but also for other clocks
such as steal_clock.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200323195707.31242-3-amakhalov@vmware.com
---
 arch/x86/kernel/cpu/vmware.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d280560..efb22fa 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,7 +122,7 @@ static unsigned long long notrace vmware_sched_clock(void)
 	return ns;
 }
 
-static void __init vmware_sched_clock_setup(void)
+static void __init vmware_cyc2ns_setup(void)
 {
 	struct cyc2ns_data *d = &vmware_cyc2ns;
 	unsigned long long tsc_now = rdtsc();
@@ -132,8 +132,7 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_ops.time.sched_clock = vmware_sched_clock;
-	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
+	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
@@ -141,8 +140,14 @@ static void __init vmware_paravirt_ops_setup(void)
 	pv_info.name = "VMware hypervisor";
 	pv_ops.cpu.io_delay = paravirt_nop;
 
-	if (vmware_tsc_khz && vmw_sched_clock)
-		vmware_sched_clock_setup();
+	if (vmware_tsc_khz == 0)
+		return;
+
+	vmware_cyc2ns_setup();
+
+	if (vmw_sched_clock)
+		pv_ops.time.sched_clock = vmware_sched_clock;
+
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
