Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9367C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16E420704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C6S1AvtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGQIEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgGQIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:04:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:04:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so6159513pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KEvi0NuPU1IP8yO4PAQchnjzLd/x6LQsk0i3r7vHyn8=;
        b=C6S1AvtTj8LyBgazLLSZt/LcOQkm40N2bLk8k+vnF1Q/0qesdwGhQOXIbIdrg+K0y3
         6WRXf56QXTDlMKRmeCFZ40Wmw40hCGXJ7OH5bmuVOTpkjBdpI4cNzzTy063Ne67hZhDA
         Kdd5l3sMZ+SBT2EsBKzvpMwcqdziXpz8MQdgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KEvi0NuPU1IP8yO4PAQchnjzLd/x6LQsk0i3r7vHyn8=;
        b=USrAFMZYhothpXOsgIlqYSJ6FK1gTQFdXs4kZcvYPz7a0nBtwhJAtOAJ3s09trnsZX
         Sv7YNRYwlfo167GWbgPexdPZMJyfv/TwlvFEr7+B7xi9QhbFvbVQBaROGtCTh9u5d2JX
         yGNwqQMgduYXEGm1kf2+NDe5GK+6xgz0xsdhIc1K3sTJxFjTpjrLHoxRd+hBn4UnlqUY
         3qLpih2hU7lm4rz66iodO0dFvruyqm7Z218t1U4jD26EyfFOWzrE0PHmTe4r40UW1hIX
         596aaRzT+Tz+ytLjQBZildKqcPdqI0iE8nrDMp4vbHOyynODKKX+BKlprwjckVBSpRRH
         GaGQ==
X-Gm-Message-State: AOAM530vUAw6ECVCX6medyw6mEUy0qvlZSaEoH5R+rVyNz8VrKjK6xJH
        mtAtQulTgtIZKWzlTv9TDkROE2KfsGFi2g==
X-Google-Smtp-Source: ABdhPJyIUB2X2bt07ezL/JxWGi7QM9dTUwoDl2jBg2/4sx2zMYj96jaBOidH0UnTgvjoskVWg8dGGQ==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr6813081plk.104.1594973046370;
        Fri, 17 Jul 2020 01:04:06 -0700 (PDT)
Received: from localhost.localdomain ([183.83.226.37])
        by smtp.gmail.com with ESMTPSA id y7sm1933330pjp.47.2020.07.17.01.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:04:05 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     jagan@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] ARM: dts: imx6qdl-icore: Fix OTG_ID pin and sdcard detect
Date:   Fri, 17 Jul 2020 13:33:52 +0530
Message-Id: <1594973032-29671-1-git-send-email-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200711135925.GG21277@dragon>
References: <20200711135925.GG21277@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

The current pin muxing scheme muxes GPIO_1 pad for USB_OTG_ID
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

The TRM mentions GPIO_1 pad should be muxed/assigned for card detect
and ENET_RX_ER pad for USB_OTG_ID for proper operation.

This patch fixes pin muxing as per TRM and is tested on a
i.Core 1.5 MX6 DL SOM.

[   22.449165] mmc0: host does not support reading read-only switch, assuming write-enable
[   22.459992] mmc0: new high speed SDHC card at address 0001
[   22.469725] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
[   22.478856]  mmcblk0: p1 p2

Fixes: 6df11287f7c9 ("ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
Changes for v3:
- Changed subject of the patch, added fixes tag and copied stable kernel
  as suggested by Shawn Guo.

Changes for v2:
- Changed patch description as suggested by Michael Trimarchi to make it
  more readable/understandable.

NOTE:
- patch tested on i.Core 1.5 MX6 DL
---
 arch/arm/boot/dts/imx6qdl-icore.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index f2f475e..23c318d 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -398,7 +398,7 @@
 
 	pinctrl_usbotg: usbotggrp {
 		fsl,pins = <
-			MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x17059
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
 		>;
 	};
 
@@ -410,6 +410,7 @@
 			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17070
 			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17070
 			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17070
+			MX6QDL_PAD_GPIO_1__GPIO1_IO01  0x1b0b0
 		>;
 	};
 
-- 
2.7.4

