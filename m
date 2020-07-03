Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588D920836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFVUp8aZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UaTMrLSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGCIBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCIB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:01:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73724C08C5C1;
        Fri,  3 Jul 2020 01:01:29 -0700 (PDT)
Date:   Fri, 03 Jul 2020 08:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8pw0IbKBUe0Gbiq3Fv9829Ab+q94MCW4jAVj94+2YY=;
        b=HFVUp8aZSDDRAVazdPSSMJr0HCXRTbIkts/+YnOAy+H/xDhEoK+rgZBGpuI886P+miZS4J
        cgddHP1GK9MBlINRdgROW6uCGT+Jh09EFINhxdTUT2yVeoEzehQK45jpqpZ2WqKpZnBv6x
        kB3xAxqFis7+KTCU05SpKE6hqkaR69ft89EKZwhJxv5H5iudydKJprzUOopEevcDG4LIEK
        UWsjAt2U401yNIgnmzatgd5auhfOm2kpd4An2qrmGqw0DI+InoSuUd204AtDwj485wabpj
        iutSzRwGFKhvqd8bkEHQuSl0MiQoejFo1mQwFBfM1vsBuP4ezZFy/+E9eVEnkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8pw0IbKBUe0Gbiq3Fv9829Ab+q94MCW4jAVj94+2YY=;
        b=UaTMrLSv+vI37ovCaOCj1z8YKpd3/K8i622KuNIgHkT8DoA6nW7RegCZZNuapuHLQQFERw
        hvV5sASxRDxqDZAQ==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/lbr: Add interface to get LBR information
Cc:     Like Xu <like.xu@linux.intel.com>, Wei Wang <wei.w.wang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200613080958.132489-4-like.xu@linux.intel.com>
References: <20200613080958.132489-4-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159376328720.4006.9030530624812063190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b2d6504761a50b9493eb4b20f6e188b673f20c32
Gitweb:        https://git.kernel.org/tip/b2d6504761a50b9493eb4b20f6e188b673f20c32
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Sat, 13 Jun 2020 16:09:48 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 02 Jul 2020 15:51:46 +02:00

perf/x86/lbr: Add interface to get LBR information

The LBR records msrs are model specific. The perf subsystem has already
obtained the base addresses of LBR records based on the cpu model.

Therefore, an interface is added to allow callers outside the perf
subsystem to obtain these LBR information. It's useful for hypervisors
to emulate the LBR feature for guests with less code.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200613080958.132489-4-like.xu@linux.intel.com
---
 arch/x86/events/intel/lbr.c       | 20 ++++++++++++++++++++
 arch/x86/include/asm/perf_event.h | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 65113b1..2ed3f2a 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1343,3 +1343,23 @@ void intel_pmu_lbr_init_knl(void)
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_LIP)
 		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
+
+/**
+ * x86_perf_get_lbr - get the LBR records information
+ *
+ * @lbr: the caller's memory to store the LBR records information
+ *
+ * Returns: 0 indicates the LBR info has been successfully obtained
+ */
+int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+{
+	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
+
+	lbr->nr = x86_pmu.lbr_nr;
+	lbr->from = x86_pmu.lbr_from;
+	lbr->to = x86_pmu.lbr_to;
+	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? MSR_LBR_INFO_0 : 0;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index e855e9c..5d2c30f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -333,6 +333,13 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
+struct x86_pmu_lbr {
+	unsigned int	nr;
+	unsigned int	from;
+	unsigned int	to;
+	unsigned int	info;
+};
+
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
@@ -348,12 +355,17 @@ static inline void perf_check_microcode(void) { }
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
 static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 {
 	*nr = 0;
 	return NULL;
 }
+static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+{
+	return -1;
+}
 #endif
 
 #ifdef CONFIG_CPU_SUP_INTEL
