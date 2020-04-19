Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98272C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7048A214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOV0ezYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgDSPGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgDSPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:06:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB93C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so8858847wrp.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6PiqSVV9dpQAqOqd+uh/E8t5jyLRFjga9Ph1jhDag8=;
        b=FOV0ezYfjjl9Ks/imkXxFXr8IJNLzQ7xwIGz5OftsX4B5vGc3mutSwNxF4+k3rruRx
         mhqwouVVHCQI1zzVmlFUnANaD5qlC/XcxHZSsnK73DRZB0w9NxY2FaqPuas2f6beqtfW
         A9CSX+/O2lSNUzKnyhoT1mv005X/uD9AUhN+DV5GvIUDbI95k44IJI/15/3fsJAjTbLz
         ewBDortR1gTg2CD5bBHvWce5gplQNHJav2f9TaH44ROQVb6RIvVqCJFiK0KIohrswMpd
         gDk4tQs7rm4reCvV4J4hoDnnKX8cT2y7vnTW57C3dVB2iwIa9zJZm5aM2YsKvQHJ0jJN
         OiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6PiqSVV9dpQAqOqd+uh/E8t5jyLRFjga9Ph1jhDag8=;
        b=K6CKN191kie8ID6hf5yNBJoOC+WqEOY5BLV4PFOpYgCr/w85WW2zzxr55eh/4FwR9E
         FCJ9FjVobJgLb+RhnHZjf3povBC1L5R8V0eKG8db2T/lZesDL/jMJ84N2MrPqW/xBvcb
         2+ndXvSfhHPq33WYpXysqgE/8tKZjLgfcHB5ijNRtINqJyODumH726l2AthBSlD/v0qU
         ir+VlQmS0SkseFvvBZexiMGPW5tiw8UAujoJYSpm8/wfV/caVIpD3UeSu4V6BuEC7fiX
         WEHGlqzbbAaNg2DavQc80zwT6KNSXG/4pX53OBM68fgIW4xNBFez+JFsCoqoZgmvOmsp
         mtHg==
X-Gm-Message-State: AGi0PubGxOMnkgvl6/6APhd4HoGvT8hhCRw52dxzMcteCZpkQ+7aIpV5
        fdrjVboPSfAZg4Vfl7TvYN5f2THPMkgie+lZtn0=
X-Google-Smtp-Source: APiQypI3G+DRojbxMZCQ/3C6Vsl76B2MCQNsmSARPJUTNIz3W6+yGt8+Kwu0fi2IVqFrot5M1S+9Lw==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr13372859wrq.234.1587308767273;
        Sun, 19 Apr 2020 08:06:07 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:06:06 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 6/6] firmware: zynqmp: use SMCCC v1.0 helper functions
Date:   Sun, 19 Apr 2020 17:05:30 +0200
Message-Id: <20200419150530.20508-7-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Xilinx Zynmp driver to use Arm SMCCC v1.0 helper functions
and ensure platform consistency on SMCCC conduit method.

Main functional change is that SMCCC conduit method for ZynqMP
firmware must be consistent with conduit methods registered by
PSCI device that is early probed.

Another functional change is an addition info trace emitted by the
device probe sequence: "probing for conduit method from DT.".

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/xilinx/zynqmp.c | 87 ++++----------------------------
 1 file changed, 9 insertions(+), 78 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 41b65164a367..1fdc468c9204 100644
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
+	ret = devm_arm_smccc_set_conduit(dev);
 	if (ret)
 		return ret;
 
-- 
2.17.1

