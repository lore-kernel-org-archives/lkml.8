Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92059214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ut1nxyn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390644AbgDCJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40032 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390586AbgDCJYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s8so5512120wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7pHx0/EXbtoV5+rhsgFvftYW29NmU7J5D/NZ/j6E1w=;
        b=ut1nxyn5/OcfY3fenkF9A1yKJWmdlxIuQ3wwOua8AWghDRLCEXazrkr4Wi5FuMVjh3
         h3Oeeamlm8HEhHV6S34fiL5dmhjqqK8YgLo6UnapGtRhTCvZ8m6MhWVwyInnPySrZt2E
         NupufDUxoqTmUKtKz5HJ8dEzLugE8JSNozVeyGY5T4x5J00WqwPPkazQMluKuDkHo4E4
         i1iEfIZs3M1YeGACmMpXG1t03xSiT2YPJylzINfKR1kXkuH/Tla2TsBkRGXBcW1HwfZt
         Vo9G4zenUhDhUDGaEy1DJMrgHWIC4KJMfaUSv93q9yI9mKvxZdH+rM9y8cD8FM1zCoap
         FsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=k7pHx0/EXbtoV5+rhsgFvftYW29NmU7J5D/NZ/j6E1w=;
        b=YMbZOHI9NsCIwYBGIlFyZv3gXxgGGr1a/eLaqhak60BYd3c6NTXMh/BZ9GwYOPbm+g
         kQTv0PrTG2x415TgJwuVxLhclhk/zhZWJ1EN2PvA9QZJNBSFIRBR0xSGwjTERb2jGz21
         HYWy6Nto8A4bDf0nCXRj+fa33b/7ifBBIWoCB9powR+p4Fgwm/l7y5WjSuBsNN7GSkFl
         DhEWqzs4VEVeszFhpz1U11oS0LqiKXOyj1GKcRgUrD1fvj14fGxQPEkTVW46+1DoXO1h
         xHvlyoxWVNukEuRvLziErscYZZe2aK62lxRYvV3blSe+QopyyUGGqq4ey0z9ty5M3mQE
         KsWQ==
X-Gm-Message-State: AGi0PubPvD8P3Kz7ADbtrKEO3LGLZaVObojPmQxOIYVSUtwMBSaIWdnf
        1iXcHwqOIQrR97V+JNEjvfYFEA==
X-Google-Smtp-Source: APiQypItR+mPFkFOGIQ34VqT1/BW5ruIBYcNzjc5P8OWkqLo97sjt04dCvHuy4/kCfEUmuC5BRyXEg==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr8560262wrp.403.1585905890415;
        Fri, 03 Apr 2020 02:24:50 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id r14sm10907567wmg.0.2020.04.03.02.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:49 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 5/7] Revert "serial: uartps: Change uart ID port allocation"
Date:   Fri,  3 Apr 2020 11:24:34 +0200
Message-Id: <a94931b65ce0089f76fb1fe6b446a08731bff754.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ae1cca3fa3478be92948dbbcd722390272032ade.

With setting up NR_PORTS to 16 to be able to use serial2 and higher
aliases and don't loose functionality which was intended by these changes.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 111 ++++-------------------------
 1 file changed, 13 insertions(+), 98 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 9db3cd120057..58f0fa07ecdb 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -27,6 +27,7 @@
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
 #define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
+#define CDNS_UART_NR_PORTS	16
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 #define TX_TIMEOUT		500000
@@ -1403,90 +1404,6 @@ static const struct of_device_id cdns_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
 
