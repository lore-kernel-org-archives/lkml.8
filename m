Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5EEC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0941C20825
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930130;
	bh=MN5EgeoI4ccyyJSmPxzesSCVCG8knB0bfsW7JeAjl2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CM6R/v+5dLHunnk686Dqvp24Rr+ZkbjE55MHwr02qDptFVtutzPRHLl4JW5Gtak/v
	 5umg3ABWThBjo/2LNh7ClgxC80zHpPIDHhJsQutHdCGV41VNhV23HzE/wRSnH3ziO8
	 x/YxuotGXtYvFHggxCnuFgSPBWbFsqLXxAEMXnUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgHHXmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgHHXkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:40:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BE37208B3;
        Sat,  8 Aug 2020 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596930021;
        bh=MN5EgeoI4ccyyJSmPxzesSCVCG8knB0bfsW7JeAjl2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wFIYANe+6ri5veOVYVtmZ44wyEKg+4sMMChKGMA8+Igus9yj3ZPhUBL06WSVjsqal
         sTOZNOqao+3ASld7ppuKTP81Bq241ynbHwJ4zdNgCeZlWXAptu0fZQAZFYhrZLQUDc
         RwH8wt2hR0yzHO2GrUuxYaDqdeST++/H6fL28lB8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 06/14] arm64: dts: qcom: msm8916: Replace invalid bias-pull-none property
Date:   Sat,  8 Aug 2020 19:40:05 -0400
Message-Id: <20200808234013.3619541-6-sashal@kernel.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 1b6a1a162defe649c5599d661b58ac64bb6f31b6 ]

msm8916-pins.dtsi specifies "bias-pull-none" for most of the audio
pin configurations. This was likely copied from the qcom kernel fork
where the same property was used for these audio pins.

However, "bias-pull-none" actually does not exist at all - not in
mainline and not in downstream. I can only guess that the original
intention was to configure "no pull", i.e. bias-disable.

Change it to that instead.

Fixes: 143bb9ad85b7 ("arm64: dts: qcom: add audio pinctrls")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Link: https://lore.kernel.org/r/20200605185916.318494-2-stephan@gerhold.net
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 4cb0b58341432..69ba1d79bcd5d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -542,7 +542,7 @@ pinconf {
 				pins = "gpio63", "gpio64", "gpio65", "gpio66",
 				       "gpio67", "gpio68";
 				drive-strength = <8>;
-				bias-pull-none;
+				bias-disable;
 			};
 		};
 		cdc_pdm_lines_sus: pdm_lines_off {
@@ -571,7 +571,7 @@ pinconf {
 				pins = "gpio113", "gpio114", "gpio115",
 				       "gpio116";
 				drive-strength = <8>;
-				bias-pull-none;
+				bias-disable;
 			};
 		};
 
@@ -599,7 +599,7 @@ pinmux {
 			pinconf {
 				pins = "gpio110";
 				drive-strength = <8>;
-				bias-pull-none;
+				bias-disable;
 			};
 		};
 
@@ -625,7 +625,7 @@ pinmux {
 			pinconf {
 				pins = "gpio116";
 				drive-strength = <8>;
-				bias-pull-none;
+				bias-disable;
 			};
 		};
 		ext_mclk_tlmm_lines_sus: mclk_lines_off {
@@ -653,7 +653,7 @@ pinconf {
 				pins = "gpio112", "gpio117", "gpio118",
 					"gpio119";
 				drive-strength = <8>;
-				bias-pull-none;
+				bias-disable;
 			};
 		};
 		ext_sec_tlmm_lines_sus: tlmm_lines_off {
-- 
2.25.1

