Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5AC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199CE214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1YrTjRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDSPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgDSPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:06:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EB3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so6817436wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5I4MSLTJOBl1Jn2nKk55DTzP4h3HxHPJ2YS3y5/mux8=;
        b=r1YrTjRdErGiKY88e0TcKF3hYB6y0VZNENz9otldapbrRE/o41dcwt/0a256WYmYeN
         XBk+pGCJNEb5GalhEY0/t1CNfs/n3S4rOu3PhmeMla02s/V5kjv0KPTC28KS7fGcgHHg
         Odx52ZNrQmpt8uAu11elsrzgEsbhklPsr6CkakUAH2zDlpIH2q+6rmeNygFOxel5nA8q
         8RYv7pxgUx5GfXsUc7VKqUeSRVvCEawdyye7hdMrNaGJGn+elhofSKrmWFMlx33FXder
         goxz6LQkMOqr22IjN2voIIsTUiuCAX3lDqsGfK+taIr9ArWV+zG0gfixaedq7pWwcPWj
         +KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5I4MSLTJOBl1Jn2nKk55DTzP4h3HxHPJ2YS3y5/mux8=;
        b=S7i0j+o+XDvhC87SGcUZYnLFOHMScQPBbWKapkE+FUxYA5icOFItaGTZHHRjZihbZk
         NkjQUV6A+g0ijIicH7jSPkfdpXLtrAzF8N4rkiTQv8aBd6EFdJiDgQhMKHFpNK4de/i1
         CX0SjjMkGghaBJ5NGMkMlbEZEoWLQwyPRrB4m+u9QH6TaF19ZsI6vJKCxKGJvEA7UvR0
         EE8+sPfx0L2ERYp+zUDNB2NWECq7Z9bRxGvnMkzVNleC/tU1r1rs4gWjoMsNtGKZ4r0m
         XhmEkQW/EntszWNDoEqEyv4bPmX4zX267FBfEgi78N8pFaPLcGn+49pzGuJhGTLsDA/E
         XJ5A==
X-Gm-Message-State: AGi0PuYIwE26IHtvqMq9zeO15era1g1wt8ud/UFqxmTOD66yosvlhbdL
        5ocR6HSMRtjmgf1fkvaipwnYpFE65FoK6WI4hdI=
X-Google-Smtp-Source: APiQypJQZkht5jaZb1/UjrEqkxLSRTN/YHe1uN80L6ohNNQHDpqFwI7mFtgWoDuegY/ylULabpEmnQ==
X-Received: by 2002:adf:fe45:: with SMTP id m5mr14927300wrs.124.1587308760428;
        Sun, 19 Apr 2020 08:06:00 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:05:59 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 2/6] firmware: psci: set SMCCC v1.0 conduit and use helpers functions
Date:   Sun, 19 Apr 2020 17:05:26 +0200
Message-Id: <20200419150530.20508-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change PSCI driver to use SMCCC v1.0 helper functions. As PSCI device
is initialized before other devices, it sets the SMCCC conduit used
to SMCCC v1.0 compliant calls and other devices can rely on it.

No functional change in the PSCI device itself.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/psci/psci.c | 60 +++++-------------------------------
 include/linux/psci.h         |  1 -
 2 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2937d44b5df4..00bb205cad7c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -53,7 +53,6 @@ bool psci_tos_resident_on(int cpu)
 }
 
 struct psci_operations psci_ops = {
-	.conduit = SMCCC_CONDUIT_NONE,
 	.smccc_version = SMCCC_VERSION_1_0,
 };
 
@@ -62,13 +61,9 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
 	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
 		return SMCCC_CONDUIT_NONE;
 
-	return psci_ops.conduit;
+	return arm_smccc_1_0_get_conduit();
 }
 
-typedef unsigned long (psci_fn)(unsigned long, unsigned long,
-				unsigned long, unsigned long);
-static psci_fn *invoke_psci_fn;
-
 enum psci_function {
 	PSCI_FN_CPU_SUSPEND,
 	PSCI_FN_CPU_ON,
@@ -120,23 +115,14 @@ bool psci_power_state_is_valid(u32 state)
 	return !(state & ~valid_mask);
 }
 
-static unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
+static unsigned long invoke_psci_fn(unsigned long function_id,
+				    unsigned long arg0, unsigned long arg1,
+				    unsigned long arg2)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
-	return res.a0;
-}
+	arm_smccc_1_0_invoke(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
 
-static unsigned long __invoke_psci_fn_smc(unsigned long function_id,
-			unsigned long arg0, unsigned long arg1,
-			unsigned long arg2)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
 	return res.a0;
 }
 
@@ -229,41 +215,11 @@ static unsigned long psci_migrate_info_up_cpu(void)
 			      0, 0, 0);
 }
 
-static void set_conduit(enum arm_smccc_conduit conduit)
-{
-	switch (conduit) {
-	case SMCCC_CONDUIT_HVC:
-		invoke_psci_fn = __invoke_psci_fn_hvc;
-		break;
-	case SMCCC_CONDUIT_SMC:
-		invoke_psci_fn = __invoke_psci_fn_smc;
-		break;
-	default:
-		WARN(1, "Unexpected PSCI conduit %d\n", conduit);
-	}
-
-	psci_ops.conduit = conduit;
-}
-
 static int get_set_conduit_method(struct device_node *np)
 {
-	const char *method;
-
-	pr_info("probing for conduit method from DT.\n");
-
-	if (of_property_read_string(np, "method", &method)) {
-		pr_warn("missing \"method\" property\n");
+	if (of_arm_smccc_1_0_set_conduit(np))
 		return -ENXIO;
-	}
 
-	if (!strcmp("hvc", method)) {
-		set_conduit(SMCCC_CONDUIT_HVC);
-	} else if (!strcmp("smc", method)) {
-		set_conduit(SMCCC_CONDUIT_SMC);
-	} else {
-		pr_warn("invalid \"method\" property: %s\n", method);
-		return -EINVAL;
-	}
 	return 0;
 }
 
@@ -605,9 +561,9 @@ int __init psci_acpi_init(void)
 	pr_info("probing for conduit method from ACPI.\n");
 
 	if (acpi_psci_use_hvc())
-		set_conduit(SMCCC_CONDUIT_HVC);
+		arm_smccc_1_0_set_conduit(SMCCC_CONDUIT_HVC);
 	else
-		set_conduit(SMCCC_CONDUIT_SMC);
+		arm_smccc_1_0_set_conduit(SMCCC_CONDUIT_SMC);
 
 	return psci_probe();
 }
diff --git a/include/linux/psci.h b/include/linux/psci.h
index a67712b73b6c..9de579a1d237 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -35,7 +35,6 @@ struct psci_operations {
 	int (*affinity_info)(unsigned long target_affinity,
 			unsigned long lowest_affinity_level);
 	int (*migrate_info_type)(void);
-	enum arm_smccc_conduit conduit;
 	enum smccc_version smccc_version;
 };
 
-- 
2.17.1

