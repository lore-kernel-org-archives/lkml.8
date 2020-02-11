Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3774C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7C520714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="GX/TfeW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgBKKfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:21 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:15594 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgBKKfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:04 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48Gzg94jdqzC7;
        Tue, 11 Feb 2020 11:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417301; bh=gsI64DD1kNeK+TXxunWfPL4x93Hi8VLx1d+WlAIlPgE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=GX/TfeW0mldC+XmYLfwocJWvzPuONFxy6JTFHHhauhWhlMHI2lK5bZxM6h0+zcA4N
         whoGDhAgD9ECfey8Ui/9fWsOUhxU2DJvExM9YZBm9/k5XM3CFK7skhClvGJ2GTAtC9
         8rWdTKnxqpLXZs1fLDiuFQpsoRP/qXt8gXieu6izZjXtosl43Htk1OvUiiqcCcmKrM
         tDVSvBNG78SBC0cIUSgoq5CJ+8ISfpDJoj8NJlAkFMP7cAs82K42As5BjGQ91VqDwp
         m3Ij5p2Ek9m3CfIlNo6iBjp2p8I2Vpt7zcl0oCvZXwF4hUReeQg+KV4uS6l9iCBcQY
         ZR8sw4VsNdt+w==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:01 +0100
Message-Id: <f0c66cbb3110c2736cd4357c753fba8c14ee3aee.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 1/6] staging: wfx: fix init/remove vs IRQ race
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code races in init/exit with interrupt handlers. This is noticed
by the warning below. Fix it by using devres for ordering allocations and
IRQ de/registration.

WARNING: CPU: 0 PID: 827 at drivers/staging/wfx/bus_spi.c:142 wfx_spi_irq_handler+0x5c/0x64 [wfx]
race condition in driver init/deinit

Cc: stable@vger.kernel.org
Fixes: 0096214a59a7 ("staging: wfx: add support for I/O access")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: use devres to fix the races
---
 drivers/staging/wfx/bus_sdio.c | 15 ++++++---------
 drivers/staging/wfx/bus_spi.c  | 27 ++++++++++++++-------------
 drivers/staging/wfx/main.c     | 21 +++++++++++++--------
 drivers/staging/wfx/main.h     |  1 -
 4 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/wfx/bus_sdio.c b/drivers/staging/wfx/bus_sdio.c
index f8901164c206..5450bd5e1b5d 100644
--- a/drivers/staging/wfx/bus_sdio.c
+++ b/drivers/staging/wfx/bus_sdio.c
@@ -200,25 +200,23 @@ static int wfx_sdio_probe(struct sdio_func *func,
 	if (ret)
 		goto err0;
 
-	ret = wfx_sdio_irq_subscribe(bus);
-	if (ret)
-		goto err1;
-
 	bus->core = wfx_init_common(&func->dev, &wfx_sdio_pdata,
 				    &wfx_sdio_hwbus_ops, bus);
 	if (!bus->core) {
 		ret = -EIO;
-		goto err2;
+		goto err1;
 	}
 
+	ret = wfx_sdio_irq_subscribe(bus);
+	if (ret)
+		goto err1;
+
 	ret = wfx_probe(bus->core);
 	if (ret)
-		goto err3;
+		goto err2;
 
 	return 0;
 
-err3:
-	wfx_free_common(bus->core);
 err2:
 	wfx_sdio_irq_unsubscribe(bus);
 err1:
@@ -234,7 +232,6 @@ static void wfx_sdio_remove(struct sdio_func *func)
 	struct wfx_sdio_priv *bus = sdio_get_drvdata(func);
 
 	wfx_release(bus->core);
-	wfx_free_common(bus->core);
 	wfx_sdio_irq_unsubscribe(bus);
 	sdio_claim_host(func);
 	sdio_disable_func(func);
diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
index 40bc33035de2..605ad74068b7 100644
--- a/drivers/staging/wfx/bus_spi.c
+++ b/drivers/staging/wfx/bus_spi.c
@@ -154,6 +154,11 @@ static void wfx_spi_request_rx(struct work_struct *work)
 	wfx_bh_request_rx(bus->core);
 }
 
