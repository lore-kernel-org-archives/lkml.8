Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18194C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCF820684
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598946919;
	bh=W0uN8aKDqSAGlnT2Mlz/Qc+vE6rVkb26WLYOnYjnz1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KPyzTxRFaz8uzOdscYOWfc2YdOtvmuLXSgE3W7Gpd/ajgwOHmDOp85bJXJIABnbhI
	 ZQOj3IJlmYBnAx5LA5lxiBGC0P2QLNK4bEHVaJPWdpqyET0HShq/uhYudViIZqz9Mm
	 Y9avC9CvTQOnq+WCDVjEtZC2Q0n90xaCkqPqhgnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgIAHzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgIAHzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:55:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E612087D;
        Tue,  1 Sep 2020 07:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598946916;
        bh=W0uN8aKDqSAGlnT2Mlz/Qc+vE6rVkb26WLYOnYjnz1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSauzjsEjMvli3RYqDS9PBw5hxdHzpOIYlonnPpBENaTbBfymRv7UjY6DmpfUIlsn
         jfy7YFfOYaCzmOP13p0fFg1KCefgLhArfHB7kXGh0e0VB7e20eZ4EGNPn1HbJO7sk/
         NhQS7DkhfcOeZbtcGdbkh6yufp7pMO5X2UP6BqgE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 12/13] ARM: dts: exynos: Silence SATA PHY warning in SMDK5250
Date:   Tue,  1 Sep 2020 09:54:16 +0200
Message-Id: <20200901075417.22481-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901075417.22481-1-krzk@kernel.org>
References: <20200901075417.22481-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SATA PHY in Exynos5250 SoCs has two interfaces and two device nodes:
1. sata-phy@12170000
2. i2c-9/i2c@38

The first node represents the actual SATA PHY device with phy-cells.
The second represents additional I2C interface, needed by the driver
to communicate with the SATA PHY device.  It is not a PHY-provider in
the terms of dtschema so rename it to silence dtbs_check warning:

  arch/arm/boot/dts/exynos5250-smdk5250.dt.yaml: sata-phy@38: '#phy-cells' is a required property
    From schema: lib/python3.6/site-packages/dtschema/schemas/phy/phy-provider.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 00af7fb65080..e613814da386 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -328,7 +328,7 @@
 	samsung,i2c-max-bus-freq = <40000>;
 	samsung,i2c-slave-addr = <0x38>;
 
-	sata_phy_i2c: sata-phy@38 {
+	sata_phy_i2c: sata-phy-i2c@38 {
 		compatible = "samsung,exynos-sataphy-i2c";
 		reg = <0x38>;
 	};
-- 
2.17.1

