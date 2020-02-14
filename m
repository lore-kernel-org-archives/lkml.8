Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB68C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0A24681
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695735;
	bh=0riOLmm1KUbfHFuWluYYO4aIPkUq6Iig7m88Ct78IjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BZ34z8NMSMwgun4A8RZ8VrlvNNsIKUMM4SVIwldMvDhIkzlO6Rf2rJN/ToMVb89NV
	 jpgk5qCONvvQ0UD42Jj9Xf7Xbp8CdVhCnVN3IweJs0gApEcQdgeXt2rOgYrmVPDmsA
	 oYL9DqLp/TDVKAOKjpDBAh1jjDVsb7Xfk3nhDRuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbgBNPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731742AbgBNPzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672A724681;
        Fri, 14 Feb 2020 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695720;
        bh=0riOLmm1KUbfHFuWluYYO4aIPkUq6Iig7m88Ct78IjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVcyqGGA+QCFTfTqO8ZOw3q5Hdeosy8CJhkhKRe1Fg/Z+VdqBVkVlBZuIOuDk+CyR
         pIjPxxvRPox+Pub1eVnkwLhJVRgNBVZd8Z03mlyCZ37R+s//NNfQ5bbF8PxsGfOe70
         W/mv1oBT05gQNAAAUcWanomrj/uTjTPT0vKr2Fgw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 297/542] arm64: dts: qcom: msm8998-mtp: Add alias for blsp1_uart3
Date:   Fri, 14 Feb 2020 10:44:49 -0500
Message-Id: <20200214154854.6746-297-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit c9ec155b5962233aff3df65210bd6a4788dee21c ]

The msm_serial driver has a predefined set of uart ports defined, which
is allocated either by reading aliases or if no match is found a simple
counter, starting at index 0. But there's no logic in place to prevent
these two allocation mechanism from colliding. As a result either none
or all of the active msm_serial instances must be listed as aliases.

Define blsp1_uart3 as "serial1" to mitigate this problem.

Fixes: 4cffb9f2c700 ("arm64: dts: qcom: msm8998-mtp: Enable bluetooth")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Link: https://lore.kernel.org/r/20191119011823.379100-1-bjorn.andersson@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 5f101a20a20a2..e08fcb426bbf8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -9,6 +9,7 @@
 / {
 	aliases {
 		serial0 = &blsp2_uart1;
+		serial1 = &blsp1_uart3;
 	};
 
 	chosen {
-- 
2.20.1

