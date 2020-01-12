Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FFC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B445A22314
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="vjJJu2RV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbgALLaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 06:30:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35298 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732695AbgALLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 06:30:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so6572325wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 03:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHwbLASHxjGE27Uiky3wxlrPdCw9dEtw2S64/E8yyuc=;
        b=vjJJu2RVXp0X6oEZP5H5bBX8C4YIBD9gsbjZfzgUFNd+TARl2D3CDJtZyt0rcYYA0N
         HsWFg5Ab8FSddlpv/cVQ1bwjE4DACclssOIo4SDpoME73MZHM320/dRgXPxdodNTctU/
         PMARG6KCEn115gWEu57sHns+Y+czGuVKs4e0pHnAdmu58hDzCiaCMjil90+XeFHaJjeZ
         2CvTrOuVB/05jbG+d4uFQ589Wy/CXM3lyOBbqoD2hItrJcutVaiS/2rzU74p20qqlrWn
         GVUWTHQBKbSWGpNz/x6S/bjSBClpNMPoCMYTggYIyFayTgzBfc5KxTz4EaLjgudSrbZQ
         l+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHwbLASHxjGE27Uiky3wxlrPdCw9dEtw2S64/E8yyuc=;
        b=rMwMzhYE9jCLBC0htdOCxLiM7gDBOr34Aihg4qCnCyXfSz7fjT1yKy/zzvcvenfKC+
         PUZSzuWUnUoIYw4VQ+N3UzbFTsLBh1Ix6G4x+jrD8GixhEiXPjg708d4sWjXG73jD4Ll
         zbUJr4z0acY1v2WIDHVBRzZxzWbWlDehBalCE1kTN0CQVBmGIS8lufCnCRm5Vlpm44IN
         CSR7RfIE/w0cA7aChNDCunMM+2KL4H0yVX+Gq8gvnDPQx9ve6lNAb7kq3EzJ6vQ+ht3S
         4fdK59gxbPwD2QOBmN4uj5QYTIAvCJVoZD8Ab5cC9sCW/UkCfxGuYvUeuJfFZexsytsM
         s5vg==
X-Gm-Message-State: APjAAAUO4yWO6l9tiKVb1nUxXHnz4almucMVN0sUdAaXqIJPtLF09OX5
        YMoaXF5h9zHDJz1WD3rRb81MaA==
X-Google-Smtp-Source: APXvYqysamBkNqIu5nyLG9FpW2nztuJSFajzk43xKKLVsG3seq7LABXj4KAhtOv45hCvJnDDUX/XnA==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr14953970wmh.58.1578828614509;
        Sun, 12 Jan 2020 03:30:14 -0800 (PST)
Received: from localhost.localdomain (dh207-5-115.xnet.hr. [88.207.5.115])
        by smtp.googlemail.com with ESMTPSA id y17sm9943045wma.36.2020.01.12.03.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 03:30:14 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/3] arm: dts: IPQ4019: add SDHCI VQMMC LDO node
Date:   Sun, 12 Jan 2020 12:30:03 +0100
Message-Id: <20200112113003.11110-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200112113003.11110-1-robert.marko@sartura.hr>
References: <20200112113003.11110-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have driver for the SDHCI VQMMC LDO needed
for I/0 voltage levels lets introduce the necessary node for it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index d2b53e190954..d95aee50454d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -211,6 +211,28 @@
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		sdhci: sdhci@7824900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+			bus-width = <8>;
+			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_DCD_XO_CLK>;
+			clock-names = "core", "iface", "xo";
+			status = "disabled";
+		};
+
+		vqmmc: regulator@1948000 {
+			compatible = "qcom,vqmmc-ipq4019-regulator";
+			reg = <0x01948000 0x4>;
+			regulator-name = "vqmmc";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-always-on;
+			status = "disabled";
+		};
+
 		blsp_dma: dma@7884000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x07884000 0x23000>;
-- 
2.24.1

