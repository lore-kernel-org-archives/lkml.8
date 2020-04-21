Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43291C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B32B206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOoLwi1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgDUQjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729020AbgDUQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:39:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DEC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so15154786wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XETYSm4uP7bMLvF3XXve3QfqSUan+bhGi6fMh9AIGS0=;
        b=cOoLwi1nBGkaJzbd6hFSTZUSFb6exxh61seT1TfNMjcSgFd8lo7YN7qz/tpO60L9/M
         Enc6SKK9s4eyB7pqhh4z8hIffoHVMO9dwt0fi/08ZFN/VSl8Lzpg/90FDl3f/VFiyfAF
         c4EH2nDejCuYKUj6Hv0OpMGKkubaIBo+fW2VVsrCciiZ9X8fBOgkxz1B+N2ifBQUFup+
         8Mb1yCg+IGBYHMqLTiO1kZDWCKsNLDM9FySXnJ9W88g387XLIkXzjDfSiXwNTZpF8WB8
         S/73ElPfyZCiN9FkiyxCEcdepela8wHg29ck/wY27zvDZjjGIxCqeUYxq4+64Uy4xO4b
         JqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XETYSm4uP7bMLvF3XXve3QfqSUan+bhGi6fMh9AIGS0=;
        b=TN71K0Lmep9UvpugQM/MpeLxv43mOtU26GMYF8yXM+q2SzdMZvE8Wi8heYXSh/e17r
         2IBGSEiquTHk9tnWq/EABcwL0MCpD5GdcwYaM0umUGSZnvkt5yXFIQw5RNBcmZU3MeIa
         E/HwkDDPoThzISjvPs6dPFTOGaXjmUH5XTdHohj6Zxyj8nvg84DfYPSHyBjctBGRHwC9
         jTCf03BOUYzeq2WqsTmiJ/GEB5t7xIBZElhHSm65r3rKYb18GI1oF1G2pENvvRLC8fA7
         iUqyeemH2c9Lenl6JgeTewXhiW7lPUg4/O9vx5F8CZu4p23RELygadEKsu3MUnw31dm3
         DYog==
X-Gm-Message-State: AGi0Pua6gPLSoZD2NC7rqK9uHOODvf/KYtHr3auD31VyHaPnkkkHWLEv
        AvgCGq6d9tGa0h12amGlnH50BE2Acz4GL0vh
X-Google-Smtp-Source: APiQypI7JT3311pD+psUEN7y085u4go8Aun9MwUBdg5ZI7jJih77ao3oeCj84EnxhEfJUsEA84dO3g==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr24048869wrp.300.1587487155355;
        Tue, 21 Apr 2020 09:39:15 -0700 (PDT)
Received: from lmecxl0524.lme.st.com (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id q143sm4389055wme.31.2020.04.21.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 09:39:14 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH v2 4/6] firmware: arm_sdei: use SMCCC v1.0 helper functions
Date:   Tue, 21 Apr 2020 18:38:09 +0200
Message-Id: <20200421163811.22720-5-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421163811.22720-1-etienne.carriere@linaro.org>
References: <20200421163811.22720-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Arm SDEI firmware driver to use SMCCC v1.0 helper functions.

Main functional change is that Arm SDEI firmware driver can find
appropriate SMCCC conduit if it does not define one but another
device as the PSCI firmware driver has set the kernel conduit for
SMCCC calls.

Other functional changes are the trace messages emitted at device
probe time that are now dev_*() traces instead of pr_*() traces.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_sdei.c | 79 +++++++++++++------------------------
 1 file changed, 27 insertions(+), 52 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 334c8be0c11f..92f8077e0bde 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -34,12 +34,9 @@
 #include <linux/uaccess.h>
 
 /*
- * The call to use to reach the firmware.
+ * The SMCCC cnduit for the call to use to reach the firmware.
  */
-static asmlinkage void (*sdei_firmware_call)(unsigned long function_id,
-		      unsigned long arg0, unsigned long arg1,
-		      unsigned long arg2, unsigned long arg3,
-		      unsigned long arg4, struct arm_smccc_res *res);
+static enum arm_smccc_conduit sdei_firmware_call_conduit;
 
 /* entry point from firmware to arch asm code */
 static unsigned long sdei_entry_point;
