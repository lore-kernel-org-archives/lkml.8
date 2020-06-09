Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E83AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE66207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyiKk/+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgFIKTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgFIKSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:18:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EDC05BD1E;
        Tue,  9 Jun 2020 03:18:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n2so7840169pld.13;
        Tue, 09 Jun 2020 03:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=acQt2SkaRoRSIkj+Wwww9zFIV+WDcbOdsThKWoJ9LTo=;
        b=QyiKk/+W/t5VVEbt8B7jTiKYYdAF/9eeWmvLklcjqc87SPm5gzlP/2PXvOw3UIVCE6
         9d/B5dtljk+oixS4JnwGwBZMH07RKPMFA7ll+fBRa3HWN5msS77cj1+sbwbmd6NGj8Av
         oZk71dLnwOteVznh5mUhygt9gPLfC2DX0KjNIcnutDhogavaqutXj78VYo2CZraj4zp5
         nJVsufdjjhuRE0rJ4+9e8ZM1WDgAqJ2TmQOkYyjSPB+/xzpU/glLA/mz0y0M8X/ELkMr
         qAwd1iMn6fLmk4h0tmXVNGiF59+v/jE9/gSbOTcYxTEKUORuXYwkTb14o7QwvFz+xpaK
         RJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=acQt2SkaRoRSIkj+Wwww9zFIV+WDcbOdsThKWoJ9LTo=;
        b=f+DNTQnsTqW2+6SjM2mrxO04TsXcY1Uby0ONFwIQdETDz8XWWbJr2smfOfbq19ue5M
         K9nWuI90ro8veJOkAumbtKzeOVTCWgTP70IkPqBPgp37TLiqAJFZmJI3sajtH6fWOQD1
         usr2pRvXgm71n2RmyDvZFapxbKQgN2YTnTMPIxy2iXbW8NbBRCEtPj5xK0zFi2VpN7mi
         UCHlmTIHQDscOeBbfxnu1z9n7i80fkiab1KHODjDNBPEdMTcj4ov1jqpI1iVFpZX90Je
         aOc171Mg51Z6MXUu00YkGaJr3hz5+rcHxh679JynoM+JcuQasM4QzhsIYQQdXZ2xLjLE
         jbgQ==
X-Gm-Message-State: AOAM531TCzLSBKiAwUP2IrbeBwkPB9Wt4KmkVd624E7rI1LFCbiAAmZK
        nLZdfbIuHLI9zor/iTUYH2U=
X-Google-Smtp-Source: ABdhPJx9voH2sXqtHqYO+DI6O8uAoudvXBbpaYomU9v4iR44LTpKLBTSlNBXN6lLvbAQqha+Dp24aw==
X-Received: by 2002:a17:90a:f3d6:: with SMTP id ha22mr3868718pjb.193.1591697899064;
        Tue, 09 Jun 2020 03:18:19 -0700 (PDT)
Received: from localhost.localdomain ([223.190.87.90])
        by smtp.gmail.com with ESMTPSA id d189sm9637253pfc.51.2020.06.09.03.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 03:18:18 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v4 09/10] arm64: dts: actions: Add MMC controller support for S700
Date:   Tue,  9 Jun 2020 15:47:09 +0530
Message-Id: <1591697830-16311-10-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds support for MMC controllers present on Actions S700 SoC,
there are 3 MMC controllers in this SoC which can be used for accessing
SD/EMMC/SDIO cards.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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

