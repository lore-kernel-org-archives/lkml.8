Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5972072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597679840;
	bh=i4zhqUPJ+dMplr2JiLDz7Y+XOtarvFX1bYE2TU8H5W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATflz+7Rd40lKpGgbj1VdP5k22yAVw8nWYYLO6QExfV/Bu5Kg74/RTgfX5wpiQxT2
	 iQW0MTOGXk462Du9jKZtrFZ9IvwPSi/zyHcN7eE3ITvqSV2TsPqbLMH9Ss24SudioJ
	 W096VUOw3Xnj8e8iSOzw/vD7KlHBq43aTCMW92Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbgHQP5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgHQPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:42:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DC820760;
        Mon, 17 Aug 2020 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678930;
        bh=i4zhqUPJ+dMplr2JiLDz7Y+XOtarvFX1bYE2TU8H5W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YwulDsEGIzdt/iHTh8lgKqIxYiUbAMzvtlnX5BypyKVbz7ItaZmc4wS5FqzwFW0GG
         J6ZcVy+hSStBjEaGpEZXkYIFqT3JTF08V7S6CPC3RatQYmO3GGCos9jzgGe/zZBDEG
         nmNSg2yX9Fit5jaf8MRHwYSyJEuiYA3BnZ7WXcZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 039/393] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Add regulator supply to all CPU cores
Date:   Mon, 17 Aug 2020 17:11:29 +0200
Message-Id: <20200817143821.496743524@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 55b271af765b0e03d1ff29502f81644b1a3c87fd ]

The device tree currently only assigns the a supply for the first CPU
core, when in reality the regulator supply is shared by all four cores.
This might cause an issue if the implementation does not realize the
sharing of the supply.

Assign the same regulator supply to the remaining CPU cores to address
this.

Fixes: 6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20200717160053.31191-3-wens@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index 22466afd38a3a..a628b5ee72b65 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -28,3 +28,15 @@ reg_vdd_cpux: vdd-cpux {
 &cpu0 {
 	cpu-supply = <&reg_vdd_cpux>;
 };
+
+&cpu1 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
+&cpu2 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
+&cpu3 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
-- 
2.25.1



