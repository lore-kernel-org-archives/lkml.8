Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C48C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FDE221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STYnBBHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bo6c7zoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgIKHDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:02:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E9C0613ED;
        Fri, 11 Sep 2020 00:02:34 -0700 (PDT)
Date:   Fri, 11 Sep 2020 07:02:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599807752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bIk+bdhcIVFBDR/zooKSR6qXtAQ2vQRf6634nE/STs=;
        b=STYnBBHDT7ACGCThP+PiBAzmDVNDYvdJ1ku4mz9u/XpVq/IKnSiClho8Pr5i/ZyN6Cud9T
        B3/azSBchIv+j4w1CFInlf1FvC3NaqaX8n1RBCkNojJRUYP7Y1Y68Uz5sPLTV7x4u8ezJR
        igg0AuRVBVPUXK3ten9mjgPc4RGPQSqxZBGPWxNl9EB+TGeU7/Y5uBpCYY7srKjNaYy16K
        +b4KSSPahINboh1Qc69I2Q6nM9IY/xuTy+RW1FjJeuEmjR1y4YZGKQTc4yCI3CmQQP0J4n
        9fzP4B3UqfCzHyNQKXJfZoE2hcNwx6j7jAwIuGsKLCFdHln5UXGh6SSqf4hBpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599807752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bIk+bdhcIVFBDR/zooKSR6qXtAQ2vQRf6634nE/STs=;
        b=Bo6c7zohV2MPWCCWpq04jflAhqO76maFmkYMIGBTXai5REXl3ByKZ/rZ9I+fgd0ZnCKykh
        VzmgBIArBmkAKrBw==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200908214740.18097-7-kim.phillips@amd.com>
References: <20200908214740.18097-7-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <159980774689.20229.8560566905019815809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8b0bed7d410f48499d72af2e2bcd890daad94e0d
Gitweb:        https://git.kernel.org/tip/8b0bed7d410f48499d72af2e2bcd890daad94e0d
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 08 Sep 2020 16:47:39 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:36 +02:00

perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter

IBS hardware with the OpCntExt feature gets a 7-bit wider internal
counter.  Both the maximum and current count bitfields in the
IBS_OP_CTL register are extended to support reading and writing it.

No changes are necessary to the driver for handling the extra
contiguous current count bits (IbsOpCurCnt), as the driver already
passes through 32 bits of that field.  However, the driver has to do
some extra bit manipulation when converting from a period to the
non-contiguous (although conveniently aligned) extra bits in the
IbsOpMaxCnt bitfield.

This decreases IBS Op interrupt overhead when the period is over
1,048,560 (0xffff0), which would previously activate the driver's
software counter.  That threshold is now 134,217,712 (0x7fffff0).

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200908214740.18097-7-kim.phillips@amd.com
---
 arch/x86/events/amd/ibs.c         | 42 ++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  1 +-
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index cfbd020..ea323dc 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -339,10 +339,13 @@ static u64 get_ibs_op_count(u64 config)
 	 * and the lower 7 bits of CurCnt are randomized.
 	 * Otherwise CurCnt has the full 27-bit current counter value.
 	 */
-	if (config & IBS_OP_VAL)
+	if (config & IBS_OP_VAL) {
 		count = (config & IBS_OP_MAX_CNT) << 4;
-	else if (ibs_caps & IBS_CAPS_RDWROPCNT)
+		if (ibs_caps & IBS_CAPS_OPCNTEXT)
+			count += config & IBS_OP_MAX_CNT_EXT_MASK;
+	} else if (ibs_caps & IBS_CAPS_RDWROPCNT) {
 		count = (config & IBS_OP_CUR_CNT) >> 32;
+	}
 
 	return count;
 }
@@ -398,7 +401,7 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
-	u64 period;
+	u64 period, config = 0;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -407,13 +410,19 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	perf_ibs_set_period(perf_ibs, hwc, &period);
+	if (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_OPCNTEXT)) {
+		config |= period & IBS_OP_MAX_CNT_EXT_MASK;
+		period &= ~IBS_OP_MAX_CNT_EXT_MASK;
+	}
+	config |= period >> 4;
+
 	/*
 	 * Set STARTED before enabling the hardware, such that a subsequent NMI
 	 * must observe it.
 	 */
 	set_bit(IBS_STARTED,    pcpu->state);
 	clear_bit(IBS_STOPPING, pcpu->state);
-	perf_ibs_enable_event(perf_ibs, hwc, period >> 4);
+	perf_ibs_enable_event(perf_ibs, hwc, config);
 
 	perf_event_update_userpage(event);
 }
@@ -581,7 +590,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	struct perf_ibs_data ibs_data;
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
-	u64 *buf, *config, period;
+	u64 *buf, *config, period, new_config = 0;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -676,13 +685,17 @@ out:
 	if (throttle) {
 		perf_ibs_stop(event, 0);
 	} else {
-		period >>= 4;
-
-		if ((ibs_caps & IBS_CAPS_RDWROPCNT) &&
-		    (*config & IBS_OP_CNT_CTL))
-			period |= *config & IBS_OP_CUR_CNT_RAND;
+		if (perf_ibs == &perf_ibs_op) {
+			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
+				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
+				period &= ~IBS_OP_MAX_CNT_EXT_MASK;
+			}
+			if ((ibs_caps & IBS_CAPS_RDWROPCNT) && (*config & IBS_OP_CNT_CTL))
+				new_config |= *config & IBS_OP_CUR_CNT_RAND;
+		}
+		new_config |= period >> 4;
 
-		perf_ibs_enable_event(perf_ibs, hwc, period);
+		perf_ibs_enable_event(perf_ibs, hwc, new_config);
 	}
 
 	perf_event_update_userpage(event);
@@ -749,6 +762,13 @@ static __init void perf_event_ibs_init(void)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
 		*attr++ = &format_attr_cnt_ctl.attr;
 	}
+
+	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
+		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+	}
+
 	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
 
 	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index e20aa58..6960cd6 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -405,6 +405,7 @@ struct pebs_xmm {
 #define IBS_OP_ENABLE		(1ULL<<17)
 #define IBS_OP_MAX_CNT		0x0000FFFFULL
 #define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
+#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
 #define IBS_RIP_INVALID		(1ULL<<38)
 
 #ifdef CONFIG_X86_LOCAL_APIC
