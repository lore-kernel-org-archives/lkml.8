Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7787BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537FF20842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ7L5pli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHET4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHEQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984AC034614
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:49:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so40608189wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NGh3qV9bnhStjMJvm5/xoTqyt0oZ80U2JyhykslboTM=;
        b=dJ7L5plirWRryjsL0w+sJdTROVivbDeTQAkwANWl4dPDxYJDMr8xmxqugElTamdk/C
         DIp8qiSY4E3w3uk6Q/hZNyz+5z9YF/9oVzR8hMoB1YUX9JtDvk01+bBwbLwzmYgya+sT
         fpt4pVhtNx8pzHiLR8591sACDg7U9ccxPEVTi57bFi/0vd3iT7S7IG1UjjrB9nLrPCrQ
         0ql8jUDRfEP/FWyrgGB/Tktb9p+8Z9BQHnVBvjgwN8vjgDkpIQjJPRYsV+5DFAuo7JjC
         vLBE2Yf/p3sAo9P8t+kXMtFUq8lpczXR0FoAZkb2nyAI5aVwXJNebMCqJVNu1k7AW45B
         g7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NGh3qV9bnhStjMJvm5/xoTqyt0oZ80U2JyhykslboTM=;
        b=q/WzpOi6rL9qynj6MBmjLhHipe37PQq5s0Ow2bsZH+Rfr8fZXdg/RoSHuOj2yAKuNC
         Ob7DiktZqo9ElFtCT+GYZGQqyDI8S1vfcLMkY7QDX5a0l2+bLf/LNm38ErnUI5tGfcOT
         +7cyLzLPZFav1ZI9Ylrrm1s3PztqZyT1EgtD28+ULbYlmLHiLHwbWjBa0Q6DCJd+pkRZ
         l7IlBx/vddrTOQM/BPgDXuxh1sDQ9RIfIIUPIR9xabhYUFNVdB6HoebX25gD3xgFiHTH
         zPUep3Nv+331A+Eu8Yq8GRpT2AUmBcfnyEzrqNWhg9tBQXTgovIexK+OvWS5iI9VkvOl
         FH9w==
X-Gm-Message-State: AOAM53183zjHOrDAEVb+jKgQXuMdfy8fX365Tr8V70xYP5UgSjR3zmBA
        f2O7vTcoFfgIC4cY+7gckyDZ5vMJ
X-Google-Smtp-Source: ABdhPJy7mglUaNyadtCneLJtoiOr+c9efaQCWD3ufWo36Iu3UnV+qw5Tzxf4W4mHSIiRQbZqzRKXKA==
X-Received: by 2002:a5d:494b:: with SMTP id r11mr2813496wrs.419.1596631783888;
        Wed, 05 Aug 2020 05:49:43 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 33sm2713525wri.16.2020.08.05.05.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 05:49:42 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: PCIe Advanced Error Reporting support
Date:   Wed,  5 Aug 2020 15:49:38 +0300
Message-Id: <20200805124939.13935-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

driver will now get notified upon any PCI error occurred and
will respond according to the severity of the error.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../misc/habanalabs/common/habanalabs_drv.c   | 76 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index c6b31e93fb5e..a36e33c58d37 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -11,6 +11,7 @@
 #include "habanalabs.h"
 
 #include <linux/pci.h>
+#include <linux/aer.h>
 #include <linux/module.h>
 
 #define HL_DRIVER_AUTHOR	"HabanaLabs Kernel Driver Team"
@@ -408,6 +409,8 @@ static int hl_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, hdev);
 
+	pci_enable_pcie_error_reporting(pdev);
+
 	rc = hl_device_init(hdev, hl_class);
 	if (rc) {
 		dev_err(&pdev->dev, "Fatal error during habanalabs device init\n");
@@ -440,22 +443,93 @@ static void hl_pci_remove(struct pci_dev *pdev)
 		return;
 
 	hl_device_fini(hdev);
+	pci_disable_pcie_error_reporting(pdev);
 	pci_set_drvdata(pdev, NULL);
-
 	destroy_hdev(hdev);
 }
 
+/**
+ * hl_pci_err_detected - a PCI bus error detected on this device
+ *
+ * @pdev: pointer to pci device
+ * @err: PCI error type
+ *
+ * Called by the PCI subsystem whenever a non-correctable
+ * PCI bus error is detected
+ */
+static pci_ers_result_t
+hl_pci_err_detected(struct pci_dev *pdev, enum pci_channel_state state)
+{
+	struct hl_device *hdev = pci_get_drvdata(pdev);
+	enum pci_ers_result result;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+
+	case pci_channel_io_frozen:
+		dev_warn(hdev->dev, "frozen state error detected\n");
+		result = PCI_ERS_RESULT_NEED_RESET;
+		break;
+
+	case pci_channel_io_perm_failure:
+		dev_warn(hdev->dev, "failure state error detected\n");
+		result = PCI_ERS_RESULT_DISCONNECT;
+		break;
+
+	default:
+		result = PCI_ERS_RESULT_NONE;
+	}
+
+	hdev->asic_funcs->halt_engines(hdev, true);
+
+	return result;
+}
+
+/**
+ * hl_pci_err_resume - resume after a PCI slot reset
+ *
+ * @pdev: pointer to pci device
+ *
+ */
+static void hl_pci_err_resume(struct pci_dev *pdev)
+{
+	struct hl_device *hdev = pci_get_drvdata(pdev);
+
+	dev_warn(hdev->dev, "Resuming device after PCI slot reset\n");
+	hl_device_resume(hdev);
+}
+
+/**
+ * hl_pci_err_slot_reset - a PCI slot reset has just happened
+ *
+ * @pdev: pointer to pci device
+ *
+ * Determine if the driver can recover from the PCI slot reset
+ */
+static pci_ers_result_t hl_pci_err_slot_reset(struct pci_dev *pdev)
+{
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 static const struct dev_pm_ops hl_pm_ops = {
 	.suspend = hl_pmops_suspend,
 	.resume = hl_pmops_resume,
 };
 
+static const struct pci_error_handlers hl_pci_err_handler = {
+	.error_detected = hl_pci_err_detected,
+	.slot_reset = hl_pci_err_slot_reset,
+	.resume = hl_pci_err_resume,
+};
+
 static struct pci_driver hl_pci_driver = {
 	.name = HL_NAME,
 	.id_table = ids,
 	.probe = hl_pci_probe,
 	.remove = hl_pci_remove,
 	.driver.pm = &hl_pm_ops,
+	.err_handler = &hl_pci_err_handler,
 };
 
 /*
-- 
2.17.1

