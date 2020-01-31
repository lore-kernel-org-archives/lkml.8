Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A251CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8120E2253D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgAaIsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:48:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38438 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgAaIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:48:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so7716830wmj.3;
        Fri, 31 Jan 2020 00:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C68wfOK/1whk3hXx2aI+LZu/B14qolQqF5YsPbhywYw=;
        b=GkZIp2/LUCxd47JmekKureB0smlb+45EPwVMqhopvjt+YCCB5GNyzIZNOwwRsFpd8O
         rpC945vRBIIqEWI0GzGl19SPC1Ck4uMqqQxySltJKzPaU7y+IqSLYsOaa2K+AayRvWd5
         0xXHX9b4RF02utBMtAUUZR3vuQz7VzTTZcg8vAqf4Z4VJt3X9En6K7bed0H4KmweQAop
         FW/BYhqadc8gNYk2ar1EBRW0Q43UAj9/zWYW87agSwjo2uuZ74T+IoffYp6pULVRUeyr
         Vtpju7Bt1BxRco8M4fVy+QG1VfBkPQwvEBLyzhPvB7MP4+53cPhQYuDsfr6Mtvcg08LC
         cLJQ==
X-Gm-Message-State: APjAAAVM+fJJni2vGHvPInN7AEYPET/i3CPJpRRs76OfGOzVJ/rFilbH
        917M4U8fckSdzKDUAwGCMWD65EyQzyU=
X-Google-Smtp-Source: APXvYqwZ5N3sHxvAExBZXSD9o505UDKVeLrvfAAmDTlTytHy1nqyoBwtcmRSKUnDauBtIb7j0fk1aA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr11167735wmi.31.1580460114264;
        Fri, 31 Jan 2020 00:41:54 -0800 (PST)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id x7sm11034302wrq.41.2020.01.31.00.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:41:53 -0800 (PST)
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
Subject: [PATCH v3 05/12] ARM: dts: imx7d: cl-som-imx7: update pfuze3000 max voltage
Date:   Fri, 31 Jan 2020 08:36:31 +0000
Message-Id: <20200131083638.6118-5-git@andred.net>
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

The max voltage of SW1A is 3.3V on PF3000 as per
http://cache.freescale.com/files/analog/doc/data_sheet/PF3000.pdf?fsrch=1&sr=1&pageNum=1

While at it, remove the unnecessary leading zero from
the i2c address.

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
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 481bd3971c55..78046633d91b 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -81,12 +81,12 @@
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze3000";
-		reg = <0x08>;
+		reg = <0x8>;
 
 		regulators {
 			sw1a_reg: sw1a {
 				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1475000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <6250>;
-- 
2.23.0.rc1

