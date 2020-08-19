Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3831B207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7vMRphO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dhrh4JO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgHSIzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:55:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37160 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgHSIwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:52:13 -0400
Date:   Wed, 19 Aug 2020 08:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OydP4AsVDVkP8DZxQlDMyQ28reXrT/7uTIhNrCu6WJ4=;
        b=J7vMRphOx9EUoVbs8QOBGHnVgY3nabXgFtdYMxA8wlv1AuRMdX55f9k8TAiTK5OHONGcxV
        srUoRK5L1iJiQoDPuXiKE8bOWlKWFh3sGW2EaPaAXyC3+xhMowG0V8nEbDAoeHK5zW/s5u
        XxiesW0E2iGu1GLkz2AHj7EX8sSu4W7jSG4xA/uIbk1Mua3ggPiYbEzmr6lIdpSGVGgey3
        gbgDuZXnBKqEl5+P2SiXxKRj8OX+oh8XnwM7cuHDdkqXaVo+t99Pu2acrHc8aXeQ/Y+nnw
        EHldfvknRAPhPZJgw6zhXdw++7K5QIDlr37DTle8ni106oMzkEntaTzSTldIcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OydP4AsVDVkP8DZxQlDMyQ28reXrT/7uTIhNrCu6WJ4=;
        b=Dhrh4JO7+yl9Rp3YaUO66TrHJq7yLb6QawkCxNx8rSeW+H0VCZdf33DR7DykSgIz6u1X2A
        XQd/24T+bV8gr8CA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Introduce the fourth fixed counter
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-4-kan.liang@linux.intel.com>
References: <20200723171117.9918-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782713022.3192.7440422907426444873.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6f7225099d5f3ec3019f380a0da2b456b7796cb0
Gitweb:        https://git.kernel.org/tip/6f7225099d5f3ec3019f380a0da2b456b7796cb0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:06 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:35 +02:00

perf/x86/intel: Introduce the fourth fixed counter

The fourth fixed counter, TOPDOWN.SLOTS, is introduced in Ice Lake to
measure the level 1 TopDown events.

Add MSR address and macros for the new fixed counter, which will be used
in a later patch.

Add comments to explain the event encoding rules for the fixed counters.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-4-kan.liang@linux.intel.com
---
 arch/x86/include/asm/perf_event.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fd3eba6..fe8110a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -197,12 +197,24 @@ struct x86_pmu_capability {
  */
 
 /*
- * All 3 fixed-mode PMCs are configured via this single MSR:
+ * All the fixed-mode PMCs are configured via this single MSR:
  */
 #define MSR_ARCH_PERFMON_FIXED_CTR_CTRL	0x38d
 
 /*
- * The counts are available in three separate MSRs:
+ * There is no event-code assigned to the fixed-mode PMCs.
+ *
+ * For a fixed-mode PMC, which has an equivalent event on a general-purpose
+ * PMC, the event-code of the equivalent event is used for the fixed-mode PMC,
+ * e.g., Instr_Retired.Any and CPU_CLK_Unhalted.Core.
+ *
+ * For a fixed-mode PMC, which doesn't have an equivalent event, a
+ * pseudo-encoding is used, e.g., CPU_CLK_Unhalted.Ref and TOPDOWN.SLOTS.
+ * The pseudo event-code for a fixed-mode PMC must be 0x00.
+ * The pseudo umask-code is 0xX. The X equals the index of the fixed
+ * counter + 1, e.g., the fixed counter 2 has the pseudo-encoding 0x0300.
+ *
+ * The counts are available in separate MSRs:
  */
 
 /* Instr_Retired.Any: */
@@ -213,11 +225,16 @@ struct x86_pmu_capability {
 #define MSR_ARCH_PERFMON_FIXED_CTR1	0x30a
 #define INTEL_PMC_IDX_FIXED_CPU_CYCLES	(INTEL_PMC_IDX_FIXED + 1)
 
-/* CPU_CLK_Unhalted.Ref: */
+/* CPU_CLK_Unhalted.Ref: event=0x00,umask=0x3 (pseudo-encoding) */
 #define MSR_ARCH_PERFMON_FIXED_CTR2	0x30b
 #define INTEL_PMC_IDX_FIXED_REF_CYCLES	(INTEL_PMC_IDX_FIXED + 2)
 #define INTEL_PMC_MSK_FIXED_REF_CYCLES	(1ULL << INTEL_PMC_IDX_FIXED_REF_CYCLES)
 
+/* TOPDOWN.SLOTS: event=0x00,umask=0x4 (pseudo-encoding) */
+#define MSR_ARCH_PERFMON_FIXED_CTR3	0x30c
+#define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
+#define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
+
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
