Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE612C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFFC20809
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3NbLYkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEOV6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgEOV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:58:05 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77156C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:05 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t57so4022831qte.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Hva6k/6TTq+q0N05SG0Vffd+jU34Hf/9UQ5ci8XyaCk=;
        b=K3NbLYkGQqInbFDQg4wMLCm8zkpXEm1pb14TmLQBG0foOFozUS9bzBnYl9W/nK8tvm
         /+KcIresLOO23AOlP9y84BNnZFVZGeOp+7FxqvMaMf+nZVN1izXFANUEJbIYo8ALWc2V
         C2Vpn15gMocmwVDZsLw/ADh3ROXEryOsOPlBqNo3fE3fiEsCiOe719HudYeEWnb+VlWS
         ZCnnZlzuxJu0cw3kxoArRCxBJRP+/291YSxPRWDw85mwhdf7vgfM/ptEx85cXov+amnc
         vVAiVo4pqdqbIEPg13rh8KUpRTIDka5RXZ/ztuLgU6d2aUWyeK+EemCogNwq3FM18Lcv
         f4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Hva6k/6TTq+q0N05SG0Vffd+jU34Hf/9UQ5ci8XyaCk=;
        b=d+BDgqoS+JcnT5phpkDMD7HuOpqGesjdrLoDZmrYUsrAk/SFQFYJcpsmIZEYbeNwEy
         howh6m2/Obb+Xk529dxVyrVrJuxZ04ReSpzOa8XIZ6ogUcvO+92Lo0sBaCTxBobfd0M4
         2CdK+s1K1FgfY0nyA7q/RFFlNml8Snl8HAC1GL7Rczqm4t/9xRlmtkXI1f7MSn+iekRJ
         NblvaU6N1p5IHxbi/0Qnp3T/zSxOERKqrmB7Jg0E3oMiJCbliJAX00i8tHyov7eTdVa5
         IuWIEvEIxEd+sA/WcbXgadc09DGI4M9tttLDOjboJHmEleUTQqbEWHP45mrByzizUNA0
         p0Ew==
X-Gm-Message-State: AOAM533gZk3g+mp9UGz6m03i4hFkGBvuGKZsIrakJxBEcyc4HoJiHIFb
        LbC1HrpVeRUe/12GllJcEhrzltMHBnK8Ez7+wnEc9lliAvP5Q8FuR7V4XxOccfXpQCSXsNs01qT
        tbqsKCwWEDOsr1uma2DDsrCc4ap1JLzc7YdPNiGjlG5I+ZijB7v09vE/Io/YkDrRgzQxg0Vpj
X-Google-Smtp-Source: ABdhPJwyQXlnJm5Hc7FlFyUs4Ygp3jntJUYjrKA029imgSg0rHn2RNs3pUk0ATTEoJzJiVm9bN9zv2g/FJNC
X-Received: by 2002:a0c:90e7:: with SMTP id p94mr5803823qvp.219.1589579884577;
 Fri, 15 May 2020 14:58:04 -0700 (PDT)
Date:   Fri, 15 May 2020 14:57:32 -0700
In-Reply-To: <20200515215733.20647-1-eranian@google.com>
Message-Id: <20200515215733.20647-3-eranian@google.com>
Mime-Version: 1.0
References: <20200515215733.20647-1-eranian@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 2/3] perf/x86/rapl: refactor code for Intel/AMD sharing
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
index ece043fb7b494..e98f627a13fa8 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -131,7 +131,9 @@ struct rapl_pmus {
 };
 
 struct rapl_model {
+	struct perf_msr *rapl_msrs;
 	unsigned long	events;
+	int		msr_power_unit;
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
2.26.2.761.g0e0b3e54be-goog

