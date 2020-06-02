Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF50A206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLMJ+dCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgFBRig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgFBRie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:38:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6226FC05BD1E;
        Tue,  2 Jun 2020 10:38:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1824079pjv.2;
        Tue, 02 Jun 2020 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wRmkP6kAdBR7TaWl8CAPxlHOoqQz8rJlj1f3tr5k9TE=;
        b=PLMJ+dCKk8b/fGljUh8B1Yf0pxUDiNve3Iy39rE28FzcVaEsslmgWJgAdQsqu1+rGq
         71MX+KHONlVuD0qC4YtYQRAnFFtheCX+/A/u5LCD3iQ50n/s3sHaXmTePuVvl9LKoX59
         lmfzoujFNSMzEIlLmztXVBtmKcAboIHa7X+sFOs5UgDfqdQdt7j0AVEMBlO0qixzVq4h
         7BQOk31nl9WF+eGhmBK5VXRHnujO/mNOfqtL9tTA7Hws9a/uHvAXcnc3rYox+5fy4IUE
         THJMD8YkpV3HAjIZ9JQBaUKI71d1pBVgFX3BQv+AHJIESxQrpwuZQcheF/KPhHMW7GpD
         u7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wRmkP6kAdBR7TaWl8CAPxlHOoqQz8rJlj1f3tr5k9TE=;
        b=tdYaSljLBcyR8NMs3Qkb2de/aD6W07fO9UJ4kzvu8utyQRExYcOFVO9YnYPFojIVli
         piEomek6MI+8taiSgB2zfba9zsGSDQoHlherZNiYUQ4G5mhpfr5uh9Yo9sZYgdWo1SSl
         A1ZAtAQ46WYggu/jNTRaLPL3rg5zmtLXCwTjXjzceZcj20uJLQEe2GhQkGiZ2nDVHVn8
         eKqIruc2MKEGkjX23puBMF4cmJKBfbQXJl2xmjnxywg8IzplRxB0AZwqmd46vMx4/V3w
         FrfnCvqmKkRnlQ6d8tf386PmZ95SpPBB/9u7E5g15TCkfvE5vjPjvTgoA+d9vNBbGaRH
         SrAw==
X-Gm-Message-State: AOAM5310SOuP49czF+hMBQ+v0602Ds2d60qrXZNrVjP7d7gELaImulQ3
        gAeWfH9boq21qT7GCnKAF/c=
X-Google-Smtp-Source: ABdhPJz3hIQhct0HIJc2XhQ75/vck8IojRxBrjisoBjFg2X+DwipcyTdDvk6VYrf/8g27UGAUfnTuA==
X-Received: by 2002:a17:90b:28d:: with SMTP id az13mr308523pjb.67.1591119513888;
        Tue, 02 Jun 2020 10:38:33 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.38.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:38:33 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Tue,  2 Jun 2020 23:03:11 +0530
Message-Id: <1591119192-18538-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds support for MMC controllers present on Actions S700 SoC,
there are 3 MMC controllers in this SoC which can be used for accessing
SD/EMMC/SDIO cards.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v2:
	* No change.
Changes since v1:
        * Added SoC specific compatibe string.
Changes since RFC:
        * No change
---
 arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 605594dd7a0e..b1a34f95d44c 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -259,5 +259,38 @@
 			clocks = <&cmu CLK_DMAC>;
 			power-domains = <&sps S700_PD_DMA>;
 		};
+
+		mmc0: mmc@e0210000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0210000 0x0 0x4000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD0>;
+			resets = <&cmu RESET_SD0>;
+			dmas = <&dma 2>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc1: mmc@e0214000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0214000 0x0 0x4000>;
+			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD1>;
+			resets = <&cmu RESET_SD1>;
+			dmas = <&dma 3>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
+
+		mmc2: mmc@e0218000 {
+			compatible = "actions,s700-mmc", "actions,owl-mmc";
+			reg = <0x0 0xe0218000 0x0 0x4000>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cmu CLK_SD2>;
+			resets = <&cmu RESET_SD2>;
+			dmas = <&dma 4>;
+			dma-names = "mmc";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

