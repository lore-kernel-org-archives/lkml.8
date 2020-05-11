Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399CBC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02CBA208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMYFpRdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgEKLcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729633AbgEKLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA438C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:42 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so4586374wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=8M0Yw9ZlP27+yzyoFVtekQdQVFPvIzmyNfdaeC4ZVlY=;
        b=hMYFpRdngomdb01Dd8GsxZKG9csptP1GQIO+RgDQFPblYjYaHoiFoCh4BCVHf6LKiH
         C9Jz28aO1DGFyMK35p3rLMPSAi4K02G9mZTgXOzvOwAHQFlmN9o8jNQCXIKAPCJmQpQ6
         VGyKC+j/P33DGVqSppQc0YpGYFOJiRvYvIHximBqAm9DnHO2oOFmFcM9rL7/0wV2WJH1
         iqleSKLsHHxajJ2AjrOZ+KajoFBW4BqDJsSVfesgnaOQSYmN3LCUWvWW/OTaU3LNWaVb
         8H3f50HgHl5dJiPyyF/sEy5G6x4EFUKkymavULIQX8AhtByovnFfX+Mp2uQBO4MUL/OS
         HP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=8M0Yw9ZlP27+yzyoFVtekQdQVFPvIzmyNfdaeC4ZVlY=;
        b=HZ6ibkN5lPO51b4S1ADCmMUt8r3B/XlGCNM0KVK3gz9RlG1fqhaIE5HkO/tLzgUI6e
         T7HHNK9eD2iN7brD8wbAsAwyii+2ntTt8ptGXLY/B4maJGhoJ2EfqStCo2Q629YnhiwX
         1eQSDYW0mdzIU9CRmtEbHrY3k+yCELgYFlA37JyJDAUGWtODKlqMdAXoY/80v4qCN+s5
         KSmQJoW++xiEsviXnRteZlAA3Ko1rJh8N4u0OySL2ffn4QFZUAtDNGH9A743EUkrGwcI
         0HBPKmwD0tQzXENzr0EcxFYBekFRitE55pFglqb9slW14nkAgEx64zXPmsVhrNYCSDe9
         WKBg==
X-Gm-Message-State: AGi0PuYKdmZXctjkpTRDM38QYGcTq4XCypP+B/PIM7jOxIXSSjgrutFY
        ALlmpwRxvxRpeJGX3FDWTvtRaVpa
X-Google-Smtp-Source: APiQypKgCm2AzfIdlcWfm5LynfPv0aLA7VgVckwg9OJ+0TbtBzzt8gR8VxHKbbEGAcXR17Ix2xUX1w==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr9777299wrt.158.1589196760968;
        Mon, 11 May 2020 04:32:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 03/11] habanalabs: support clock gating enable/disable
Date:   Mon, 11 May 2020 14:32:24 +0300
Message-Id: <20200511113232.5771-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511113232.5771-1-oded.gabbay@gmail.com>
References: <20200511113232.5771-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Gaudi there is a feature of clock gating certain engines.
Therefore, add this property to the device structure.

In addition, due to a limitation of this feature, the driver needs to
dynamically enable or disable this feature during run-time. Therefore, add
ASIC interface functions to enable/disable this function from the common
code.

