Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D646020787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="UHKH84LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCaUf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:35:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33836 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:35:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id i6so24638568qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWtGUXK2zzrPXg+mdinua6CvQBln6b8yVtBovLhZQBM=;
        b=UHKH84LZwqr0bTdSwOk8VIsZ6AYBEPPO9nInCQAu3ZSyBdpWRCbIrt21I54J3efqMH
         CRcRLuraIHpJJr+2PxYTCHgAKLK/nrHYseyTVaXpZ8W75RGfZ4wESFS1GHlVOnD4rr2x
         Kh/x0msbStYMQNWZDhu8YQSyALwBDH9TsChu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pWtGUXK2zzrPXg+mdinua6CvQBln6b8yVtBovLhZQBM=;
        b=a+LkRl+y5r7c0PDS9U2C2uHKd58zid25txONSROaIc8PIa09HRQYKo7iZifVfpbPQU
         juNWpm+VCa9saawF+5rJu9Nf2NZTaZasMSTwCLokQm1m09c6addnkziMAm00YrlRHxj+
         lv3PaV1eTZTLqe+Xr0aXCVdGQD9bZ/+OCxZMWVtAaPgNIA/LtkP+WPRuW2vrDpvn3vbp
         t5Nq0Y8Z1GDQogIiw409nizFarZhFNJ+Nr8Bffqvwvw2qKbPD95Q1aT2m/5E/mXmL+Wo
         eyRDb12uLjjF6kGEzEuhmLsknHDSjtTYbzzhNqv2QNbJ9lzbX+axONbSDYj/8Dkx1Wne
         3QHg==
X-Gm-Message-State: ANhLgQ2PsRwxRes7b/iM8zgpAeumR1Z9HekpcoMYE1sGltl0xWUWPB0o
        dgfbvikRN1utpBsOAYsACl8ilg==
X-Google-Smtp-Source: ADFU+vtvRN6McKV5WGRyQGrJqQFKIHQwBHa5/AK61/BtydHPYOQvzA5pNrN2Yuj49YvxZmk9U7GEOQ==
X-Received: by 2002:a37:30f:: with SMTP id 15mr6246456qkd.44.1585686957509;
        Tue, 31 Mar 2020 13:35:57 -0700 (PDT)
Received: from bacon.ohporter.com ([2605:a000:1234:6170:a2c3:e83:a1a:a4b])
        by smtp.gmail.com with ESMTPSA id i20sm16566qkl.135.2020.03.31.13.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:35:56 -0700 (PDT)
From:   Matt Porter <mporter@konsulko.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: imx8mm: fix dma peripheral type for SAI nodes
Date:   Tue, 31 Mar 2020 16:35:51 -0400
Message-Id: <20200331203551.20914-1-mporter@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The peripheral type specified in the dma phandle for each SAI node
is incorrect. Change it to specify the SAI peripheral.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..ddc93fc4817a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -240,7 +240,7 @@
 					 <&clk IMX8MM_CLK_SAI1_ROOT>,
 					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+				dmas = <&sdma2 0 24 0>, <&sdma2 1 24 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -253,7 +253,7 @@
 					<&clk IMX8MM_CLK_SAI2_ROOT>,
 					<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+				dmas = <&sdma2 2 24 0>, <&sdma2 3 24 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -267,7 +267,7 @@
 					 <&clk IMX8MM_CLK_SAI3_ROOT>,
 					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+				dmas = <&sdma2 4 24 0>, <&sdma2 5 24 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -280,7 +280,7 @@
 					 <&clk IMX8MM_CLK_SAI5_ROOT>,
 					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+				dmas = <&sdma2 8 24 0>, <&sdma2 9 24 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -293,7 +293,7 @@
 					 <&clk IMX8MM_CLK_SAI6_ROOT>,
 					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
 				clock-names = "bus", "mclk1", "mclk2", "mclk3";
-				dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+				dmas = <&sdma2 10 24 0>, <&sdma2 11 24 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
-- 
2.20.1

