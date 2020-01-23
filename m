Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC5C33CBA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530BD24655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao6lIidT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgAWLTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:19:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39008 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgAWLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:19:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1225027plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uT4jStC2COjiLy5iu1J5/xW3m4eW/2z2+pN3SjDLaws=;
        b=ao6lIidT/kfOyv95yQA8Lu9FCrKSRWJimu2Kx1IRPv29RCD/NPi/FYYUmD6MFmGVwK
         UKHs5ohaOOEyTGSjWmAJp8yRxkE1UZVozkeDbH4EXbwtIBqgk7/h3exTCOsPjt8TdHZ3
         Gn8tseWyt6RpnU3DF4T2HhDkiy1x6Bb7TOc9FQ6eoLMQrgO5FrFrn6XzFHe5/4xN3v0q
         bYOq7VcSco/MOnbIlpCb4YWu5UQxp7r5f9hTv6YsXMnERmf7jUF7UYsZsHbmroIoN68E
         L8KiVCeagoeWVY581IktPXa8IquC5I/M+KKyBUWUFihw5r2UnDmUvEWHzQ0GGizZLM2C
         JLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uT4jStC2COjiLy5iu1J5/xW3m4eW/2z2+pN3SjDLaws=;
        b=B/FJm2DDQmSiAMKLADUfvn3/mn5NR5V8pgB1EqL2Xp8icRnNKJomvsJsRKwWJQVizP
         H06LYzwEaRBIjIqf5HJxTo+hJeuLzL18HVO7xXG4c1yXzH/aaY0qoPioYvORtmHjgqkW
         R6XvGW7Ymj93tjvKMMveVy7OTdk5D8GcWsI55R5ckcCgSSdFTQaxNmmQ4EM56RIwGOYq
         mPfhZhZZcABPiKvDFyyelYP8cmaixkpKoS6h+jqZ8pj3Y0J/9T7Hgua0vr1meNpHFYiH
         uNTDU5LkH5CFY2pfpaaRWmgRmRG6ZgeOQ3nlIkFr9t93k08xlLS8wmNXyDAvK/ooeyY4
         u0cA==
X-Gm-Message-State: APjAAAW3VtLYP7ZUWLzoQbgXMp8zN5vSRH7cddDEghNANEmqVZruD9Zs
        g4owIdPIansK4EVjeQ99sUfY
X-Google-Smtp-Source: APXvYqzeDK3voTfF3J7OPkgCU/t8XojBSc7HjGmUL5qKGGDBq8HpiMj5//lngt96xarRCqULWgXebA==
X-Received: by 2002:a17:902:8d8a:: with SMTP id v10mr15412330plo.90.1579778353855;
        Thu, 23 Jan 2020 03:19:13 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id y6sm2627559pgc.10.2020.01.23.03.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:19:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/16] bus: mhi: core: Add support for downloading firmware over BHIe
Date:   Thu, 23 Jan 2020 16:48:28 +0530
Message-Id: <20200123111836.7414-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MHI supports downloading the device firmware over BHI/BHIe (Boot Host
Interface) protocol. Hence, this commit adds necessary helpers, which
will be called during device power up stage.

This is based on the patch submitted by Sujeev Dias:
https://lkml.org/lkml/2018/7/9/989

Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
[mani: splitted the data transfer patch and cleaned up for upstream]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c     | 268 ++++++++++++++++++++++++++++++++
 drivers/bus/mhi/core/init.c     |   1 +
 drivers/bus/mhi/core/internal.h |   1 +
 3 files changed, 270 insertions(+)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 0996f18c4281..36956fb6eff2 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -20,6 +20,121 @@
 #include <linux/wait.h>
 #include "internal.h"
 
