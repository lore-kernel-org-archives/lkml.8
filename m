Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5ADCC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8812082F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942957;
	bh=CeLhgvWLprxAbT6KatLMM/DFe6z/XMeYOLP479CQgU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0IgybQK7cRdip8F4jlj0WvLNiZKtmRBfYv4COl+TGDL/l/xl/ZeZxoiurAnaktGRh
	 77YTuvsnHAmAXCAemLpqqPhlZi4j9vB1y+yVFt2glmXv0tmYELUERAoXo1CH1XEWEp
	 17v24yZVP9puiSBFd6RFknHLCFrAtXcKuk2yajqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgFWUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387952AbgFWUIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DDB206C3;
        Tue, 23 Jun 2020 20:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942905;
        bh=CeLhgvWLprxAbT6KatLMM/DFe6z/XMeYOLP479CQgU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uI9S3pIMSGkKS/D8t0V6+Xy2PJ5xcLUS/lNZIpqdKcqZDjcIsZCpsLl+L9k8/uxcl
         ytjg/5tSvrpCH8sdx1kA06NGKMVjQ9cnPXnv8cZRky3L0uYR+kOlzmyeJqkabX65RS
         m+cwYSK++tIBnZR1s10qWUYvK3R7I2io5OPTOOGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 182/477] arm64: dts: msm8996: Fix CSI IRQ types
Date:   Tue, 23 Jun 2020 21:52:59 +0200
Message-Id: <20200623195416.188669837@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit 4a4a26317ec8aba575f6b85789a42639937bc1a4 ]

Each IRQ_TYPE_NONE interrupt causes a warning at boot.
Fix that by defining an appropriate type.

Fixes: e0531312e78f ("arm64: dts: qcom: msm8996: Add CAMSS support")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Link: https://lore.kernel.org/r/1587470425-13726-1-git-send-email-loic.poulain@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 98634d5c44405..d22c364b520ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -989,16 +989,16 @@
 				"csi_clk_mux",
 				"vfe0",
 				"vfe1";
-			interrupts = <GIC_SPI 78 0>,
-				<GIC_SPI 79 0>,
-				<GIC_SPI 80 0>,
-				<GIC_SPI 296 0>,
-				<GIC_SPI 297 0>,
-				<GIC_SPI 298 0>,
-				<GIC_SPI 299 0>,
-				<GIC_SPI 309 0>,
-				<GIC_SPI 314 0>,
-				<GIC_SPI 315 0>;
+			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 315 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "csiphy0",
 				"csiphy1",
 				"csiphy2",
-- 
2.25.1