-/*
- * Maximum number of instances without alias IDs but if there is alias
- * which target "< MAX_UART_INSTANCES" range this ID can't be used.
- */
-#define MAX_UART_INSTANCES	32
-
-/* Stores static aliases list */
-static DECLARE_BITMAP(alias_bitmap, MAX_UART_INSTANCES);
-static int alias_bitmap_initialized;
-
-/* Stores actual bitmap of allocated IDs with alias IDs together */
-static DECLARE_BITMAP(bitmap, MAX_UART_INSTANCES);
-/* Protect bitmap operations to have unique IDs */
-static DEFINE_MUTEX(bitmap_lock);
-
-static int cdns_get_id(struct platform_device *pdev)
-{
-	int id, ret;
-
-	mutex_lock(&bitmap_lock);
-
-	/* Alias list is stable that's why get alias bitmap only once */
-	if (!alias_bitmap_initialized) {
-		ret = of_alias_get_alias_list(cdns_uart_of_match, "serial",
-					      alias_bitmap, MAX_UART_INSTANCES);
-		if (ret && ret != -EOVERFLOW) {
-			mutex_unlock(&bitmap_lock);
-			return ret;
-		}
-
-		alias_bitmap_initialized++;
-	}
-
-	/* Make sure that alias ID is not taken by instance without alias */
-	bitmap_or(bitmap, bitmap, alias_bitmap, MAX_UART_INSTANCES);
-
-	dev_dbg(&pdev->dev, "Alias bitmap: %*pb\n",
-		MAX_UART_INSTANCES, bitmap);
-
-	/* Look for a serialN alias */
-	id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (id < 0) {
-		dev_warn(&pdev->dev,
-			 "No serial alias passed. Using the first free id\n");
-
-		/*
-		 * Start with id 0 and check if there is no serial0 alias
-		 * which points to device which is compatible with this driver.
-		 * If alias exists then try next free position.
-		 */
-		id = 0;
-
-		for (;;) {
-			dev_info(&pdev->dev, "Checking id %d\n", id);
-			id = find_next_zero_bit(bitmap, MAX_UART_INSTANCES, id);
-
-			/* No free empty instance */
-			if (id == MAX_UART_INSTANCES) {
-				dev_err(&pdev->dev, "No free ID\n");
-				mutex_unlock(&bitmap_lock);
-				return -EINVAL;
-			}
-
-			dev_dbg(&pdev->dev, "The empty id is %d\n", id);
-			/* Check if ID is empty */
-			if (!test_and_set_bit(id, bitmap)) {
-				/* Break the loop if bit is taken */
-				dev_dbg(&pdev->dev,
-					"Selected ID %d allocation passed\n",
-					id);
-				break;
-			}
-			dev_dbg(&pdev->dev,
-				"Selected ID %d allocation failed\n", id);
-			/* if taking bit fails then try next one */
-			id++;
-		}
-	}
-
-	mutex_unlock(&bitmap_lock);
-
-	return id;
-}
-
 /**
  * cdns_uart_probe - Platform driver probe
  * @pdev: Pointer to the platform device structure
@@ -1520,17 +1437,21 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (!cdns_uart_uart_driver)
 		return -ENOMEM;
 
-	cdns_uart_data->id = cdns_get_id(pdev);
+	/* Look for a serialN alias */
+	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (cdns_uart_data->id < 0)
-		return cdns_uart_data->id;
+		cdns_uart_data->id = 0;
+
+	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
+		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
+		return -ENODEV;
+	}
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
 				     CDNS_UART_NAME, cdns_uart_data->id);
-	if (!driver_name) {
-		rc = -ENOMEM;
-		goto err_out_id;
-	}
+	if (!driver_name)
+		return -ENOMEM;
 
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
@@ -1559,7 +1480,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	rc = uart_register_driver(cdns_uart_uart_driver);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to register driver\n");
-		goto err_out_id;
+		return rc;
 	}
 
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
@@ -1710,10 +1631,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	clk_disable_unprepare(cdns_uart_data->pclk);
 err_out_unregister_driver:
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
-err_out_id:
-	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
-	mutex_unlock(&bitmap_lock);
+
 	return rc;
 }
 
@@ -1736,9 +1654,6 @@ static int cdns_uart_remove(struct platform_device *pdev)
 #endif
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
-	mutex_lock(&bitmap_lock);
-	clear_bit(cdns_uart_data->id, bitmap);
-	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
 	pm_runtime_disable(&pdev->dev);
-- 
2.26.0

