Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91772074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599200919;
	bh=zfS0H6v715P21vFlZs6nukhnAfrndiT7PBg+XlOj3Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qD+Q/x5o3OjuzL2i1kpj/E7MrUUwAx7J49v1jC6Ke1h2eW5BrnYpI0DBrBrGI29jC
	 OJU2anvRD75WV8HjkMh6VyuCJ01FpnHukOyxWa0bwhjwYJ9JA/jMXgwl2yZlMg7M7D
	 aS8qGlfyma+fdEV8w2IJ7dulp6Ycm8rNyQGrYqq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgIDG2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbgIDG2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:28:35 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9228420748;
        Fri,  4 Sep 2020 06:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200914;
        bh=zfS0H6v715P21vFlZs6nukhnAfrndiT7PBg+XlOj3Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSd6aoX1dMaMrseJcTDBoaOZjt/+LfdFkpRKY1pQ9y5/rwEw0e9VG5aZo/vj6k/78
         A69lla9FxWCsnctDdB32Id567iT37FiEcjhjfl2oKKgfuNxnh0EKs8qzkXz6fHSGym
         qtaW8SLzb8rarIyyZ7ULqHrfm9Xk1+71hp0D4YxA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 14/14] ARM: dts: imx28-m28: Align GPMI NAND node name with schema
Date:   Fri,  4 Sep 2020 08:27:43 +0200
Message-Id: <20200904062743.6273-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904062743.6273-1-krzk@kernel.org>
References: <20200904062743.6273-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree schema expects NAND controller to be named
"nand-controller", otherwise dtbs_check complain with a warning like:

    arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dt.yaml: gpmi-nand@8000c000:
        $nodename:0: 'gpmi-nand@8000c000' does not match '^nand-controller(@.*)?'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Rebase on already applied similar patches
---
 arch/arm/boot/dts/imx28-m28.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-m28.dtsi b/arch/arm/boot/dts/imx28-m28.dtsi
index 0bac72d5351f..2bdb4c093545 100644
--- a/arch/arm/boot/dts/imx28-m28.dtsi
+++ b/arch/arm/boot/dts/imx28-m28.dtsi
@@ -16,7 +16,7 @@
 
 	apb@80000000 {
 		apbh@80000000 {
-			gpmi-nand@8000c000 {
+			nand-controller@8000c000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				pinctrl-names = "default";
-- 
2.17.1

