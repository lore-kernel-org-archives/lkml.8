Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25163C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0398F2076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001661;
	bh=rnYHb0s5js4ByiGzI4bA3XnakDr668Pyp1YPTOtvpj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KUvnNfuQinC3/UtRrutxf8A9FWW5WMmg4RhCl85v0bCphhi5E3Uyf3WxjdSeD6fhf
	 Nvexqk+40FIRslbnJ4m8kx1mTAdU/nwlLRTIIlKQDlaRXnyuJHNeifoednxn9T6ra7
	 W0WyV0nNEbw1SUgvPymaE0XK+4sP/G3o9iRru0MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGQQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGQQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:00:58 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D3922074B;
        Fri, 17 Jul 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001658;
        bh=rnYHb0s5js4ByiGzI4bA3XnakDr668Pyp1YPTOtvpj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XP+NZaUj6lIZ4nobsZ5aoYm9T8hb6JXjDCrmaF9zv1Yhh/EDMXHMc2+a18Ly87rnY
         hqYI1QAz5hqyhwEqrhF+vJqbNWSL20Ld/ROxwRLWs6VJ/dOydh150ZDrwxZEuN+Qgf
         SbVaDaXNQeeiJBcC6MU1L+WXVm9h/W77bDBiC4+Y=
Received: by wens.tw (Postfix, from userid 1000)
        id 1617F5F81B; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] ARM: dts: sunxi: libretech-all-h3-cc: Add regulator supply to all CPU cores
Date:   Sat, 18 Jul 2020 00:00:46 +0800
Message-Id: <20200717160053.31191-2-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index 19b3b23cfaa8..c44fd726945a 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -128,6 +128,18 @@ &cpu0 {
 	cpu-supply = <&reg_vdd_cpux>;
 };
 
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
+
 &de {
 	status = "okay";
 };
-- 
2.27.0

