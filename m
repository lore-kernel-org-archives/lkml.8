Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A3C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79BB24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8nLVzUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgB1Isg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:48:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38314 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Isg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:48:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id n64so977014wme.3;
        Fri, 28 Feb 2020 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kSTO66soFbvc/5Jm/tEDfZFDRH8dNbe8ver6F7pISSU=;
        b=t8nLVzUAuYfbtG81ZKfM6k4Iiq22yAcFELg8c8fyrEXnuq3RHaTsEVHWCRrcekNowk
         zwoaEr5b5s6BsOhLnMu9vvrFjpmZL3ydmLdEqkP/Mdju3GROnN3RgJgS3FWS67RRebmn
         QV/qBZ2xvvuxMB/Lg4vxXzkAvlXBl2Msegis4TD2qOVuYQv3SDnw9aNU3uggXdZejCVg
         ebQzb4QZD20BbpcsqzSRifFqAl68kzyTIGdK/rfoY0fYJ3wQkHgt/NUH0L0ytTXmlT3O
         dFVJGkGWudoMVg0UHBWRKFBIbHKJbwiGzvUsDs/7L3u3w5r+hKqUbutT8u3geyTges5B
         7Iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kSTO66soFbvc/5Jm/tEDfZFDRH8dNbe8ver6F7pISSU=;
        b=hTWGlOjNLGK/zcvu3Bs0MbtuayfBEJ0rSp0aTAIKHVpyDFTDz5tyZKHho1uDppAS/I
         frsq8picHOhyKONc9vlrwrSoU8me9NFmKSp9ORCGQiVVk2kkSORn23iO4lFISMRioEwU
         X/xZh6s2x8hzAODgCElOfH94byHG8PrSCwDC/sAoNtCIi346J5HSZg0BL6X2DqVwLHTd
         6G7rdfmjXf+FFQ7hDC5dJrGmS4Jz6WpxvHZT0kbTsAB7WwgoQJQmBMUr9DG15mZ8POtW
         Fm/I6PYS1HHqpG8bE5/nBZCCq5et+Q+VY402cgdU2EHcVykfifkZAAxxCVyeaRZmYVP7
         UBaA==
X-Gm-Message-State: APjAAAXIet2YXma1zse9dIxMAlEc3py+1WCy8cVmNI+Ky0Wu1hb+Z/4t
        Jvx+/SRE/thwxvr3GOYuXEddo9lG
X-Google-Smtp-Source: APXvYqyqHsz+mxqVS4aLRQAeppLeop3ADBWwBXJvRWEgLA6x8ZR5U0eUOgB2g79t4bbxWiNTpy4Ayw==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr3659938wmr.72.1582879714750;
        Fri, 28 Feb 2020 00:48:34 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id y3sm1209337wmi.14.2020.02.28.00.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 00:48:34 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix cpu compatible property for rk3308
Date:   Fri, 28 Feb 2020 09:48:27 +0100
Message-Id: <20200228084827.16198-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example these errors:

arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
Additional items are not allowed ('arm,armv8' was unexpected)
arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
['arm,cortex-a35', 'arm,armv8']
is too long

Fix these errors by removing the last argument of
the cpu compatible property in rk3308.dtsi.

make ARCH=arm64
dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/cpus.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 116f1900e..3bd5bc860 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -40,7 +40,7 @@
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			clocks = <&cru ARMCLK>;
@@ -53,7 +53,7 @@
 
 		cpu1: cpu@1 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -63,7 +63,7 @@
 
 		cpu2: cpu@2 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
@@ -73,7 +73,7 @@
 
 		cpu3: cpu@3 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a35", "arm,armv8";
+			compatible = "arm,cortex-a35";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			operating-points-v2 = <&cpu0_opp_table>;
-- 
2.11.0

