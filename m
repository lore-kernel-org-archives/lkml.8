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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08076C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEB9206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Hey0ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCLROz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:14:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36382 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:14:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id g62so7243924wme.1;
        Thu, 12 Mar 2020 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EYdjJi1eg7gwDE8+qiJsI5fjOAKRoOIZdPVPZzHXbKM=;
        b=M8Hey0ZIup/VKHiqLIq6b3cKb1xTOXZWyT6gZ3p9k0zIiwpnZqOMK/NXvJy6vrxPW0
         irrMKZk9dIXmf7GvYxSwMBq2s4GuK64k6lzUS+lX9gSflctbgWaPA07GhFj4c1KNHfBf
         FdE/xvA0ZSd/VSqUaOynJermbkYE5fUHZaaM/ku9/o9z5+1vhkY3QJrAv3N3WBblUQ4B
         2lQvlu8sQJ+VdF0Jwu5xAYoscqTEAX8SQmIp5tOPVifLuPbaGqCJlgwp7EHj6bsL9+8X
         ZfBggl6QGE1xt77F0pH7bfdO4/6GU9YDSF/5Sg65sfW4UZj6KL6tauTT2xewUhFqGWVi
         qZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EYdjJi1eg7gwDE8+qiJsI5fjOAKRoOIZdPVPZzHXbKM=;
        b=cQHTGrMqr4dJzCf76fVHqTdMe7gz7ROhYKvhGL5iWc2VtM2SbIm5oNGEAALGwU/SPt
         G7c2spcJPE3D3nzSKj807Mo3kjT5Mdw2vjeqLiinwmopVlyVK3psPykPfyPl9ux0bXcZ
         GKQwTB01pLaUFsWO0kS9GSGICB4bgM1XF0cQ5LwckMWiJXuylnCjWsovr+I8HDh0xSCM
         FrvnNl3f9oUvMfJnpg+zur1rCTnVyincJNUJ4q3Rs9jex8t9ZsicILjTyHZ7e7qm3anJ
         eebwfR8ewEXWAJm32GqRRyPDby47aPZBE2hhKAwW7PPDT3LOW40197CEOXdim4esTGjW
         FA/Q==
X-Gm-Message-State: ANhLgQ33H5C7iuq0Bxhj0MQ5R3nml4YosJHVPeWczxPg8rFbIPfptaCe
        aUHszjsjn/c6lpE7jtA7uDY=
X-Google-Smtp-Source: ADFU+vtU7C/3+s0Pk9eeP2zgYFICLmB/RyyyGdx933hyEaJXNcwP3tqeI/5HWn0ccTbWbpltz9yuHQ==
X-Received: by 2002:a1c:1b8a:: with SMTP id b132mr5690411wmb.93.1584033293552;
        Thu, 12 Mar 2020 10:14:53 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v10sm3398832wmh.17.2020.03.12.10.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:14:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: rockchip: remove clock-names property from 'generic-ohci' nodes
Date:   Thu, 12 Mar 2020 18:14:39 +0100
Message-Id: <20200312171441.21144-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200312171441.21144-1-jbx6244@gmail.com>
References: <20200312171441.21144-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rv1108-evb.dt.yaml: usb@30160000:
'clock-names' does not match any of the regexes: 'pinctrl-[0-9]+'

'clock-names' is not a valid property name for usb_host nodes with
compatible string 'generic-ohci', so remove them.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/generic-ohci.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 3 ---
 arch/arm/boot/dts/rv1108.dtsi | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 6503247e9..06172ebbf 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -732,7 +732,6 @@
 		reg = <0x300a0000 0x20000>;
 		interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy0>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy0_host>;
 		phy-names = "usb";
 		status = "disabled";
@@ -753,7 +752,6 @@
 		reg = <0x300e0000 0x20000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST1>, <&u2phy1>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy1_otg>;
 		phy-names = "usb";
 		status = "disabled";
@@ -774,7 +772,6 @@
 		reg = <0x30120000 0x20000>;
 		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST2>, <&u2phy1>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy1_host>;
 		phy-names = "usb";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d33e606be..153868c62 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -505,7 +505,6 @@
 		reg = <0x30160000 0x20000>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HOST0>, <&u2phy>;
-		clock-names = "usbhost", "utmi";
 		phys = <&u2phy_host>;
 		phy-names = "usb";
 		status = "disabled";
-- 
2.11.0

