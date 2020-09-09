Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7210CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318892087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jbdhf4gH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIIGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbgIIIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:06:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23409C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:06:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so1475813pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVlYlbWkozbz0sLJ6S/+BIlF4v5FRp4qwtHLHAvdMQ8=;
        b=Jbdhf4gHp3pe7ZAg6MfN+hmU7XutrDtvHYeWgzZC69kwrslIzxW3C5cjPf9rdszvVs
         IlpM/YR2tNGDZg3yTGtyhT7TFvneCjyhGgODs4OAECJ+6GHWMFzU+tbdmCPJtFaUGmnq
         1aG+i5wU/AK9VW/a8k5N6GsGYvM5QgSw6ixoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVlYlbWkozbz0sLJ6S/+BIlF4v5FRp4qwtHLHAvdMQ8=;
        b=My+01KSf2CbcWM5xZT1qc9hpHJhfJYxl6trBz7gGV524F08kr4D4HH+9j4Z7SA/++J
         974l3uIQlEx/Pl3neUiiQpj6bWEVb2A/B58gbqr9J3UHVdw9pSwmpp9sxiIuWzI6anIc
         M29URZZirM91xjmwnOzxo2XOJdNh+p3pbJAFSl/LkhsRqzdD6PPrDJ2Vc0jE/y/Qk22I
         73T43Ja/Iudz6Pojzh7teovJnmgABwBh7qGBt0Yp81E1P3mcpO3yhDfBg4Fh3f+D3OJp
         HnfJDc7eMeEnocWblxvXceReIx4VaVr4TcpFkHjIJEs6FOJcg4HEtHx0iqvSPXuFLiAZ
         ctIg==
X-Gm-Message-State: AOAM530kAZP0cI5QKyJjCbVhoS05RJJI1yxY9Ye6EWcd3OIpGbFuqtel
        71w2M9w82HrilucSPaqQ0tRniQ==
X-Google-Smtp-Source: ABdhPJzwx8jiPPdem7eCjQdoXrfB3KZxZs1HdZ8y27DOvo/H7K6FuYkhAgGi5eOJxtphcwcCI89QLA==
X-Received: by 2002:a63:5c66:: with SMTP id n38mr2053035pgm.217.1599638768656;
        Wed, 09 Sep 2020 01:06:08 -0700 (PDT)
Received: from kafuu-chino.c.googlers.com.com (105.219.229.35.bc.googleusercontent.com. [35.229.219.105])
        by smtp.googlemail.com with ESMTPSA id d8sm1260489pjs.47.2020.09.09.01.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:06:08 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: mt8183-kukui: add scp node
Date:   Wed,  9 Sep 2020 16:05:58 +0800
Message-Id: <20200909080558.2409470-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scp node to mt8183-kukui

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index f0a070535b34..85f7c33ba446 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -90,6 +90,18 @@ pp3300_alw: regulator6 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
+
 	max98357a: codec0 {
 		compatible = "maxim,max98357a";
 		sdmode-gpios = <&pio 175 0>;
@@ -524,6 +536,13 @@ pins_clk {
 		};
 	};
 
+	scp_pins: scp {
+		pins_scp_uart {
+			pinmux = <PINMUX_GPIO110__FUNC_TP_URXD1_AO>,
+				 <PINMUX_GPIO112__FUNC_TP_UTXD1_AO>;
+		};
+	};
+
 	spi0_pins: spi0 {
 		pins_spi{
 			pinmux = <PINMUX_GPIO85__FUNC_SPI0_MI>,
@@ -651,6 +670,17 @@ pins_wifi_wakeup {
 	};
 };
 
+&scp {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&scp_pins>;
+
+	cros_ec {
+		compatible = "google,cros-ec-rpmsg";
+		mtk,rpmsg-name = "cros-ec-rpmsg";
+	};
+};
+
 &soc_data {
 	status = "okay";
 };
-- 
2.28.0.526.ge36021eeef-goog

