Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA485C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4776206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/iKYiP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgDGKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:36:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36383 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:36:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id d202so1283315wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p+jrVWY9jfP+8Y37zFyB2OTvL0uCfTEvFAk5REfQdCQ=;
        b=e/iKYiP3U8IFZUiXKXgRyKuO40a7lPZXacKRxaNnk8MwYDQ3a5AKR/LnSGEkVPxV5w
         8yhqESa/jPWOsEURwyjYi2wFW6W3qsEhURrBI+O1dIR4mEugRqvLr5qAD5kCg7s7MrEm
         7BEiqe4ZAS2ugw9pzPCFYuXyrdFT1tnKJQIqlCOuso1slzuAFEYFJ9bQLbXHhRWjdavc
         +hagbwhtthEtQhUwJTDaZeTF7dwU4BtXEjjXhFU540VI0Vv/TZut+YzfiFGIdGufn2IB
         dvNv+yhk/kci/AjkaBipbOMOep91gXsg9mjE8wQnSb944kVxaiJXW78cZbD+XA5RNssm
         zc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p+jrVWY9jfP+8Y37zFyB2OTvL0uCfTEvFAk5REfQdCQ=;
        b=SMbAns7UqJT08E1PkFRApugtXR2UH4Nbnqh8i8Mqy+qECdMRq/wUXVV0zO63e+MRN4
         6KwViL3Jj2QJPo4iM9YcN9M0bfljHpfe1QjcGn55TBmV5DzkS5SxyJ/Ih+K59rmwVztc
         F9JXB+80VYxIh+jvbMz5qQJDGFETNiWkwDzwwUf0fWZvJNs4i+vvgMJDezQfLVOS7czA
         WahehALEZ2j33d7og6vCRwiFCrvDY4nazOMxYRewiFF5sDpIOZDTBvvQrqxRg5J2Ic51
         v1UNwHvRf66Jgm9s8PjCOJx+8yjJIGur5KD8lyr3qDJqT6uO/lQQHNwAWY1PFO/b1+Y+
         YFzg==
X-Gm-Message-State: AGi0PuYS3rq7G4KFj0HGroR+gi/WTz1iPt4rlvrb7KELYnkbJtUudvqz
        vWSwXSNM1m0coOdpCS8EGqs=
X-Google-Smtp-Source: APiQypJ2rpcyVhbW1cGHbfHfmSBrOKk8gU9YMo2YwCvd00EuJXCIiVVanib/NghtO6RkweID08Ep4g==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr1718399wmd.186.1586255808914;
        Tue, 07 Apr 2020 03:36:48 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id c17sm25016722wrp.28.2020.04.07.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:36:48 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 4/4] arm64: defconfig: refresh
Date:   Tue,  7 Apr 2020 12:35:37 +0200
Message-Id: <20200407103537.4138-5-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407103537.4138-1-max.krummenacher@toradex.com>
References: <20200407103537.4138-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refresh with make defconfig savedefconfig

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm64/configs/defconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d43bd18bedf1e..b65425f83e0b6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -165,9 +165,9 @@ CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
 CONFIG_BPF_JIT=y
 CONFIG_CAN=m
+CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_RCAR_CANFD=m
-CONFIG_CAN_FLEXCAN=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_HS is not set
@@ -202,20 +202,19 @@ CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCIE_BRCMSTB=m
 CONFIG_PCI_LAYERSCAPE=y
-CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
 CONFIG_PCIE_TEGRA194_HOST=m
+CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
-CONFIG_FSL_MC_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
@@ -494,10 +493,10 @@ CONFIG_SENSORS_INA3221=m
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-CONFIG_QORIQ_THERMAL=m
-CONFIG_SUN8I_THERMAL=y
 CONFIG_IMX_SC_THERMAL=m
 CONFIG_IMX8MM_THERMAL=m
+CONFIG_QORIQ_THERMAL=m
+CONFIG_SUN8I_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
@@ -610,9 +609,9 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
-CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_SII902X=m
+CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
@@ -660,7 +659,6 @@ CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
@@ -795,14 +793,13 @@ CONFIG_QCOM_A53PLL=y
 CONFIG_QCOM_CLK_APCS_MSM8916=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_QCOM_CLK_RPMH=y
-CONFIG_IPQ_GCC_8074=y
 CONFIG_IPQ_GCC_6018=y
+CONFIG_IPQ_GCC_8074=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_MSM_GCC_8994=y
 CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
-CONFIG_SDM_GCC_845=y
 CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
@@ -931,10 +928,10 @@ CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m
 CONFIG_SLIM_QCOM_CTRL=m
 CONFIG_SLIM_QCOM_NGD_CTRL=m
-CONFIG_MUX_MMIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.20.1

