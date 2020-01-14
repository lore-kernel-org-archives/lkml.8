Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D743BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55BB24689
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgANKQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:16:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42302 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729251AbgANKQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:16:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFj-0007ey-M7; Tue, 14 Jan 2020 11:16:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4C3691C03A9;
        Tue, 14 Jan 2020 11:16:51 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:51 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-19-sean.j.christopherson@intel.com>
References: <20191221044513.21680-19-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701117.1022.3718082104115954655.tip-bot2@tip-bot2>
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

Commit-ID:     616c59b52342b0370ab822ce88fa0ff7f3671e4a
Gitweb:        https://git.kernel.org/tip/616c59b52342b0370ab822ce88fa0ff7f3671e4a
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:12 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 19:33:56 +01:00

perf/x86: Provide stubs of KVM helpers for non-Intel CPUs

Provide stubs for perf_guest_get_msrs() and intel_pt_handle_vmx() when
building without support for Intel CPUs, i.e. CPU_SUP_INTEL=n.  Lack of
stubs is not currently a problem as the only user, KVM_INTEL, takes a
dependency on CPU_SUP_INTEL=y.  Provide the stubs for all CPUs so that
KVM_INTEL can be built for any CPU with compatible hardware support,
e.g. Centuar and Zhaoxin CPUs.

Note, the existing stub for perf_guest_get_msrs() is essentially dead
code as KVM selects CONFIG_PERF_EVENTS, i.e. the only user guarantees
the full implementation is built.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-19-sean.j.christopherson@intel.com
---
 arch/x86/include/asm/perf_event.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee26e92..29964b0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -322,17 +322,10 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
-extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
-static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-	*nr = 0;
-	return NULL;
-}
-
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	memset(cap, 0, sizeof(*cap));
@@ -342,8 +335,23 @@ static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
 #endif
 
+#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
+extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+#else
+static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
+{
+	*nr = 0;
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_CPU_SUP_INTEL
  extern void intel_pt_handle_vmx(int on);
+#else
+static inline void intel_pt_handle_vmx(int on)
+{
+
+}
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
