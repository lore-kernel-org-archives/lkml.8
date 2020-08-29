Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4F0C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DD206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711188;
	bh=6gznRRrKsqAQNWmMyK3EtnSRpMtqnII6P6GgV9nfPDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1eKKBzpZR/C9TNvFFspjWa6NMN2vvhHD5qUZ7iseyB8cUKtnSOb5jUfdjNBcR/kCh
	 Md5rK7EuGmQDdz3UphqOFS+wcRjc5qy7+fTtRPgkrttShVLBWOslx+2pDHHlM7mxde
	 nb3lk01mh1KlpqSBYq4mJg/D2wGVdyKBPPgtCuU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgH2O00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgH2OZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:25:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D726820791;
        Sat, 29 Aug 2020 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711153;
        bh=6gznRRrKsqAQNWmMyK3EtnSRpMtqnII6P6GgV9nfPDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykSI5/vivMZCJ/zaqQo1HfS6rLP0th/ECZU3qUrs4QBNLMpoSQCspQsQFh6kiqmsI
         Y7xEH8oXyzlvQRE0WpAD96kv0vIpwAirg6JrfcPFqBtItQV2RFbD6i68BEbOEhOJ9U
         6Z1iMrsvNt+/i83xi7toS8eLB4ehdk4S/hm47wFk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 08/10] arm64: dts: exynos: Add compatibles to sysreg nodes
Date:   Sat, 29 Aug 2020 16:24:59 +0200
Message-Id: <20200829142501.31478-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System register nodes, implementing syscon binding, should use
appropriate compatible.  This fixes dtbs_check warnings:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: syscon@13b80000:
    compatible: ['syscon'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 74ac4ac75865..b2eebdd88c3c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1015,17 +1015,17 @@
 		};
 
 		syscon_disp: syscon@13b80000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x13b80000 0x1010>;
 		};
 
 		syscon_cam0: syscon@120f0000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x120f0000 0x1020>;
 		};
 
 		syscon_cam1: syscon@145f0000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x145f0000 0x1038>;
 		};
 
-- 
2.17.1

