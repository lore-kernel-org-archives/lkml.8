Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC5FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CC92311D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pK8cqQB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgFTD2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732271AbgFTD2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:28:36 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:28:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so5282998pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wEs1bwDB/TtDfJTP+rfPS/eV3OYFDhVkY2AGM1gTF5E=;
        b=pK8cqQB0iaxFCQTro5VYTVkbeMbmlffBMiXp4BLcWkJ+Hi7VYupgMvngrbaIMZ23DE
         T+sYQDXM46cA+pIckwp9yhK7KHfNEC/LyhVnBh7tSDZndbi7OQ5Bl1ZQvOTPhd3H4LrN
         8qqoaH12Q0DH4IzoR7TTDzAyeBqduNOJLKUq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wEs1bwDB/TtDfJTP+rfPS/eV3OYFDhVkY2AGM1gTF5E=;
        b=f/Vg5sWFpY8P7DqKoZ0Vp36VDTSj11joC1iO7Nv1ZCq6AkNh8xP2Qr2J2ajxDaf6yZ
         NLAOq+uGghZBrIPdb2YN3xpOaYTL+bNNmatHfu3wwQTkkuCOhYpfsuzGQnTgFD657hAy
         oz5X+skH9MYKhatgi95T6skhozMtaXW2A5Lq1Rmt4PR+pjGhOGZqXLt2A+PAqOkVrFvH
         NaE20VxaptVxEjMtMElkmSRE1Rpih4IXik9i1FolRq2utDO+gauR3mBNlMU4OqhP1oFY
         ndun9b2phzKWALb0J6f4dongLH3iZCLjttsPmzvWQAlqkVi8AoY/XHH3m36bjP1J9s67
         D+Nw==
X-Gm-Message-State: AOAM531MhKmue9lmFkR9gp2cHoU2V8xcNBjJd9ONJ+yqReQ1NHG+vBVx
        dutEjLFRECxgmnfHKMm8s9TUoQ==
X-Google-Smtp-Source: ABdhPJzyfQElYK0QcW79S/OVQnqqlVKouBZCgo8zhKaHIx8bCkDGQavnty0ung243w0p9t0m9hE+KQ==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr10826477plk.42.1592623714598;
        Fri, 19 Jun 2020 20:28:34 -0700 (PDT)
Received: from localhost.localdomain ([42.111.160.67])
        by smtp.gmail.com with ESMTPSA id 67sm6182262pga.44.2020.06.19.20.28.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 20:28:34 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        gregkh@linuxfoundation.org, sashal@kernel.org
Cc:     jagan@amarulasolutions.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2] arch: arm: imx6qdl-icore: Fix OTG_ID pin and sdcard detect
Date:   Sat, 20 Jun 2020 08:58:16 +0530
Message-Id: <1592623696-21485-1-git-send-email-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAOf5uwkrjj98+_8Hn40ujn2bLz_oYb7FCWcuO8yNn2y0ewMehg@mail.gmail.com>
References: <CAOf5uwkrjj98+_8Hn40ujn2bLz_oYb7FCWcuO8yNn2y0ewMehg@mail.gmail.com>
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

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
Changes for v2:
- Changed patch description as suggested by Michael Trimarchi to make it
  more readable/understandable.
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