@@ -144,14 +141,14 @@ static int invoke_sdei_fn(unsigned long function_id, unsigned long arg0,
 	int err = 0;
 	struct arm_smccc_res res;
 
-	if (sdei_firmware_call) {
+	if (sdei_firmware_call_conduit != SMCCC_CONDUIT_NONE) {
 		sdei_firmware_call(function_id, arg0, arg1, arg2, arg3, arg4,
 				   &res);
 		if (sdei_is_err(&res))
 			err = sdei_to_linux_errno(res.a0);
 	} else {
 		/*
-		 * !sdei_firmware_call means we failed to probe or called
+		 * No SMCCC conduit means we failed to probe or called
 		 * sdei_mark_interface_broken(). -EIO is not an error returned
 		 * by sdei_to_linux_errno() and is used to suppress messages
 		 * from this driver.
@@ -364,7 +361,7 @@ static void sdei_mark_interface_broken(void)
 {
 	pr_err("disabling SDEI firmware interface\n");
 	on_each_cpu(&_ipi_mask_cpu, NULL, true);
-	sdei_firmware_call = NULL;
+	sdei_firmware_call_conduit = SMCCC_CONDUIT_NONE;
 }
 
 static int sdei_platform_reset(void)
@@ -874,23 +871,19 @@ static struct notifier_block sdei_reboot_nb = {
 	.notifier_call = sdei_reboot_notifier,
 };
 
-static void sdei_smccc_smc(unsigned long function_id,
-			   unsigned long arg0, unsigned long arg1,
-			   unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, struct arm_smccc_res *res)
-{
-	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
-}
-NOKPROBE_SYMBOL(sdei_smccc_smc);
 
-static void sdei_smccc_hvc(unsigned long function_id,
-			   unsigned long arg0, unsigned long arg1,
-			   unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, struct arm_smccc_res *res)
+static asmlinkage void sdei_firmware_call(unsigned long function_id,
+					  unsigned long arg0,
+					  unsigned long arg1,
+					  unsigned long arg2,
+					  unsigned long arg3,
+					  unsigned long arg4,
+					  struct arm_smccc_res *res)
 {
-	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
+	arm_smccc_1_0_invoke(function_id, arg0, arg1, arg2, arg3, arg4,
+			     0, 0, res);
 }
-NOKPROBE_SYMBOL(sdei_smccc_hvc);
+NOKPROBE_SYMBOL(sdei_firmware_call);
 
 int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
 		       sdei_event_callback *critical_cb)
@@ -959,48 +952,30 @@ int sdei_unregister_ghes(struct ghes *ghes)
 	return err;
 }
 
-static int sdei_get_conduit(struct platform_device *pdev)
+static enum arm_smccc_conduit sdei_get_conduit(struct platform_device *pdev)
 {
-	const char *method;
-	struct device_node *np = pdev->dev.of_node;
-
-	sdei_firmware_call = NULL;
-	if (np) {
-		if (of_property_read_string(np, "method", &method)) {
-			pr_warn("missing \"method\" property\n");
-			return SMCCC_CONDUIT_NONE;
-		}
-
-		if (!strcmp("hvc", method)) {
-			sdei_firmware_call = &sdei_smccc_hvc;
-			return SMCCC_CONDUIT_HVC;
-		} else if (!strcmp("smc", method)) {
-			sdei_firmware_call = &sdei_smccc_smc;
-			return SMCCC_CONDUIT_SMC;
-		}
-
-		pr_warn("invalid \"method\" property: %s\n", method);
+	if (pdev->dev.of_node) {
+		devm_arm_smccc_1_0_set_conduit(pdev->dev);
 	} else if (IS_ENABLED(CONFIG_ACPI) && !acpi_disabled) {
-		if (acpi_psci_use_hvc()) {
-			sdei_firmware_call = &sdei_smccc_hvc;
-			return SMCCC_CONDUIT_HVC;
-		} else {
-			sdei_firmware_call = &sdei_smccc_smc;
-			return SMCCC_CONDUIT_SMC;
-		}
+		if (acpi_psci_use_hvc())
+			arm_smccc_1_0_set_conduit(SMCCC_CONDUIT_HVC);
+		else
+			arm_smccc_1_0_set_conduit(SMCCC_CONDUIT_SMC);
 	}
 
-	return SMCCC_CONDUIT_NONE;
+	sdei_firmware_call_conduit = arm_smccc_1_0_get_conduit();
+
+	return sdei_firmware_call_conduit;
 }
 
 static int sdei_probe(struct platform_device *pdev)
 {
 	int err;
 	u64 ver = 0;
-	int conduit;
+	enum arm_smccc_conduit conduit;
 
 	conduit = sdei_get_conduit(pdev);
-	if (!sdei_firmware_call)
+	if (conduit == SMCCC_CONDUIT_NONE)
 		return 0;
 
 	err = sdei_api_get_version(&ver);
-- 
2.17.1

