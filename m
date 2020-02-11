Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B48C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF4420714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="o6WsPurw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBKKfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:05 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:30738 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBKKfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:04 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzgB3DDSz204;
        Tue, 11 Feb 2020 11:35:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417302; bh=pM3kHma+Yvip/GLz2vbupcyRhREUkJGO1ZAbFLVGKU0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=o6WsPurwin5fAaNOs8xOSe39rwq7VCDL8BRIpeupmWcrGT3UUVq7C295xB2OqqIK9
         YtyugyBobgVjLJfkP8Gz9/COu2sOtMFj/MQ85/p7BE+SHLlj2v/FFcb4cT7YLxRuw5
         WoKLDk/MhMhXaKxFXDKb0MxQVTZIL7R+jgmVEV1UVctj6VYLnpU8m75dLiZqMXVAQI
         x4YNlv9whNIIF2g2xuFt4REcayXPw+AwEIpSC8PfJL9JdVySBDiB/wWJqmEfvmcqms
         Nf56LrQNu1suABUD6fmawP/SZQGTdPoUz1EDPs3qtNksS24WBd9bEDLCRl4kyoL4OF
         cVWMLBjvFKsZQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:02 +0100
Message-Id: <0e6dda06f145676861860f073a53dc95987c7ab5.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 3/6] staging: wfx: add proper "compatible" string
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

Add "compatible" string matching "vendor,chip" template and proper
GPIO flags handling. Keep support for old name and reset polarity
for older devicetrees.

Cc: stable@vger.kernel.org   # d3a5bcb4a17f ("gpio: add gpiod_toggle_active_low()")
Cc: stable@vger.kernel.org
Fixes: 0096214a59a7 ("staging: wfx: add support for I/O access")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 .../bindings/net/wireless/siliabs,wfx.txt          |  7 ++++---
 drivers/staging/wfx/bus_spi.c                      | 14 ++++++++++----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
index 26de6762b942..52f97673da1e 100644
--- a/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
+++ b/drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt
@@ -6,7 +6,7 @@ SPI
 You have to declare the WFxxx chip in your device tree.
 
 Required properties:
- - compatible: Should be "silabs,wfx-spi"
+ - compatible: Should be "silabs,wf200"
  - reg: Chip select address of device
  - spi-max-frequency: Maximum SPI clocking speed of device in Hz
  - interrupts-extended: Should contain interrupt line (interrupt-parent +
@@ -15,6 +15,7 @@ Required properties:
 Optional properties:
  - reset-gpios: phandle of gpio that will be used to reset chip during probe.
    Without this property, you may encounter issues with warm boot.
+   (Legacy: when compatible == "silabs,wfx-spi", the gpio is inverted.)
 
 Please consult Documentation/devicetree/bindings/spi/spi-bus.txt for optional
 SPI connection related properties,
@@ -23,12 +24,12 @@ Example:
 
 &spi1 {
 	wfx {
-		compatible = "silabs,wfx-spi";
+		compatible = "silabs,wf200";
 		pinctrl-names = "default";
 		pinctrl-0 = <&wfx_irq &wfx_gpios>;
 		interrupts-extended = <&gpio 16 IRQ_TYPE_EDGE_RISING>;
 		wakeup-gpios = <&gpio 12 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
 		reg = <0>;
 		spi-max-frequency = <42000000>;
 	};
diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
index 605ad74068b7..d6a75bd61595 100644
--- a/drivers/staging/wfx/bus_spi.c
+++ b/drivers/staging/wfx/bus_spi.c
@@ -27,6 +27,8 @@ MODULE_PARM_DESC(gpio_reset, "gpio number for reset. -1 for none.");
 #define SET_WRITE 0x7FFF        /* usage: and operation */
 #define SET_READ 0x8000         /* usage: or operation */
 
+#define WFX_RESET_INVERTED 1
+
 static const struct wfx_platform_data wfx_spi_pdata = {
 	.file_fw = "wfm_wf200",
 	.file_pds = "wf200.pds",
@@ -206,9 +208,11 @@ static int wfx_spi_probe(struct spi_device *func)
 	if (!bus->gpio_reset) {
 		dev_warn(&func->dev, "try to load firmware anyway\n");
 	} else {
-		gpiod_set_value(bus->gpio_reset, 0);
-		udelay(100);
+		if (spi_get_device_id(func)->driver_data & WFX_RESET_INVERTED)
+			gpiod_toggle_active_low(bus->gpio_reset);
 		gpiod_set_value(bus->gpio_reset, 1);
+		udelay(100);
+		gpiod_set_value(bus->gpio_reset, 0);
 		udelay(2000);
 	}
 
@@ -245,14 +249,16 @@ static int wfx_spi_remove(struct spi_device *func)
  * stripped.
  */
 static const struct spi_device_id wfx_spi_id[] = {
-	{ "wfx-spi", 0 },
+	{ "wfx-spi", WFX_RESET_INVERTED },
+	{ "wf200", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, wfx_spi_id);
 
 #ifdef CONFIG_OF
 static const struct of_device_id wfx_spi_of_match[] = {
-	{ .compatible = "silabs,wfx-spi" },
+	{ .compatible = "silabs,wfx-spi", .data = (void *)WFX_RESET_INVERTED },
+	{ .compatible = "silabs,wf200" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, wfx_spi_of_match);
-- 
2.20.1

