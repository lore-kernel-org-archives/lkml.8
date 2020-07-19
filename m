Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED00C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ED621744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+sG8A0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgGSRnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgGSRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:43:16 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B8C0619D2;
        Sun, 19 Jul 2020 10:43:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a23so6323140pfk.13;
        Sun, 19 Jul 2020 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=34HjvNomJ/6biYOR1u7jUgjUz6VJVWlaaUwFENTGmD4=;
        b=E+sG8A0CN4wkbdT7H50UQQbfUvdE3WXixoQ3K9Wpj/K2MHcm8rtFoa4BbXoJh7c32A
         9iQe1QXLunMGMGN4nA4sxdluYUjn2UIJjZ1X3YX4wjCsrqb9GY01Ay4G1zuatljKdvWo
         m/A+v2ggxZA7qe2mNmgApbOfaBUpJ99jRi+qJUa2se70OheiO+vx7FQG9/xuJywUQeIq
         L7F2McS4RU92C3G6ql53QwjbSL4FW/qQ5DTs48WAY7o+hqp3qi+M/Oe+GRY6yKqcGcH/
         PtYy+MJt/2mCXu3NxlXdmxDLruIFZeXJLb0FmbfNZn9lwWyoeNZougslM6YGTjAryh+m
         EApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=34HjvNomJ/6biYOR1u7jUgjUz6VJVWlaaUwFENTGmD4=;
        b=pKLT+fOiCz16VOePpgpg9oR69FtASW4SlnPK2Y2SPIP+4Rqjlv2h603ks4M90Uji3b
         Fa6UEGnA7gY8p3pIOspA4HIcJEeUu4+YDn3a5XQBX6UTKhdLewNWj+4xfyUAGiAsGofM
         npQSuXL36IKu2dCUdgzUfSAZd1NLw+s2exicQQdz3cf/mg/tLSWX6SNkCE/rMNrIlbZM
         b4UX0Cl0mRvpis/xPLoRk6eVohBIZ1C0b1obQrY4+qVXBEa0LCDbxVjkf0xNjO1kyh5r
         u1DhynaOQ1nkIB0BLbmLPUq7HhqH0RTys3AoLGGf2QtSSlXRVT+NzF2JyNOtQRrPLuwx
         YYsw==
X-Gm-Message-State: AOAM531I6KBePbPPcbtmAXj5vFj1E/uc0jnxAEDUKsyjUsAYSmbD1jer
        XWbFCu/AS6gJULPrqVQbSWU=
X-Google-Smtp-Source: ABdhPJzmwlE/CSIZmqoN3qQbbBYtT6vWZ7R/h80emIl1CPS88GKs4E5CT9vjbibmsxDkoGb2y4DSqQ==
X-Received: by 2002:aa7:9422:: with SMTP id y2mr16669862pfo.211.1595180595789;
        Sun, 19 Jul 2020 10:43:15 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:43:15 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Sun, 19 Jul 2020 23:12:06 +0530
Message-Id: <1595180527-11320-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds support for MMC controllers present on Actions S700 SoC,
there are 3 MMC controllers in this SoC which can be used for accessing
SD/EMMC/SDIO cards.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes since v6:
	* No change.
Changes since v5:
        * Added Mani's Reviewed-by: tag.
Changes since v4:
        * No change.
Changes since v3:
        * No change.
Changes since v2:
        * No change.
Changes since v1:
        * Added SoC specific compatibe string.
Changes since RFC:
        * No change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 2c78caebf515..9ed88aafc2da 100644
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

