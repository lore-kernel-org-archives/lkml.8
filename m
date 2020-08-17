Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6944820716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693829;
	bh=bkVpK0KOWR9Ed9jeIrDj4gZF2KKuZLesyyGYbP4hNZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAbbP9QRhULOtnoVgzDykDiltpCMzTGz7yQG7O8gb34WP5ODJZyrK+Xz9Cy5koyB5
	 upuHv69UWhkpq3gm67NVgeY9Jl/UeSc0SSQfuCwjhYtRArhNYgTito+vS4o1FJHhW2
	 qRs1gdkgd7fbYLjqUa3Lkd7wFyfYWrUCU/J1F+t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbgHQTu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbgHQPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:19:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CEB20760;
        Mon, 17 Aug 2020 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677565;
        bh=bkVpK0KOWR9Ed9jeIrDj4gZF2KKuZLesyyGYbP4hNZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxGdRCD5xfBgEvOc4wQVfcAwBRdf188KaaudubG2m5gK5iV1Gy1ABByRyx4gKRpnj
         iwXENpVzEgw+siVhNzTaksiG8oZ1P+ABiXJ5jHU82tHzRB0f3dEqnCfD2/WSWRhVvk
         ct0pwSlt3doK8g9kkhKDOLyAXAy4NgJhca6CgfM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 028/464] arm64: dts: exynos: Fix silent hang after boot on Espresso
Date:   Mon, 17 Aug 2020 17:09:41 +0200
Message-Id: <20200817143835.109493140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

[ Upstream commit b072714bfc0e42c984b8fd6e069f3ca17de8137a ]

Once regulators are disabled after kernel boot, on Espresso board silent
hang observed because of LDO7 being disabled.  LDO7 actually provide
power to CPU cores and non-cpu blocks circuitries.  Keep this regulator
always-on to fix this hang.

Fixes: 9589f7721e16 ("arm64: dts: Add S2MPS15 PMIC node on exynos7-espresso")
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 7af288fa9475f..a9412805c1d6a 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -157,6 +157,7 @@ ldo7_reg: LDO7 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-enable-ramp-delay = <125>;
+				regulator-always-on;
 			};
 
 			ldo8_reg: LDO8 {
-- 
2.25.1



