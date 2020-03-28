Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A6FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF71206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsA6647y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1Iwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:52:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41894 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgC1Iwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so14534942wrc.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aDZg4QZxHpMF1pfEf60w/KD9yrkJym+QYMZCsG1rfho=;
        b=VsA6647yN6mosYpWrA6IGo5hgmBHD3xikhTZQkh7EjHjPAEJno7IHmlAHvq8HTtXv4
         tiJRGVVHsoW2cgCOliqKHcnRSuLkgsTaLnqAh31jgK+oP1DGFW5xI2M8rad0x5GqDE50
         M8AxWlzqTnoIgkpY/yfo3UH24x3UMIFMde/q0YgJWGtInqe5i0BX7gwUFAJa2fV4e+sX
         T0+ixvL2paSnkFk2kt+aWgD+5/0veCboiyfpV7saOC0MplonEbQzKnPlYE4jT1emU2f+
         TiT43xYJK3NT2FVN67fX9YbumVT5Ev+UArFl/+CAf2AVOVuAhkfZtBoW8mdTloOyOvdL
         Pa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aDZg4QZxHpMF1pfEf60w/KD9yrkJym+QYMZCsG1rfho=;
        b=dgLgyfozbMFbBxXIWwyadQ6rN8+uU+WAwR+P+gB0Pp5vJE+/uQJZhrv7fbTGiYGsfE
         /xQjxkThqxeWb7OLHPylcPXTvY1G1rxjijNIL0pf8PfAw5XOObcqy/YExK+VF11pWadV
         D/l6SprOF/MxZz/9ltH3fegYp4SRmr6gVEuVj9QMZsbB239ALE/PCXciwi7nzLH+aG+0
         J7zds2W+72q0UJ8ksB3tjXPw5Ekeb9LKsw9U2+lYLx2e5YNXLP6Yv5JTjJqgyESVf+JU
         CHQX7Ra0Wr4hvcjHkX5vESfOcfO9oyZR1NNCs3NBQyCO3RnGx+E9qrNRDJg0JBK8Jf+F
         YJ7Q==
X-Gm-Message-State: ANhLgQ2GqFnxQ8wr6nhoS56nkxLmuy11xEyciAA88SK6rvb1BtFSrL60
        nqTZuwTgotbAqi4T1WHmqs7iBEGS
X-Google-Smtp-Source: ADFU+vt1zKaWqffJEZHTBxXn3bmfYblQpSQcRUnLj5wG3NDS0MfLvm7gLzmy7Pc8G42nAjbhoQXjAA==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr3698025wrw.234.1585385564659;
        Sat, 28 Mar 2020 01:52:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/6] habanalabs: remove stop-on-error flag from DMA
Date:   Sat, 28 Mar 2020 11:52:34 +0300
Message-Id: <20200328085238.3428-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Stop-on-error mode in DMA is useful as it stops the transaction
immediately upon error e.g. page fault.
But it may cause the next command submission to fail as is leaves the DMA
in unstable state.
Therefore we remove the stop-on-error configuration from the DMA.
Stop-on-err is still available for debug.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/debugfs-driver-habanalabs     |  7 +++
 drivers/misc/habanalabs/debugfs.c             | 55 +++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c           |  6 +-
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 .../include/goya/asic_reg/goya_masks.h        |  3 +-
 5 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index a73601c5121e..67e04f2d7e1d 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -150,3 +150,10 @@ KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
 Description:    Displays a list with information about all the active virtual
                 address mappings per ASID
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
+Date:           Mar 2020
+KernelVersion:  5.6
+Contact:        oded.gabbay@gmail.com
+Description:    Sets the stop-on_error option for the device engines. Value of
+                "0" is for disable, otherwise enable.
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 756d36ed5d95..37beff3096f8 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -970,6 +970,49 @@ static ssize_t hl_device_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static ssize_t hl_stop_on_err_read(struct file *f, char __user *buf,
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
+	sprintf(tmp_buf, "%d\n", hdev->stop_on_err);
+	rc = simple_read_from_buffer(buf, strlen(tmp_buf) + 1, ppos, tmp_buf,
+			strlen(tmp_buf) + 1);
+
+	return rc;
+}
+
+static ssize_t hl_stop_on_err_write(struct file *f, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 value;
+	ssize_t rc;
+
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev,
+				"Can't change stop on error during reset\n");
+		return 0;
+	}
+
+	rc = kstrtouint_from_user(buf, count, 10, &value);
+	if (rc)
+		return rc;
+
+	hdev->stop_on_err = value ? 1 : 0;
+
+	hl_device_reset(hdev, false, false);
+
+	return count;
+}
+
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_data_read32,
@@ -1015,6 +1058,12 @@ static const struct file_operations hl_device_fops = {
 	.write = hl_device_write
 };
 
