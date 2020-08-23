Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E19C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 17:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F1A20825
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598203251;
	bh=A+5+6JhdVbUJ9D0QMqSPAjM/5xlJh4wUHfgnQQlFXz0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qSKXPVgyS86JENTBR2OakiFumjrO1h8hoSzuV4iTtVODEfF8/L9Qatw5/BMk8KIpF
	 dziF/NTuWYQNBTGiSSw8+uXw3BvJAnifIfLVaLsjQnB/okEFmFqBllznsI+M4DYGet
	 jybVrdX7tyU4poTDYmxSM9ZfTFdO2Jmx3UP/in3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHWRUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 13:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHWRU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 13:20:29 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A1B207CD;
        Sun, 23 Aug 2020 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598203228;
        bh=A+5+6JhdVbUJ9D0QMqSPAjM/5xlJh4wUHfgnQQlFXz0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mxmX4tZJzWGyQS5KfjziN7YAg6FAk7DnZfrWgfdppSVCCMM52HKHEiz7Uqvwg8OnZ
         PYsQYvZFOvPAWBBR4S1qKSqGsklpCOnMGO80D33GbM0ejTXJ949fPLR8y/C8qGQZrG
         KsYKjrC/rD1CdIf0mlZpxPoacfojP/kZMWS6TNUs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] arm64: dts: imx8mm-beacon-kit: Add missing build through Makefile
Date:   Sun, 23 Aug 2020 19:20:16 +0200
Message-Id: <20200823172019.18606-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200823172019.18606-1-krzk@kernel.org>
References: <20200823172019.18606-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing imx8mm-beacon-kit.dts object in Makefile so it will be build
when building dtbs.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index a39f0a1723e0..903c0eb61290 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
 
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
-- 
2.17.1