Moreover, this feature must be turned off when the user wishes to debug the
ASIC by reading/writing registers and/or memory through the driver's
debugfs. Therefore, add an option to enable/disable clock gating via the
debugfs interface.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/debugfs-driver-habanalabs     | 10 +++
 drivers/misc/habanalabs/debugfs.c             | 61 +++++++++++++++++++
 drivers/misc/habanalabs/device.c              |  4 ++
 drivers/misc/habanalabs/goya/goya.c           | 12 ++++
 drivers/misc/habanalabs/habanalabs.h          |  6 ++
 drivers/misc/habanalabs/habanalabs_drv.c      |  1 +
 6 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 67e04f2d7e1d..f6d9c2a8d528 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -8,6 +8,16 @@ Description:    Sets the device address to be used for read or write through
                 only when the IOMMU is disabled.
                 The acceptable value is a string that starts with "0x"
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/clk_gate
+Date:           May 2020
+KernelVersion:  5.8
+Contact:        oded.gabbay@gmail.com
+Description:    Allow the root user to disable/enable in runtime the clock
+                gating mechanism in Gaudi. Due to how Gaudi is built, the
+                clock gating needs to be disabled in order to access the
+                registers of the TPC and MME engines. This is sometimes needed
+                during debug by the user and hence the user needs this option
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 37beff3096f8..3c8dcdfba20c 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -970,6 +970,55 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_clk_gate_read(struct file *f, char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	char tmp_buf[200];
+	ssize_t rc;
+
+	if (*ppos)
+		return 0;
+
+	sprintf(tmp_buf, "%d\n", hdev->clock_gating);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_clk_gate_write(struct file *f, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev,
+				"Can't change clock gating during reset\n");
+		return 0;
+	}
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	if (value) {
+		hdev->clock_gating = 1;
+		if (hdev->asic_funcs->enable_clock_gating)
+			hdev->asic_funcs->enable_clock_gating(hdev);
+	} else {
+		if (hdev->asic_funcs->disable_clock_gating)
+			hdev->asic_funcs->disable_clock_gating(hdev);
+		hdev->clock_gating = 0;
+	}
+
+	return count;
+}
+
 static ssize_t hl_stop_on_err_read(struct file *f, char __user *buf,
 					size_t count, loff_t *ppos)
 {
@@ -1058,6 +1107,12 @@ static const struct file_operations hl_device_fops = {
 	.write = hl_device_write
 };
 
+static const struct file_operations hl_clk_gate_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_clk_gate_read,
+	.write = hl_clk_gate_write
+};
+
 static const struct file_operations hl_stop_on_err_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_stop_on_err_read,
@@ -1201,6 +1256,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_device_fops);
 
+	debugfs_create_file("clk_gate",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_clk_gate_fops);
+
 	debugfs_create_file("stop_on_err",
 				0644,
 				dev_entry->root,
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index f618cff9a167..7ce4540648cf 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -603,6 +603,9 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 
 		hdev->in_debug = 0;
 
+		if (!hdev->hard_reset_pending)
+			hdev->asic_funcs->enable_clock_gating(hdev);
+
 		goto out;
 	}
 
@@ -613,6 +616,7 @@ int hl_device_set_debug_mode(struct hl_device *hdev, bool enable)
 		goto out;
 	}
 
+	hdev->asic_funcs->disable_clock_gating(hdev);
 	hdev->in_debug = 1;
 
 out:
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index fb2ff82e0db5..56f415f9120a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5018,6 +5018,16 @@ int goya_armcp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
+static void goya_enable_clock_gating(struct hl_device *hdev)
+{
+
+}
+
+static void goya_disable_clock_gating(struct hl_device *hdev)
+{
+
+}
+
 static bool goya_is_device_idle(struct hl_device *hdev, u32 *mask,
 				struct seq_file *s)
 {
@@ -5239,6 +5249,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.mmu_invalidate_cache = goya_mmu_invalidate_cache,
 	.mmu_invalidate_cache_range = goya_mmu_invalidate_cache_range,
 	.send_heartbeat = goya_send_heartbeat,
+	.enable_clock_gating = goya_enable_clock_gating,
+	.disable_clock_gating = goya_disable_clock_gating,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
 	.soft_reset_late_init = goya_soft_reset_late_init,
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index d77410886a67..b1c3a89c7f38 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -578,6 +578,8 @@ enum hl_pll_frequency {
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
+ * @enable_clock_gating: enable clock gating for reducing power consumption.
+ * @disable_clock_gating: disable clock for accessing registers on HBW.
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
  * @soft_reset_late_init: perform certain actions needed after soft reset.
@@ -678,6 +680,8 @@ struct hl_asic_funcs {
 	void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 			u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
+	void (*enable_clock_gating)(struct hl_device *hdev);
+	void (*disable_clock_gating)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u32 *mask,
 				struct seq_file *s);
@@ -1408,6 +1412,7 @@ struct hl_device_idle_busy_ts {
  *                   huge pages.
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
+ * @clock_gating: is clock gating enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fpriv_list, enforces
@@ -1494,6 +1499,7 @@ struct hl_device {
 	u8				dram_default_page_mapping;
 	u8				pmmu_huge_range;
 	u8				init_done;
+	u8				clock_gating;
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 5e73b456facd..822acb5a00bb 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -231,6 +231,7 @@ static void set_driver_behavior_per_device(struct hl_device *hdev)
 	hdev->fw_loading = 1;
 	hdev->cpu_queues_enable = 1;
 	hdev->heartbeat = 1;
+	hdev->clock_gating = 1;
 
 	hdev->reset_pcilink = 0;
 }
-- 
2.17.1

