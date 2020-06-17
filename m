Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF327C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81FE2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUcUY14X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgFQQtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgFQQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:26 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FDBC06174E;
        Wed, 17 Jun 2020 09:48:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so2476417edr.12;
        Wed, 17 Jun 2020 09:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fOhYKXX9hi+9MVHQhHY4sI0Y8sLNLyLXejCOvgcKKQA=;
        b=HUcUY14XiOkgINSgtEcMP6dwMeU1iUCpAavOYpWWvcVsh9XJTa5DtQjSFtnFPZZkj0
         Oa7QNVwBIslc9t6Nh6P7i0srtKtpqD24pR8l2nFKt31ELaSdZj/Ycbe8cxhUKr9HKmpN
         vOqvXiQOrmtlRHg3DWzvmyaSzf0bGKG7L1sDV0331ySBiCYWFWW4YNFQBe49jpYqxObU
         mwEynxqcr8CHDGWoUwuDv/hijrkEjuULX/FaIeUoz5pu7o7TMksFy/jGDs4Uy66kQ5Wk
         okV7lrH0CSJwnz9J3uMVyNBlawa+8iQwV9grYTcYJiVEXWU9fEkj73bl+9Ouk4dcS/y4
         bgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fOhYKXX9hi+9MVHQhHY4sI0Y8sLNLyLXejCOvgcKKQA=;
        b=CCA34oMwKRpCfuKjWNuoKNZXcuImQfVL6dlDG1dNKo434C1i34rwwtdEu+K4PL3DzI
         XFstM+6Dy5yHaJEL/lYn/Y9Ocmru2o55WQQpHYxGDJ595IGcyN2Ejyerog812p5asx4d
         pjHisF634IhiolAYd4Mkai3ws/UEooGiws7xEMEN6syGhtAKbq9yh/PGJN5H2PZPk1gG
         lQqjociZ31T+go97qGsQ4DZazQ36SChjBu29eymD+u2xFuwFnEs6wn33StQbcBVXXSM8
         P8PqSI0Y3JZFeZyIzk5DZC/NbrZr1vcF0Cc2T6bfQMPEP5liZTp9+YdL5VZoJG+XFY7D
         hJgA==
X-Gm-Message-State: AOAM530EeRXzaVj84yM5BzGCn5RIIGLabGk9cdT6HtmI/R5gjv/OEm3a
        YEt4O/xNGLaD/Tdz1YhrrcE=
X-Google-Smtp-Source: ABdhPJwGHl1xZxgFACdA/VlCPqa/bNkM9owgM5dNiTwaSed9JoosVOhxU8MsEZ5Dh2Qw0s1ywW03nw==
X-Received: by 2002:a50:fc0d:: with SMTP id i13mr87504edr.260.1592412504023;
        Wed, 17 Jun 2020 09:48:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id v3sm127124edj.89.2020.06.17.09.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:48:23 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm: dts: owl-s500: Add DMA controller
Date:   Wed, 17 Jun 2020 19:48:07 +0300
Message-Id: <5b942daad7854c50faabbc9ce8e24c2ade74f641.1592407030.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
References: <cover.1592407030.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA controller node for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index ac3d04c75dd5..0f4fc5487dad 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -205,5 +205,19 @@ sps: power-controller@b01b0100 {
 			reg = <0xb01b0100 0x100>;
 			#power-domain-cells = <1>;
 		};
+
+		dma: dma-controller@b0260000 {
+			compatible = "actions,s900-dma";
+			reg = <0xb0260000 0xd00>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <12>;
+			dma-requests = <46>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S500_PD_DMA>;
+		};
 	};
 };
-- 
2.27.0

