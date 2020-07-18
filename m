Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D060C433F1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A085207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILk8sJlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgGRJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:20:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23925C0619D2;
        Sat, 18 Jul 2020 02:20:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so7865080pgh.3;
        Sat, 18 Jul 2020 02:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qR4vJT+mcA6eHTDOA004E+9HQE1jjc1zKhWS+aHn5+s=;
        b=ILk8sJlgP/1iJ+pXHTXLVEti55fV/dvUXOg3wBPshnyNPk4yOH5Y0hdD6cPdP3pJnd
         qHCGk0CGL9vO4u1Hdng6HTn7EruWAZhAlRcBckOOVPSuTE3lMRuoyWetrO3l3FKQ8/qw
         ypKfrelR7H4sIzqLyeTNqiy05mnHtpaYcM2IEN543K7GIzboj9Uxz5rLVdn/m/1d83pm
         Rg0ILXwr3kGpK3rYEo6a0C5bf9R99DWiJTcm9TuYg/KxamDiDAqspsywl4eZjTjekgL6
         WTl4Wa97NN6ySVmGDabFERIIwiKLeVii8wCxBbMW4isBMj47ORxjPG+4JAYKxEQOWqbC
         8fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qR4vJT+mcA6eHTDOA004E+9HQE1jjc1zKhWS+aHn5+s=;
        b=QAtA2P3eOBVNjYtHzDClAwkFFTSq3Hd2BUGifY/Z5Px048a2j/v7dnBPhdJYBxqBSy
         V8PVKXeoVMVrDKwxXoNKEVzZPnDB5ttVibuwD6t7JNTkx2ZPiXo0vA66o9Saul+dGPMw
         Vwd1tUNN/KjMVpSFGeMbU84b9cLa6Ioi1bDo0VrLHjMVthZsPV/Jxd6O/Ea4T5PEwUIA
         TVOAx5mu8TP2Q5mF0GtLGR0RtYPGv6JcOR5rGpmAvp7fgBL6GIE+u0ZB45xiWe1eSafg
         YwmxmcoVnlK+thLm5m+pJJ/mx3AetCQokWzR1nJaqhJ1YDeck3T9AOmXWtFO5haZlwpd
         Mliw==
X-Gm-Message-State: AOAM530pIjSzNptv1uPdLok11/C/oQHykFMZem1aMH/Hv8AiTOyHuf7g
        adx3VCg55po7hXGNMicQsp0=
X-Google-Smtp-Source: ABdhPJxLuQJNE5tXdiUm1YBU5Ezg+JifUDzpOp3MPCMjoq9HM3zMjRf2cvytGZKg+ulw9tXPALZ3dQ==
X-Received: by 2002:a63:ca11:: with SMTP id n17mr11688198pgi.439.1595064046647;
        Sat, 18 Jul 2020 02:20:46 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id nl5sm5217800pjb.36.2020.07.18.02.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:20:45 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Sat, 18 Jul 2020 14:49:33 +0530
Message-Id: <1595063974-24228-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
References: <1595063974-24228-1-git-send-email-amittomer25@gmail.com>
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
        * No change
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

