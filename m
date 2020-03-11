Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E47C2BB57
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC1720873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G815P8fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgCKMfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:35:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33963 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgCKMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:35:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so2414771wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvyKd0t3+qfQkjBAhdo61NmuHCYlR+DRre07BlO1Nos=;
        b=G815P8fyDtM6GYZ9Ybl+860JL0ZVbhz07A7HXj9b1iZHsxT3+wZZN/8lnC578RRMZm
         WyWhGPHK6lDHSsmYQwhUyXl+UQRus6z7S7xaCTWgd0V4UrZmNtegW9TS+XAGWh1YQw+h
         h01zfsxB5twA0QGcn2TJLckSZAd0Zbd2nRo4uOou5XSgBx98MjDA0Z5Kh58l0VGueHLT
         zZqGlnbnzNp4BFLktgbQeUJ1hBgsvS7/xg3sYWryzWtUeioKSGI2wErIzNQpy4dxPJCx
         VFGXRdyjGwr6TyO7Q3yga+pnw+bzGj5Z6vt7wsAZnWhQzva5KaXfp3dG0dvVg9x0KXlZ
         cpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvyKd0t3+qfQkjBAhdo61NmuHCYlR+DRre07BlO1Nos=;
        b=DyHyprfIc6IJ02TAvKVD3i385cw9mZ2iTJI3Slp3vAaguSwLSEbcl+cf74SEtOClvu
         Vbz5nUMgqTpyJRW5r5TDoP10+AX8vgDO9V5n2qv3lL8IdrMZGJE2strZdyxC2gnX0iJe
         0zTg7shQ1Kx1Nr2OGugoTmA+dEyYrrDUbuhLKTelewjROQe2fYhxFkmfeK71zOVj/j6y
         HJVS73DWR+WgFlAc7/UlJtqGBD/uDsKRzftTzA59IS8LRksylv0cRp/gRY+arUubx5T4
         ZOCru3LmhnhJhIYWtgM5yfKVeIFA2llQPEMgmNS/QtJJF6hxn4XMeS0zNtgIpZP9zzuI
         jAgg==
X-Gm-Message-State: ANhLgQ3D92hTRI1CffUpWpl5bRVzqleYdQZfGElM6My9hq/K1inXNodk
        JQm1L7S/wfc8lf5QLE/jxwDB6Q==
X-Google-Smtp-Source: ADFU+vsIKG8BRFaCapFFZcz3md1ZzUxxu8pQAo4ykDwAmnwztoT4NEp3wcwJQhMl3K4PkLdJRE+gzw==
X-Received: by 2002:adf:afd4:: with SMTP id y20mr4556101wrd.57.1583930114288;
        Wed, 11 Mar 2020 05:35:14 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:9087:3e80:4ebc:ae7b])
        by smtp.gmail.com with ESMTPSA id m25sm7822732wml.35.2020.03.11.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:35:13 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        maxime@cerno.tech, leonard.crestez@nxp.com, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v1 6/6] arm64: defconfig: Enable QCOM CAMCC, CAMSS and CCI drivers
Date:   Wed, 11 Mar 2020 13:35:01 +0100
Message-Id: <20200311123501.18202-7-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311123501.18202-1-robert.foss@linaro.org>
References: <20200311123501.18202-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build camera clock, isp and controller drivers as modules.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
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

