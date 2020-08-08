Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6E8C433E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F57920672
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930602;
	bh=i4zhqUPJ+dMplr2JiLDz7Y+XOtarvFX1bYE2TU8H5W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m9yjkAdeZyW7RczJhLmDA5Zr+IlAG1VhzdTZ2DNAq+frdCYQNOn0ZEGfq1w/E8yeC
	 /9EjVvy7sdqB681QX1pgzvw3L0Tp0YHWyHh+5yoMACJooBFSTSnWOYRcHdKwyxw3tM
	 7TWGrAAoLw3yIlWDhdtDgAtny2IhfInq908wAYoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgHHXgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgHHXgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:36:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B61D20716;
        Sat,  8 Aug 2020 23:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929801;
        bh=i4zhqUPJ+dMplr2JiLDz7Y+XOtarvFX1bYE2TU8H5W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BCquYTAzRcdAbRzXcQBw0eA203YR1lLTO+QNTy5JTLgm5vblZlNKc01iR7puxgwb+
         nVSCR1oGo88usBJMHbckJTdU3lHC/5Fs3aYTdU5f5aR0rLlf+lVuNGcFCtJ46S0Dwu
         pFEVtyQ3ZgF2p6NtXLkp9fHiaqhMwPFSnIssvp+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.8 39/72] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Add regulator supply to all CPU cores
Date:   Sat,  8 Aug 2020 19:35:08 -0400
Message-Id: <20200808233542.3617339-39-sashal@kernel.org>
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

