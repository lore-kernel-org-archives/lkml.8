Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B47C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1084D2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796634;
	bh=p8LmWweSMI5BYVBRe4Iv2P0KvrQz7VZ1Le+ZnJ3hJjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZmv9ooohx4Y/pq/9DYfd1m2LYKO8saDTizfJ7bqXZoeOcdrLveZ9B2aqQMWdNCCU
	 5Q27HMHsuocdEI78PIDUk9zn0hw9It90IOK56dS0qx9NWzWsG/qjmlpccqklXk7row
	 g3EvVg6ncG7hGmIdmlIKsi0RepHbHg8TZj1E5gkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgH3OKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbgH3Ny6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B832151B;
        Sun, 30 Aug 2020 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795698;
        bh=p8LmWweSMI5BYVBRe4Iv2P0KvrQz7VZ1Le+ZnJ3hJjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwPGousW7eBgChyeKkvctqma2xGtR9doUnlK5/Z9VCrH7YjnXG+YFfBLiOjDe1gHR
         Snx9TwyN6NzqbwUZhmekoyOplQjC2A9Ag1+jViZWbrOzPGwRW/FLfgkEC4EuKE301q
         WYvD5v+KFdHijOME18iNnAhY7JLbRIh8jhZRu544=
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
Subject: [PATCH 21/33] ARM: dts: exynos: Add CPU cooling in Universal C210
Date:   Sun, 30 Aug 2020 15:51:48 +0200
Message-Id: <20200830135200.24304-21-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing cooling devices for CPU thermal zones in Exynos4210
Universal C310 board.  This allows to scale down CPU frequency (and
voltage) in case of thermal pressure.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 279f0f8f86ed..546d84fe4599 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -196,6 +196,19 @@
 	cpu0-supply = <&vdd_arm_reg>;
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
 &ehci {
 	status = "okay";
 	phys = <&exynos_usbphy 1>;
-- 
2.17.1

