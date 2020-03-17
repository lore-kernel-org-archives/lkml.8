Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71A0C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8468206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6l/WllN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgCQN6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:58:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCQN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:58:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so25846549wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UppQrsnlpe86U1iJ2vxLuqmcwC6nQrjDuqLHzwr9eq8=;
        b=n6l/WllNY7yB9vdu0o78Kevuih0X0jlKF33Qac5TIulVecbJJhn04M3bXa5FVZ2Ayj
         nMdI2M0fpHFdBWRa0BhPJzsNtf74iIzJYsfnN/E1j7ud159TZCGIsrMb4PANiVBt/4LX
         JDIvbOBhvc0l5ps5YEzy+FSZY670na89VlTNkUBEPnAT4m+/pqKZCSCBGpNcv48E88W0
         sG19qv8z6WQT4MsCry1difL47JM6xzqgNIUayos0WV1rsSJ3xwsFJb9ciVilyB624Sp5
         OzHf51degqnW+xr8gcVWrV//eDELr22o9g1plb1Y699FSbPxS61/1fq8hycr0Gr9+fK0
         cazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UppQrsnlpe86U1iJ2vxLuqmcwC6nQrjDuqLHzwr9eq8=;
        b=pR82aQ/JFF0hFBsaU9c33QHjWgI3sTV+c6gBw6CWRwGvYBdoFuUy03cZG5Aovuulpl
         3i2/a3gBE/ias5/8dKBxB+hjqmEhQfueWPtY1AenKvnkFk64vMbHuemk73KPpykbXQdK
         mirV+4zlwkdmcO9QYlWNTdgXcblU3IgiPG5ZzSe+tZsTxsD7oacsLk79RPzExTdVYSoh
         ZB8QlYOn7YhaLmgIHffWUckt9ez9IAruAipxZZmGpJFw5A9c7AzDqAzljM3yqxA2kYeU
         YakPrMQNBW6nfMLJPUGQA9ZIlnvDAwCK3RBQlQsZ1tCTl7W5sFdGpKnc5/4jEaWXCbqT
         89mQ==
X-Gm-Message-State: ANhLgQ24IHDTQVCAlMNoijykoBtyeuZJvksKWUeUEd556cIei9nu+pk1
        nfgblGhYrI5OvOgIFRsQr45C4g==
X-Google-Smtp-Source: ADFU+vuB83bdRe3honSZVhDGSTt2YdioMyqclnLEVfdMeETbDf0ejd9vEKSvzBHwoB0XWvgcu6GtAg==
X-Received: by 2002:adf:a348:: with SMTP id d8mr6276482wrb.83.1584453479320;
        Tue, 17 Mar 2020 06:57:59 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:84f7:5c25:a9d8:81a1])
        by smtp.gmail.com with ESMTPSA id r3sm2976558wrn.35.2020.03.17.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:57:58 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, maxime@cerno.tech,
        Anson.Huang@nxp.com, dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v2 6/6] arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers
Date:   Tue, 17 Mar 2020 14:57:40 +0100
Message-Id: <20200317135740.19412-7-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317135740.19412-1-robert.foss@linaro.org>
References: <20200317135740.19412-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build camera clock, isp and controller drivers as modules.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4db223dbc549..7cb6989249ab 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -376,6 +376,7 @@ CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_OWL=y
 CONFIG_I2C_PXA=y
+CONFIG_I2C_QCOM_CCI=m
 CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
@@ -530,6 +531,7 @@ CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
+CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_DRM=m
 CONFIG_DRM_I2C_NXP_TDA998X=m
 CONFIG_DRM_NOUVEAU=m
@@ -732,6 +734,7 @@ CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
+CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GCC_845=y
 CONFIG_SM_GCC_8150=y
 CONFIG_QCOM_HFPLL=y
@@ -762,6 +765,7 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GENI_SE=y
 CONFIG_QCOM_GLINK_SSR=m
 CONFIG_QCOM_RMTFS_MEM=m
+CONFIG_SDM_CAMCC_845=m
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_SMEM=y
-- 
2.20.1

