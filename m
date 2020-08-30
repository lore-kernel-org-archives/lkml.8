Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195A1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E682A2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796640;
	bh=e0JyFqQj5dDq9Ts6nr7zlxHV9FBQ38m+GvcYvlj8naE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJ+cwhnBl7YDLM+QeXP8fmKyq6+Y8adRY7jPWixf4tLNRNd0pdLTJBOJRyWYaobNH
	 BC6Ly9fXeZ3dpfCRUlqjofryWoMVBgHpoujdf7huRYpo3wtkqyzzQdHUlCSz8XNCNo
	 vJIgUn7ZlHQn19Hs1H+nzSnheAUJVi9Uv0GfioMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgH3OKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgH3Nyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:55 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED19D20757;
        Sun, 30 Aug 2020 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795695;
        bh=e0JyFqQj5dDq9Ts6nr7zlxHV9FBQ38m+GvcYvlj8naE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsuXc/dD/X7e1s7Ddz66jr/lJ3NB4QW2w07Kb7LvJYTnnsEYzFBf21JhhJ3lPTHOz
         mTVdhL33JoBmy5WcSuHZAhgbeycHcaW+7ZVIsI08t7dzPOkbv63unxJQjA5pJkuM3C
         2lkP/F7/3X2LGiNPVgPansfcu7k6AWcpsD3UYBL4=
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
Subject: [PATCH 20/33] ARM: dts: exynos: Add CPU cooling in SMDKv310
Date:   Sun, 30 Aug 2020 15:51:47 +0200
Message-Id: <20200830135200.24304-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing cooling devices for CPU thermal zones in Exynos4210 SMDKv310
board.  This allows to scale down CPU frequency (and voltage) in case of
thermal pressure.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-smdkv310.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 0b0e86737b26..c5609afa6101 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -50,6 +50,19 @@
 	};
 };
 
+&cpu_thermal {
+	cooling-maps {
+		map0 {
+			/* Corresponds to 800MHz */
+			cooling-device = <&cpu0 2 2>;
+		};
+		map1 {
+			/* Corresponds to 200MHz */
+			cooling-device = <&cpu0 4 4>;
+		};
+	};
+};
+
 &i2c_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
-- 
2.17.1

