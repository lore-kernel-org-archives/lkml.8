Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8538CC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B95E20665
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 09:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598694064;
	bh=4N+AVz1iFewUv22C1sZLRU1oZ3vPM6n5YgLdZX5yJcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRwMUjTWgOuiLC7VRjsMPgqEFT7StGoLBmft3DezBpwh4s1Wh148KdDMcartxraX3
	 qHS9nLONf7VRhgavWaw3KoGG8fXIK7pLYN9cvoX2SkIh/AHazwynZKAFoxM0650Utp
	 CkjOAJe2hsvj7hrLYFQp8SbJfqbdPMioNRgwpiNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgH2JlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 05:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727913AbgH2Jk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:40:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98ABF20665;
        Sat, 29 Aug 2020 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598694056;
        bh=4N+AVz1iFewUv22C1sZLRU1oZ3vPM6n5YgLdZX5yJcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+2wD2ZhjhIN1gXzv1amScu0pxB18z3tqbRTRtpEupuRJq79iElTKAuAemb7X3jOY
         nnVIDhQXNJJFbBUDdIrVwuTtsQQxzDXz6G9b0lWbNBdatVX7AoBwj1Q4LlCLBl2pEs
         tCZFgb+pSXuiToUF3BNuvYynThEnKVqwe5fMoeoo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] ARM: dts: dove: Fix PCA95xx GPIO expander properties on A510
Date:   Sat, 29 Aug 2020 11:40:23 +0200
Message-Id: <20200829094024.31842-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829094024.31842-1-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCA95xx GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/dove-sbc-a510.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dove-sbc-a510.dts b/arch/arm/boot/dts/dove-sbc-a510.dts
index 2bb85a9b7614..df021f9b0117 100644
--- a/arch/arm/boot/dts/dove-sbc-a510.dts
+++ b/arch/arm/boot/dts/dove-sbc-a510.dts
@@ -143,6 +143,7 @@
 	gpio_ext: gpio@20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;
+		gpio-controller;
 		#gpio-cells = <2>;
 	};
 };
-- 
2.17.1

