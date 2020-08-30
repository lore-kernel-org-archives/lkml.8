Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA594C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F46C206FA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598796056;
	bh=iO29siIj1A3pg94M9/E7qHOcb8dG0rcPAl2NI4lvh6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRqJLoqH6ReOIOo/J7T1H4sC2ZaEgbtk943vr2CzgpXw+Vfkmr7OrBdrKkKHPr66v
	 +ZaKb5iWn2+apBM8vwzRWB1RLu5krJV+4Z91/7vX7HlrHmS3/abDxFbHp13AT6SP3w
	 QQp3a2LIjJfVVttRU9Yo/socdK4L8k8upqp6oglE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgH3OAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbgH3NzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 09:55:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E01222087D;
        Sun, 30 Aug 2020 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598795704;
        bh=iO29siIj1A3pg94M9/E7qHOcb8dG0rcPAl2NI4lvh6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zeaPP37IN+ywOlmiuegUWc80CNzYLSOFgVt7+BSOduJcC+rO97Ze942JGwkdaRFvf
         Z8gHrHD/UdeKBNwyrD+cdrRkcKqN+3d0bFe8TpN4IM0PbrVwbB7Y/uSgp3QmCzvmGU
         jiJkuiDrmnt5SjrOSyvul2WZF8OGxDUxdHhL6IK0=
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
Subject: [PATCH 23/33] ARM: dts: exynos: Remove empty camera pinctrl configuration in Odroid X/U3
Date:   Sun, 30 Aug 2020 15:51:50 +0200
Message-Id: <20200830135200.24304-23-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830135200.24304-1-krzk@kernel.org>
References: <20200830135200.24304-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The camera's pinctrl configuration is simply empty and not effective.
Remove it to fix dtbs_check warning:

  arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: camera: pinctrl-0: True is not of type 'array'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index a5c1ce1e396c..6d3576e21ffa 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -136,8 +136,6 @@
 
 &camera {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <>;
 };
 
 &clock {
-- 
2.17.1

