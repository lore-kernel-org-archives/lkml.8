Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0598BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5F320740
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K/inijt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgCTCCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:02:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40365 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:02:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so1854932plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 19:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxCmmJIeQXXMDK4PXyk/uUgKhxeXHbfjhMrYeRKTAzE=;
        b=K/inijt5Xy0NkV/t8PMLdVKiD30W6z9IktWegvVpXBE+kDdLb8I93hNCeXtvU1dQ5E
         kp6mqdYVJdSQyLJYfFG62u0b41plJY16VIH1Q79pJpub5tIb/jrjcb50jd+nylUrI2Ms
         WaQOjl5/jZD6LH7SdhpwICTtvNCmLyBPTvvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxCmmJIeQXXMDK4PXyk/uUgKhxeXHbfjhMrYeRKTAzE=;
        b=mVL4VZwvHP8gZ/91boSz/xzUcLUAAsSSoQg3IVtImAGvPbsgblo9HTi1hfDMfBn9Yp
         NCv9WGvO6SNVa44jT2wEWqtyZs9Rnd6OqMQbtSQNcQWbTcb0OWMsS8YbcA+qX0Zr5uQC
         61Tj3S1rTI+86ReF52THQ6yMWlBQRbFEnkjUoLmw4kND/7cG5V4BdfHJxKBvu3RiDhus
         l6QFJ/lCXQJCNPn+dkMrjX3Zt3jQRLeoXXKVDvxCuGwZWcUD2E27S2k3Vt5t5LrMOtgG
         CBfc+plkQDSSIyT1qzb8WMZd71RZQPKuZmjXG5UEGoR8Ys54AOwRqw7AY543ZYFh6J39
         DNPQ==
X-Gm-Message-State: ANhLgQ3GmgsU7qPUWJXKe+rIFZhwIhmzXWCFwbkJV3w5SxoWtzwcMbwT
        tfhmCr+K6RgfEUz5sV++x2kXEg==
X-Google-Smtp-Source: ADFU+vt0iHeozfFwcY0DOwR+KMv94sZ1RWrzdYePPtfXVvqMNZvkMhHZrPMAJ6ya0IuoOq9Xg6O+4Q==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr5985653pln.185.1584669722286;
        Thu, 19 Mar 2020 19:02:02 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y13sm3475705pfp.88.2020.03.19.19.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:02:01 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
        ulf.hansson@linaro.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mka@chromium.org,
        dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: btmrvl: Detect hangs and force a reset of the SDIO card
Date:   Thu, 19 Mar 2020 19:01:53 -0700
Message-Id: <20200319190144.1.I40cc9b3d5de04f0631c931d94757fb0f462b24bd@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320020153.98280-1-abhishekpandit@chromium.org>
References: <20200320020153.98280-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

When scanning for BLE devices for a longer period (e.g. because a
BLE device is paired, but not connected) the Marvell 8997 often
ends up in a borked state, which manifests through failures on
certain SDIO transactions.

When such a SDIO failure is detected force a reset of the SDIO
card to initialize it from scratch. Since the SDIO bus is shared
with the WiFi part of the chip this also involves a reset of WiFi.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btmrvl_sdio.c | 24 ++++++++++++++++++++++++
 drivers/bluetooth/btmrvl_sdio.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f3a020703ab..69a8b6b3c11c 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
+#include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/module.h>
@@ -59,6 +61,23 @@ static const struct of_device_id btmrvl_sdio_of_match_table[] = {
 	{ }
 };
 
+static void btmrvl_sdio_card_reset_work(struct work_struct *work)
+{
+	struct btmrvl_sdio_card *card =
+		container_of(work, struct btmrvl_sdio_card, reset_work);
+	struct sdio_func *func = card->func;
+
+	sdio_claim_host(func);
+	mmc_hw_reset(func->card->host);
+	sdio_release_host(func);
+}
+
+static void btmrvl_sdio_card_reset(struct btmrvl_sdio_card *card)
+{
+	BT_ERR("resetting SDIO card!");
+	schedule_work(&card->reset_work);
+}
+
 static irqreturn_t btmrvl_wake_irq_bt(int irq, void *priv)
 {
 	struct btmrvl_sdio_card *card = priv;
@@ -774,6 +793,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 	ret = btmrvl_sdio_read_rx_len(card, &buf_len);
 	if (ret < 0) {
 		BT_ERR("read rx_len failed");
+		btmrvl_sdio_card_reset(card);
 		ret = -EIO;
 		goto exit;
 	}
@@ -809,6 +829,7 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
 			  num_blocks * blksz);
 	if (ret < 0) {
 		BT_ERR("readsb failed: %d", ret);
+		btmrvl_sdio_card_reset(card);
 		ret = -EIO;
 		goto exit;
 	}
@@ -913,6 +934,7 @@ static int btmrvl_sdio_read_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
 	ret = sdio_readsb(card->func, adapter->hw_regs, 0, SDIO_BLOCK_SIZE);
 	if (ret) {
 		BT_ERR("sdio_readsb: read int hw_regs failed: %d", ret);
+		btmrvl_sdio_card_reset(card);
 		return ret;
 	}
 
@@ -1591,6 +1613,8 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 		card->supports_fw_dump = data->supports_fw_dump;
 	}
 
+	INIT_WORK(&card->reset_work, btmrvl_sdio_card_reset_work);
+
 	if (btmrvl_sdio_register_dev(card) < 0) {
 		BT_ERR("Failed to register BT device!");
 		return -ENODEV;
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 3a522d23ee6e..d35a2f1b7046 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -103,6 +103,7 @@ struct btmrvl_sdio_card {
 	struct btmrvl_private *priv;
 	struct device_node *plt_of_node;
 	struct btmrvl_plt_wake_cfg *plt_wake_cfg;
+	struct work_struct reset_work;
 };
 
 struct btmrvl_sdio_device {
-- 
2.25.1.696.g5e7596f4ac-goog

