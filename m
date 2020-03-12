Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59634C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D37206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYXn3PTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCLRPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:15:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54739 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCLRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:14:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id n8so6952975wmc.4;
        Thu, 12 Mar 2020 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gvIHQy0x0uikDeWAsY+tRBfCVP/6W4keDh1IPsYRgIk=;
        b=tYXn3PTZuAQXxTt+iA/09QAahXBf7be8mV1OiH1bsJ/2iHNzElyZl1d8X0ap2ALfG7
         SwUy2N+XS4R7gyNbXNmB5Pv0Q0DXmW77m4UyjfhyLC4XV4ASWtZ8WtdVfszTz4VLcS5u
         /0LZYB0l/EfhEfvv8bIQwvTDDVa/i2P2OSKQ01qrUQold/cAlJP574BjFAfVFP2XWH/G
         tfaNHumgsb8O6ijLF93tWM/5TmN3cn7IwxQq3oTH6GmOTgSceFBdoQq3RuQ3Pf5KEH+p
         jIXJzAkEriGq24vosjrAgkmHJ/wmrk6KNLWydwtqiWfFZAZFyH5j/guQ/3/1Q3Sttdss
         dU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gvIHQy0x0uikDeWAsY+tRBfCVP/6W4keDh1IPsYRgIk=;
        b=LVUWWtKgr3oGb62t0KCbz0hpjRvIqeng7DPSsEwgP/tyJO8beBnx0lu5O2luN0E3i1
         +GQre6iHSzLcYKWcnMnI3eH2yHveNmoS+A04VC09DmveVxv+/uPlbydHJtCehxu7ZDZw
         4ZmDA6MDGYfmQxsrmBZSAZE0MJjOqcMNV+e3nbLKBaB02n1VJKh9zieHwciqaO21VAtO
         yenXkmy6B2dSU0aauSu+9/PYI20BHqWcUWPTB7GC+CqMuE+kJGJkQLYp+uslL8bVgCl9
         HaneCzhMylMOmVnmbS/66H1YR5U//wjaHdoqsF1PlU+hdosEHICRkb0qI89COV+O/8fp
         BZkQ==
X-Gm-Message-State: ANhLgQ3/zz0wIVgJQY/GpZwQl6xPwOEczdVmySFSvNuO7jdroAG6bWQG
        G8BBDIiETu4a2+NiwT4SmmmYsM0R
X-Google-Smtp-Source: ADFU+vsQ2aPblQLNxCLnKbPMpQn0WV9BgJU3/TShBh84qWgATHucWB5d9a1Rl0/uzCrCVKP230JVBQ==
X-Received: by 2002:a7b:c082:: with SMTP id r2mr6113172wmh.177.1584033296112;
        Thu, 12 Mar 2020 10:14:56 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v10sm3398832wmh.17.2020.03.12.10.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:14:54 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: remove clock-names property from 'generic-ehci' nodes
Date:   Thu, 12 Mar 2020 18:14:40 +0100
Message-Id: <20200312171441.21144-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312171441.21144-1-jbx6244@gmail.com>
References: <20200312171441.21144-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3328-evb.dt.yaml: usb@ff5c0000:
'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

'clock-names' is not a valid property name for usb_host nodes with
compatible string 'generic-ehci', so remove them.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/generic-ehci.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 1 -
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 1 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 1bbed660f..be5569b74 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -881,7 +881,6 @@
 		reg = <0x0 0xff340000 0x0 0x10000>;
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST>;
-		clock-names = "usbhost";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		power-domains = <&power PX30_PD_USB>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index d9490f417..ac08d2b70 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -967,7 +967,6 @@
 		reg = <0x0 0xff5c0000 0x0 0x10000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 2079e877a..1ebb0eef4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -513,7 +513,6 @@
 		reg = <0x0 0xff500000 0x0 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>;
-		clock-names = "usbhost";
 		status = "disabled";
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 63355ba7c..bbae92ef3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -349,8 +349,6 @@
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>,
 			 <&u2phy0>;
-		clock-names = "usbhost", "arbiter",
-			      "utmi";
 		phys = <&u2phy0_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -375,8 +373,6 @@
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>,
 			 <&u2phy1>;
-		clock-names = "usbhost", "arbiter",
-			      "utmi";
 		phys = <&u2phy1_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.11.0