+/* Download AMSS image to device */
+static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
+			    const struct mhi_buf *mhi_buf)
+{
+	void __iomem *base = mhi_cntrl->bhie;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	u32 tx_status, sequence_id;
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		return -EIO;
+	}
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
+		      upper_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_LOW_OFFS,
+		      lower_32_bits(mhi_buf->dma_addr));
+
+	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
+
+	sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
+	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
+			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
+			    sequence_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base,
+					      BHIE_TXVECSTATUS_OFFS,
+					      BHIE_TXVECSTATUS_STATUS_BMSK,
+					      BHIE_TXVECSTATUS_STATUS_SHFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		return -EIO;
+
+	return (tx_status == BHIE_TXVECSTATUS_STATUS_XFER_COMPL) ? 0 : -EIO;
+}
+
+/* Download SBL image to device */
+static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
+			   dma_addr_t dma_addr,
+			   size_t size)
+{
+	u32 tx_status, val, session_id;
+	int i, ret;
+	void __iomem *base = mhi_cntrl->bhi;
+	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
+	struct {
+		char *name;
+		u32 offset;
+	} error_reg[] = {
+		{ "ERROR_CODE", BHI_ERRCODE },
+		{ "ERROR_DBG1", BHI_ERRDBG1 },
+		{ "ERROR_DBG2", BHI_ERRDBG2 },
+		{ "ERROR_DBG3", BHI_ERRDBG3 },
+		{ NULL },
+	};
+
+	read_lock_bh(pm_lock);
+	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	/* Start SBL download via BHI protocol */
+	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
+		      upper_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
+		      lower_32_bits(dma_addr));
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
+	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
+	read_unlock_bh(pm_lock);
+
+	/* Wait for the image download to complete */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+			   MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
+			   mhi_read_reg_field(mhi_cntrl, base, BHI_STATUS,
+					      BHI_STATUS_MASK, BHI_STATUS_SHIFT,
+					      &tx_status) || tx_status,
+			   msecs_to_jiffies(mhi_cntrl->timeout_ms));
+	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state))
+		goto invalid_pm_state;
+
+	if (tx_status == BHI_STATUS_ERROR) {
+		dev_err(mhi_cntrl->dev, "Image transfer failed\n");
+		read_lock_bh(pm_lock);
+		if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
+			for (i = 0; error_reg[i].name; i++) {
+				ret = mhi_read_reg(mhi_cntrl, base,
+						   error_reg[i].offset, &val);
+				if (ret)
+					break;
+				dev_err(mhi_cntrl->dev, "Reg: %s value: 0x%x\n",
+					error_reg[i].name, val);
+			}
+		}
+		read_unlock_bh(pm_lock);
+		goto invalid_pm_state;
+	}
+
+	return (!ret) ? -ETIMEDOUT : 0;
+
+invalid_pm_state:
+
+	return -EIO;
+}
+
 void mhi_free_bhie_table(struct mhi_controller *mhi_cntrl,
 			 struct image_info *image_info)
 {
@@ -87,3 +202,156 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
 
 	return -ENOMEM;
 }
