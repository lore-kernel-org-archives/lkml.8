Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F81C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADCE20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enzE2lZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDHObD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:31:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38611 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgDHObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:31:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so8066543wre.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyDE/DAow1HKfw9siXqu+BUO4Iv4LhO2/XGLlEGwwpM=;
        b=enzE2lZoy6PK42q1fBJmgw+P8pJ5fQLJlPJ86GI4CsGsBlyLD6VvpsSHVINFHI1pHS
         6aIeDtCJHV6wGb7MnKhkVpy6oItqyZUBmNz2aEyVFoXRbKAq4zbpaefxR0DwHjjKXalE
         vtt99ey5Do8kGr1BIfz6ao4QaaYrPcH5w83xQOjR9X8VFVX6CXjrG3ndW4UGYLJdd4iW
         MVgl83hovMLiv0SnCuEHRI9GNk7qdd7t6zZLFwOHdm4fWfBn/p0O7iuTGVI62bYSfZBA
         qltMjWIqClDTNa08iPcz6AUao2PWrW68i/Xu4ijxaFCDlVTV4MYmr+hwGSmz0aSvjPeN
         512g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyDE/DAow1HKfw9siXqu+BUO4Iv4LhO2/XGLlEGwwpM=;
        b=eivwIedDBsYkE0PfDhezHufEfnTw3nTo4N8QZM7w2zJ821dSW7QVljctYuTwdcbrIe
         9aep8L20CSumskf0JtjZbrgvAhG+avJEnD2X/A2GuK+QLtiD7yOC/fJ0ahzriP7/HlDd
         FCDLELTcbpMtXZhRcmjtNvKEIpZBMz6RK0l1innjMQav/mS64yJinecO9Lqcwl0yI1Oz
         mwEd758CozRkWOe3ASYuoq5AMl9oSq8WxGk3WmzR40TwsRsSDaWPIu0JynrK8ZYhQcnA
         vRm9M+L68Uhq+ZITQu5RsFQU2Z1xL0mXxHkSf+VtCyPjs2ZBWhQbuwkdJO6d0W6wnz7q
         ofuQ==
X-Gm-Message-State: AGi0PuaFxbgAGVF9e0FAylezSj6fS4Q0TS0wWjNgHX99ydpNEiubF7G6
        MFaMCoeToCFOSKrHRc7n4u4=
X-Google-Smtp-Source: APiQypKltU+gZXosQgFXeWbDm5Ug2G9QbX9w0EJMILudxJET+MWXZkyb2dGVrPc548WClfwBq64jkA==
X-Received: by 2002:a5d:6183:: with SMTP id j3mr8798851wru.83.1586356260277;
        Wed, 08 Apr 2020 07:31:00 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:59 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 5/5] arm64: defconfig: refresh
Date:   Wed,  8 Apr 2020 16:30:40 +0200
Message-Id: <20200408143040.57458-6-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refresh with make defconfig savedefconfig

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- add reviewed-by tags

 arch/arm64/configs/defconfig | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4a361734cfc71..a4baafe01c346 100644
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
@@ -610,10 +609,10 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
-CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_SII902X=m
+CONFIG_DRM_SIMPLE_BRIDGE=m
 CONFIG_DRM_THINE_THC63LVD1024=m
 CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
@@ -661,7 +660,6 @@ CONFIG_SND_SOC_WSA881X=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-CONFIG_USB_CONN_GPIO=m
 CONFIG_USB=y
 CONFIG_USB_OTG=y
 CONFIG_USB_XHCI_HCD=y
@@ -796,14 +794,13 @@ CONFIG_QCOM_A53PLL=y
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
@@ -932,10 +929,10 @@ CONFIG_FPGA_REGION=m
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

