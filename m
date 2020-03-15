Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B633C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BEC2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 05:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gywJFKfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgCOFKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 01:10:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43911 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgCOFKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 01:10:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id f8so6273802plt.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s23IqWHm+4YdBVxKLV9+dw8Ig+I7LwtH5N9j7UZLiqw=;
        b=gywJFKfavAY6uDxQ1Kn0OAm3rMpvfeGnfRwPr6mM4K357+Tqw7gKU9/7B+vt238ul2
         Amfm9bNE72ozNWizh+w2aP/kWBeJqVSs1FJTS2Md8gY8+bay6u4VN4/icM1KOjsJLhd4
         eGbFUDxbkuc429CbwOOYi9Qg6bMvFuCHnsN0dEbHm9+bBoN42v5m/5GPEpIn7t+iI5Ih
         fF+ITWKQDKHSQbjIFK0UFAO7fjiXyVcROk5WquJpSX8ndKSDQlS8raW0Dn26fqHaVVWV
         axW7fBSstLcX2WZaUEx5D8FT4RRCAeY/SDk7gQ1knLr18ltOh6vr/84wf6N4M0kCEWBx
         LwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s23IqWHm+4YdBVxKLV9+dw8Ig+I7LwtH5N9j7UZLiqw=;
        b=ZNq693ympFX2H21iQZacsjIxNHnEdhNtYK981uFLA/rmo2/qzAsNcWFKXYppRua3B7
         OU9Hei2nfEg/HFC9cydpicAHX2GzmzCUUJk23yT5K6WFMcPdNianK8z6v0kB3OYZEuvN
         8HhAM1AhuywZF/qLriyJvBTTtD9VcVqiu7xUNA9ycifIIvgmkh3NA4avxvzkQTRSSCSJ
         MuEf0YHT2SlF3jrxQzkg16h7KK4J74hV471qEAimxGhODPbXJ+eN8/6dz3ma5zkD9UJf
         4jLuaQb0QWan+FwAu1t1LfLehayrEkqiMVgDhXwp9OEP7Hq4unAIqMo5uVPrxiiGMSKF
         Yhgw==
X-Gm-Message-State: ANhLgQ1YvtfPdVhuE9qbjSnEbKgk6exFQlBPdkj3yTT/XQSV5Q9mXsDD
        4+gUsLoauwfCGHECfxLWtzSHrg==
X-Google-Smtp-Source: ADFU+vsMXczaHvc9ZvzzvJSkN74Xjwxdnlfpp2mPgcBJRSn9WVH2LDUgXcaEIowRj5ftZRBu8+IkNQ==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr21109002plo.195.1584249003475;
        Sat, 14 Mar 2020 22:10:03 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v67sm19168821pfc.120.2020.03.14.22.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 22:10:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: defconfig: Enable Qualcomm SDM845 audio configs
Date:   Sat, 14 Mar 2020 22:08:27 -0700
Message-Id: <20200315050827.1575421-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable soundwire, slimbus frameworks, the machine driver and the codec
drivers for WCD934x and WSA881x used on varios SDM845 based designs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0a8a2ad94bef..f186d0424619 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -436,6 +436,7 @@ CONFIG_GPIO_MB86S7X=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_UNIPHIER=y
+CONFIG_GPIO_WCD934X=m
 CONFIG_GPIO_XGENE=y
 CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_MAX732X=y
@@ -501,6 +502,7 @@ CONFIG_MFD_SPMI_PMIC=y
 CONFIG_MFD_RK808=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_ROHM_BD718XX=y
+CONFIG_MFD_WCD934X=m
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
 CONFIG_REGULATOR_BD718XX=y
@@ -604,6 +606,7 @@ CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
+CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
@@ -616,6 +619,8 @@ CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SOC_TAS571X=m
+CONFIG_SND_SOC_WCD934X=m
+CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
@@ -782,6 +787,8 @@ CONFIG_QCOM_SYSMON=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
+CONFIG_SOUNDWIRE=m
+CONFIG_SOUNDWIRE_QCOM=m
 CONFIG_OWL_PM_DOMAINS=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_IMX_SCU_SOC=y
@@ -797,6 +804,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_SOCINFO=m
+CONFIG_QCOM_APR=m
 CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A774B1=y
 CONFIG_ARCH_R8A774C0=y
@@ -883,6 +891,9 @@ CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_SLIMBUS=m
+CONFIG_SLIM_QCOM_CTRL=m
+CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.24.0

