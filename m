Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C069C55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8F2074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6HCt7MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgDYTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgDYTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:25:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105DEC09B04D;
        Sat, 25 Apr 2020 12:25:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so15032659wmk.5;
        Sat, 25 Apr 2020 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Svwyrkr3vZwd5gW0zxpIHtZBdUFG58pTxykJU1ReoEI=;
        b=o6HCt7MVG5qE3rdhC06F7oJEaQrBhlAt31o0hGF4VVyT9lWSQLDwzU/Gsoy/EjaVYs
         X6rkhDQuCb4UC2Z+UGjSC+kfnFz0G7EYKwSroVNbhdWEOElrmrvS80+dWydgY97kAIGl
         2dNWdNt5bes//bjT1ymMcT5guGSuXkluWx/j8VfXnivU2FqnKJ0f+aceAc2ir9yGfKAz
         ONbZvJGH8CNojAUwDaVa/495vx5enCxVVgWM5FbvzaFYrDSdUllZCBAjOGESvKNEQ3dM
         GXwhbVKcY08bt7U9RiXEdLUZusRTg99jJh3BEsOW4+HtHVq6IQdnbe1ZI9vDgSMXjNP4
         6frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Svwyrkr3vZwd5gW0zxpIHtZBdUFG58pTxykJU1ReoEI=;
        b=RX53ZyM3F2xfwgAYgKqeR4sHc2d1dyLWtmCKuk0+akBRnYlqTEMQqeN/1D7Varp3BU
         3RnBfGMV9zkLXGEfIAds1X6nc4TmT7xmOzkZMtn7o8vJcX26XGKugxJPAmel32Yljl7x
         gEChO3/5fwk9bEEuEVrdFCzydc4lVOlA18mptV5lsGUJXMImfruh61pfJX54+C2whA1N
         X0XirVZc9RaCe63fqt36UWNiX523xHq/S2hfVVymsFghu9J5aRsAeL+h0aqDykhAJ/a3
         akB3lVE7xRJfACzhWrl0zvXfbwauR49UI5nuM/aFZCLlsHaMT6y8PLZ6yGsaIRBDeMII
         /FgQ==
X-Gm-Message-State: AGi0PuYToUGAJQrH8ElJ7kB1UrizLbM1a3g2z7NhuDHhuxWG1K4C1Jo2
        ZRlDNGijAmHuIR2PewSE5O4=
X-Google-Smtp-Source: APiQypJvr2ETu86soNz5g+ftzOH15ko7oHbimV7sQWH3laHOhQ46ztWN9wQQV1fyA6HogX+wRGv4dQ==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr18237912wme.5.1587842707860;
        Sat, 25 Apr 2020 12:25:07 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id j13sm14277666wrq.24.2020.04.25.12.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:25:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: swap clock-names of gpu nodes
Date:   Sat, 25 Apr 2020 21:25:00 +0200
Message-Id: <20200425192500.1808-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dts files with Rockchip 'gpu' nodes were manually verified.
In order to automate this process arm,mali-utgard.txt
has been converted to yaml. In the new setup dtbs_check with
arm,mali-utgard.yaml expects clock-names values
in the same order, so fix that.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 781ac7583..d9a0c9a29 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -128,7 +128,7 @@
 		assigned-clocks = <&cru SCLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		clocks = <&cru SCLK_GPU>, <&cru SCLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index f7c80538c..7a1a69183 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -557,7 +557,7 @@
 				  "pp1",
 				  "ppmmu1";
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		resets = <&cru SRST_GPU_A>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index f9fcb7e96..d929b6051 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -84,7 +84,7 @@
 		compatible = "arm,mali-400";
 		reg = <0x10090000 0x10000>;
 		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
-		clock-names = "core", "bus";
+		clock-names = "bus", "core";
 		assigned-clocks = <&cru ACLK_GPU>;
 		assigned-clock-rates = <100000000>;
 		resets = <&cru SRST_GPU>;
-- 
2.11.0

