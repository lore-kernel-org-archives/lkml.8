Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C64C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617D5206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796038;
	bh=bvy5JgfVStU+LmnfyJ6fxrqzEqJ3ekac2/7lOiEU4fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FnEDOt6/dq0C5lrpzGqX6kHqY8XI+5T1E0kvODuPHpy9vVZl++xj/xgYz9T99J+p4
	 vi6Tfut+TQ7zWtPk5P/wUNYDJutJRlbPLmUjO4+xd8VCBjTAPltleaAqEenyl8MgZU
	 FU2FKIK7FVQSMxe+68X0hx9h5X5Hx9QXaTQJDCIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgH3OAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbgH3Nyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0845420EDD;
        Sun, 30 Aug 2020 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795692;
        bh=bvy5JgfVStU+LmnfyJ6fxrqzEqJ3ekac2/7lOiEU4fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7cJ3p82YVQ7DddJCjLDCPppLFVVAzWnWVCP5cq5ymEQYla3h2vqnYR11y1FPuGbi
         8I41zw4ehdUL+MEkERQimJNTE8kbGZCpPP46iARC04+WmwOL/mirG9SIqEvKXer4pk
         DCsnVNEbfdyZjZVJDMIz+abKYDiwL8le0mRlY1Ao=
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
Subject: [PATCH 19/33] ARM: dts: exynos: Add CPU cooling in Origen
Date:   Sun, 30 Aug 2020 15:51:46 +0200
Message-Id: <20200830135200.24304-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing cooling devices for CPU thermal zones in Exynos4210 Origen
board.  This allows to scale down CPU frequency (and voltage) in case of
thermal pressure.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.
---
 arch/arm/boot/dts/exynos4210-origen.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index fcf45619a3e4..d6d8a8096eb4 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -129,6 +129,19 @@
 	cpu0-supply = <&buck1_reg>;
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
 &exynos_usbphy {
 	status = "okay";
 };
-- 
2.17.1

