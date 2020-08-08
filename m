Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCB3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F2120672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930609;
	bh=CD3HPUADLYe44TSi72mJmigB4TKXwZYje3mQ+Tm1oJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yd6vGV56g09xRcFWVMoCxtyxBN3WBabihtUeCLjkIGrNOggiDwQhV22keI5TBNDgv
	 5+22sExC4fZbGyPiyYTxo3SOOyvpCFVkuOS6CxMz55OZ2zs0GHbVjjsMm1n81RHNJs
	 qgmQbweUuJwTDaFolHLcPwVKCxQCDH0Zt+CwP4zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHHXgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgHHXgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E62B206C3;
        Sat,  8 Aug 2020 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929797;
        bh=CD3HPUADLYe44TSi72mJmigB4TKXwZYje3mQ+Tm1oJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTTk8jV8xMHer0yyGJy0DQbaNE/Yc+2Cq2AfLjC4jqexbA2yfdqW2AeFD00zyWcgg
         CFekU2/rrgmlQSvBXPlMaKtkOtj7zfoNYPxvvyAAzrfmIsLHPhwFZPKuHnS8yA+8Ba
         ZRa0CIgFL0WavmlFOj1wTgJr9dFNJmk0izgBDqXc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 36/72] ARM: dts: exynos: Disable frequency scaling for FSYS bus on Odroid XU3 family
Date:   Sat,  8 Aug 2020 19:35:05 -0400
Message-Id: <20200808233542.3617339-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233542.3617339-1-sashal@kernel.org>
References: <20200808233542.3617339-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 9ff416cf45a08f28167b75045222c762a0347930 ]

Commit 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the
values correct for Exynos5422 Odroids") changed the parameters of the
OPPs for the FSYS bus. Besides the frequency adjustments, it also removed
the 'shared-opp' property from the OPP table used for FSYS_APB and FSYS
busses.

This revealed that in fact the FSYS bus frequency scaling never worked.
When one OPP table is marked as 'opp-shared', only the first bus which
selects the OPP sets the rate of its clock. Then OPP core assumes that
the other busses have been changed to that OPP and no change to their
clock rates are needed. Thus when FSYS_APB bus, which was registered
first, set the rate for its clock, the OPP core did not change the FSYS
bus clock later.

The mentioned commit removed that behavior, what introduced a regression
on some Odroid XU3 boards. Frequency scaling of the FSYS bus causes
instability of the USB host operation, what can be observed as network
hangs. To restore old behavior, simply disable frequency scaling for the
FSYS bus.

Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Fixes: 1019fe2c7280 ("ARM: dts: exynos: Adjust bus related OPPs to the values correct for Exynos5422 Odroids")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index ab27ff8bc3dca..afe090578e8fa 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -411,12 +411,6 @@ &bus_fsys_apb {
 	status = "okay";
 };
 
-&bus_fsys {
-	operating-points-v2 = <&bus_fsys2_opp_table>;
-	devfreq = <&bus_wcore>;
-	status = "okay";
-};
-
 &bus_fsys2 {
 	operating-points-v2 = <&bus_fsys2_opp_table>;
 	devfreq = <&bus_wcore>;
-- 
2.25.1

