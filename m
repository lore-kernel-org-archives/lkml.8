Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF9C18E5F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 05:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE52072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 05:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r3PrAbng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgCHF4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 00:56:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgCHF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 00:56:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id g21so3300241pfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 21:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQLcaG4v4iP9SXWeTRwv6UzXT7p+SW2HOZis4ljRrU8=;
        b=r3PrAbngur1I3ac8O7nrPt5vFQcuLshUpHLyjwDgQx5bahchJ4LgeBcyOhQkmB3zZ2
         GlHcgsK5vR6Em9CAKrfI+kNkABaITMonig5UXcFWr09Lk1d3MGepfzrm5T6pHvo+IotW
         zNaYONaMlaBK9Z8ZF0r+qMTauSeo25I2HhhGt/GIMmNVaR/cKQGaFaYldixeQCTnJmBI
         KHU8jMgYR54PPUaSWLL8Ni5TQvr3ewjtlgNf4Vjziu9Rk5ftFrBBszJVG8HSARrqODui
         rVcufxgfteyv5F02a+0gdoF4pqBLurIVs9iul3hAiNZgO0EN5WCqNCQ3Nsmo9I0UAKKb
         CH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQLcaG4v4iP9SXWeTRwv6UzXT7p+SW2HOZis4ljRrU8=;
        b=k9j2L1LKz58SuRuBDYk67JhhoMxnVb4qnWKccOCrukhXpSFveqzc3xuUNMQD1gXPA+
         T8j7EXyPj4oiIqCAmGfFiTFb+wjbZNNRrIznWuRD7XvOvE6w3WoyQp9muX5tEaoJtnXz
         tB8BYvPsHsBl/LkYYwlS+cQUEnKYrEJuwSlkpE3IgXCofwPIVHoVxDnCBs1DUkIpAnG7
         bTBy36K5B+91GYz1C5pQ5IeiAmdfIeyAblQCIQ0zS9cxuTuLz8twRbS+/mvGARKEXDYk
         TVKmBIuYNogQOmBHmnwksbl9hDw/SB/DFR4iARrGrE75ntSXjHlgx6jXYTSJGRSWNr1L
         shDg==
X-Gm-Message-State: ANhLgQ3uAWgbjisGhNwezIn9UF4JEQN4zMXOgw+NnNotMse+XydhZP+u
        ReM38gC2s4ywUw4ObAQYaxZSgA==
X-Google-Smtp-Source: ADFU+vvtxEJiap8kXC5Tov4FW+UxaNfAA81JqXk07ynGpFMuJ/1wUtQooNds0qI0B70AI7/sw1U1mg==
X-Received: by 2002:aa7:8119:: with SMTP id b25mr8184678pfi.122.1583646974936;
        Sat, 07 Mar 2020 21:56:14 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k72sm14305175pjb.47.2020.03.07.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 21:56:14 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998-mtp: Disable funnel 4 and 5
Date:   Sat,  7 Mar 2020 21:54:45 -0800
Message-Id: <20200308055445.1992189-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable Coresight funnel 4 and 5, for now, as these causes the MTP to
crash when clock late_initcall disables unused clocks.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
index 0e0b9bc12945..8a14b2bf7bca 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
@@ -95,11 +95,15 @@ &funnel3 {
 };
 
 &funnel4 {
-	status = "okay";
+	// FIXME: Figure out why clock late_initcall crashes the board with
+	// this enabled.
+	// status = "okay";
 };
 
 &funnel5 {
-	status = "okay";
+	// FIXME: Figure out why clock late_initcall crashes the board with
+	// this enabled.
+	// status = "okay";
 };
 
 &pm8005_lsid1 {
-- 
2.24.0

