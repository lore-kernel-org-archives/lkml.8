Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD37C54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237C6214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOChkGBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDSPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgDSPGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 11:06:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t63so7021650wmt.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mgJBrbN8ENQqYlA1aIDPfUqg5Ku3KzLaL/T3CN2BzCg=;
        b=dOChkGBXatBUuviw+VQ7NlxwgSe4bulYhXcZnUSRbQzSkY8v2IGYGkp1F67pAW+lHn
         +rKzTGQtt+p0ef5si0UK/1SZ/FtgfisWJ8S8N8YGxJ24TYQfFLmRCmLzG3mO084ovSeM
         /QDwzKFejEYNo8+nvKgNBtbLY1L2w45Tzed+My5voD0yFEofKWUG8PJ9mj6rqp87sAXA
         62LqvCOcn8WBuw6jKOXQ3Dlq6jt6+JC5/4eHv8qlE0djHyL1qoUIK26hitN9stHGipmw
         kJCVk25HCUAoW2+tZVyzZcDalsZwQN4EjYQjDPtS+wbQqXJwkbqs7WBRL2fvSmIebLpY
         Em5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mgJBrbN8ENQqYlA1aIDPfUqg5Ku3KzLaL/T3CN2BzCg=;
        b=tJU1G+JT0s+w4Yb06uguwrqoMZgTbD4be9zLiO42k8i0Ad4e/aKTodlgJYFTY3uDbx
         ByF+UcSnckqMRwsjpXknguG6VyRL/O+5FhhXJ8FP9ljGq2SnTwM5CmG1XzMcslGReSQr
         TsI9LY9iLX6XIs6KjV7YVg25ek1wNuqLScA37j2oqbn5v81eibNC7V8VM2PmOqoKHO+r
         77y3hCM1ss37TlHhkjn2wg/l6KWDZzheuuL4gfsmtcLWVuN9GinVB4lDulsv/GtkrNbu
         llOC3ibkwcyaz0urLOUtt5YIuqcf6z9ptSgnsLRMRYW9Wp/hsMLCTpf9O3TyHxi7bFuI
         7lLg==
X-Gm-Message-State: AGi0PuYtxRffo6IDendyM76AeFGXAx5OvLZLN+krsLOhIdx+mut+IpYo
        ppmBvLttYXXtYnlpxNisA3WE+wmIs1wU+Ec+oDo=
X-Google-Smtp-Source: APiQypIHYS79qS6Ym7/zsAfw92yZoAhc0D6OXdVNJBvmovHjD1VVezpW6nATF5ItbotHjroDPpo0ng==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr12078369wml.45.1587308763884;
        Sun, 19 Apr 2020 08:06:03 -0700 (PDT)
Received: from lmecxl0524.home (2a01cb058702ff00947c0d9b78b8fa1e.ipv6.abo.wanadoo.fr. [2a01:cb05:8702:ff00:947c:d9b:78b8:fa1e])
        by smtp.gmail.com with ESMTPSA id w12sm25948635wrk.56.2020.04.19.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 08:06:03 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, james.morse@arm.com,
        michal.simek@xilinx.com, richard.gong@linux.intel.com,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        sudeep.holla@arm.com,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [RFC PATCH 4/6] firmware: arm_sdei: use SMCCC v1.0 helper functions
Date:   Sun, 19 Apr 2020 17:05:28 +0200
Message-Id: <20200419150530.20508-5-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419150530.20508-1-etienne.carriere@linaro.org>
References: <20200419150530.20508-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change Arm SDEI firmware driver to use SMCCC v1.0 helper functions.

Functional changes are Arm SDEI firmware driver can find appropriate
set conduit if it does not define one but another device has set
the kernel conduit for SMCCC calls.

Other functional changes are the trace messages emitted at device
probe time that now dev_*() traces instead of pr_*() traces.

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

