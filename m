Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F24621789
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599503659;
	bh=aDc9+/SMZFvLx8hLQQ+z1mERnBlVBNE/bUXwrPjKYdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2SiG4aYIX4Iar9qOdWmc7Xzj62hqF2a4xBD7OPntRQruDUl0bSYaCyXsGviNhuct
	 WmfRYGlNpV5SW9S85gNcQwPFpNE2Bzs6AV6on+kjZ5Mtw8yCCdk8+z8S8x7GxgW4k3
	 ksy+94HojGcZWhw4cSYKwwR4Q0hjJIZb74USFH8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgIGSeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:34:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgIGSdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:33:51 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F110321532;
        Mon,  7 Sep 2020 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599503631;
        bh=aDc9+/SMZFvLx8hLQQ+z1mERnBlVBNE/bUXwrPjKYdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+1PS6hRk3SfG8ZxWJ8/uckGnMUjCpx32WYfer4ucD3sKdiCxbTEFntNVifSaOfw8
         XFRfBCrwr4pGU3S+j+yxn13K4hgGXREGRZRB5x77d7yRrw5BagDbd2C4DUlbIHG325
         z6duIh4pzjxDtE71HdPyQdFXkRUTdBa+bv5VaNnA=
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
Subject: [PATCH 09/11] ARM: dts: s3c24xx: align PWM/timer node name with dtschema
Date:   Mon,  7 Sep 2020 20:33:11 +0200
Message-Id: <20200907183313.29234-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907183313.29234-1-krzk@kernel.org>
References: <20200907183313.29234-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although PWM is used on S3C24xx as clocksource/timer, the dtschema
expects the node to be named in certain format:

  timer@51000000: $nodename:0: 'timer@51000000' does not match '^pwm(@.*|-[0-9a-f])*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c24xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index 80d4ce79be55..06f82c7e458e 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -39,7 +39,7 @@
 		};
 	};
 
-	timer: timer@51000000 {
+	timer: pwm@51000000 {
 		compatible = "samsung,s3c2410-pwm";
 		reg = <0x51000000 0x1000>;
 		interrupts = <0 0 10 3>, <0 0 11 3>, <0 0 12 3>, <0 0 13 3>, <0 0 14 3>;
-- 
2.17.1