+static void wfx_flush_irq_work(void *w)
+{
+	flush_work(w);
+}
+
 static size_t wfx_spi_align_size(void *priv, size_t size)
 {
 	// Most of SPI controllers avoid DMA if buffer size is not 32bit aligned
@@ -207,22 +212,23 @@ static int wfx_spi_probe(struct spi_device *func)
 		udelay(2000);
 	}
 
-	ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
-			       IRQF_TRIGGER_RISING, "wfx", bus);
-	if (ret)
-		return ret;
-
 	INIT_WORK(&bus->request_rx, wfx_spi_request_rx);
 	bus->core = wfx_init_common(&func->dev, &wfx_spi_pdata,
 				    &wfx_spi_hwbus_ops, bus);
 	if (!bus->core)
 		return -EIO;
 
-	ret = wfx_probe(bus->core);
+	ret = devm_add_action_or_reset(&func->dev, wfx_flush_irq_work,
+				       &bus->request_rx);
 	if (ret)
-		wfx_free_common(bus->core);
+		return ret;
 
-	return ret;
+	ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
+			       IRQF_TRIGGER_RISING, "wfx", bus);
+	if (ret)
+		return ret;
+
+	return wfx_probe(bus->core);
 }
 
 static int wfx_spi_remove(struct spi_device *func)
@@ -230,11 +236,6 @@ static int wfx_spi_remove(struct spi_device *func)
 	struct wfx_spi_priv *bus = spi_get_drvdata(func);
 
 	wfx_release(bus->core);
-	wfx_free_common(bus->core);
-	// A few IRQ will be sent during device release. Hopefully, no IRQ
-	// should happen after wdev/wvif are released.
-	devm_free_irq(&func->dev, func->irq, bus);
-	flush_work(&bus->request_rx);
 	return 0;
 }
 
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 84adad64fc30..76b2ff7fc7fe 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -262,6 +262,16 @@ static int wfx_send_pdata_pds(struct wfx_dev *wdev)
 	return ret;
 }
 
+static void wfx_free_common(void *data)
+{
+	struct wfx_dev *wdev = data;
+
+	mutex_destroy(&wdev->rx_stats_lock);
+	mutex_destroy(&wdev->conf_mutex);
+	wfx_tx_queues_deinit(wdev);
+	ieee80211_free_hw(wdev->hw);
+}
+
 struct wfx_dev *wfx_init_common(struct device *dev,
 				const struct wfx_platform_data *pdata,
 				const struct hwbus_ops *hwbus_ops,
@@ -332,17 +342,12 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wfx_init_hif_cmd(&wdev->hif_cmd);
 	wfx_tx_queues_init(wdev);
 
+	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
+		return NULL;
+
 	return wdev;
 }
 
-void wfx_free_common(struct wfx_dev *wdev)
-{
-	mutex_destroy(&wdev->rx_stats_lock);
-	mutex_destroy(&wdev->conf_mutex);
-	wfx_tx_queues_deinit(wdev);
-	ieee80211_free_hw(wdev->hw);
-}
-
 int wfx_probe(struct wfx_dev *wdev)
 {
 	int i;
diff --git a/drivers/staging/wfx/main.h b/drivers/staging/wfx/main.h
index 875f8c227803..9c9410072def 100644
--- a/drivers/staging/wfx/main.h
+++ b/drivers/staging/wfx/main.h
@@ -34,7 +34,6 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 				const struct wfx_platform_data *pdata,
 				const struct hwbus_ops *hwbus_ops,
 				void *hwbus_priv);
-void wfx_free_common(struct wfx_dev *wdev);
 
 int wfx_probe(struct wfx_dev *wdev);
 void wfx_release(struct wfx_dev *wdev);
-- 
2.20.1

