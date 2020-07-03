Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA39C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E1E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R55UeEch";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIkFaEVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGCIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:01:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57378 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGCIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:01:30 -0400
Date:   Fri, 03 Jul 2020 08:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oy4WReyZBoVmzASbvO7rtP53h0E1pKoAmkXDqRED9lA=;
        b=R55UeEchtpQOBCcV8s6UaKXeF3DBEW+0N/QdF1JYwrbDEQKs2dXJ5oTlQswy8YmmXntZFU
        nEzm/vUz4/BiPaTo3UwhArQlHX48cT+h3JP+e8LHWGAlklN37sfIaj42gaW+dLFdDDkQMJ
        BS0dF45XlpIyAsWUzeb+8lqzn+8ywx4WaGeL/nK/h9f9kDQ1O2yp5hw4WfSGyIujuN5klp
        B1Z129bQBANM7tt0tahY3rKR1dKkmd0XdIXgSyKaV833ypuoUvEzZnNOgCleARbPgSx/OO
        ssVdRtdnvkcmC1ScO8v0dN9LiOK1YhXqUgAGOcmJPoLU2U9q0TVwAbeOYvpS3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593763287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oy4WReyZBoVmzASbvO7rtP53h0E1pKoAmkXDqRED9lA=;
        b=sIkFaEVzORdGBcVg+snmvJx50H8YEdsSg3bmWyJ3Jtp2uKp6TVvNXOWYBMUav6F6a6KKSm
        reN8apMA2LLhY0Ag==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add constraint to create guest LBR event
 without hw counter
Cc:     Like Xu <like.xu@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200514083054.62538-5-like.xu@linux.intel.com>
References: <20200514083054.62538-5-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159376328664.4006.3096246262316423436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     097e4311cda952dfb047f2a49d35aa5de500d474
Gitweb:        https://git.kernel.org/tip/097e4311cda952dfb047f2a49d35aa5de500d474
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Sat, 13 Jun 2020 16:09:49 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 02 Jul 2020 15:51:46 +02:00

perf/x86: Add constraint to create guest LBR event without hw counter

The hypervisor may request the perf subsystem to schedule a time window
to directly access the LBR records msrs for its own use. Normally, it would
create a guest LBR event with callstack mode enabled, which is scheduled
along with other ordinary LBR events on the host but in an exclusive way.

To avoid wasting a counter for the guest LBR event, the perf tracks its
hw->idx via INTEL_PMC_IDX_FIXED_VLBR and assigns it with a fake VLBR
counter with the help of new vlbr_constraint. As with the BTS event,
there is actually no hardware counter assigned for the guest LBR event.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200514083054.62538-5-like.xu@linux.intel.com
---
 arch/x86/events/core.c            |  1 +
 arch/x86/events/intel/core.c      | 18 ++++++++++++++++++
 arch/x86/events/intel/lbr.c       |  4 ++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h | 22 +++++++++++++++++++++-
 5 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 15cb7af..d740c86 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1104,6 +1104,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 
 	switch (hwc->idx) {
 	case INTEL_PMC_IDX_FIXED_BTS:
+	case INTEL_PMC_IDX_FIXED_VLBR:
 		hwc->config_base = 0;
 		hwc->event_base	= 0;
 		break;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8dac4c6..51e1fba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2621,6 +2621,20 @@ intel_bts_constraints(struct perf_event *event)
 	return NULL;
 }
 
+/*
+ * Note: matches a fake event, like Fixed2.
+ */
+static struct event_constraint *
+intel_vlbr_constraints(struct perf_event *event)
+{
+	struct event_constraint *c = &vlbr_constraint;
+
+	if (unlikely(constraint_match(c, event->hw.config)))
+		return c;
+
+	return NULL;
+}
+
 static int intel_alt_er(int idx, u64 config)
 {
 	int alt_idx = idx;
@@ -2811,6 +2825,10 @@ __intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 {
 	struct event_constraint *c;
 
+	c = intel_vlbr_constraints(event);
+	if (c)
+		return c;
+
 	c = intel_bts_constraints(event);
 	if (c)
 		return c;
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 2ed3f2a..d285d26 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1363,3 +1363,7 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
+
+struct event_constraint vlbr_constraint =
+	FIXED_EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT,
+			       (INTEL_PMC_IDX_FIXED_VLBR - INTEL_PMC_IDX_FIXED));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eb37f6c..77a6dd6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -990,6 +990,7 @@ void release_ds_buffers(void);
 void reserve_ds_buffers(void);
 
 extern struct event_constraint bts_constraint;
+extern struct event_constraint vlbr_constraint;
 
 void intel_pmu_enable_bts(u64 config);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5d2c30f..2df7073 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -192,10 +192,30 @@ struct x86_pmu_capability {
 #define GLOBAL_STATUS_UNC_OVF				BIT_ULL(61)
 #define GLOBAL_STATUS_ASIF				BIT_ULL(60)
 #define GLOBAL_STATUS_COUNTERS_FROZEN			BIT_ULL(59)
-#define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(58)
+#define GLOBAL_STATUS_LBRS_FROZEN_BIT			58
+#define GLOBAL_STATUS_LBRS_FROZEN			BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI			BIT_ULL(55)
 
 /*
+ * We model guest LBR event tracing as another fixed-mode PMC like BTS.
+ *
+ * We choose bit 58 because it's used to indicate LBR stack frozen state
+ * for architectural perfmon v4, also we unconditionally mask that bit in
+ * the handle_pmi_common(), so it'll never be set in the overflow handling.
+ *
+ * With this fake counter assigned, the guest LBR event user (such as KVM),
+ * can program the LBR registers on its own, and we don't actually do anything
+ * with then in the host context.
+ */
+#define INTEL_PMC_IDX_FIXED_VLBR	(GLOBAL_STATUS_LBRS_FROZEN_BIT)
+
+/*
+ * Pseudo-encoding the guest LBR event as event=0x00,umask=0x1b,
+ * since it would claim bit 58 which is effectively Fixed26.
+ */
+#define INTEL_FIXED_VLBR_EVENT	0x1b00
+
+/*
  * Adaptive PEBS v4
  */
 
