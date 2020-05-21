Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FF9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99632065F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEu+tgPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgEUHCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbgEUHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:02:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE41CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so1334849wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fbhc9Uc961//sNLKiqrYZROYOtQKJP3LnakGvoYx7dQ=;
        b=FEu+tgPECyszNO7TO7GIzQ0RWovU9DxpXVK380vh7hJe6n5fECj5kIaHoU5fBwWskX
         aAnBIg0sUoyiB/3jnB8mOiHBJ9Btt/rANFsVC3KU9Em84GDhirZzmsk7NozYMenXREjb
         9Qj63nOU3ws3xPQlWhFU3cywt5RZaanpwxp0APJV5Y/p3UNQ+lbCT+SkhRdxuEpCMVyp
         Gzk7yJN+TMzL22bQTyNwOEmrOECdCR7onRN8iMCMEKuzx83ezIA8kjsspzqo2PHnOzWb
         XdKeKCYy2/HnhMMi0Q1WUtNIVkNUsCRhAnbHyJkhuLfjlbRhZJOEP/5wUQ5g1RCLoQf0
         O5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fbhc9Uc961//sNLKiqrYZROYOtQKJP3LnakGvoYx7dQ=;
        b=YjqCDkHUBV4d9JbBOCuf/RbKancGEUXo82oM/sIM5k0Ni4tGFDy+JqebKJiGmMsAxB
         +1KG8kMbzAL0B3XvMxTiN+UvNM6aTML5MRyeWH9LqbqjX10a6sRIOeTTI2tpq1ZkPK/O
         Lv/moVFo73tH4SzaFIYOndHTARddvtzJbqZKjokvkW075YEFdsHaLQSdBTeNEBaqzSwk
         oXLD2L1PngCeHNA9UP3kYI+EL5lKvn8HQb5+/YIRBz+Tt7OFAup9wgz1TQr29od+eRWj
         xZtav4SKGc1Rs/ljSHjqls7/XzXqlBJmRfAmLXtRElksyG/PpK7gLN0PrtDYiiC+dAjz
         KAkA==
X-Gm-Message-State: AOAM531BoLA22ordybLgImKktG/bDab2OUGb9dZRKBAAQbmOf+hokyMy
        qJtjAKCMa9DreR0/NNZRcziqGXa8
X-Google-Smtp-Source: ABdhPJx9AHx1ZhamKPHIyfZa28TzkakMreBa7KSWsvYNafefKdor3nmA4RAeoCld+Gk6rIi4fbKEfQ==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr7741586wro.255.1590044536224;
        Thu, 21 May 2020 00:02:16 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id w20sm5448205wmk.25.2020.05.21.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:02:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/4] habanalabs: GAUDI does not support soft-reset
Date:   Thu, 21 May 2020 10:02:04 +0300
Message-Id: <20200521070205.26673-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521070205.26673-1-oded.gabbay@gmail.com>
References: <20200521070205.26673-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GAUDI does not support soft-reset as it leaves the NIC ports in an awkward
state, where their QMANs were reset but the NIC itself is still working.

In addition, there is not much sense in doing soft-reset when training is
done on multiple GAUDIs.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c      |  6 +++++
 drivers/misc/habanalabs/gaudi/gaudi.c | 38 +++++++++++++++------------
 drivers/misc/habanalabs/goya/goya.c   |  1 +
 drivers/misc/habanalabs/habanalabs.h  |  2 ++
 drivers/misc/habanalabs/sysfs.c       |  5 ++++
 5 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 4b6c8de46dd8..4a4a446f479e 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -801,6 +801,7 @@ static void device_hard_reset_pending(struct work_struct *work)
  * @hdev: pointer to habanalabs device structure
  * @hard_reset: should we do hard reset to all engines or just reset the
  *              compute/dma engines
+ * @from_hard_reset_thread: is the caller the hard-reset thread
  *
  * Block future CS and wait for pending CS to be enqueued
  * Call ASIC H/W fini
@@ -823,6 +824,11 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		return 0;
 	}
 
