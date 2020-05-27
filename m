Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E87F2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TJfxogc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgE0WrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgE0WrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:13 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 19so27404858qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EPOmpxXNIJ+6In9IN6TBBRdLz/P9JOhwRE1awJTQ7UI=;
        b=TJfxogc/xDxHr9mQZHN7JkU1Up2TtKdYLsm4R30RDECy3TUXBL+JSdGI70Tnf4ldY7
         I6P3Nc/b4csbG+TKEInX8M6A6kHdKFJ6Enw4CBjP1DFYTGKgxuS9QNf5kkmqwR7LyYUb
         dgdRuJVwR9eb+7Am0jKimjii8WIx1CDMTKFsjE/q8gCW8lQZoz7JUbxvfteUvuCSq5pv
         LGD2bb7wY0U2v6EqJbeCyNedhKsLTPZSzzF3ymQS/vJDK77ygCvNSxCvBU5gCkrGLaR6
         3PA6GEnMQuvK12duehw64GuRd9xBM9XmRSxP/o6s5Jp94b6+uD3bF0F2jFefUO2UIMom
         mO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EPOmpxXNIJ+6In9IN6TBBRdLz/P9JOhwRE1awJTQ7UI=;
        b=O2JSNesOoPAnMVZAuOz3ETSHCY9T6uGpRdUK5bZB9pl1JhaAkEANvPIicxOxhAbCic
         KRPL/xD6o8phmWIZcLDoy4jH8+zkXMtH6OLepdu+U/VaCvILpfGmUVpQiTkqAD2AYzmB
         0kE+2kOgIiDdfqDQV4mJawTp55r/vM2i35OwRBHxV/YJa57qfcCs4OodzsYNmP5JcYn9
         UPHUIrrkkW0LlXrHW7424O0cMtsZAQhQylCMEfNn16YvtCKYLrLrt12DE5gvd7Afekm2
         aipunrEMbQPyJHQYpGMbiElIdGMiyZnhUDyb6JBA2nU0URRnPCqlX4/Jq5CPnzxl0lSA
         f7Cw==
X-Gm-Message-State: AOAM533XDluFsnFQjMPGsYpRRaDj4Fz+dQpF0ziDsadnpIMw/w/Nol4z
        XcOMJJf0HedyXPlr2saIew5gYrj85WXtDoVT4a6yocJdpGZ+wUp789pgikrw0epy0oKsJqP9zoz
        yg7QuS+Z6Bt9zu1qmFy+tBzERC6ipb8iFIzcZwkhk/VAdJvRHtXdBLtO8rJdgCC36T8qY92FO
X-Google-Smtp-Source: ABdhPJxjxd/6kJpQ9z8kT6kKlT6FKW+xMzusW2OFeQEQ0rKlH4J1wfDQgf0ZaX/krytmcAgJN795UmBexRo/
X-Received: by 2002:a0c:9aeb:: with SMTP id k43mr278612qvf.101.1590619632442;
 Wed, 27 May 2020 15:47:12 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:56 -0700
In-Reply-To: <20200527224659.206129-1-eranian@google.com>
Message-Id: <20200527224659.206129-3-eranian@google.com>
Mime-Version: 1.0
References: <20200527224659.206129-1-eranian@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 2/5] perf/x86/rapl: refactor code for Intel/AMD sharing
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the rapl_model struct to include architecture specific
knowledge to Intel specific structure, and in particular the MSR for
POWER_UNIT and the rapl_msrs array.

No functional changes.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/rapl.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index ece043fb7b494..72990e9a4e71f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -131,7 +131,9 @@ struct rapl_pmus {
 };
 
 struct rapl_model {
+	struct perf_msr *rapl_msrs;
 	unsigned long	events;
+	unsigned int	msr_power_unit;
 	bool		apply_quirk;
 };
 
@@ -141,7 +143,7 @@ static struct rapl_pmus *rapl_pmus;
 static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr rapl_msrs[];
+static struct perf_msr *rapl_msrs;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
@@ -516,7 +518,7 @@ static bool test_msr(int idx, void *data)
 	return test_bit(idx, (unsigned long *) data);
 }
 
-static struct perf_msr rapl_msrs[] = {
+static struct perf_msr intel_rapl_msrs[] = {
 	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr },
 	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr },
 	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr },
@@ -578,13 +580,13 @@ static int rapl_cpu_online(unsigned int cpu)
 	return 0;
 }
 
-static int rapl_check_hw_unit(bool apply_quirk)
+static int rapl_check_hw_unit(struct rapl_model *rm)
 {
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
 	/* protect rdmsrl() to handle virtualization */
-	if (rdmsrl_safe(MSR_RAPL_POWER_UNIT, &msr_rapl_power_unit_bits))
+	if (rdmsrl_safe(rm->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_DOMAINS; i++)
 		rapl_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
@@ -595,7 +597,7 @@ static int rapl_check_hw_unit(bool apply_quirk)
 	 * "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, V2
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
-	if (apply_quirk)
+	if (rm->apply_quirk)
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 
 	/*
@@ -676,6 +678,8 @@ static struct rapl_model model_snb = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_PP1),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_snbep = {
@@ -683,6 +687,8 @@ static struct rapl_model model_snbep = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsw = {
@@ -691,6 +697,8 @@ static struct rapl_model model_hsw = {
 			  BIT(PERF_RAPL_RAM) |
 			  BIT(PERF_RAPL_PP1),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_hsx = {
@@ -698,12 +706,16 @@ static struct rapl_model model_hsx = {
 			  BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= true,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_knl = {
 	.events		= BIT(PERF_RAPL_PKG) |
 			  BIT(PERF_RAPL_RAM),
 	.apply_quirk	= true,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static struct rapl_model model_skl = {
@@ -713,6 +725,8 @@ static struct rapl_model model_skl = {
 			  BIT(PERF_RAPL_PP1) |
 			  BIT(PERF_RAPL_PSYS),
 	.apply_quirk	= false,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -758,10 +772,13 @@ static int __init rapl_pmu_init(void)
 		return -ENODEV;
 
 	rm = (struct rapl_model *) id->driver_data;
+
+	rapl_msrs = rm->rapl_msrs;
+
 	rapl_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_MAX,
 					false, (void *) &rm->events);
 
-	ret = rapl_check_hw_unit(rm->apply_quirk);
+	ret = rapl_check_hw_unit(rm);
 	if (ret)
 		return ret;
 
-- 
2.27.0.rc0.183.gde8f92d652-goog

