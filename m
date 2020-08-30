Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF4EC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1BC206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796080;
	bh=FaOPcDhgZcobruDLgJzbpI0/gTfdD2QV0RtRB8lWHYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWTnyOfB1rGMyg5HuV7mmaJ5VpjelbawugHbOXNVExASyL9fFIMZjEDHZjW8a7uza
	 Bq/GspysgAEarB/UWxOLnGotua6i7Pgz5qGqyBsVZTYS3wa8gs6W17+m6cx1t/dlTm
	 cmavUwstxvN4R9qfEocvqynhpIdvxTvumYT1I36s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgH3OA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbgH3NzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:01 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B8A208DB;
        Sun, 30 Aug 2020 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795701;
        bh=FaOPcDhgZcobruDLgJzbpI0/gTfdD2QV0RtRB8lWHYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFIGDQOuYnDGl+CsJiUET7CVF/FOSyBK3NwWfOUg+VG5dU4PDoQsokrpjuto/VOV3
         O4flj0KTePJt2LyADWktbwKrOnj1kvJnZrWEjKobg+rbt/+vcK+TpimpkTfKKeD2Ei
         FekIAMxJBN9riiGE5MCtBxZoC24P6HE5q1p1YT4k=
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
Subject: [PATCH 22/33] ARM: dts: exynos: Align MHL GPIO pin configuration with dtschema on Galaxy I9100
Date:   Sun, 30 Aug 2020 15:51:49 +0200
Message-Id: <20200830135200.24304-22-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of mag-mhl-gpio node to avoid dtschema confusion and
dtbs_check warning:

  arch/arm/boot/dts/exynos4210-i9100.dt.yaml: pinctrl@11000000: mag-mhl-gpio:
    {'samsung,pins': ['gpd0-2'], 'samsung,pin-function': [[3]], 'samsung,pin-pud': [[0]]} is not of type 'array'
    From schema: dtschema/schemas/gpio/gpio-consumer.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-i9100.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 799b69e1a93a..5370ee477186 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -681,7 +681,7 @@
 		samsung,pin-val = <0>;
 	};
 
-	mag_mhl_gpio: mag-mhl-gpio {
+	mag_mhl_gpio: mag-mhl {
 		samsung,pins = "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.17.1

