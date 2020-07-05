Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7F9C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80452075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRdeBB5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGENMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6CC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so38818792wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYJarRYk6o1F2ye7TmGbn9RIA3mYpXI9HqDJ3GfMipE=;
        b=cRdeBB5KgKVOsp+qhFRdYCoRNAJ9Q906WrypglcI/9dx8ed1kBbvI9WhMKM9lYcb9q
         VaTQQJfFPtbtvduUiphg/jCmAxm2EbDAJgflVoreemcbjIqjL2JKJzcVeuUhQ3Dtg+kX
         J/TZdgplQBQTBiEz6VS2ZslLIde7BL/ZojVPpxEKx7ML4X5Abx2FQdO0GzCbhqO+F9MF
         gsqyYWVrdQJVxMTFZX5TuPdvi6e25bCuyUQT4rFcGlwDo8dA9XIx6xrQSBnUBG8/T+te
         8q+VNNvNoctu7XfNRLAj+mCZGstmi8XWSgrmwIK0BZxifKrcqVIjJvhkQQYoX7iISlVq
         S6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYJarRYk6o1F2ye7TmGbn9RIA3mYpXI9HqDJ3GfMipE=;
        b=BGoOCiXrOiSwWDgLVOn7lkwz04VyxZvVokEQHhh5SapSS1kWBoyjSzez/SzRrx083j
         GJTeNBHFEjkX6Dp5rWYb7KGCUkVJ2gxBVhi3+4UbV2LXANlBIlbjOIB2UImU1R3t3AN4
         DkIEQbh9MKhg8H1iv8zodxZBysTp+CVTahwpSLD5CbJGsLyIneYtVM1wvCSQ4kxn7YMT
         AkjNtxkeaLaJvLHyg5XVRrYFTnQtPFVbrUQzd1NKz7GSMFR1ujHIpvPILAzQiTXzWD89
         kmbwwzOncLnO40BSzeGgGE/1Rhkw7+RcqMHZTMs9eyWxMjpRAIAmBAKhx4DcAj8+NTZT
         nlog==
X-Gm-Message-State: AOAM5326exb8eSrZ90qKHFM7bflFZf9SPLqqBxs0K3H630nZgsM0tF1Q
        PCK2XxV84u7Bw5C/WKPWKbmIYHpB
X-Google-Smtp-Source: ABdhPJzOB1YF8M+yoK71jn/I9lP/WHwSdg2HrzmrUiNMGxqarEeLQ4sCtVqPFAWFenG+J4Amle8sGw==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr44779246wmc.188.1593954768108;
        Sun, 05 Jul 2020 06:12:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:46 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Christine Gharzuzi <cgharzuzi@habana.ai>
Subject: [PATCH 3/9] habanalabs: extract cpu boot status lookup
Date:   Sun,  5 Jul 2020 16:12:39 +0300
Message-Id: <20200705131245.9368-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christine Gharzuzi <cgharzuzi@habana.ai>

Extract detection of the cpu boot status to a function
to allow code reuse

Signed-off-by: Christine Gharzuzi <cgharzuzi@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/firmware_if.c | 92 ++++++++++++++-------------
 1 file changed, 48 insertions(+), 44 deletions(-)

diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 9e7f203a09d7..3be1549cd137 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -393,6 +393,53 @@ static void fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg)
 			"Device boot error - NIC F/W initialization failed\n");
 }
 
+static void hl_detect_cpu_boot_status(struct hl_device *hdev, u32 status)
+{
+	switch (status) {
+	case CPU_BOOT_STATUS_NA:
+		dev_err(hdev->dev,
+			"Device boot error - BTL did NOT run\n");
+		break;
+	case CPU_BOOT_STATUS_IN_WFE:
+		dev_err(hdev->dev,
+			"Device boot error - Stuck inside WFE loop\n");
+		break;
+	case CPU_BOOT_STATUS_IN_BTL:
+		dev_err(hdev->dev,
+			"Device boot error - Stuck in BTL\n");
+		break;
+	case CPU_BOOT_STATUS_IN_PREBOOT:
+		dev_err(hdev->dev,
+			"Device boot error - Stuck in Preboot\n");
+		break;
+	case CPU_BOOT_STATUS_IN_SPL:
+		dev_err(hdev->dev,
+			"Device boot error - Stuck in SPL\n");
+		break;
+	case CPU_BOOT_STATUS_IN_UBOOT:
+		dev_err(hdev->dev,
+			"Device boot error - Stuck in u-boot\n");
+		break;
+	case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
+		dev_err(hdev->dev,
+			"Device boot error - DRAM initialization failed\n");
+		break;
+	case CPU_BOOT_STATUS_UBOOT_NOT_READY:
+		dev_err(hdev->dev,
+			"Device boot error - u-boot stopped by user\n");
+		break;
+	case CPU_BOOT_STATUS_TS_INIT_FAIL:
+		dev_err(hdev->dev,
+			"Device boot error - Thermal Sensor initialization failed\n");
+		break;
+	default:
+		dev_err(hdev->dev,
+			"Device boot error - Invalid status code %d\n",
+			status);
+		break;
+	}
+}
+
 int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 			u32 msg_to_cpu_reg, u32 cpu_msg_status_reg,
 			u32 boot_err0_reg, bool skip_bmc,
@@ -466,50 +513,7 @@ int hl_fw_init_cpu(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	 * versions but we keep them here for backward compatibility
 	 */
 	if (rc) {
-		switch (status) {
-		case CPU_BOOT_STATUS_NA:
-			dev_err(hdev->dev,
-				"Device boot error - BTL did NOT run\n");
-			break;
-		case CPU_BOOT_STATUS_IN_WFE:
-			dev_err(hdev->dev,
-				"Device boot error - Stuck inside WFE loop\n");
-			break;
-		case CPU_BOOT_STATUS_IN_BTL:
-			dev_err(hdev->dev,
-				"Device boot error - Stuck in BTL\n");
-			break;
-		case CPU_BOOT_STATUS_IN_PREBOOT:
-			dev_err(hdev->dev,
-				"Device boot error - Stuck in Preboot\n");
-			break;
-		case CPU_BOOT_STATUS_IN_SPL:
-			dev_err(hdev->dev,
-				"Device boot error - Stuck in SPL\n");
-			break;
-		case CPU_BOOT_STATUS_IN_UBOOT:
-			dev_err(hdev->dev,
-				"Device boot error - Stuck in u-boot\n");
-			break;
-		case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
-			dev_err(hdev->dev,
-				"Device boot error - DRAM initialization failed\n");
-			break;
-		case CPU_BOOT_STATUS_UBOOT_NOT_READY:
-			dev_err(hdev->dev,
-				"Device boot error - u-boot stopped by user\n");
-			break;
-		case CPU_BOOT_STATUS_TS_INIT_FAIL:
-			dev_err(hdev->dev,
-				"Device boot error - Thermal Sensor initialization failed\n");
-			break;
-		default:
-			dev_err(hdev->dev,
-				"Device boot error - Invalid status code %d\n",
-				status);
-			break;
-		}
-
+		hl_detect_cpu_boot_status(hdev, status);
 		rc = -EIO;
 		goto out;
 	}
-- 
2.17.1

