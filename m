Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F084BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C218D206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943932;
	bh=NUV7KWqtjBx+rwaxIhAbNyWL2HuwPznETRhWqAOl53E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ou3P0i48dU3TbZ01tHlmsufV/PnJ0Y5DIH+8WX7ZoJOLhfrQTZZQmSILh2GEyVgAA
	 G7N1qTrknpzuq7xTg0O7XUZfHjrB0PyzsR+izg+Fr+yoohSy8ytO45GPRIw6K4OivD
	 uMaEyHzFxQ/12c/+vPAdyQIZiLQtl/CYXodxkyQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbgFWUZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390270AbgFWUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:25:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B46E20702;
        Tue, 23 Jun 2020 20:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943919;
        bh=NUV7KWqtjBx+rwaxIhAbNyWL2HuwPznETRhWqAOl53E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZ4TPiSyiWVD5QzTAzBNRsXpqpYl4DvmO3BIsjkWh+kUQ+OrbsHNy/hbuEpVteqq5
         WRnTaJV0ChiHhTZc3wHH9xoJr73/zcXZK46MfvtHmjKXJfvbZRtHIxJrsCtDrvXNlT
         3aul2K6PpZQlk4tt8OE/o+ClQ8Fo+b/TPh5F9Bdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/314] arm64: dts: qcom: fix pm8150 gpio interrupts
Date:   Tue, 23 Jun 2020 21:54:50 +0200
Message-Id: <20200623195343.387896656@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit 61d2ca503d0b55d2849fd656ce51d8e1e9ba0b6c ]

This was mistakenly copied from the downstream dts, however the upstream
driver works differently.

I only tested this with the pm8150_gpios node (used with volume button),
but the 2 others should be the same.

Fixes: e92b61c8e775 ("arm64: dts: qcom: pm8150l: Add base dts file")
Fixes: 229d5bcad0d0 ("arm64: dts: qcom: pm8150b: Add base dts file")
Fixes: 5101f22a5c37 ("arm64: dts: qcom: pm8150: Add base dts file")
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Link: https://lore.kernel.org/r/20200420153543.14512-1-jonathan@marek.ca
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 14 ++------------
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 14 ++------------
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 14 ++------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index b6e304748a576..c0b197458665d 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -73,18 +73,8 @@
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x0 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x0 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 322379d5c31f9..40b5d75a4a1dc 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -62,18 +62,8 @@
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x2 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x2 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index eb0e9a090e420..cf05e0685d101 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -56,18 +56,8 @@
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			interrupts = <0x4 0xc0 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc1 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc2 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc3 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc4 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc5 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc6 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc7 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc8 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xc9 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xca 0x0 IRQ_TYPE_NONE>,
-				     <0x4 0xcb 0x0 IRQ_TYPE_NONE>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 	};
 
-- 
2.25.1



