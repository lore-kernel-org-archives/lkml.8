Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9668222B4D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924990;
	bh=ZXv7bnXuZvWW5Lt2pE/RNj6XrUbrKNUDy20z6LOBy3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IfNQtDNSRg379osAWllR5+coA/jUTJOo2Gw5e7LUhzsZBSFinPkmL1W1+CjLNR19q
	 BPu6W7mBqYKklVLCWWdb3YLrNbWVE17pfgTsFsVhwmUhy00QOKAbR5rYCxGU24Luzk
	 6DgPy3nWDO5AmECgpyFGVZ1/vEIuxcBzIbFJFX6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgHTMDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730429AbgHTJ7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:59:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE63D2067C;
        Thu, 20 Aug 2020 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917583;
        bh=ZXv7bnXuZvWW5Lt2pE/RNj6XrUbrKNUDy20z6LOBy3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fKmzhL9uRYeIqiXu8AK15jcawwF7nax9SG6OR2GDuvgzAmNrK+Ts2Ts1Mtw/wIEZL
         3qETUcUoeCNe5/hvpRFGkKDOv3JIRYrySwpuR1/JmBX64Sr+WmnwYYTUDr3zG/d4+C
         LQQxjWbZMC7MR6mQgKl4AW1ge2Svf1hTZ3/wdgdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 083/212] arm64: dts: qcom: msm8916: Replace invalid bias-pull-none property
Date:   Thu, 20 Aug 2020 11:20:56 +0200
Message-Id: <20200820091606.553528872@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 10c83e11c272f..fabc0cebe2aa2 100644
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