+	if ((!hard_reset) && (!hdev->supports_soft_reset)) {
+		dev_dbg(hdev->dev, "Doing hard-reset instead of soft-reset\n");
+		hard_reset = true;
+	}
+
 	/*
 	 * Prevent concurrency in this function - only one reset should be
 	 * done at any given time. Only need to perform this if we didn't
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3d4a569914d3..92a5130f06fb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5774,7 +5774,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
 			>> EQ_CTL_EVENT_TYPE_SHIFT);
 	u8 cause;
-	bool soft_reset_required;
+	bool reset_required;
 
 	gaudi->events_stat[event_type]++;
 	gaudi->events_stat_aggregate[event_type]++;
@@ -5840,16 +5840,18 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_TPC6_DEC:
 	case GAUDI_EVENT_TPC7_DEC:
 		gaudi_print_irq_info(hdev, event_type, true);
-		soft_reset_required = gaudi_tpc_read_interrupts(hdev,
+		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_dec_event_to_tpc_id(event_type),
 					"AXI_SLV_DEC_Error");
-		if (soft_reset_required) {
-			dev_err_ratelimited(hdev->dev,
-					"soft reset required due to %s\n",
-					gaudi_irq_map_table[event_type].name);
-			hl_device_reset(hdev, false, false);
+		if (reset_required) {
+			dev_err(hdev->dev, "hard reset required due to %s\n",
+				gaudi_irq_map_table[event_type].name);
+
+			if (hdev->hard_reset_on_fw_events)
+				hl_device_reset(hdev, true, false);
+		} else {
+			hl_fw_unmask_irq(hdev, event_type);
 		}
-		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_TPC0_KRN_ERR:
@@ -5861,16 +5863,18 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_TPC6_KRN_ERR:
 	case GAUDI_EVENT_TPC7_KRN_ERR:
 		gaudi_print_irq_info(hdev, event_type, true);
-		soft_reset_required = gaudi_tpc_read_interrupts(hdev,
+		reset_required = gaudi_tpc_read_interrupts(hdev,
 					tpc_krn_event_to_tpc_id(event_type),
 					"KRN_ERR");
-		if (soft_reset_required) {
-			dev_err_ratelimited(hdev->dev,
-					"soft reset required due to %s\n",
-					gaudi_irq_map_table[event_type].name);
-			hl_device_reset(hdev, false, false);
+		if (reset_required) {
+			dev_err(hdev->dev, "hard reset required due to %s\n",
+				gaudi_irq_map_table[event_type].name);
+
+			if (hdev->hard_reset_on_fw_events)
+				hl_device_reset(hdev, true, false);
+		} else {
+			hl_fw_unmask_irq(hdev, event_type);
 		}
-		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_PCIE_CORE_SERR:
@@ -5921,8 +5925,8 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 
 	case GAUDI_EVENT_RAZWI_OR_ADC_SW:
 		gaudi_print_irq_info(hdev, event_type, true);
-		hl_device_reset(hdev, false, false);
-		hl_fw_unmask_irq(hdev, event_type);
+		if (hdev->hard_reset_on_fw_events)
+			hl_device_reset(hdev, true, false);
 		break;
 
 	case GAUDI_EVENT_TPC0_BMON_SPMU:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 15b6c3228e37..152418dfe20c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -752,6 +752,7 @@ static int goya_sw_init(struct hl_device *hdev)
 
 	spin_lock_init(&goya->hw_queues_lock);
 	hdev->supports_coresight = true;
+	hdev->supports_soft_reset = true;
 
 	return 0;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 5a855b7edf43..0f0691875298 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1436,6 +1436,7 @@ struct hl_device_idle_busy_ts {
  * @stop_on_err: true if engines should stop on error.
  * @supports_sync_stream: is sync stream supported.
  * @supports_coresight: is CoreSight supported.
+ * @supports_soft_reset: is soft reset supported.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1522,6 +1523,7 @@ struct hl_device {
 	u8				stop_on_err;
 	u8				supports_sync_stream;
 	u8				supports_coresight;
+	u8				supports_soft_reset;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index e4454414d0e1..5d78d5e1c782 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -183,6 +183,11 @@ static ssize_t soft_reset_store(struct device *dev,
 		goto out;
 	}
 
+	if (!hdev->supports_soft_reset) {
+		dev_err(hdev->dev, "Device does not support soft-reset\n");
+		goto out;
+	}
+
 	dev_warn(hdev->dev, "Soft-Reset requested through sysfs\n");
 
 	hl_device_reset(hdev, false, false);
-- 
2.17.1

