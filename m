Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E7C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971A8214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgAaIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:48:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38502 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgAaIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:48:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so7718514wmj.3;
        Fri, 31 Jan 2020 00:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jGtaYskwXqtitTmb81lpaqplH9rL6ZrH9axl395rJFM=;
        b=OsI0g/I9G/6ZM+KNji8reFOn3AI14W05lJ9FgcS2UeOxJmI/98TzT5syJEwUzgHYI4
         fzSWPQ5nD9wnb7vieOMNawXWzvOSXlOyvt5SRxjTLy2BXPIlDYC93mwIzuPP1MX7Notz
         7WoeRHBbhCB8y1OuouAEO+02E1NHc3oKYRO6WJdVqw602CUtZzvB9Vdidr9f/w1Qfo89
         m9AnrgLVE6GK9i7wmnRj6ReCIb3kgsOE8kuIgu2B+eQD7gyvRyggSrgRcvpJOTc6Lp9X
         Cx2a/YvoUTkZwpHt1SjZX3SCc+GNNH/LfKF3d32T8Z/J5BPIZHvHPAoQmLuQvNr9xo3S
         M8iQ==
X-Gm-Message-State: APjAAAXYwLXlxuoofXVaDM92ag/LV4qHvutwmOTbAm+5HR5W6nfc1+XY
        LBeexyIo3XJP+UL2fJXMamou7j8wgy0=
X-Google-Smtp-Source: APXvYqzdHgyllrzTjRIsDWUxqKCWD3djcZmRB0k47vFVyGaNCVZjRihXvyt4cZA1Ts7DFW5lbYfhbA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr10617994wmj.105.1580460115395;
        Fri, 31 Jan 2020 00:41:55 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:54 -0800 (PST)
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
Subject: [PATCH v3 06/12] ARM: dts: imx7d: cl-som-imx7: add / enable watchdog
Date:   Fri, 31 Jan 2020 08:36:32 +0000
Message-Id: <20200131083638.6118-6-git@andred.net>
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

add / enable watchdog which is connected via
WDOG_B to the PMIC, due to i.MX7 Errata e10574

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 78046633d91b..ca3c5d95d6c3 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -207,6 +207,12 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -288,4 +294,10 @@
 			MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x4000007f
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
+		>;
+	};
 };
-- 
2.23.0.rc1

