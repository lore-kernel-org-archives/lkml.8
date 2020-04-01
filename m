Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B9C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F472071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiUngpcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgDAHMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:12:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:12:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so11678093pgs.9;
        Wed, 01 Apr 2020 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B3hOtuYx2qEFqAvN/dFn1En7OfC2UzEXV8qVkkGMlOE=;
        b=uiUngpcwOC8F3/6uoxQp7s8GmF7oqVnVmTMMRbRXKM64s6Lq8YfMvgnYlSqNyTV+eJ
         MJwZU/Ijxq7Xe6EMGDI61kJhwQesukIHq41fF6cnG2fNo7H3FIX4RV8pBsvfn2QKEume
         OptFai9Ob7DugbYUnoork2+xHwI9ttzh7RydmThY1PKdvIIzhm1aN355zNJtAUI3PCt8
         bwzjvIYYA7qkzYew5tdVpneLAvsqiNPRDT3Ldd1NqxDmgFtsosgs5enz4Ce6ArRFOOwH
         +6oDWBchh9VfB/tjYDYJcCX7G0o1I7qLy2geFx9tfP4zX/hqFeiM//zyuePS00cPEHkH
         8o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3hOtuYx2qEFqAvN/dFn1En7OfC2UzEXV8qVkkGMlOE=;
        b=oj8QJVinwOdZpkx85V88mqqgRTqp5AAl5pVIfPE+07RLJsBHsy2JCddE93pbS7u517
         X3FDerI3ZOzD9X+/JDL2DLbdnigxGv6zutEpcC7ra5NfXqolV8kbf7Q6EbJueBXTCXHk
         ygj0I8pUbcxoIrzjHmKvpVeIDr+wqs4QNM1hGgDGj2rcxF3jPTmtjb5CBJRYXMOUKSn0
         BbxXMFk2+OBvYzY58RuejIkvGjvIZPK91Lk/rWfNd2RWOp4AcVy91dSK0sJyCrVnLVyy
         i04rOG2T/JaooXcZMa4DzD1mHLrMcwxpJULw87SulamU2yGYxAP8Xp9Oy6wnW+goYs/t
         Ncdw==
X-Gm-Message-State: AGi0PuZYhspX+dGLWzbUKNpu+iDb/qXyc7ps96TDvKhGPQQSxomWSMlD
        40oNRiCuYJh6g41XpouDnOVOljdk
X-Google-Smtp-Source: APiQypLyBd7s6JV3zjT87uX/15+MDZZWtntLDX01WXIkpSydLpFlVa7z3J4DxQfm6MCwtVb1uWDmhg==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr8375506pfl.2.1585725148445;
        Wed, 01 Apr 2020 00:12:28 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n7sm784519pgm.28.2020.04.01.00.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:12:27 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/2] arm64: dts: Add SC9863A emmc and sd card nodes
Date:   Wed,  1 Apr 2020 15:11:44 +0800
Message-Id: <20200401071144.10424-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401071144.10424-1-zhang.lyra@gmail.com>
References: <20200401071144.10424-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add emmc and sd card devicetree nodes for SC9863A.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 586c7488c12b..2003fa0293b6 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2019, Unisoc Inc.
  */
 
+#include <dt-bindings/clock/sprd,sc9863a-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include "sharkl3.dtsi"
 
@@ -543,5 +544,46 @@
 				};
 			};
 		};
+
+		ap-ahb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			sdio0: sdio@20300000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20300000 0 0x1000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_SDIO0_2X>,
+					 <&apahb_gate CLK_SDIO0_EB>;
+				assigned-clocks = <&aon_clk CLK_SDIO0_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+				bus-width = <4>;
+				no-sdio;
+				no-mmc;
+			};
+
+			sdio3: sdio@20600000 {
+				compatible  = "sprd,sdhci-r11";
+				reg = <0 0x20600000 0 0x1000>;
+				interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+
+				clock-names = "sdio", "enable";
+				clocks = <&aon_clk CLK_EMMC_2X>,
+					 <&apahb_gate CLK_EMMC_EB>;
+				assigned-clocks = <&aon_clk CLK_EMMC_2X>;
+				assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+				bus-width = <8>;
+				non-removable;
+				no-sdio;
+				no-sd;
+				cap-mmc-hw-reset;
+			};
+		};
 	};
 };
-- 
2.20.1

