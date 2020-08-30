Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8B8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF25D20707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598795939;
	bh=ncdBjX6kj1zQYOK5FR4Q6lv8taXgN5OQVLTPtWHDUX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lMwtnySyTla1cP6Lfjj56NxgsIj6Y+AEdUO5TtYabxfun0nyIWkdWJ+7VqnOAaNbg
	 XHkMn6K5lbN3wfLf3I5zHPoDQnCScfWBnvjkIWV5tgmGU0gae+dV+t7fC32M62UHm4
	 F27cA/uOvYtxDwRffbFmJuMhkxxAEItRNTKPmSe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgH3N6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:58:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbgH3Ny2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:54:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4864E2137B;
        Sun, 30 Aug 2020 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795667;
        bh=ncdBjX6kj1zQYOK5FR4Q6lv8taXgN5OQVLTPtWHDUX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gelShzUV73fCIfVVyDXkwKLiYi44nL3LXC76BdXngjdGxwwqfsDbjBF6KhcpsHcah
         nNXV6KlCboMQO+gVZrVEO8fFwqMnctETwbear/Dkazq9rlbW+y7w9ZH2Mj4PPiH/Z7
         fHLh1nsdGC4/pI2xa9t+pvYEOrq8A0z8C5IhUko0=
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
Subject: [PATCH 11/33] ARM: dts: exynos: Remove empty camera pinctrl configuration in Trats
Date:   Sun, 30 Aug 2020 15:51:38 +0200
Message-Id: <20200830135200.24304-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warning:

  arch/arm/boot/dts/exynos4210-trats.dt.yaml: camera: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-trats.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 0f3af293d9d3..33b40f619dea 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -159,8 +159,6 @@
 };
 
 &camera {
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 	status = "okay";
 };
 
-- 
2.17.1

