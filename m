Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A135AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725622193E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442694;
	bh=nXySQYyZR7XIC8RhMQ6BDal9RFYXQkjxarwlV7ejjg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdMI5dcojMrKjiYCbIe2MmAjA3P5J+RV6vgnnmn98BRyGa2W19w7s/IamvKH6JIqI
	 Rls2egvnVMWVJNXjzGpf0yU29ZALig8dDyngMhQO+mX5fGfzUAkJT2g38tjH2EFwgt
	 F/JEn5TogezV7Dl8fyvRRLtX65v7ZVA+n39q+wkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgFRBLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgFRBLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B88021D7E;
        Thu, 18 Jun 2020 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442665;
        bh=nXySQYyZR7XIC8RhMQ6BDal9RFYXQkjxarwlV7ejjg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oksSqBSdFUTFZz76Fsp50PfymeOiMY2wCJZwx2v9zo35ieaYH06yuo9Rr76QsKmL6
         cQLKQlMMllPbiDHtxW6KACXZExLJx4LOaz/b1ZAIAI16MWrl34np9uQLmTaIFrveCl
         uo30EKvIei+psEhg3Egn6c750jIBfYhT16KkOL8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 135/388] arm64: dts: qcom: sm8250: Fix PDC compatible and reg
Date:   Wed, 17 Jun 2020 21:03:52 -0400
Message-Id: <20200618010805.600873-135-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 240031967ac4c63713c6e0c3249d734e23c913aa ]

The pdc node suffers from both too narrow compatible and insufficient
cells in the reg, fix these.

Fixes: 60378f1a171e ("arm64: dts: qcom: sm8250: Add sm8250 dts file")
Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200415054703.739507-1-bjorn.andersson@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 891d83b2afea..2a7eaefd221d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -314,8 +314,8 @@ intc: interrupt-controller@17a00000 {
 		};
 
 		pdc: interrupt-controller@b220000 {
-			compatible = "qcom,sm8250-pdc";
-			reg = <0x0b220000 0x30000>, <0x17c000f0 0x60>;
+			compatible = "qcom,sm8250-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x30000>, <0 0x17c000f0 0 0x60>;
 			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
 					  <125 63 1>, <126 716 12>;
 			#interrupt-cells = <2>;
-- 
2.25.1

