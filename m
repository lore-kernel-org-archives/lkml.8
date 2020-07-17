Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1303C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982D6204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001678;
	bh=UJzWr7fIaC1FyWjEniPNQ4ep+bnFBKT0R2NcL+7tYnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUFZT1G7KThlCBbuMTHo0s39gUabxqAiYXNYGRxZwcgKvifWSh4lAxIX4Cv200DTK
	 IkBjtXbVU2Myj9oBJj9rRfVYb2Nkc/JcDu2wDrs4/rPAdOVy25ykY9eM3pRQD7wP5I
	 mzL/yQiOKz4nyWw1Dj2ljr/NRK+cdH+oHB/Isx6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgGQQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgGQQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:00:58 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303B320775;
        Fri, 17 Jul 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001658;
        bh=UJzWr7fIaC1FyWjEniPNQ4ep+bnFBKT0R2NcL+7tYnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WgIN4DfY0AZ3g0YEP5Q0tzl54zR701GSEQqV9NRmjuKcT2Z3KI+pru+Wr+xrl5wK
         BBV9gLTd2nOwyuAU9iye1NKZJfvfaeV78GjXtn7NTf/RkTHbT2kzotAp9A41f54PCL
         guEJDDms5CtyoEPE+ZU4Lzc4/aX8vDxR55/d6moU=
Received: by wens.tw (Postfix, from userid 1000)
        id 1D6745FD2B; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] ARM: dts: sunxi: bananapi-m2-plus-v1.2: Add regulator supply to all CPU cores
Date:   Sat, 18 Jul 2020 00:00:47 +0800
Message-Id: <20200717160053.31191-3-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The device tree currently only assigns the a supply for the first CPU
core, when in reality the regulator supply is shared by all four cores.
This might cause an issue if the implementation does not realize the
sharing of the supply.

Assign the same regulator supply to the remaining CPU cores to address
this.

Fixes: 6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index 22466afd38a3..a628b5ee72b6 100644
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
2.27.0

