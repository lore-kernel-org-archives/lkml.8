Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF66C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CFB206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599671915;
	bh=YEdRbTwEhXplWKi1EZoFj+urxRYVg1g/QN1Y18dYxm8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5tm1wCGCxpftwVdcW0GfsekmLW+YziruYNRegNbsBzUkj/4pAkAcu/98ZYex76vx
	 FbqEs6CjoF/72pq5UrY+lWA6oMdMTXL5h/0Fx8D6IGWbCtCwMBnRrdPLYSBlOthSZO
	 uricWqpwbLK2852RFJpVyW9D8ZfW+tFDlbBKzbSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgIIRSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728631AbgIIP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6991722288;
        Wed,  9 Sep 2020 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599664691;
        bh=YEdRbTwEhXplWKi1EZoFj+urxRYVg1g/QN1Y18dYxm8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T31ouZ5uM8E0bASs2sqo/dkfdda5jo5fMnsF0xHv46+HtwL/5HP2373qsxBeyq2l5
         Sx6T7bfXYF+upvXDki8AyFEBubpMaMvDNypZblVRVCkj4UeF/Xs+mnvdBR5mc0b0qU
         BH/SjydD4+AaxfuTolTcDqcvDeo0ruV0gwmULsH4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mn-ddr4-evk: Remove unneeded PMIC pin configuration
Date:   Wed,  9 Sep 2020 17:17:55 +0200
Message-Id: <20200909151755.17783-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909151755.17783-1-krzk@kernel.org>
References: <20200909151755.17783-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin configuration for PMIC interrupt is already set by
imx8mn-evk.dtsi with exactly the same values.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 643f94144152..66668d886a91 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -153,11 +153,3 @@
 		};
 	};
 };
-
-&iomuxc {
-	pinctrl_pmic: pmicirq {
-		fsl,pins = <
-			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
-		>;
-	};
-};
-- 
2.17.1

