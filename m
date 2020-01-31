Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E3C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1AB20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgAaIsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:48:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35908 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgAaIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:48:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7736844wma.1;
        Fri, 31 Jan 2020 00:48:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rCIaYhy19uhXqC3cBNmvWggUiwiZruQsnEVhDd61mE=;
        b=DjM9h5+sBhZlQQca+0quhcJ+4I5o1oMSuffIBgvp3dslreOJkOGXecUANQTlT66Daw
         K2VYfqLm3YSBsw73/P0uDjiov2EABe/oRkiSYrT2FRK9qCKXxzPhNHaiAggsSn1RAqFH
         0yLK1QDXpzEBouOttmybefx9Xk4PzTXR+5roK18remS4k5VCBiwXKoDKqy/pwI6a2mkv
         wmxJxXrRfeXwO7NMPWwZPovxkQ6qEQ2qaDD5bj7FRpTUC1Qe8S16FxwYqosG3w5fEWqw
         3mud+rABM9b/6UAtbNGjhp+mJrh8iBFML599TMIUQxMwDcW2xz1bgx+OAjBTytcvCema
         FH1A==
X-Gm-Message-State: APjAAAUf0ww3FSPgsFq7GJB3ADWn0iZxUgfhhdv27lAB9OECzGjc9nNe
        FuyLiYGrR11F74OS+ePpF7V4AEpXNtE=
X-Google-Smtp-Source: APXvYqypc6MF6QgCbmPRGX+Y/IH0R/dp9yLZXlhDd9OMREV7VANLITul+BVlNBUSXC75nGwIZHUBxQ==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr10365919wmd.7.1580460118795;
        Fri, 31 Jan 2020 00:41:58 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:58 -0800 (PST)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 09/12] ARM: dts: imx7d: cl-som-imx7: add SMSC USB3503 usb hub
Date:   Fri, 31 Jan 2020 08:36:35 +0000
Message-Id: <20200131083638.6118-9-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200131083638.6118-1-git@andred.net>
References: <20200131083638.6118-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the SoM design, add the SMSC USB3503 that is
used as a PHY in hardware-only mode, connected
to the imx7d's &usbh interface, providing additional
USB ports for USB and mini-PCIe.

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index f80be855b4ec..a16cbb070a12 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -22,6 +22,12 @@
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
+
+	/* SMSC USB3503 connected to &usbh */
+	usb_hub: usb-hub {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pca9555 6 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &cpu0 {
-- 
2.23.0.rc1

