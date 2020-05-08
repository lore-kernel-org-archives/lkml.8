Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332FDC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10719208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944243;
	bh=iUpnDukiDylvST34jVfkAEYh0JcTaabcxV3c2zG1q7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjbyfiDTPsEye6uCp1I/fFwH8QAB0t0wtgglIlGvpzeY4j9TC8sWVoKEDNVWxFhU9
	 J2rbKhLF46u8HhrRUgB0fwOqASNRFNVX8/T9lZyWkU6U06sxIhxpK0iQ460SW9yVtM
	 UcSQbvJaGpWwBz5YwphbEnqOCT3MMWKMKbDx5JKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgEHNYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgEHMha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54173215A4;
        Fri,  8 May 2020 12:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941449;
        bh=iUpnDukiDylvST34jVfkAEYh0JcTaabcxV3c2zG1q7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaiaiESgSnbqPF1RVn9EAHJZzdBAQdq+yy1olrAhapFmbDJtqEX5qkeZFxoNxcn1V
         tOPeWIbOAOuSFIAnllfDSTNenP2o/QNH+zG18az5HFDt4ncSQ3Rb25ts+ZzaECVvev
         0Yyc40kly9bX2cDGNuFvn6C0u024aNkNk3Cln/ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>,
        Roger Shimizu <rogershimizu@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 4.4 037/312] ARM: dts: kirkwood: gpio pin fixes for linkstation ls-wvl/vl
Date:   Fri,  8 May 2020 14:30:28 +0200
Message-Id: <20200508123127.100070288@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Shimizu <rogershimizu@gmail.com>

commit 6f86e9adc53b4c0a2a4283692216d119019f0b8d upstream.

For kirkwood, gpio pins starts from 32 are in the 2nd bank, so it should be
converted to "gpio1 <pin minus 32>" in dts file.
e.g. gpio 40 should be "gpio1 8"

The pin/bank issue was found when discussing Debian Bug #810894
  [https://bugs.debian.org/810894#47]

Fixes: c43379e150aa ("ARM: dts: add buffalo linkstation ls-wvl/vl")
Reported-by: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/kirkwood-lswvl.dts |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/arch/arm/boot/dts/kirkwood-lswvl.dts
+++ b/arch/arm/boot/dts/kirkwood-lswvl.dts
@@ -1,7 +1,8 @@
 /*
  * Device Tree file for Buffalo Linkstation LS-WVL/VL
  *
- * Copyright (C) 2015, rogershimizu@gmail.com
+ * Copyright (C) 2015, 2016
+ * Roger Shimizu <rogershimizu@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -156,21 +157,21 @@
 		button@1 {
 			label = "Function Button";
 			linux,code = <KEY_OPTION>;
-			gpios = <&gpio0 45 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		};
 
 		button@2 {
 			label = "Power-on Switch";
 			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
-			gpios = <&gpio0 46 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		};
 
 		button@3 {
 			label = "Power-auto Switch";
 			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
-			gpios = <&gpio0 47 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -185,38 +186,38 @@
 
 		led@1 {
 			label = "lswvl:red:alarm";
-			gpios = <&gpio0 36 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 		};
 
 		led@2 {
 			label = "lswvl:red:func";
-			gpios = <&gpio0 37 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
 		};
 
 		led@3 {
 			label = "lswvl:amber:info";
-			gpios = <&gpio0 38 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
 		};
 
 		led@4 {
 			label = "lswvl:blue:func";
-			gpios = <&gpio0 39 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 		};
 
 		led@5 {
 			label = "lswvl:blue:power";
-			gpios = <&gpio0 40 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
 		};
 
 		led@6 {
 			label = "lswvl:red:hdderr0";
-			gpios = <&gpio0 34 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
 
 		led@7 {
 			label = "lswvl:red:hdderr1";
-			gpios = <&gpio0 35 GPIO_ACTIVE_LOW>;
+			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 		};
 	};
 
@@ -233,7 +234,7 @@
 				3250 1
 				5000 0>;
 
-		alarm-gpios = <&gpio0 43 GPIO_ACTIVE_HIGH>;
+		alarm-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
 	};
 
 	restart_poweroff {