+static const struct file_operations hl_stop_on_err_fops = {
+	.owner = THIS_MODULE,
+	.read = hl_stop_on_err_read,
+	.write = hl_stop_on_err_write
+};
+
 static const struct hl_info_list hl_debugfs_list[] = {
 	{"command_buffers", command_buffers_show, NULL},
 	{"command_submission", command_submission_show, NULL},
@@ -1152,6 +1201,12 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 				dev_entry,
 				&hl_device_fops);
 
+	debugfs_create_file("stop_on_err",
+				0644,
+				dev_entry->root,
+				dev_entry,
+				&hl_stop_on_err_fops);
+
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 
 		ent = debugfs_create_file(hl_debugfs_list[i].name,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index db125cf80850..08f1d4080008 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -800,6 +800,7 @@ static void goya_init_dma_qman(struct hl_device *hdev, int dma_id,
 	u32 so_base_lo, so_base_hi;
 	u32 gic_base_lo, gic_base_hi;
 	u32 reg_off = dma_id * (mmDMA_QM_1_PQ_PI - mmDMA_QM_0_PQ_PI);
+	u32 dma_err_cfg = QMAN_DMA_ERR_MSG_EN;
 
 	mtr_base_lo = lower_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
 	mtr_base_hi = upper_32_bits(CFG_BASE + mmSYNC_MNGR_MON_PAY_ADDRL_0);
@@ -836,7 +837,10 @@ static void goya_init_dma_qman(struct hl_device *hdev, int dma_id,
 	else
 		WREG32(mmDMA_QM_0_GLBL_PROT + reg_off, QMAN_DMA_FULLY_TRUSTED);
 
-	WREG32(mmDMA_QM_0_GLBL_ERR_CFG + reg_off, QMAN_DMA_ERR_MSG_EN);
+	if (hdev->stop_on_err)
+		dma_err_cfg |= 1 << DMA_QM_0_GLBL_ERR_CFG_DMA_STOP_ON_ERR_SHIFT;
+
+	WREG32(mmDMA_QM_0_GLBL_ERR_CFG + reg_off, dma_err_cfg);
 	WREG32(mmDMA_QM_0_GLBL_CFG0 + reg_off, QMAN_DMA_ENABLE);
 }
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 31ebcf9458fe..ae3db8eb2fb5 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1300,6 +1300,7 @@ struct hl_device_idle_busy_ts {
  * @in_debug: is device under debug. This, together with fpriv_list, enforces
  *            that only a single user is configuring the debug infrastructure.
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
+ * @stop_on_err: true if engines should stop on error.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1380,6 +1381,7 @@ struct hl_device {
 	u8				dma_mask;
 	u8				in_debug;
 	u8				cdev_sysfs_created;
+	u8				stop_on_err;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
diff --git a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
index 3c44ef3a23ed..067489bd048e 100644
--- a/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
+++ b/drivers/misc/habanalabs/include/goya/asic_reg/goya_masks.h
@@ -55,8 +55,7 @@
 	(1 << DMA_QM_0_GLBL_ERR_CFG_DMA_ERR_MSG_EN_SHIFT) | \
 	(1 << DMA_QM_0_GLBL_ERR_CFG_PQF_STOP_ON_ERR_SHIFT) | \
 	(1 << DMA_QM_0_GLBL_ERR_CFG_CQF_STOP_ON_ERR_SHIFT) | \
-	(1 << DMA_QM_0_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT) | \
-	(1 << DMA_QM_0_GLBL_ERR_CFG_DMA_STOP_ON_ERR_SHIFT))
+	(1 << DMA_QM_0_GLBL_ERR_CFG_CP_STOP_ON_ERR_SHIFT))
 
 #define QMAN_MME_ENABLE		(\
 	(1 << MME_QM_GLBL_CFG0_PQF_EN_SHIFT) | \
-- 
2.17.1

