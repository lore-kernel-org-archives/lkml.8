Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31128C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE72A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KTLKPAFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIJVnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730924AbgIJNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:01:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11558C0617AB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so6611026wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HphHCPdJUs9HEUbW8jhDJPa14fS8feVjDMdm8pwKQX0=;
        b=KTLKPAFfGEgTr2BImp+QKZGVPI0BzcHxU/2gi4Hz4aq6K/0m9lhzMmNEiW8wgtH2iJ
         9mMpJYcT0vvo2wEb5v4jHjlftFwV7dVCl0Mszv4QdLfjxoQJ0psBeF6XCHqyLGq2iJGT
         JG/RiC70ZixTF7vkGxFnCKBHpN8EYdTYJF8mpnSaVEfGQpo/ZvNn6b9KSpmSz6VQkZk8
         hwwQIH7wRd612A+1kyQ9+Wo0SE/5kRVFTC+Feihkv7rQIanO+n8nGntYaPSdmWrgj1MD
         7XrBCFG9+53zppoSdG3GdYpd3G32cYgfKwIU+0XDPXodzaDBsm1YhRNWsnb6pL+LeuLE
         P0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HphHCPdJUs9HEUbW8jhDJPa14fS8feVjDMdm8pwKQX0=;
        b=SsC7N/Dq0RAH3OETQLIXxyDiZDNMcrFPHYXDUMe1FuZzDnLPAYFrsnoLJt1zjSXWn3
         THjXjjJ/7IbvST9x11cCYaaQs1XnBkh+dO/kH04q9FcYfYZB9KtZ4LluCI9Z0JFCxUQF
         OT/sTH4duufk1V0MlfsMaPaS5Mrz0l//7iHVjhAJj8VQZ2bH/PRxc7Pfe/Pv8eobntPa
         8odP8mxhhTunCtBJS2Q0e7LiWkgJneg+DTmpuP79Vc9eT5umNJMqGy7P5gik4O3Mr8Zu
         CzbvqFSvCt2jeSax/HqsySQCQI0h74bB4f0pJm+UeysTcnYcS+s0VeOyzh+P7p0wpIuo
         dsSQ==
X-Gm-Message-State: AOAM5328JloCMQ81PDPtEfZSqZ1rlYVW5MD2MDx433Llb1PcqNpL7lVI
        K7oOnBasWuXAadbv8UqFi8bXeg==
X-Google-Smtp-Source: ABdhPJxQ/7u8nEM7o5yIM0TqrL9dfyr46k2FRZOHqGju4TlGZTK0gY0DH16yhGiFzt+kO1B2bqgRGQ==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr9460647wrf.77.1599742902740;
        Thu, 10 Sep 2020 06:01:42 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y1sm9488269wru.87.2020.09.10.06.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:01:41 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 4/4] ARM64: mt8183: Add support of APU to mt8183
Date:   Thu, 10 Sep 2020 15:01:48 +0200
Message-Id: <20200910130148.8734-5-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910130148.8734-1-abailon@baylibre.com>
References: <20200910130148.8734-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the support of APU to mt8183.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index e215f1eb3eb2..28f75452961c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -967,12 +967,51 @@ ipu_adl: syscon@19010000 {
 			#clock-cells = <1>;
 		};
 
+		apu0: apu@0x19100000 {
+			compatible = "mediatek,mt8183-apu";
+			reg = <0 0x19180000 0 0x14000>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
+
+			iommus = <&iommu M4U_PORT_IMG_IPUO>,
+				 <&iommu M4U_PORT_IMG_IPU3O>,
+				 <&iommu M4U_PORT_IMG_IPUI>;
+
+			clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
+				 <&ipu_core0 CLK_IPU_CORE0_IPU>,
+				 <&ipu_core0 CLK_IPU_CORE0_JTAG>;
+
+			clock-names = "axi", "ipu", "jtag";
+
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
+			status = "disabled";
+		};
+
 		ipu_core0: syscon@19180000 {
 			compatible = "mediatek,mt8183-ipu_core0", "syscon";
 			reg = <0 0x19180000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		apu1: apu@19200000 {
+			compatible = "mediatek,mt8183-apu";
+			reg = <0 0x19280000 0 0x14000>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_LOW>;
+
+			iommus = <&iommu M4U_PORT_CAM_IPUO>,
+				 <&iommu M4U_PORT_CAM_IPU2O>,
+				 <&iommu M4U_PORT_CAM_IPU3O>,
+				 <&iommu M4U_PORT_CAM_IPUI>,
+				 <&iommu M4U_PORT_CAM_IPU2I>;
+
+			clocks = <&ipu_core0 CLK_IPU_CORE1_AXI>,
+				 <&ipu_core0 CLK_IPU_CORE1_IPU>,
+				 <&ipu_core0 CLK_IPU_CORE1_JTAG>;
+
+			clock-names = "axi", "ipu", "jtag";
+
+			power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE1>;
+		};
+
 		ipu_core1: syscon@19280000 {
 			compatible = "mediatek,mt8183-ipu_core1", "syscon";
 			reg = <0 0x19280000 0 0x1000>;
-- 
2.26.2

