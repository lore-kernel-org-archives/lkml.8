Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC44C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518FC20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSgXE3T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbgAXQaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:30:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34165 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389216AbgAXQaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:30:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so2722311wrr.1;
        Fri, 24 Jan 2020 08:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/nBc1idIrTwhJFh2qLcvWt1ZlcdSJDY72KjH7Mzfc/k=;
        b=YSgXE3T8mt/EvF+QBdSHJ+8QtQoLULOKFX9+kmB/k0ZO+uQ/MQJA3Y7awKMrnSU+6g
         fXP9+FuM88lRM5LDGPsE2AKXP6TTCsFqyjIYaMcr4Q8MU2yoRHYmAvcBZHpysGBGHx7a
         SIN+WNlKdgHNe3yHHDaEfx8CWGTbwGE/Gz10Z0Gyfb73QarMhqMx3NBscurLgeF2J23y
         p52IG04Buf1H0FXxIDixiMQta4GxO7pKsKJhzl796RmlvED0xvx2kyRkB1SEVMBi+qnw
         aLiMFbYbNbhxe1bFQq05lTkhFp6ejMQT1xTGhdS1RCZ6384QMAfMNTDt6fNxVofcBu6I
         UzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/nBc1idIrTwhJFh2qLcvWt1ZlcdSJDY72KjH7Mzfc/k=;
        b=EMHhITxrGsMVkrt/knjpnyHU/8J+9ayn8HzUIv48VUTvMslejigSuNjx4kl2fsUewv
         +Qz5vEp3/FmaaKtamXn1vYtVHJe+VK46KdE65dYNZX41satG7MFafeajEBXYgqbZE+96
         sQT0P5BstYd6vQj9YSA3Cbo6rDahgdlCxkCnyRZG9zn+Tr6UHoG1lYmsAy8L2XvCOY1v
         6pPc48cYSIcY0x9e7dPq76Awuk8QLzs55JWakm/BhDnmg6xpy3fMm0Q2BXhIw4cqpC+a
         oyQRdKFs2lWfuYM7D2BQ5dybTaWyBgxbV2izePlQSdXxfXJmk/ChEkx3THmMEH45GFav
         +enw==
X-Gm-Message-State: APjAAAVR2BAGP0iZlVVjaXQ2sPi2lFHd8qgRy+K5OwnIa228lhmVj9wb
        3YaD5sm/fFLSz78PhGhq8D0=
X-Google-Smtp-Source: APXvYqyl7Gc1UX6AHRXTGZ6is7tIQEw78voWTsF408bHyHQ4F4/LAx7SDI0+T/jobj0CLg/ilLdF3w==
X-Received: by 2002:adf:e887:: with SMTP id d7mr5105370wrm.162.1579883418665;
        Fri, 24 Jan 2020 08:30:18 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 205sm1977304wmd.42.2020.01.24.08.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 08:30:18 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: [RFC PATCH v2 07/10] arm64: dts: rockchip: add nandc node for px30
Date:   Fri, 24 Jan 2020 17:29:58 +0100
Message-Id: <20200124163001.28910-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dingqiang Lin <jon.lin@rock-chips.com>

Add nandc node for px30.

Signed-off-by: Dingqiang Lin <jon.lin@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 8812b70f3..5560e5b35 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -865,6 +865,18 @@
 		status = "disabled";
 	};
 
+	nandc: nand-controller@ff3b0000 {
+		compatible = "rockchip,px30-nand-controller";
+		reg = <0x0 0xff3b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "hclk_nandc", "clk_nandc";
+		assigned-clocks = <&cru SCLK_NANDC>;
+		assigned-clock-parents = <&cru SCLK_NANDC_DIV50>;
+		power-domains = <&power PX30_PD_MMC_NAND>;
+		status = "disabled";
+	};
+
 	vopb: vop@ff460000 {
 		compatible = "rockchip,px30-vop-big";
 		reg = <0x0 0xff460000 0x0 0xefc>;
-- 
2.11.0

