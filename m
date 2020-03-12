Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64501C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366D72067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPGM5Sxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCLRWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:22:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33239 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:22:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id r7so5993601wmg.0;
        Thu, 12 Mar 2020 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AsK4lZiLvTPVWly7O3MtjFY6qfzheagg9cYmbmhqOKY=;
        b=nPGM5SxvKf5b6JPPp18z82FgPVQEaflZ27VlAmUFrua6iJ5ra4vp4WuhpL6duNYOsG
         OZt0sJAFBRs34tnwiNPSNAumz2NlmxBfT0ixjWCV/2z39jvzIFlS9gPZ+8q6/PiH/Ul6
         3nAyRLPlh8uAz0A1j+GhNlZ7/qAmCoqjsThw+E/n6Uojpo/9jdB4a9L6GObTE6MkBUEW
         3DAdfgaFpab/HPQgrWaggLSWUokxN9gnySRkoec8/QxPfJi2zj77pvftmMQu81ycha/i
         7T0BVdxox5wLeAhNlP3QboI2CpxdX/VcNcLoSqV9tIR/AHIC9AR2K843AXIXFcihgtMg
         aSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AsK4lZiLvTPVWly7O3MtjFY6qfzheagg9cYmbmhqOKY=;
        b=rLgpEG+cFof+gUGOqBCSIwNRUXDFVQ173tCMvv9k2zNm24gUacpadrOuQ/7t9kQBch
         3tsC53mqbkO5DCohFCzHaf1kSkdE6dwCrVGj4i14rxkV12ykPnlM1rSxRrOdnqKds5hc
         9kfC458Hpm/PzyROPca3P5q+XftHyNCpN/o/4t/hz1g+gD8gafUZSpnRCS1LrO9rvnFQ
         gdqXfrH4Tt1N2xKF8vkzVU33dv+A5w/ttUEgbvJkE7SPUZOrcXaBOK1mFGnzaHfMrwg1
         goj9kx5Xreo+yWMY2UJOGoQnykYzTl43DNE7pWEVplQMW2AMxYu4vttMKTlM9rOx6ETh
         qO/Q==
X-Gm-Message-State: ANhLgQ1QzUv9+9vFBmyfwC1qR6OV4yoi338pmjEQ99ISKOyKkEMJ7Szx
        Qf4o5+QRlDPXwlpYMGAbVJaug1+/
X-Google-Smtp-Source: ADFU+vsUmojL2gcA4UagPD4gg2rCKhbMtgcVCkmNLqEkRNDJPORZpiblkgYC9vuknxd30gcWUo508w==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr5711167wmg.70.1584033768625;
        Thu, 12 Mar 2020 10:22:48 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7sm2064492wrc.25.2020.03.12.10.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:22:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: swap clocks and clock-names values for spdif nodes
Date:   Thu, 12 Mar 2020 18:22:40 +0100
Message-Id: <20200312172240.21362-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312172240.21362-1-jbx6244@gmail.com>
References: <20200312172240.21362-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'spdif' nodes are manually verified.
In order to automate this process rockchip-spdif.txt
has to be converted to yaml. In the new setup dtbs_check with
rockchip-spdif.yaml expect clocks and clock-names values
in the same order. Fix this for some older Rockchip models.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sound/rockchip-spdif.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 4 ++--
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 24abf214a..2298a8d84 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -182,8 +182,8 @@
 		compatible = "rockchip,rk3188-spdif", "rockchip,rk3066-spdif";
 		reg = <0x1011e000 0x2000>;
 		#sound-dai-cells = <0>;
-		clock-names = "hclk", "mclk";
-		clocks = <&cru HCLK_SPDIF>, <&cru SCLK_SPDIF>;
+		clocks = <&cru SCLK_SPDIF>, <&cru HCLK_SPDIF>;
+		clock-names = "mclk", "hclk";
 		dmas = <&dmac1_s 8>;
 		dma-names = "tx";
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 485234f6a..07681f1f0 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -944,8 +944,8 @@
 		compatible = "rockchip,rk3288-spdif", "rockchip,rk3066-spdif";
 		reg = <0x0 0xff8b0000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
-		clock-names = "hclk", "mclk";
-		clocks = <&cru HCLK_SPDIF8CH>, <&cru SCLK_SPDIF8CH>;
+		clocks = <&cru SCLK_SPDIF8CH>, <&cru HCLK_SPDIF8CH>;
+		clock-names = "mclk", "hclk";
 		dmas = <&dmac_bus_s 3>;
 		dma-names = "tx";
 		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0

