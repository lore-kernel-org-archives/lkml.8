Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B0C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6AC207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193172;
	bh=iZjxy8T/Nc73CHqNdlRJ7qSrCKOqpu8z/vE94Mm7m2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t5yNsC5HGCTDh2QMPLfkIvxrGSm0vHVvD94V7vrVggRkuSFT9iA6ULBp158qjgTE3
	 48swjbknLKq2Vh0bqe4T/STYg4CKdkJLx0wxHzSNCSciKKcedvkis+v3nyYyE98hFi
	 sxeMStAoklya96gd7Mx7LuyX3oRtL3Lk7OKxWAa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgAPQqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgAPQqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:46:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1A9207FF;
        Thu, 16 Jan 2020 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193168;
        bh=iZjxy8T/Nc73CHqNdlRJ7qSrCKOqpu8z/vE94Mm7m2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avHEXF/+xSdvlwwZLUah2eZgAUWsfBO/a8ZgMpg5NrVprELnnr9JXO2ksWernHuvo
         8WAujq2pyhDPsqyM9bt7tRGeZOwSokRhxxRAULen8aeZ0/2PvD4o3rvduxphM9lpuw
         pbs0IyxhvsvCMkxeUYX+++hZiOeIbKa08qLFNfxQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 038/205] arm64: dts: apq8096-db820c: Increase load on l21 for SDCARD
Date:   Thu, 16 Jan 2020 11:40:13 -0500
Message-Id: <20200116164300.6705-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

[ Upstream commit e38161bd325ea541ef2f258d8e28281077dde524 ]

In the same way as for msm8974-hammerhead, l21 load, used for SDCARD
VMMC, needs to be increased in order to prevent any voltage drop issues
(due to limited current) happening with some SDCARDS or during specific
operations (e.g. write).

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Fixes: 660a9763c6a9 (arm64: dts: qcom: db820c: Add pm8994 regulator node)
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 04ad2fb22b9a..dba3488492f1 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -623,6 +623,8 @@
 				l21 {
 					regulator-min-microvolt = <2950000>;
 					regulator-max-microvolt = <2950000>;
+					regulator-allow-set-load;
+					regulator-system-load = <200000>;
 				};
 				l22 {
 					regulator-min-microvolt = <3300000>;
-- 
2.20.1

