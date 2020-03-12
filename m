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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4A5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC052067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzPeiPds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgCLRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:15:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:14:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so2267460wrj.10;
        Thu, 12 Mar 2020 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SuRBJARNQVs5dyf0eB48d3tfDeB3eEZR49uCWJ2tP8=;
        b=uzPeiPdsp74lWp9Qj5xiaV3WA3py5k+YwaJ9xw/Ik0gg+Qg9JReCtwkJdtBRI63UQm
         Km5K/BOBZfAfyLom73b5wD82OqkEDCffMUGFyF/Lzro2SomkgOZFS/ltRjP4iOxrj15u
         ZS4o0giDu4Agko6eM9XCcnPFac9C33t1dwWlOKPo8wUhhdPeJJ/w7Qeo57BHTKi/Bqwo
         gjDMqGYx7KBnkxq5EQfD8U6MrmKKscXGMZ2YgGtFC66ovpsoAIvqA+px4JIwLa5iiMej
         y6PYERJgbbm8kh6iU1893TTGSXwjsS8gYuWmvBRoakV+iguLgW7TXKl4eL5QBTGXU3M9
         0aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SuRBJARNQVs5dyf0eB48d3tfDeB3eEZR49uCWJ2tP8=;
        b=V9czw8oVuXrTpWy1B35Rg0XvpHpEUOIgFkV/plLYsnB0Bl+bUBPiScjoAiyCcWAokf
         pmPQ2utNuusD7twM5vHfBDquN/yi1nveuuQnq4sqdtzAyMueWr+upyLTQ/1kP4CosTHB
         XMhg2QBAkLNw+wUM2b0GEmvwb1t+ikhd+LIsRA6cwj5sXrpEhyA9d9/lEybxWYEM48V/
         RxRpUrtP4sDjri+nWlIULxJSW3h69M13sqews/1RoYfmkP945id1XIqGd7mw99EMXwEH
         3gRxsgxF6URH/fsTXwsA7rw/Q6MK/nDVI9AHqU3L/v5bqp8eFgbXbeZKprxH5R+P56+P
         9iSQ==
X-Gm-Message-State: ANhLgQ2hEGbunlNpkxC7Zl4/1fsHxl66gIOOfppAinNTvf6N+ezOpjM3
        dEuebgA0q65wC/zEJUzQqNQ=
X-Google-Smtp-Source: ADFU+vsZcBv981uxb63P0Pkt+xHhdWoNcU8cUuoWL3IDP3tTTIFt+ojHaQbBjZJnjoZGgpraBs9A4g==
X-Received: by 2002:adf:ab4d:: with SMTP id r13mr12395984wrc.188.1584033297481;
        Thu, 12 Mar 2020 10:14:57 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v10sm3398832wmh.17.2020.03.12.10.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:14:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: remove clock-names property from 'generic-ohci' nodes
Date:   Thu, 12 Mar 2020 18:14:41 +0100
Message-Id: <20200312171441.21144-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312171441.21144-1-jbx6244@gmail.com>
References: <20200312171441.21144-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff5d0000:
'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

'clock-names' is not a valid property name for usb_host nodes with
compatible string 'generic-ohci', so remove them.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/generic-ohci.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index be5569b74..bd5f51d23 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -892,7 +892,6 @@
 		reg = <0x0 0xff350000 0x0 0x10000>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST>;
-		clock-names = "usbhost";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		power-domains = <&power PX30_PD_USB>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index ac08d2b70..54b3f4616 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -977,7 +977,6 @@
 		reg = <0x0 0xff5d0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index bbae92ef3..8aac201f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -360,8 +360,6 @@
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
 			 <&u2phy0>;
-		clock-names = "usbhost", "arbiter",
-			      "utmi";
 		phys = <&u2phy0_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -384,8 +382,6 @@
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
 			 <&u2phy1>;
-		clock-names = "usbhost", "arbiter",
-			      "utmi";
 		phys = <&u2phy1_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.11.0

