Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B13EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B96206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsY5Mtcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgDUQjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729092AbgDUQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81072C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so4307953wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwFO/u2aeUUzfosuhBTWahZc0BcOCP6Dfva7x951Kew=;
        b=YsY5MtcynhLjmd4f5oPMFhzDUUL//yZqTVSXr/da17ytsjb18WOt73a2TR/vR9Xx7P
         gppN9LpWP/YEV7OBFcP72H8yYBpKq7lI4GH3eM22Tvobvce4BUEIAbwVjrmDRHMkwMxt
         X+TRM4z001H2b8vQaCwc1UeAtvot0XhM3DmrY7dGZv+jhxr1DvK329tt5RvM4tkHx+CZ
         xXLa71dgImb57W+R1nncyaP/3JdyAH88ME/y/unJ4vMQPpO3PX/iTUdIgc2sOo58iO0Z
         mDwgQEoZecgYjYm8SizcoapcKNC2MGwkE8QCGvZK79GBiFlU9LWQ0SHGdmt5QTBM6IAd
         /6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwFO/u2aeUUzfosuhBTWahZc0BcOCP6Dfva7x951Kew=;
        b=QczjFXmgRt/fjggi6YFw9LNinfU3dRNkICBS5JiMjn5uPO4nc0cvgnOpzw3ij1SrZK
         PAqm+buu/EPb7Vw91ve4uHIMXdLPDcC4d1mSZVfig7Vv3QZf3eyrLHKlmOuKRWu395Wo
         LpdsYsfWRXavGNsZTZZ2dj6WY0SBbfc1MsNXtl3dm4m8yyz3yizOPAAyiPm40Hith4Ny
         YgVGCFMmdIDilJaeIgDEl2C/5cqtkUkY/k3CnUStQMd/JwyquVBxeBcYCz29aACM2vLX
         SUPrRhwnoMqVd1nLkcpY791e0t6Zdh+RBfwIJyrk5ijTUaBmrTB6HzeVEpiyFbsNmjSx
         miZg==
X-Gm-Message-State: AGi0PuYKJ/l2f4RVNWbkuTJ9jrWXZOfjWiGRU+HeQlE2KNU67lQiGlgU
        1oDhyNElBUulEMRinLsq3x3Di315enXVPFmW
X-Google-Smtp-Source: APiQypIxKMzeiiJWPN1V8wijRp5361DgD4XkoZLFBW75v7EUbfB74QMNUxM0q98bebRI/tDk5G6hzA==
X-Received: by 2002:a1c:b38b:: with SMTP id c133mr5628173wmf.24.1587487157942;
        Tue, 21 Apr 2020 09:39:17 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id q143sm4389055wme.31.2020.04.21.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:17 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH v2 6/6] firmware: zynqmp: use SMCCC v1.0 helper functions
Date:   Tue, 21 Apr 2020 18:38:11 +0200
Message-Id: <20200421163811.22720-7-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421163811.22720-1-etienne.carriere@linaro.org>
References: <20200421163811.22720-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Xilinx Zynmp driver to use Arm SMCCC v1.0 helper functions.

Main functional change is that SMCCC conduit method for ZynqMP
firmware must be consistent with conduit methods registered by
PSCI device that is early probed in case the later is enabled.

Another functional change is an additional info level trace emitted
by the device probe sequence: "probing for conduit method from DT.".

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c | 87 ++++----------------------------
 1 file changed, 9 insertions(+), 78 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 41b65164a367..f2172978ed4d 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -63,51 +63,11 @@ static int zynqmp_pm_ret_code(u32 ret_status)
 	}
 }
 
-static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
-				    u32 *ret_payload)
-{
-	return -ENODEV;
-}
-
-/*
- * PM function call wrapper
- * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
- */
-static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
-
-/**
- * do_fw_call_smc() - Call system-level platform management layer (SMC)
- * @arg0:		Argument 0 to SMC call
- * @arg1:		Argument 1 to SMC call
- * @arg2:		Argument 2 to SMC call
- * @ret_payload:	Returned value array
- *
- * Invoke platform management function via SMC call (no hypervisor present).
- *
- * Return: Returns status, either success or error+reason
- */
-static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
-				   u32 *ret_payload)
-{
-	struct arm_smccc_res res;
-
-	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
-
-	if (ret_payload) {
-		ret_payload[0] = lower_32_bits(res.a0);
-		ret_payload[1] = upper_32_bits(res.a0);
-		ret_payload[2] = lower_32_bits(res.a1);
-		ret_payload[3] = upper_32_bits(res.a1);
-	}
-
-	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
-}
-
 /**
- * do_fw_call_hvc() - Call system-level platform management layer (HVC)
- * @arg0:		Argument 0 to HVC call
- * @arg1:		Argument 1 to HVC call
- * @arg2:		Argument 2 to HVC call
+ * do_fw_call() - Call system-level platform management layer
+ * @arg0:		Argument 0 to HVC/SMC call
+ * @arg1:		Argument 1 to HVC/SMC call
+ * @arg2:		Argument 2 to HVC/SMC call
  * @ret_payload:	Returned value array
  *
  * Invoke platform management function via HVC
@@ -116,12 +76,13 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
  *
  * Return: Returns status, either success or error+reason
  */
-static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
-				   u32 *ret_payload)
+static noinline int do_fw_call(u64 arg0, u64 arg1, u64 arg2, u32 *ret_payload)
 {
 	struct arm_smccc_res res;
 
-	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
+	if (arm_smccc_1_0_invoke(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res) ==
+	    SMCCC_CONDUIT_NONE)
+		return -ENODEV;
 
 	if (ret_payload) {
 		ret_payload[0] = lower_32_bits(res.a0);
@@ -287,36 +248,6 @@ static int zynqmp_pm_get_trustzone_version(u32 *version)
 	return ret;
 }
 
-/**
- * get_set_conduit_method() - Choose SMC or HVC based communication
- * @np:		Pointer to the device_node structure
- *
- * Use SMC or HVC-based functions to communicate with EL2/EL3.
- *
- * Return: Returns 0 on success or error code
- */
-static int get_set_conduit_method(struct device_node *np)
-{
-	const char *method;
-
-	if (of_property_read_string(np, "method", &method)) {
-		pr_warn("%s missing \"method\" property\n", __func__);
-		return -ENXIO;
-	}
-
-	if (!strcmp("hvc", method)) {
-		do_fw_call = do_fw_call_hvc;
-	} else if (!strcmp("smc", method)) {
-		do_fw_call = do_fw_call_smc;
-	} else {
-		pr_warn("%s Invalid \"method\" property: %s\n",
-			__func__, method);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 /**
  * zynqmp_pm_query_data() - Get query data from firmware
  * @qdata:	Variable to the zynqmp_pm_query_data structure
@@ -790,7 +721,7 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	}
 	of_node_put(np);
 
-	ret = get_set_conduit_method(dev->of_node);
+	ret = devm_arm_smccc_1_0_set_conduit(dev);
 	if (ret)
 		return ret;
 
-- 
2.17.1

