Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E157C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C93208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599156885;
	bh=5b3Egfm+10MTau1tfMtMDO2dK/Gow5RosvWsPo2xF0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h4QZvbmVdloHlmaO5g9s9qcJYZ2n0Pk0XtbfDfBflYb8HyvvGd9l8MFfRuWxTERuP
	 KYqJycyXnYQMLrDaxd8fu154sYUCfUMHBPg/5qA7LwU5/1R58guZIVditXri2uUQvY
	 Nc4CG7a77Uj4y0jWMhRjQyehzpcD+4eE+g5pqw2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgICSOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbgICSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:14:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D235C20DD4;
        Thu,  3 Sep 2020 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156878;
        bh=5b3Egfm+10MTau1tfMtMDO2dK/Gow5RosvWsPo2xF0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYLFRJoATh3RydGMt1khMfDZm21rtcbKjrJvbuVtJJq8tmJ4fTNqlXzhoUENsPInk
         UV7keYdSR7lmKcJE0y5olYVM9zLcXu3eE9qV4mLmiAZJlWxe1EmCOsAzyW0exUX+kI
         MHXBf2BJJ2IDWm4d7f7C33O+hSLnpf2TthUOaW1I=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v2 3/3] ARM: dts: exynos: Add assigned clock parent to CMU in Exynos5422 Odroid XU3
Date:   Thu,  3 Sep 2020 20:14:25 +0200
Message-Id: <20200903181425.5015-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903181425.5015-1-krzk@kernel.org>
References: <20200903181425.5015-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 78a68acf3d33 ("ARM: dts: exynos: Switch to dedicated Odroid XU3
sound card binding") added assigned clocks under sound device node.

However the dtschema expects "clocks" property if "assigned-clocks" are
used.  Add reference to input clock, the parent used in
"assigned-clock-parents" to silence the dtschema warnings:

  arch/arm/boot/dts/exynos5422-odroidxu3.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index c3c2d85267da..44467a10c3b8 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -29,6 +29,11 @@
 			"HiFi Playback", "Mixer DAI TX",
 			"Mixer DAI RX", "HiFi Capture";
 
+		clocks = <&clock CLK_FOUT_EPLL>,
+			 <&clock CLK_MOUT_EPLL>,
+			 <&clock CLK_MOUT_MAU_EPLL>,
+			 <&clock CLK_MAU_EPLL>,
+			 <&clock_audss EXYNOS_MOUT_AUDSS>;
 		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
-- 
2.17.1

