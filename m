Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE214C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 04:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6720772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 04:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvjKs12h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgHSEXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 00:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSEXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 00:23:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDDCC061389;
        Tue, 18 Aug 2020 21:23:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so10753793pgm.7;
        Tue, 18 Aug 2020 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gs2moho+8LLh/szOeFyTur0O43lNxC9IiDOCEh8TM9E=;
        b=UvjKs12h9DQKYGQRS1toiyg8jpbgB/8nWdastjYJyhssofp6FGxo18MSWkuH0QDrwd
         siZVLO/1UJDEU+s5+LyT+g+t2VLvL6JqUBYARntwh3hZjzJCWz5Mv8W6XwAaJWpSvcik
         YR/+H8WC0WYRgp9Y4rSD+qEicdkVKDxxu6DuYVI2zpuV5p+qHoe11O7UBoU6hhGE8izQ
         Z3mkaCnpA592d3lX2Vgv+5K4fbKsIpF7asJwTh7yhxfe8n4AqQ5hgxwEdf9c/Y9y5rxQ
         7jW3s013pIaxCiW46KfTfmRSc74jNDwlIGMBQ4ATLFIgKuktPHekhV5ctVel0WL5w4nu
         MVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gs2moho+8LLh/szOeFyTur0O43lNxC9IiDOCEh8TM9E=;
        b=iVUOL9Vsft+WU9JIalL1FL/g+tyYgNQTtnC5O0hyx36xXHWeedk79VETcYv2fyJy0S
         xgCLmm0Z0dgzqCB+V2y1NlnckL8H75d6cuKXwWpBrTVJQ/URBfn+vkej9eJkK+h94OD0
         5O82AUPFzKruLJRdGyW3tQYlV5HosffYy78aRnaOa8hTfHrUVdwF6cZT1nyUvNJitrH3
         0t530xVPUUAAwbMukvakv+JbXqB28ntp7IHAnCoxhwDtg1eDsiGcSYMNCvkkqd5cDx1E
         8XDYYXWUdXzi78N85Uh5b1nO9PQhmnW8YBvHcHyxnx7xIC9BDM1yJAb7QVL7yy6U2bjF
         5GbQ==
X-Gm-Message-State: AOAM531EJ1tYkd7Lzg/Ny7HG+Bh3aN/UPtPic6+31GLsCENhwULhuJOX
        47LkpjoWRAzZ99Kwp4cPhQA=
X-Google-Smtp-Source: ABdhPJz9/1ooO+46V/DifjOQSnAS8Pt2MsME2bhXJp+E69XSJuk0FgwL2E0diO6Usx/r2k+Hg2D1rw==
X-Received: by 2002:a63:5515:: with SMTP id j21mr15011312pgb.31.1597810994235;
        Tue, 18 Aug 2020 21:23:14 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id x11sm10723336pgl.65.2020.08.18.21.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 21:23:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM5301X ARM
        ARCHITECTURE), Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: BCM5301X: Fix pin controller node
Date:   Tue, 18 Aug 2020 21:23:07 -0700
Message-Id: <20200819042308.19043-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin controller resources start at 0xc0 from the CRU base which is at
0x100 from th DMU base, for a final address of 0x1800_c1c0, whereas we
are currently off by 0x100. The resource size of the CRU is also
incorrect and should end at 0x248 bytes from 0x100 which is the start
address. Finally, the compatibility strings defined for the
pin-controller node should reflect the SoC being used.

Fixes: 9994241ac97c ("ARM: dts: BCM5301X: Describe Northstar pins mux controller")
Reported-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Christian, can you test this as a preliminary patch for your Cisco
Meraki MR32 series? Thanks!

 arch/arm/boot/dts/bcm4708.dtsi  | 4 ++++
 arch/arm/boot/dts/bcm4709.dtsi  | 4 ++++
 arch/arm/boot/dts/bcm5301x.dtsi | 8 ++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708.dtsi b/arch/arm/boot/dts/bcm4708.dtsi
index 1a19e97a987d..5064fe51e402 100644
--- a/arch/arm/boot/dts/bcm4708.dtsi
+++ b/arch/arm/boot/dts/bcm4708.dtsi
@@ -43,6 +43,10 @@ cpu@1 {
 
 };
 
+&pinctrl {
+	compatible = "brcm,bcm4708-pinmux";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm4709.dtsi b/arch/arm/boot/dts/bcm4709.dtsi
index e1bb8661955f..7417c275ea9d 100644
--- a/arch/arm/boot/dts/bcm4709.dtsi
+++ b/arch/arm/boot/dts/bcm4709.dtsi
@@ -5,6 +5,10 @@
 
 #include "bcm4708.dtsi"
 
+&pinctrl {
+	compatible = "brcm,bcm4709-pinmux";
+};
+
 &uart0 {
 	clock-frequency = <125000000>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 2d9b4dd05830..bf49943f504a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -402,14 +402,14 @@ dmu@1800c000 {
 
 		cru@100 {
 			compatible = "simple-bus";
-			reg = <0x100 0x1a4>;
+			reg = <0x100 0x248>;
 			ranges;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			pin-controller@1c0 {
-				compatible = "brcm,bcm4708-pinmux";
-				reg = <0x1c0 0x24>;
+			pinctrl: pin-controller@c0 {
+				compatible = "brcm,bcm53012-pinmux";
+				reg = <0xc0 0x24>;
 				reg-names = "cru_gpio_control";
 
 				spi-pins {
-- 
2.25.1

