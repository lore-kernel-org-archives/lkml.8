Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FDC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAE6206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711422;
	bh=CP8KqP43wOtJ8WcHsmx6axWh4HzD/Tid44BJ/kee/5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFaFhEdQRJboFeeCAM4gUo9SrJb+xw6KEF0UeocgRCl4G4O/R227IKArkR9gqsMMi
	 yf+3CboGRQsS1hvYllL8kl/20piF+MIDbG5uD18nasmyW+JEfuWrJGSFSvCvq/RRPd
	 1QreQJbUHwMATIXv/RY74sixBLRJCKjh71sqoeEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgH2OaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgH2OaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:30:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15BED20791;
        Sat, 29 Aug 2020 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711408;
        bh=CP8KqP43wOtJ8WcHsmx6axWh4HzD/Tid44BJ/kee/5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwBwyz80yplEZECMeZEv+mE9/bwYZaDZvhvIGUEh3Vlzdyxlg9QCDBbpHbse+7dCV
         +6An3jubPj37vyZnEeHzZamA76+vqIdAwtenB6WHgn1PnSLlGgCoH+cY9HRsYzoxLx
         ITu9WK2q2bie7ZBh8IIR0PHlFt1xylM44H6byLZQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfc@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 4/4] arm64: dts: exynos: Use newer S3FWRN5 GPIO properties in Exynos5433 TM2
Date:   Sat, 29 Aug 2020 16:29:48 +0200
Message-Id: <20200829142948.32365-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142948.32365-1-krzk@kernel.org>
References: <20200829142948.32365-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since "s3fwrn5" is not a valid vendor prefix, use new GPIO properties
instead of the deprecated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 250fc01de78d..24aab3ea3f52 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -795,8 +795,8 @@
 		reg = <0x27>;
 		interrupt-parent = <&gpa1>;
 		interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-		s3fwrn5,en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
-		s3fwrn5,fw-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
+		en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
+		wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
2.17.1

