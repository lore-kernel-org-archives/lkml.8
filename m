Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0770C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821022525
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193941;
	bh=hEy+SEyJHy2Z+9dl0yeA1B7o61iCzX8WEsxkcrLp2wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdbapgPeeyV1C9Wa3pB/mn8HoZ9hV65jWP2dyxmTEeGwDLhiSLIhEq4rdg13B/8cy
	 QJv3GD6aZMrsysHWNs7jgwyzvY5ckAlY/23aqOvCyOX2yVTLO0s0vGWyJVQmk1lOSB
	 +5QNQkxXfdksdOmlNSaQRg4c5rhK4dmHkQZh3WKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgAPQ7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732782AbgAPQ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9444A24673;
        Thu, 16 Jan 2020 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193854;
        bh=hEy+SEyJHy2Z+9dl0yeA1B7o61iCzX8WEsxkcrLp2wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQ6e8xAgvu2uG3Q587sR8Wo96cfzcRdu2ZXlRjBX2/qql52MU8mSqKPfoyxkiSh+X
         wI2zz9ovOez1hSLAPXUQp4yYk1qwm7B2DPl4q0G0DzoC36puipwbEvXk/fERX9PzhA
         qGTeWuE+NUDNu4vHJ87dJlKja7hkR5cjWQuKnFaU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 104/671] ARM: dts: r8a7743: Fix sorting of rwdt node
Date:   Thu, 16 Jan 2020 11:45:35 -0500
Message-Id: <20200116165502.8838-104-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das@bp.renesas.com>

[ Upstream commit 383f6024981d32425fa453bf2e66b546fdbc1314 ]

Watchdog node is incorrectly placed on r8a7743 SoC dtsi. This patch fixes
the sorting order.

Fixes: b5beb5d4c81c358f50a8310108 ("ARM: dts: r8a7743: Add watchdog support to SoC dtsi")

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/r8a7743.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 5015e2273d82..fcc6d926991b 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -154,6 +154,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog@e6020000 {
+			compatible = "renesas,r8a7743-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		gpio0: gpio@e6050000 {
 			compatible = "renesas,gpio-r8a7743",
 				     "renesas,rcar-gen2-gpio";
@@ -310,16 +320,6 @@
 			reg = <0 0xe6160000 0 0x100>;
 		};
 
-		rwdt: watchdog@e6020000 {
-			compatible = "renesas,r8a7743-wdt",
-				     "renesas,rcar-gen2-wdt";
-			reg = <0 0xe6020000 0 0x0c>;
-			clocks = <&cpg CPG_MOD 402>;
-			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
-			resets = <&cpg 402>;
-			status = "disabled";
-		};
-
 		sysc: system-controller@e6180000 {
 			compatible = "renesas,r8a7743-sysc";
 			reg = <0 0xe6180000 0 0x200>;
-- 
2.20.1

