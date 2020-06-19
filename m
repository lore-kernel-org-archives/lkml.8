Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2981C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA6D20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="W+x4CClX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgFSTQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733115AbgFSTQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:16:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F124C0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:16:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i12so4440532pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QpjsOQ81m2+7Vf1tKhbI0NPMb57wPuYHIHejUZfeOx0=;
        b=W+x4CClX3BaHnLSt/1xtF5HA5oIJlM8A+EGmUOOouefvbHiG6YC0Wsg8b7CB6Pp8f5
         pEyFrNb9aZk1QdlliapBCUCIem9PZnRIF1pNDG541eEWKTNagxIBWk/a5ThEjdUHubXI
         O2fstgpGQQrTlufuHR2nutPWOwG7k0KKO0UPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QpjsOQ81m2+7Vf1tKhbI0NPMb57wPuYHIHejUZfeOx0=;
        b=iKcQrYHXKbTcyiW1UGnw0TCTunO11qNzuQIO8pGEtJNG8dtj8ZJ1YzmvhgJ+Ejw+sc
         p+XbbJBIBX+mgmKAoIXq/W63nDEBWhLhFOMrOdS+uegVSoQ9qAiDAptDeXfUtT68DbvJ
         D1DDQ7zhtpW/BpHBUY7/I3g94aJnEipkR1aocZ/C9matNh7SlJR6GX4GTMkzDVt29xd6
         0+KdSHyRN93YDoPysMBTvB7t5TB/aBMZrW2OxJYeooNtw8dzgSVbGjKHzHnY2Yi7S1GU
         4DetCV92VbL1Ljz/yF7VfgzZy1RS7qm/tNmpL2OaGwY4HAnXOcR+Y8krXH7oWwOioJq7
         sW2w==
X-Gm-Message-State: AOAM53239meZoPWF9uxs9OkeHAJavGIlKBqDX8PKbYzy7VD9I2bdXxfA
        rbDQ/xz1MBv2tRM8GV9viZ36cw==
X-Google-Smtp-Source: ABdhPJwNurzM+LygEC0YiX0wuysnxgJPszpw0mtEo9Y7176XsIpQNBKYeTFSdYlDE/YRvgnE/WhMHg==
X-Received: by 2002:a17:90b:50d:: with SMTP id r13mr4895894pjz.94.1592594190698;
        Fri, 19 Jun 2020 12:16:30 -0700 (PDT)
Received: from localhost.localdomain ([42.111.138.30])
        by smtp.gmail.com with ESMTPSA id 12sm6482743pfj.149.2020.06.19.12.16.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 12:16:30 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     jagan@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        stable@vger.kernel.org
Subject: [PATCH] arch: arm: imx6qdl-icore: Fix OTG_ID pin and sdcard detect
Date:   Sat, 20 Jun 2020 00:46:13 +0530
Message-Id: <1592594173-13497-1-git-send-email-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

The current pin muxing scheme muxes GPIO_1 pad for USB_OTG_ID
but the TRM mentions GPIO_1 pad is muxed for card detetcion,
because of which when card is inserted, usb otg is enumerated
and the card is never detected.

[   64.492645] cfg80211: failed to load regulatory.db
[   64.492657] imx-sdma 20ec000.sdma: external firmware not found, using ROM firmware
[   76.343711] ci_hdrc ci_hdrc.0: EHCI Host Controller
[   76.349742] ci_hdrc ci_hdrc.0: new USB bus registered, assigned bus number 2
[   76.388862] ci_hdrc ci_hdrc.0: USB 2.0 started, EHCI 1.00
[   76.396650] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.08
[   76.405412] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   76.412763] usb usb2: Product: EHCI Host Controller
[   76.417666] usb usb2: Manufacturer: Linux 5.8.0-rc1-next-20200618 ehci_hcd
[   76.424623] usb usb2: SerialNumber: ci_hdrc.0
[   76.431755] hub 2-0:1.0: USB hub found
[   76.435862] hub 2-0:1.0: 1 port detected

Fix the pin muxing as per TRM by muxing ENET_RX_ER pad for USB_OTG_ID
and GPIO_1 pad for card detect.

[   22.449165] mmc0: host does not support reading read-only switch, assuming write-enable
[   22.459992] mmc0: new high speed SDHC card at address 0001
[   22.469725] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
[   22.478856]  mmcblk0: p1 p2

Cc: stable@vger.kernel.org
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
NOTE:
- patch tested on i.Core 1.5 MX6 DL
---
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 756f3a9..12997da 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -397,7 +397,7 @@
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
 		>;
 	};
 
@@ -409,6 +409,7 @@
 			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17070
 			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17070
 			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1b0b0
 		>;
 	};
 
-- 
2.7.4

