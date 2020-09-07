Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02915C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C411821941
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503649;
	bh=nO3c5u2hV50mdK3Ye8I2x//FGbka+YIR5xCZMbz5688=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m8tQTqu+vRervaqxaw4iC25gbxM8QiPnI/+SNNDYxNilKhjxrg6pkAJezMZasvwHa
	 IShO058YbKWP9zq8svs1YawZZdlxdmfxjt52fvDd8zSOgn0BHxXzbkdQMIuL2ZVHJb
	 Pgt6K8ALLqXgRF2TZJHZK9SQfuBB7b2GFP9In46E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgIGSd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgIGSdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4157B2087D;
        Mon,  7 Sep 2020 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503625;
        bh=nO3c5u2hV50mdK3Ye8I2x//FGbka+YIR5xCZMbz5688=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIWQCbjHec7OPSQOcycpuhU8nY8bPYKCfAmj0Kgn4lG64gP1OaYRFyXGukRFXgl2d
         pqTaZKGhEUPmfgYAZQvcKX693j/GyECS1RJ3+EIZNXcydlnzhZUzEMLlmIin1Vrzpt
         8iHfHrrwjtV553fQ6Z/anlaapHq+7VDeSKq/VmtI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 07/11] ARM: dts: s3c24xx: fix number of PWM cells
Date:   Mon,  7 Sep 2020 20:33:09 +0200
Message-Id: <20200907183313.29234-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM has only three cells, not four, as pointed out by dtschema:

  timer@51000000: #pwm-cells:0:0: 3 was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c24xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 6d8dd3cdd3c0..0d49d7680e72 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -43,7 +43,7 @@
 		compatible = "samsung,s3c2410-pwm";
 		reg = <0x51000000 0x1000>;
 		interrupts = <0 0 10 3>, <0 0 11 3>, <0 0 12 3>, <0 0 13 3>, <0 0 14 3>;
-		#pwm-cells = <4>;
+		#pwm-cells = <3>;
 	};
 
 	uart0: serial@50000000 {
-- 
2.17.1

