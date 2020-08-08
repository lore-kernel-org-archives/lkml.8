Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D847620656
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930033;
	bh=IfDtPWHDu6w1xaYNiEa8Sqca5Op8tyggw6IiHrLJwWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lKUFlK/Qb9BetlLquW+9ZTDxJarfqLdhIDOTXFV03N/txlo22+U+8UzojXPbFBSDY
	 Xsxc0m1DcNiimdGNv9gl89Z4qH3BG2EGjOwajobI1l3p8HdLiOlIa4CdymGPcBFMbJ
	 5+zSK7IQAjeb73lblk036soS8Ir3pJSAWSVX8Qew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgHHXkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgHHXkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC25D20855;
        Sat,  8 Aug 2020 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930022;
        bh=IfDtPWHDu6w1xaYNiEa8Sqca5Op8tyggw6IiHrLJwWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGiQ+Y7j5cwtcsD5j0v+PQTvnF/xy/FjyIPTJzqh5stlvyquKKTLSHzX6SosASxdu
         F5w1trTWocnEPw1E+9XTLs2nvmSKUo0G59vPCZRJC4X+2JG1ExbThxsjT1AZmzI/VD
         Wo9tsMm/jd/bHMqiKllN7umu9mhqPXG0Mn+ApXqk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/14] arm64: dts: exynos: Fix silent hang after boot on Espresso
Date:   Sat,  8 Aug 2020 19:40:06 -0400
Message-Id: <20200808234013.3619541-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808234013.3619541-1-sashal@kernel.org>
References: <20200808234013.3619541-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4a8b1fb51243c..c8824b918693d 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -155,6 +155,7 @@ ldo7_reg: LDO7 {
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1150000>;
 				regulator-enable-ramp-delay = <125>;
+				regulator-always-on;
 			};
 
 			ldo8_reg: LDO8 {
-- 
2.25.1

