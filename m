Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C88C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC90206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="ipK8kZ11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbgDCJY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44429 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390618AbgDCJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so7601691wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2x8p8ysEliFz5jE2Oqu/wItdod9o40YesvKMul9whhc=;
        b=ipK8kZ11Xx861bXK7JKJBTZe7qceGcfI/+9Gtdg4R4Neyv7D0AvEK7w/VEJO2hKRgB
         ba2ym/6HGK51Gfs3quEM6aLbEM/c9sbu+zG+/6jpBuI9fCu4D99oPMSYO5RNfDYn4lxE
         7bLI5VpksTCvD4LbEHNpCLz2S3GM5dfaPLfAScvg4luLAIN8TauYYHURBViGAmg2FTer
         eci+Fn83LeqsnGwgAQr4xahccldZanXV8znGtfk5Q3G8ZlW9q+gQnQEkSp+7A62jj0KB
         ZeljPPMt6sjcwcbZ6vh5G4ACSx3gsfS3+d2nTxPWJkDcoddPXpwQb6uei6HFmp6Z8Ii1
         o2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2x8p8ysEliFz5jE2Oqu/wItdod9o40YesvKMul9whhc=;
        b=Ug4eLqMAHzTjQ3FxVJf1Irm/CoWNVFKgIY40HtCbGpPsbBJh38YSDTzM6elI8RLwq3
         uYugbD2gk9y0csHz9UpD8g+QdS43ppXIZSzhgBUOG+5OW1zxbhYkgabTYVnzYwN1rSJC
         NOmS/PtzE+L0ucXPYKQbdUf803y9XLKwH3OtACMusqSIA/E5PXzrne80EjO5JZmxSiSd
         NexBp6SfogrcS/rbBmvmwO70RbYC45DQ5lP+Pc3G+j/yDz3nb2HJqCuFDZH+RC1+I/h7
         bU1RZhA5Soeo+FEqU7kaTL/u97fER5ZXvqmN0IIr5d5fNgxFTsQ3GHizGvC1+G5imf5E
         uozw==
X-Gm-Message-State: AGi0PuZS+1YzoR7751uiyRb5N1FTDXIVq1LttoUyNO1ml2SMVFciOzBi
        5wiGMe5SNJNHA2/1zOJu3PeN5Q==
X-Google-Smtp-Source: APiQypKw6HEIvok/WpHic3c7lXENKAg1I9ouayy+2Q+AEs1grm1dYRpDaYfMpwIxyHwr6UdX8ZkyQg==
X-Received: by 2002:a5d:404a:: with SMTP id w10mr7932066wrp.295.1585905892040;
        Fri, 03 Apr 2020 02:24:52 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t81sm10538068wmb.15.2020.04.03.02.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:51 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 6/7] Revert "serial: uartps: Move Port ID to device data structure"
Date:   Fri,  3 Apr 2020 11:24:35 +0200
Message-Id: <eb0ec98fecdca9b79c1a3ac0c30c668b6973b193.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bed25ac0e2b6ab8f9aed2d20bc9c3a2037311800.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 58f0fa07ecdb..41d9c2f188f0 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -189,7 +189,6 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
  * @pclk:		APB clock
  * @cdns_uart_driver:	Pointer to UART driver
  * @baud:		Current baud rate
- * @id:			Port ID
  * @clk_rate_change_nb:	Notifier block for clock changes
  * @quirks:		Flags for RXBS support.
  */
@@ -199,7 +198,6 @@ struct cdns_uart {
 	struct clk		*pclk;
 	struct uart_driver	*cdns_uart_driver;
 	unsigned int		baud;
-	int			id;
 	struct notifier_block	clk_rate_change_nb;
 	u32			quirks;
 	bool cts_override;
@@ -1412,7 +1410,7 @@ MODULE_DEVICE_TABLE(of, cdns_uart_of_match);
  */
 static int cdns_uart_probe(struct platform_device *pdev)
 {
-	int rc, irq;
+	int rc, id, irq;
 	struct uart_port *port;
 	struct resource *res;
 	struct cdns_uart *cdns_uart_data;
@@ -1438,18 +1436,18 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Look for a serialN alias */
-	cdns_uart_data->id = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (cdns_uart_data->id < 0)
-		cdns_uart_data->id = 0;
+	id = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (id < 0)
+		id = 0;
 
-	if (cdns_uart_data->id >= CDNS_UART_NR_PORTS) {
+	if (id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		return -ENODEV;
 	}
 
 	/* There is a need to use unique driver name */
 	driver_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%d",
-				     CDNS_UART_NAME, cdns_uart_data->id);
+				     CDNS_UART_NAME, id);
 	if (!driver_name)
 		return -ENOMEM;
 
@@ -1457,7 +1455,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
 	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
-	cdns_uart_uart_driver->minor = cdns_uart_data->id;
+	cdns_uart_uart_driver->minor = id;
 	cdns_uart_uart_driver->nr = 1;
 
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
@@ -1468,7 +1466,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-	cdns_uart_console->index = cdns_uart_data->id;
+	cdns_uart_console->index = id;
 	cdns_uart_console->write = cdns_uart_console_write;
 	cdns_uart_console->device = uart_console_device;
 	cdns_uart_console->setup = cdns_uart_console_setup;
@@ -1490,7 +1488,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * registration because tty_driver structure is not filled.
 	 * name_base is 0 by default.
 	 */
-	cdns_uart_uart_driver->tty_driver->name_base = cdns_uart_data->id;
+	cdns_uart_uart_driver->tty_driver->name_base = id;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
-- 
2.26.0

