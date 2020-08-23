Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091CCC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D499C2072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598173536;
	bh=2uo/JEJs8YAZS6b2NkF8X/+7G50HlAMv/ZREDOinUng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H4MDglOA+/0ZEpRRv7tjBAmTDHIfTeKEJYPrgapLpQ4rJmOYXo3h0C0dj9NuGTc4O
	 PSjkpDVU50jgci3lWG6vca+j+HTz+AZFiIQ3J8IDuiHdmRWTFORHL0fymlB7z/0+Na
	 WkCGXqaGcJCb502zhpISMZf+gZAkn7LiOBPnlzFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHWJFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 05:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbgHWJF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:05:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762092072D;
        Sun, 23 Aug 2020 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598173527;
        bh=2uo/JEJs8YAZS6b2NkF8X/+7G50HlAMv/ZREDOinUng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVXV8H6/FWm1NY+h8uiBifu0RS9SHBzj+PgvpYZ7pWxbqJiR2wcdcE0+IOy7RFZvj
         d772vafq9BwHsW0Z8LjlX2uc5g7ZShrEY7G5sXgxY+tSglY6/X/WXUEoZvE8L7binB
         p1mTxNJ6XMQ3F+k3CYVjciDR2qb/Fo6lCaQeIW3s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: imx8mp-evk: remove orphaned pinctrl-names property
Date:   Sun, 23 Aug 2020 11:05:05 +0200
Message-Id: <20200823090505.5579-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823090505.5579-1-krzk@kernel.org>
References: <20200823090505.5579-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "pinctrl-names" property in iomux node does not make sense on its
own (without "pinctrl-X").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 3da1fff3d6fd..3d535f1b3440 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -124,8 +124,6 @@
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_fec: fecgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x3
-- 
2.17.1

