Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BCC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A7720736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="seBpYegP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgEKPIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730509AbgEKPIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:08:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E2BC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so19749437wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=seBpYegPZMs/leR6JMfg7RpttvfOQmjhwYGL5XqCrl0ivqZ8SgNJfl5MrK6SNZU0x7
         s+P+5zxeVYMfWsvU+TruIPRs58u2N7gNKpF12dehHxew8uZn0wyQlXvRs81sH/cUAU/A
         kDiLytEcupQFinP/tSVSDYeJHqjKGk/S/swcSaT9uPiZDBURaYvEzFY1KQfq187G//Gn
         fP7p4AVjZ9rbwczBJGBw15zMRSFOqPTKu+IA1dWJoqAajrlxLUjrFo00xOd0Oskl6NXS
         vFI181kFNL42vS94eYWzxhtiRzUpW9BwFO6iLc+Bp3c1tgfqYpiA57PqAjvUSUmXKZ85
         b5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nZF4M1Ryr6CWnpRgUMWuRsLTKn/UHmWXZ3+MZTEjA0A=;
        b=I4xd1tQdofI/Si6s73aJXLuUvcqPnG+75B2Jwu0tctsmRxWSmvX8wqG4D3bKVB8Cni
         pENazZH+4LPzysoM+arLkdax2137QqeYrkwbD5rG7D7Aelsy4gmVkNx9RKnq65loo4IV
         zQsWfOQMxIv6xdiEwJwCccbAD01RXK+pOOd0BCZLzN4zS/Ll1KdfNj8ulf1+T6hO2y9/
         MRfqoiz//TX3/q9elBeLdySoPq5XWQoCBq4e+d/BJnGplG0XuB+HeqvBvGIzSkKSYSBi
         DS977tVtNpXt35rL3Y8pyUESI5b4MnVx1+AUoXfwV2Voey5CBdunbnrJwVJNAmSTsqsM
         Ah4A==
X-Gm-Message-State: AGi0PuZlz7qUVcQxCokFWnZF0xpCVXWzVGF5HtlRB5oURxtXwuARyfmo
        vNKpg7uHBZoe5LFqmH7YHgD46Q==
X-Google-Smtp-Source: APiQypIPr9fJcUgRNwzXEgdam3rXk6Or+HXAPoKGbi/pvrOEjCYCARRhvNo55PBWgkqCWw6ysRwOhw==
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr31309130wmu.18.1589209720425;
        Mon, 11 May 2020 08:08:40 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 94sm3514792wrf.74.2020.05.11.08.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 08:08:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
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
Subject: [PATCH v2 14/14] ARM64: dts: mediatek: enable ethernet on pumpkin boards
Date:   Mon, 11 May 2020 17:07:59 +0200
Message-Id: <20200511150759.18766-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200511150759.18766-1-brgl@bgdev.pl>
References: <20200511150759.18766-1-brgl@bgdev.pl>
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

