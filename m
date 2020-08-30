Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF476C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FFA20757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795559;
	bh=p18sRxzhST8XgwhYT13ReRxvX7HC7a6S5P1tlyouidM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CP2llAssVEFkXQU3Lo/UZfEJUbcyCfnxSxeEwxbBVTSxnFlF52fugFgWmDP8YvQv0
	 BvNJIl0OBNJB89EyTt/Q3HfqAchwrG8jLZtTPs5pYQD6/an2z7jHF2IT2XdtjIOyi5
	 MNetoqi8gHwdBz0rPDRho2nRXnblJWdlcZlM8bcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgH3Nwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgH3NwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:52:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E0520757;
        Sun, 30 Aug 2020 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795538;
        bh=p18sRxzhST8XgwhYT13ReRxvX7HC7a6S5P1tlyouidM=;
        h=From:To:Cc:Subject:Date:From;
        b=N26CP6VTXx7+IIKB5LAYttgv/UjJ7zv4VS7M49+bMk2lG+mFu3IJZ1O2nGTVgCVaq
         cmwZS+2tkIAsKI/ebE8FAdoF2NaVAE53Es2qZfgw4OrV5er1VQZGK0iKpG91FRG7qC
         D3DBAUHtH9H4dXKdshhJhCrUWfei2Ab0K+ut2klE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Denis GNUtoo Carikli" <GNUtoo@cyberdimension.org>,
        Simon Shields <simon@lineageos.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 01/33] ARM: dts: exynos: Silence i2c-gpio dtschema warning in Galaxy I9100
Date:   Sun, 30 Aug 2020 15:51:28 +0200
Message-Id: <20200830135200.24304-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of I2C controller over GPIO lines node ends with '-gpio' which
confuses dtschema:

  /arch/arm/boot/dts/exynos4210-i9100.dt.yaml: /: i2c-gpio:
    {'compatible': ['i2c-gpio'], ...  'maxim,over-volt': [[4500]]}} is not of type 'array'
    From schema: lib/python3.6/site-packages/dtschema/schemas/gpio/gpio-consumer.yaml

Add a '-0' suffix to silence it.  This pattern on naming i2c-gpio is
already present in many other dts.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 6d0c04d77a39..3eb11cc2c3c5 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -123,7 +123,7 @@
 		reset-gpios = <&gpl1 2 GPIO_ACTIVE_LOW>;
 	};
 
-	i2c_max17042_fuel: i2c-gpio {
+	i2c_max17042_fuel: i2c-gpio-0 {
 		compatible = "i2c-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

