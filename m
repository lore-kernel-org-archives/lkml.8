Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C112C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356D8206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 04:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="sRnSlAbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgCVEdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 00:33:33 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1058 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgCVEdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 00:33:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48lPlX6smlz9Y;
        Sun, 22 Mar 2020 05:33:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584851609; bh=C8e5pKmEfUU+/34pD/pB8sAms2bn/d06yI4BbHoDCfM=;
        h=Date:From:Subject:To:Cc:From;
        b=sRnSlAbbte+rmAkBIvOStnCK5wfC6ORRdetGOh9oQPObxbvM7b3MD5AI08Yua1+3z
         D5ifJM3sSifPBgpVQzFbv4UTAvCFJMo09FDnaxjFyyveMrse01oDMG3Cyqlc2yD4aD
         u5qRFswL2nOyGMOk3VMn6SxwPEKqWYEmpdYKM155oK49mjMdGOBFpWiyvlpaYOfVvB
         ew81nrQLkZFSL3grtmwpwJGw3SJL6bImP1qe8HYLmQ5kRkBo73gGL8bauYMxb8x85h
         O/FDRW+7Kzi6+mfJ+Ag6uzY09dd37TTbHerQp8UxGhrj0ypQrrm1hFUbENtfNkFLqJ
         KeG7N9LkF1/dw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 22 Mar 2020 05:33:27 +0100
Message-Id: <55613934b7d14ae4122b648c20351b63b03a1385.1584851536.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] i2c: at91: support atomic write xfer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement basic support for atomic write - enough to get a simple
write to PMIC on shutdown. Only for chips having ALT_CMD register,
eg. SAMA5D2.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: remove runtime-PM usage
    switch to readl*poll*atomic() for transfer completion wait
v3: build fixes
---
 drivers/i2c/busses/i2c-at91-master.c | 69 +++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index ba6fbb9c7390..10c66809df83 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -21,8 +21,10 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dma-atmel.h>
 #include <linux/pm_runtime.h>
@@ -709,6 +711,68 @@ static int at91_twi_xfer(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
 	return ret;
 }
 
+static int at91_twi_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msg, int num)
+{
+	struct at91_twi_dev *dev = i2c_get_adapdata(adap);
+	struct pinctrl *pins;
+	__u32 stat;
+	int ret;
+
+	/* FIXME: only single write request supported to 7-bit addr */
+	if (num != 1)
+		return -EOPNOTSUPP;
+	if (msg->flags & I2C_M_RD)
+		return -EOPNOTSUPP;
+	if (msg->flags & I2C_M_TEN)
+		return -EOPNOTSUPP;
+	if (msg->len > dev->fifo_size && msg->len > 1)
+		return -EOPNOTSUPP;
+	if (!dev->pdata->has_alt_cmd)
+		return -EOPNOTSUPP;
+
+	pins = pinctrl_get_select_default(&adap->dev);
+
+	ret = clk_prepare_enable(dev->clk);
+	if (ret)
+		goto out;
+
+	/* Clear and disable pending interrupts, such as NACK. */
+	at91_twi_read(dev, AT91_TWI_SR);
+	at91_twi_write(dev, AT91_TWI_IDR, ~0);
+
+	at91_twi_write(dev, AT91_TWI_MMR, msg->addr << 16);
+
+	if (!msg->len) {
+		at91_twi_write(dev, AT91_TWI_CR,
+			       AT91_TWI_ACMDIS | AT91_TWI_QUICK);
+	} else {
+		size_t n = msg->len;
+		__u8 *p;
+
+		at91_twi_write(dev, AT91_TWI_CR,
+				    AT91_TWI_ACMEN |
+				    AT91_TWI_THRCLR | AT91_TWI_RHRCLR);
+		at91_twi_write(dev, AT91_TWI_ACR, AT91_TWI_ACR_DATAL(n));
+		for (p = msg->buf; n--; ++p)
+			writeb_relaxed(*p, dev->base + AT91_TWI_THR);
+	}
+
+	readl_relaxed_poll_timeout_atomic(dev->base + AT91_TWI_SR, stat,
+					  stat & AT91_TWI_TXCOMP, 100,
+					  (2 + msg->len) * 1000);
+	if (stat & AT91_TWI_NACK)
+		ret = -EREMOTEIO;
+	else
+		ret = num;
+
+	clk_disable_unprepare(dev->clk);
+out:
+	if (!IS_ERR(pins))
+		pinctrl_put(pins);
+
+	return ret;
+}
+
 /*
  * The hardware can handle at most two messages concatenated by a
  * repeated start via it's internal address feature.
@@ -725,8 +789,9 @@ static u32 at91_twi_func(struct i2c_adapter *adapter)
 }
 
 static const struct i2c_algorithm at91_twi_algorithm = {
-	.master_xfer	= at91_twi_xfer,
-	.functionality	= at91_twi_func,
+	.master_xfer		= at91_twi_xfer,
+	.master_xfer_atomic	= at91_twi_xfer_atomic,
+	.functionality		= at91_twi_func,
 };
 
 static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
-- 
2.20.1

