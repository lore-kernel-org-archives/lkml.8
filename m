Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BB9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CC83206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRkzvlI3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mIs7IXED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHSI4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHSIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:53:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130BDC061347;
        Wed, 19 Aug 2020 01:52:13 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB62ipU3c36GDRZN7Srlw0bVi4SwB21C4BFlAs5SHvk=;
        b=rRkzvlI3XGao8swR9/Z+VrwU/lKGCM2kLoZ7JIl7Aswt906xE6B9lTyhM6T+xNkCLchYgx
        avOUCnNf0Aine9gRVG9yu8HtWZT0VD+K5LJ2G2OqWG2uJSUOoEIkBi9xG2wC+TR01G2KAK
        /bQzMms6SuLz9D281L2QRFWIcF6CxoM1NN2kLTODpzyNadsITy2wb0Dfh1tOiXuisTtUgH
        hDZIizEUPENknXOA7YMfmkcT7IIAFqg0pCdggaGVJa4jFohPzSm6KU7piCnPAT2FUFVyTt
        6MDEDbiqJ/Gr+pOZEtPpv1ckU1hsOb9gpfvkl/aAatZngt6JmwM+aGLoGQfpAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xB62ipU3c36GDRZN7Srlw0bVi4SwB21C4BFlAs5SHvk=;
        b=mIs7IXEDUmifJtmZOSJeoxHcqGhYAnSuiV0IqTBpX8VY/kE1INkfPY7qNS5dTJ9ZuZDEsA
        JoZenpk90FaDTdDQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Name the global status bit in NMI handler
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-3-kan.liang@linux.intel.com>
References: <20200723171117.9918-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782713093.3192.8180456930454502423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     60a2a271cf05cf046c522e1d7f62116b4bcb32a2
Gitweb:        https://git.kernel.org/tip/60a2a271cf05cf046c522e1d7f62116b4bcb32a2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:34 +02:00

perf/x86/intel: Name the global status bit in NMI handler

Magic numbers are used in the current NMI handler for the global status
bit. Use a meaningful name to replace the magic numbers to improve the
readability of the code.

Remove a Tab for all GLOBAL_STATUS_* and INTEL_PMC_IDX_FIXED_BTS macros
to reduce the length of the line.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      |  4 ++--
 arch/x86/include/asm/perf_event.h | 22 ++++++++++++----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5096347..ac1408f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2389,7 +2389,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * PEBS overflow sets bit 62 in the global status register
 	 */
-	if (__test_and_clear_bit(62, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
 		handled++;
@@ -2410,7 +2410,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	/*
 	 * Intel PT
 	 */
-	if (__test_and_clear_bit(55, (unsigned long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
 		handled++;
 		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
 			perf_guest_cbs->handle_intel_pt_intr))
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0c1b137..fd3eba6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -225,16 +225,18 @@ struct x86_pmu_capability {
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS				(INTEL_PMC_IDX_FIXED + 16)
-
-#define GLOBAL_STATUS_COND_CHG				BIT_ULL(63)
-#define GLOBAL_STATUS_BUFFER_OVF			BIT_ULL(62)
-#define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
-#define GLOBAL_STATUS_ASIF				BIT_ULL(60)
-#define GLOBAL_STATUS_COUNTERS_FROZEN			BIT_ULL(59)
-#define GLOBAL_STATUS_LBRS_FROZEN_BIT			58
-#define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
-#define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(55)
+#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 16)
+
+#define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
+#define GLOBAL_STATUS_BUFFER_OVF_BIT		62
+#define GLOBAL_STATUS_BUFFER_OVF		BIT_ULL(GLOBAL_STATUS_BUFFER_OVF_BIT)
+#define GLOBAL_STATUS_UNC_OVF			BIT_ULL(61)
+#define GLOBAL_STATUS_ASIF			BIT_ULL(60)
+#define GLOBAL_STATUS_COUNTERS_FROZEN		BIT_ULL(59)
+#define GLOBAL_STATUS_LBRS_FROZEN_BIT		58
+#define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+#define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
+#define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
 
 /*
  * We model guest LBR event tracing as another fixed-mode PMC like BTS.
