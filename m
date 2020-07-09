Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D372C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5F3206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TldPPZhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgGIAMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgGIAMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:12:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6EAC061A0B;
        Wed,  8 Jul 2020 17:12:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so76055pls.4;
        Wed, 08 Jul 2020 17:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqkupbtZKC2qjSer1dGE8XK+5kA0IZx3gNr8bMY/uR0=;
        b=TldPPZhvHQNUVm64atdptGaYDSlL8NwtMCNrP41p3mAORV+PBRKZfmRLKKTR4frIdH
         X1ra2e5YOu1UJeF7BP2XPK/Onii6ifQH+3I2/snpFBHcW8682UZobFAGMS7TLXP4E3Rr
         JF3FMVwXfdwS50qvXNTTWH9yqvnmOu1HnPP6UASgh/0w4g2S4tJifJFutd2WharpR4tr
         I5nI9eMVNUOkffqiPptXXVAjiYM3UQyX0+y+SlOUMeBXuKEIlUx6iR//wOQoPmKM5CR3
         rR9/7BgyA6DKAaKWew8I7YBo+F/ED3n2v4Iwf3Pd0HnSNsfJh5kNK3LD17jxRd3V+dKr
         xJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqkupbtZKC2qjSer1dGE8XK+5kA0IZx3gNr8bMY/uR0=;
        b=U6h73pJHPkS76R2fsL6ocntesiJC98rij/8dsMxp39jiRFfRAjJ0NPkqWtrkUMN+Zy
         xmwIkrsLD/H/JZR+Wik5VtfIXaGjanInLRYaIwdPCUCafZrZNPymauzPK8TLaU3tukRL
         U64SKVhGuLQuuagk/B15IYJPFunNcRGkx9Q+vLeC4wGdWc1Afas7WA+brQNidNMrghgR
         jSIqVgAfuo0SOSzgsgt22by0ep342EwQ+5jBIyo8sMNdqbVL9Fci7X9xlplmoHHZdzxQ
         MdmMJlKnw4GtZoDP7BjTd+c2VEs/W+T1pZdax1zCDoX84IHptA6Jm0vMJi17plcJKDk5
         uEYQ==
X-Gm-Message-State: AOAM533eBSr3hXP5b3Vw3K0LQvI5Uz451C/NqsgMJF/fJWErcPxOhMle
        Fj3uIm2BuHfdCmSJtpwsz1E=
X-Google-Smtp-Source: ABdhPJy3s4R5Ku8XAf4vu1kwopHnU8fZOhCvhfPetPBF72iqWtUAfpqHqZNML7I8nYXyK93PJPMxxA==
X-Received: by 2002:a17:902:bd08:: with SMTP id p8mr42945633pls.154.1594253521197;
        Wed, 08 Jul 2020 17:12:01 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id u14sm810669pfk.211.2020.07.08.17.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 17:12:00 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, stefan@agner.ch,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com
Cc:     Andrew Lunn <andrew@lunn.ch>, Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] arm: dts: vf610-zii-scu4-aib: Configure fibre ports to 1000BaseX
Date:   Wed,  8 Jul 2020 17:11:54 -0700
Message-Id: <20200709001154.7403-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

The SFF soldered onto the board expect the ports to use 1000BaseX.  It
makes no sense to have the ports set to SGMII, since they don't even
support that mode.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Chris Healy <cphealy@gmail.com>
---
v2:
- convert spaces back to tabs
- Correct from line to show Andrew as the original author

 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index b642520199ba..040a1f8b6130 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -186,7 +186,7 @@
 					port@2 {
 						reg = <2>;
 						label = "eth_fc_1000_2";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff1>;
 					};
@@ -194,7 +194,7 @@
 					port@3 {
 						reg = <3>;
 						label = "eth_fc_1000_3";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff2>;
 					};
@@ -202,7 +202,7 @@
 					port@4 {
 						reg = <4>;
 						label = "eth_fc_1000_4";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff3>;
 					};
@@ -210,7 +210,7 @@
 					port@5 {
 						reg = <5>;
 						label = "eth_fc_1000_5";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff4>;
 					};
@@ -218,7 +218,7 @@
 					port@6 {
 						reg = <6>;
 						label = "eth_fc_1000_6";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff5>;
 					};
@@ -226,7 +226,7 @@
 					port@7 {
 						reg = <7>;
 						label = "eth_fc_1000_7";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff6>;
 					};
@@ -234,7 +234,7 @@
 					port@9 {
 						reg = <9>;
 						label = "eth_fc_1000_1";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff0>;
 					};
@@ -269,7 +269,7 @@
 					port@2 {
 						reg = <2>;
 						label = "eth_fc_1000_8";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff7>;
 					};
@@ -277,7 +277,7 @@
 					port@3 {
 						reg = <3>;
 						label = "eth_fc_1000_9";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff8>;
 					};
@@ -285,7 +285,7 @@
 					port@4 {
 						reg = <4>;
 						label = "eth_fc_1000_10";
-						phy-mode = "sgmii";
+						phy-mode = "1000base-x";
 						managed = "in-band-status";
 						sfp = <&sff9>;
 					};
-- 
2.21.3

