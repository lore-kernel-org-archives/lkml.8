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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B359C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695DA2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZBgUzmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgCLRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:15:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33594 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:14:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so5978670wmg.0;
        Thu, 12 Mar 2020 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/rHi3YAkRAcdMWtqtXDhFmgLSOL8x4zCT7svjD1llso=;
        b=CZBgUzmx+EEy6Hdu9DInRUBaFiOWh84iUnz4jURnXgTy+86cMmjyL+Xm/IiK5B0HBe
         mRg9AXxyeAbj6pJKhCGImAXZNQwQYE0+0WpiZ4u841pcqgBHauz7DHWB6rcY64d9niAh
         fzLFR7ZIA2K5/8mAAROD93RSBqLh2dM0gPW1ekQDJJ6RrLBwIB2qqD3klsEUspWSiurl
         Ywf3ZObsiUzImDTk30kKZwEhKeGYKFfUFrQW+7c+6DBGCUux0DjKdrBLdjMwcQhsRoSF
         9XA8tSdQcF/jcTuGbDafn92DvX8CY2bBMBEebdro2EREy+07YkkBxeSb6zHQV2qUfUbU
         9MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/rHi3YAkRAcdMWtqtXDhFmgLSOL8x4zCT7svjD1llso=;
        b=s5TAVHzL5oDKxXf5xCuUV3W3eNXFpjQ4/JvliDwQ6fLnKSAFlBtCAlQBsJI3Ya0cYv
         9fbXk05GbAiq4YBgvfreR1rbqUZ5cIhvc358kbFz97+vZFEplXqJLKac9f6DpxC98ObH
         KUKG7Dyv61Fshsoown04dmLlLibxjOlOLj4t3ZazBvD1sF0liS3G73fhoXblO9dZo96M
         CaTSL5Meerf8z46iMiXFix8o/O6F4Rwt759/mroTX0jbvQI7DMXvGCZzupV4L/hew3gN
         QcEMV9ir5QHMTdJDWb3si5hYmdP+3a1CRURa3fzvzvb3B5mqOdi1KxmmHBXuH0rKP/rt
         B9yg==
X-Gm-Message-State: ANhLgQ3/Am1lrIyFN1wJbfrQwmjtFm8uIuvG9pqz/bT7f0T48Z0Dnab0
        LDbIx9UdSPMW5as59GumA24=
X-Google-Smtp-Source: ADFU+vuU7JONushGnh3yAgda3gxF27iAlAIS/lIT8K59ScQnS7AhYwvRjg88gHQjT88rLF0AWIIufQ==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr5962352wmb.118.1584033292012;
        Thu, 12 Mar 2020 10:14:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v10sm3398832wmh.17.2020.03.12.10.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:14:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: rockchip: remove clock-names property from 'generic-ehci' nodes
Date:   Thu, 12 Mar 2020 18:14:38 +0100
Message-Id: <20200312171441.21144-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rv1108-evb.dt.yaml: usb@30140000:
'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

'clock-names' is not a valid property name for usb_host nodes with
compatible string 'generic-ehci', so remove them.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/generic-ehci.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 3 ---
 arch/arm/boot/dts/rk3288.dtsi | 2 --
 arch/arm/boot/dts/rv1108.dtsi | 1 -
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index a0acf2ef8..6503247e9 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -722,7 +722,6 @@
 		reg = <0x30080000 0x20000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy0>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy0_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -744,7 +743,6 @@
 		reg = <0x300c0000 0x20000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST1>, <&u2phy1>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy1_otg>;
 		phy-names = "usb";
 		status = "disabled";
@@ -768,7 +766,6 @@
 		clocks = <&cru HCLK_HOST2>, <&u2phy1>;
 		phys = <&u2phy1_host>;
 		phy-names = "usb";
-		clock-names = "usbhost", "utmi";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4745be518..485234f6a 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -601,7 +601,6 @@
 		reg = <0x0 0xff500000 0x0 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
-		clock-names = "usbhost";
 		phys = <&usbphy1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -644,7 +643,6 @@
 		reg = <0x0 0xff5c0000 0x0 0x100>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HSIC>;
-		clock-names = "usbhost";
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index fda16f976..d33e606be 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -495,7 +495,6 @@
 		reg = <0x30140000 0x20000>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.11.0

