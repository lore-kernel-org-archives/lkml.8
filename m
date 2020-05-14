Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40153C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F52A20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nXmcTgWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgENIAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgENIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E8C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so21708564wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=nXmcTgWKai8rBQ2DXas2d5H6t5IBpKKtBOFHUcEyAvlLdEQGxeg/oH6FNz59RFXfP1
         P7Qkldx/02KKtlnaijnKKo8qjlOii2FQNyb0gmqEdu8VwcCQdYj6QtgMy32fr6gphqMs
         7RJ1yCfST+TpHaSnZ1uw1gU9H+l+9GEZ4z8cIuXsToR7E6n+IZbRXPy8YZmXzcTpV4j0
         nKM0IY3O82aZcgwehgScYrbMYMQyyI2Gy90P+Et9IdpErBIOvAYByQc+cW+D49uP72Lm
         NOIOWdT1Jgd2LiHVVUqA2u2f/rYlHEJc0jXjQ0XYKT7TteUWkZPzMfha+VuT7f4ys2Ky
         tuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=aN/e/DBSwENhHFMo3vxtvkcsg/97RB8i+fV+l51sDf9Q7FASg7N8c4FVVyDaQVfPnR
         ROeFjKf0MOIDVsfSdpZgW+jRtMRlwZOvcqn5H/0EEyqiWd4WzaI0eGHRhCdX+I74YMom
         MiUBTDc4gxt3MdPpHUdAoPMHumjy3qGJjWO5adw8wmIDK+nhGyVy4ubR9F5DSiglTnR0
         mytvaQRDLjGl+/aHERltlDEY8Yw6+TodnIE3S9J4Vg4wls1xxRrbMyXFT9dOy5+8EGA3
         bVmkdl69lxoa14Jtw6HC1a5CKpxjsB4/cwH0CzWjy8foiUaqsltLFHArvV9PaAE36IrC
         pNTQ==
X-Gm-Message-State: AGi0PuY5ytLpMT5Bp54xEf6AQyUuBHDRqjjQRts8b7r6+lgQY0eL3j+S
        /WbLPxe4oXscY4PeQ4oddC3ekQ==
X-Google-Smtp-Source: APiQypLkHL0DWLpTgfSdy1BAdMqLrKiddZcunwHMW5P3bAckgztG6gV48Xmw/vqS4Ej0EtW7WbyHNQ==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr46778546wmc.123.1589443229077;
        Thu, 14 May 2020 01:00:29 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:28 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 15/15] ARM64: dts: mediatek: enable ethernet on pumpkin boards
Date:   Thu, 14 May 2020 09:59:42 +0200
Message-Id: <20200514075942.10136-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add remaining properties to the ethernet node and enable it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../boot/dts/mediatek/pumpkin-common.dtsi      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 4b1d5f69aba6..dfceffe6950a 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -167,6 +167,24 @@ &uart0 {
 	status = "okay";
 };
 
+&ethernet {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins_default>;
+	phy-handle = <&eth_phy>;
+	phy-mode = "rmii";
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
 &usb0 {
 	status = "okay";
 	dr_mode = "peripheral";
-- 
2.25.0

