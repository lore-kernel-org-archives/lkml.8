Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE22C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3E52100A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgFPMV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2748C08C5C2;
        Tue, 16 Jun 2020 05:21:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb5-0004aU-2S; Tue, 16 Jun 2020 14:21:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9835D1C0095;
        Tue, 16 Jun 2020 14:21:46 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Validate MMIO address before
 accessing
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1590679169-61823-3-git-send-email-kan.liang@linux.intel.com>
References: <1590679169-61823-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159231010636.16989.3413472870529613024.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f01719730bbe04b90ae60c7e9d2b6d3533308502
Gitweb:        https://git.kernel.org/tip/f01719730bbe04b90ae60c7e9d2b6d3533308502
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 May 2020 08:19:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:50 +02:00

perf/x86/intel/uncore: Validate MMIO address before accessing

An oops will be triggered, if perf tries to access an invalid address
which exceeds the mapped area.

Check the address before the actual access to MMIO sapce of an uncore
unit.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1590679169-61823-3-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c       |  3 +++
 arch/x86/events/intel/uncore.h       | 12 ++++++++++++
 arch/x86/events/intel/uncore_snbep.c |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b9c2876..cbe32d5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -132,6 +132,9 @@ u64 uncore_mmio_read_counter(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return 0;
 
+	if (!uncore_mmio_is_valid_offset(box, event->hw.event_base))
+		return 0;
+
 	return readq(box->io_addr + event->hw.event_base);
 }
 
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 79ff626..7859ac0 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -197,6 +197,18 @@ static inline bool uncore_pmc_freerunning(int idx)
 	return idx == UNCORE_PMC_IDX_FREERUNNING;
 }
 
+static inline bool uncore_mmio_is_valid_offset(struct intel_uncore_box *box,
+					       unsigned long offset)
+{
+	if (offset < box->pmu->type->mmio_map_size)
+		return true;
+
+	pr_warn_once("perf uncore: Invalid offset 0x%lx exceeds mapped area of %s.\n",
+		     offset, box->pmu->type->name);
+
+	return false;
+}
+
 static inline
 unsigned int uncore_mmio_box_ctl(struct intel_uncore_box *box)
 {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index bffb755..045c2d2 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4483,6 +4483,9 @@ static void snr_uncore_mmio_enable_event(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return;
 
+	if (!uncore_mmio_is_valid_offset(box, hwc->config_base))
+		return;
+
 	writel(hwc->config | SNBEP_PMON_CTL_EN,
 	       box->io_addr + hwc->config_base);
 }
@@ -4495,6 +4498,9 @@ static void snr_uncore_mmio_disable_event(struct intel_uncore_box *box,
 	if (!box->io_addr)
 		return;
 
+	if (!uncore_mmio_is_valid_offset(box, hwc->config_base))
+		return;
+
 	writel(hwc->config, box->io_addr + hwc->config_base);
 }
 