+
+static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
+			      const struct firmware *firmware,
+			      struct image_info *img_info)
+{
+	size_t remainder = firmware->size;
+	size_t to_cpy;
+	const u8 *buf = firmware->data;
+	int i = 0;
+	struct mhi_buf *mhi_buf = img_info->mhi_buf;
+	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+
+	while (remainder) {
+		to_cpy = min(remainder, mhi_buf->len);
+		memcpy(mhi_buf->buf, buf, to_cpy);
+		bhi_vec->dma_addr = mhi_buf->dma_addr;
+		bhi_vec->size = to_cpy;
+
+		buf += to_cpy;
+		remainder -= to_cpy;
+		i++;
+		bhi_vec++;
+		mhi_buf++;
+	}
+}
+
+void mhi_fw_load_worker(struct work_struct *work)
+{
+	int ret;
+	struct mhi_controller *mhi_cntrl;
+	const char *fw_name;
+	const struct firmware *firmware = NULL;
+	struct image_info *image_info;
+	void *buf;
+	dma_addr_t dma_addr;
+	size_t size;
+
+	mhi_cntrl = container_of(work, struct mhi_controller, fw_worker);
+
+	dev_dbg(mhi_cntrl->dev, "Waiting for device to enter PBL from: %s\n",
+		TO_MHI_EXEC_STR(mhi_cntrl->ee));
+
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 MHI_IN_PBL(mhi_cntrl->ee) ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev, "Device MHI is not in valid state\n");
+		return;
+	}
+
+	/* If device is in pass through, do reset to ready state transition */
+	if (mhi_cntrl->ee == MHI_EE_PTHRU)
+		goto fw_load_ee_pthru;
+
+	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
+		mhi_cntrl->edl_image : mhi_cntrl->fw_image;
+
+	if (!fw_name || (mhi_cntrl->fbc_download && (!mhi_cntrl->sbl_size ||
+						     !mhi_cntrl->seg_len))) {
+		dev_err(mhi_cntrl->dev,
+			"No firmware image defined or !sbl_size || !seg_len\n");
+		return;
+	}
+
+	ret = request_firmware(&firmware, fw_name, mhi_cntrl->dev);
+	if (ret) {
+		dev_err(mhi_cntrl->dev, "Error loading firmware: %d\n",
+			ret);
+		return;
+	}
+
+	size = (mhi_cntrl->fbc_download) ? mhi_cntrl->sbl_size : firmware->size;
+
+	/* SBL size provided is maximum size, not necessarily the image size */
+	if (size > firmware->size)
+		size = firmware->size;
+
+	buf = mhi_alloc_coherent(mhi_cntrl, size, &dma_addr, GFP_KERNEL);
+	if (!buf) {
+		release_firmware(firmware);
+		return;
+	}
+
+	/* Download SBL image */
+	memcpy(buf, firmware->data, size);
+	ret = mhi_fw_load_sbl(mhi_cntrl, dma_addr, size);
+	mhi_free_coherent(mhi_cntrl, size, buf, dma_addr);
+
+	if (!mhi_cntrl->fbc_download || ret || mhi_cntrl->ee == MHI_EE_EDL)
+		release_firmware(firmware);
+
+	/* Error or in EDL mode, we're done */
+	if (ret || mhi_cntrl->ee == MHI_EE_EDL)
+		return;
+
+	write_lock_irq(&mhi_cntrl->pm_lock);
+	mhi_cntrl->dev_state = MHI_STATE_RESET;
+	write_unlock_irq(&mhi_cntrl->pm_lock);
+
+	/*
+	 * If we're doing fbc, populate vector tables while
+	 * device transitioning into MHI READY state
+	 */
+	if (mhi_cntrl->fbc_download) {
+		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
+					   firmware->size);
+		if (ret)
+			goto error_alloc_fw_table;
+
+		/* Load the firmware into BHIE vec table */
+		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
+	}
+
+fw_load_ee_pthru:
+	/* Transitioning into MHI RESET->READY state */
+	ret = mhi_ready_state_transition(mhi_cntrl);
+
+	if (!mhi_cntrl->fbc_download)
+		return;
+
+	if (ret)
+		goto error_read;
+
+	/* Wait for the SBL event */
+	ret = wait_event_timeout(mhi_cntrl->state_event,
+				 mhi_cntrl->ee == MHI_EE_SBL ||
+				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state),
+				 msecs_to_jiffies(mhi_cntrl->timeout_ms));
+
+	if (!ret || MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
+		dev_err(mhi_cntrl->dev, "MHI did not enter SBL\n");
+		goto error_read;
+	}
+
+	/* Start full firmware image download */
+	image_info = mhi_cntrl->fbc_image;
+	ret = mhi_fw_load_amss(mhi_cntrl,
+			       /* Vector table is the last entry */
+			       &image_info->mhi_buf[image_info->entries - 1]);
+
+	release_firmware(firmware);
+
+	return;
+
+error_read:
+	mhi_free_bhie_table(mhi_cntrl, mhi_cntrl->fbc_image);
+	mhi_cntrl->fbc_image = NULL;
+
+error_alloc_fw_table:
+	release_firmware(firmware);
+}
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 7fff92e9661b..2f06bf958f58 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -753,6 +753,7 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 	spin_lock_init(&mhi_cntrl->wlock);
 	INIT_WORK(&mhi_cntrl->st_worker, mhi_pm_st_worker);
 	INIT_WORK(&mhi_cntrl->syserr_worker, mhi_pm_sys_err_worker);
+	INIT_WORK(&mhi_cntrl->fw_worker, mhi_fw_load_worker);
 	init_waitqueue_head(&mhi_cntrl->state_event);
 
 	mhi_cmd = mhi_cntrl->mhi_cmd;
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index d920264ded21..eab9c051ca5e 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -590,6 +590,7 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
 			       enum dev_st_transition state);
 void mhi_pm_st_worker(struct work_struct *work);
 void mhi_pm_sys_err_worker(struct work_struct *work);
+void mhi_fw_load_worker(struct work_struct *work);
 int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
 void mhi_ctrl_ev_task(unsigned long data);
 int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
-- 
2.17.1

