Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD88C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744D0206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAZUAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:00:25 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:16241 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZUAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:00:25 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjcv7w="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id k0645aw0QK0EF2F
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 26 Jan 2020 21:00:14 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Subject: [PATCH v3 1/2] DTS: bindings: wl1251: mark ti,power-gpio as optional
Date:   Sun, 26 Jan 2020 21:00:13 +0100
Message-Id: <d34183026b1a46a082f73ab3d0888c92cf6286ec.1580068813.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1580068813.git.hns@goldelico.com>
References: <cover.1580068813.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now only useful for SPI interface.
Power control of SDIO mode is done through mmc core.

Suggested by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
index f38950560982..88fd28d15eac 100644
--- a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
@@ -9,11 +9,12 @@ Required properties:
 - spi-max-frequency : Maximum SPI clocking speed of device in Hz
 - interrupts :        Should contain interrupt line
 - vio-supply :        phandle to regulator providing VIO
-- ti,power-gpio :     GPIO connected to chip's PMEN pin
 
 Optional properties:
 - ti,wl1251-has-eeprom : boolean, the wl1251 has an eeprom connected, which
                          provides configuration data (calibration, MAC, ...)
+- ti,power-gpio :	 GPIO connected to chip's PMEN pin if operated in
+			 SPI mode
 - Please consult Documentation/devicetree/bindings/spi/spi-bus.txt
   for optional SPI connection related properties,
 
-- 
2.23.0

