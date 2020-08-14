Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B36C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F4A207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QnAG3gq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="voOAM7NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHNPXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A421C061385;
        Fri, 14 Aug 2020 08:23:35 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:23:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdANNQMuUMseVByBrH26u9LG+YAJnlk/Tjr7L7O4PIs=;
        b=QnAG3gq4gobyETTNKHTW1dco1DG94ooUMIwM0SzdbQifCVz8X/ldwsf5Mkg8uKnnItB3gn
        yllx5pQRMrgcw4ebsowT4W8yDkQsDpaNTQr+kxiB7HLOyEs0pmjS1RSjzx+QE2ya1n1mTV
        pS7MjwgaVhrr4PDsUBqYGe3QyF0ucllBNQPhJ31N2uQHyzPHIH8NILBuZgFLfva++6pxX7
        acJunWiUIRO7y/6Tf74lkOoiA9H0P2A3YX91t+iMg7puNQ1aaijVewl+jRhMK+lPHcvn8p
        etvizoncWPeB9t/loD1k3gL8EnROwLt0sCSYoQ5aE1dAw477y17V6p0coDuynA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bdANNQMuUMseVByBrH26u9LG+YAJnlk/Tjr7L7O4PIs=;
        b=voOAM7NTl/YqbQ5p1JFNMaXcq/RxVFNzpuoPb1uMAftB/qttKYfcSqBKSukvhNQIxR0Kf/
        x+SEl9eOAvDcgIAQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Support multiple RAPL unit quirks
Cc:     Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200811153149.12242-3-rui.zhang@intel.com>
References: <20200811153149.12242-3-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <159741860945.3192.12569144568856845688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     74f41adab0f4a61857833e1b6fa8e9ad12c251b6
Gitweb:        https://git.kernel.org/tip/74f41adab0f4a61857833e1b6fa8e9ad12c251b6
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 11 Aug 2020 23:31:48 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:35:12 +02:00

perf/x86/rapl: Support multiple RAPL unit quirks

There will be more platforms with different fixed energy units.
Enhance the code to support different RAPL unit quirks for different
platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Link: https://lore.kernel.org/r/20200811153149.12242-3-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e972383..d0002eb 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -130,11 +130,16 @@ struct rapl_pmus {
 	struct rapl_pmu		*pmus[];
 };
 
+enum rapl_unit_quirk {
+	RAPL_UNIT_QUIRK_NONE,
+	RAPL_UNIT_QUIRK_INTEL_HSW,
+};
+
 struct rapl_model {
 	struct perf_msr *rapl_msrs;
 	unsigned long	events;
 	unsigned int	msr_power_unit;
-	bool		apply_quirk;
+	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
@@ -612,14 +617,20 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	switch (rm->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
 	 * different than the unit from power unit MSR. See
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (rm->apply_quirk)
+	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		break;
+	default:
+		break;
+	}
+
 
 	/*
 	 * Calculate the timer rate:
@@ -698,7 +709,6 @@ static struct rapl_model model_snb = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -707,7 +717,6 @@ static struct rapl_model model_snbep = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -717,7 +726,6 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -726,7 +734,7 @@ static struct rapl_model model_hsx = {
 	.events		= BIT(PERF_RAPL_PP0) |
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -734,7 +742,7 @@ static struct rapl_model model_hsx = {
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
-	.apply_quirk	= true,
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_HSW,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
@@ -745,14 +753,12 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_RAPL_POWER_UNIT,
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
-	.apply_quirk	= false,
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_msrs      = amd_rapl_msrs,
 };
