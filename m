Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DB2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA08A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yqxeccx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgF2VUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgF2Swt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DB3C02E2D4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so15527899wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MA4D/3EmXU00HIViUNDTK2zztNgG9GHE3QsyfvIeaek=;
        b=Yqxeccx+BeP2NcoVf8V9CW9Kfpy/B9e8WWtiZSLEHcXHUfBkdQr5EVkUMgJXYsMhRX
         eauSayO11Dx3fdjMWqVvKs8GhjWRJLil0U37o7wDe0enpWSyrIfJfS8I0zq1UCIH1waR
         nSq/2T/OlzJugB5pOGYgAC0+y4dfD241WRypgzJ6jV0dSfxi7/PVCjfJJf6sgOjNVlhz
         uAAUA0LtZmQhBOmnS6splciovURAzeKzs5zQCV19j1xV1Woy2IFAqcrzrujtgS/xZEoE
         SW69zYx+gng/6cTnFfPiy0h4WZAr2yIQIHpdb5NMI1ipqNxuU3XKJB3ENdl0yGYKwOTt
         nM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MA4D/3EmXU00HIViUNDTK2zztNgG9GHE3QsyfvIeaek=;
        b=rpEwvJA8wMqb5ROmu3Dn/yxxuhRRfLMO9qruiDWiwXUMl7317d0/FRazxAzmwMItvh
         VD2pVfl8qKp0KdX1rW2Dp09tjhhmW4au3fug0c5xSDJ5qoFZ4qNF3NNfW783UNpjqKYr
         87kn8lsgKKpTG9lsRXMmEAihOSoK7My8xwbcJz0qPSdigTRf1jw2pBwM16S53U+AZiWg
         hzkyR/I+oh/VDcDo1XbAicZCAjArghtd67175O9EO8LNxkgXr6J6kLcIrXrhwU7Y51kl
         +35MzHU4PKyN4/GruCnjTManYCNdsJClA2m5oBvBUh5x05qGsTG8JcuHOAnJ3kxIlXhU
         uBPQ==
X-Gm-Message-State: AOAM530+5M0d8GtVJV84J07D1bTWNSvcqbFgCvXe38eLpWhbCV3OU25e
        WAJcCfAoZTy6ZQV8brKNd+fDcQ==
X-Google-Smtp-Source: ABdhPJxDNp7vd10O4kA6m0+v/7iGwoA/DNFCia8vBm/9JG0WJDOmhz/GZXc5w1/8d9K8otS7NjxLwg==
X-Received: by 2002:a1c:bdc3:: with SMTP id n186mr1698099wmf.84.1593439500590;
        Mon, 29 Jun 2020 07:05:00 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:04:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Stefan Roese <sr@denx.de>
Subject: [PATCH 12/20] misc: lattice-ecp3-config: Remove set but clearly unused variable 'ret'
Date:   Mon, 29 Jun 2020 15:04:34 +0100
Message-Id: <20200629140442.1043957-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's odd for the return value to be assigned to a variable so many
times, but never actually checked, but this has been the case since
the driver's inception in 2012.  If it hasn't caused any issues by
now, it's probably unlikely to.  Let's take it out, at least until
someone finds a reason to start using it.

Fixes the following W=1 kernel build warning:

 drivers/misc/lattice-ecp3-config.c: In function ‘firmware_load’:
 drivers/misc/lattice-ecp3-config.c:70:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
 70 | int ret;
 | ^~~

Cc: Stefan Roese <sr@denx.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/lattice-ecp3-config.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/lattice-ecp3-config.c b/drivers/misc/lattice-ecp3-config.c
index 884485c3f7232..5eaf74447ca1e 100644
--- a/drivers/misc/lattice-ecp3-config.c
+++ b/drivers/misc/lattice-ecp3-config.c
@@ -67,7 +67,6 @@ static void firmware_load(const struct firmware *fw, void *context)
 	struct spi_device *spi = (struct spi_device *)context;
 	struct fpga_data *data = spi_get_drvdata(spi);
 	u8 *buffer;
-	int ret;
 	u8 txbuf[8];
 	u8 rxbuf[8];
 	int rx_len = 8;
@@ -92,7 +91,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 
 	/* Trying to speak with the FPGA via SPI... */
 	txbuf[0] = FPGA_CMD_READ_ID;
-	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
 	jedec_id = get_unaligned_be32(&rxbuf[4]);
 	dev_dbg(&spi->dev, "FPGA JTAG ID=%08x\n", jedec_id);
 
@@ -110,7 +109,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 	dev_info(&spi->dev, "FPGA %s detected\n", ecp3_dev[i].name);
 
 	txbuf[0] = FPGA_CMD_READ_STATUS;
-	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
 	status = get_unaligned_be32(&rxbuf[4]);
 	dev_dbg(&spi->dev, "FPGA Status=%08x\n", status);
 
@@ -130,20 +129,20 @@ static void firmware_load(const struct firmware *fw, void *context)
 	memcpy(buffer + 4, fw->data, fw->size);
 
 	txbuf[0] = FPGA_CMD_REFRESH;
-	ret = spi_write(spi, txbuf, 4);
+	spi_write(spi, txbuf, 4);
 
 	txbuf[0] = FPGA_CMD_WRITE_EN;
-	ret = spi_write(spi, txbuf, 4);
+	spi_write(spi, txbuf, 4);
 
 	txbuf[0] = FPGA_CMD_CLEAR;
-	ret = spi_write(spi, txbuf, 4);
+	spi_write(spi, txbuf, 4);
 
 	/*
 	 * Wait for FPGA memory to become cleared
 	 */
 	for (i = 0; i < FPGA_CLEAR_LOOP_COUNT; i++) {
 		txbuf[0] = FPGA_CMD_READ_STATUS;
-		ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+		spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
 		status = get_unaligned_be32(&rxbuf[4]);
 		if (status == FPGA_STATUS_CLEARED)
 			break;
@@ -160,13 +159,13 @@ static void firmware_load(const struct firmware *fw, void *context)
 	}
 
 	dev_info(&spi->dev, "Configuring the FPGA...\n");
-	ret = spi_write(spi, buffer, fw->size + 8);
+	spi_write(spi, buffer, fw->size + 8);
 
 	txbuf[0] = FPGA_CMD_WRITE_DIS;
-	ret = spi_write(spi, txbuf, 4);
+	spi_write(spi, txbuf, 4);
 
 	txbuf[0] = FPGA_CMD_READ_STATUS;
-	ret = spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
+	spi_write_then_read(spi, txbuf, 8, rxbuf, rx_len);
 	status = get_unaligned_be32(&rxbuf[4]);
 	dev_dbg(&spi->dev, "FPGA Status=%08x\n", status);
 
-- 
2.25.1

