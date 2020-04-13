Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9DCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54652064A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV7U7X1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387955AbgDMThF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387935AbgDMThD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:37:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45CC0A3BDC;
        Mon, 13 Apr 2020 12:37:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so11439926wrd.0;
        Mon, 13 Apr 2020 12:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IL8UM2G8ckEvz5Q1HLyYzF8mVCI5/VI6cQ0z6c472EQ=;
        b=XV7U7X1uveyRb9PqFljNV4aJTxa3bkX51B52APKWQ966g3JSC5gvNoJEzwMITXvu4w
         8WpFgNgK3PYryJPfcnHdA2tdc5pEiqnZwrjX/EFiy1skmg9LqAER1U7Fvc9ozcKXNnd+
         X74GyxoMg6w5PmxaQbeq0BkHivsnaSSItAbCEC7nMfw/h48FJ6xZJJzjndZqHyfpiVuf
         hjwj8hRiy6jk7Oo2QTQeDKtIKyWR/3OkYUQrdlTWqBDVYgU3w1UJJEKzLoqug9CsS2kV
         vD1DLdh1amsg09ityJ4RQFMUYoNN620mliVCKOf4GCjk1bCieTf0vo2d6hjZHvUC0Z4W
         udcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IL8UM2G8ckEvz5Q1HLyYzF8mVCI5/VI6cQ0z6c472EQ=;
        b=CdFMiffn+UqAAxr8f1DhOYTWR9DJpz3GmtEEqMIQBnH4KSwEmHZ+rn+ox8vl7tuIyf
         qKZV1Mx3e1Xjb8HHiv9ed7Xd3yVSmINVzVL1VMi2rNgLugn9L5N6nuYUFJqw9q/Mndb+
         hL3IqqNQ3hM/aEyHkGnHOgYNY68DhGuSoYSWOXVGLAxj4LFqQFjuF1ZJgOUgTYokaTdX
         igMn9XfpAjwK3ZFWaMVkRwwyZaO1pbCFEVRyuhUtMZuei/v1c8cxo4HDRiPRHmA9koU8
         6by9J56Z1zl0COVaPybks17QYrYvvy2t38HgG22yqmoAJXKxxYobicCEaqNyn/GDjUVr
         o33g==
X-Gm-Message-State: AGi0PuYxpZyoir7Nnj09g/2M5oMMQEuoCV3OVOuklPDkgKeIFZ+KOC/4
        82zoS848EhIJWnagxm19wv+i2UOL
X-Google-Smtp-Source: APiQypL9aZQMlpGKhdYWyFuCrzaNq51hpaS4p3qbtjobH7zo8hHacrhQXSiGqmJXkX1J+79WQN70IQ==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr20903930wrq.139.1586806621899;
        Mon, 13 Apr 2020 12:37:01 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b4sm11121659wrv.42.2020.04.13.12.37.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2020 12:37:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308.dtsi
Date:   Mon, 13 Apr 2020 21:36:52 +0200
Message-Id: <20200413193652.1952-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bus-width' property for mmc nodes is defined both in
'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
In line with the other Rockchip SoCs define that in a user dts only,
so remove all entries from mmc nodes in 'rk3308.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index a9b98555d..130771ede 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -587,7 +587,6 @@
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff480000 0x0 0x4000>;
 		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-		bus-width = <4>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -602,7 +601,6 @@
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff490000 0x0 0x4000>;
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-		bus-width = <8>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
@@ -615,7 +613,6 @@
 		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xff4a0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-		bus-width = <4>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
-- 
2.11.0

