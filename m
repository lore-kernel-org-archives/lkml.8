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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9986C433EB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DD21744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4A14xNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGSRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:43:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D90C0619D2;
        Sun, 19 Jul 2020 10:43:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so7611775ply.11;
        Sun, 19 Jul 2020 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ln2ry33JZeYSRz7UO65SnIUwaEVYySx56C+yn6tKPXQ=;
        b=T4A14xNYImiKs5f8YkDq4Bh1g5kT81BjvllgxFeNPlYTAHgha4D+OFuOhBdMKKAaPq
         0vkGtnTzPJzB7gio009QBGcs10xQY22lB4cgpiF+U6oX66+r/yvdyVcMFCqfNGMisg1g
         r2+1jYdIvoPOi36YUxMZfpzFIerCs0B3+WI44Owu4+cPTqzB/0QhpiouF/5nB+BqPHJZ
         6haAN5myAQICQ2YI4q4yQyziqg4F6mCwfKsDPlXNkvAVIT8YPiNms/BO7WAJ0RfU2B2o
         AotDK0csSbWayGzLwYuWzCDMqE2LbHD+5oavje3liAP5QPPKT0jYYbw5n5THWzvyWfBc
         NN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ln2ry33JZeYSRz7UO65SnIUwaEVYySx56C+yn6tKPXQ=;
        b=MozAoZ6W+lKSn9rsExrurbmptzlOzaWwihBfM8cj74CHZY3dBEDTSehJqpik/sx+j0
         lKF0+bDxZPnavVNApF//fPSpBfTrpIx1iprEz94SbvdMSB9JcmlFIszVp6q/+/lGECaI
         FW1lkDde6dxFxIqK4pQ7NrWbwgj8YTEOdJDOj0RsEgP59MbDgjn1XaF5sIMSKaUg6/n/
         UVlkJ4vqvlmqbbu5XB/eg0Y1gY/dERbsXbBfA7Z0uFl7hyE2Obpn2DIX9jGgHKnUMoJy
         CKgNDGAW8chjeb2h6tC5WVC4i4gN2r81Yt2Uoi0iifI5nSGstMEvVm/iiIURR0jb25me
         MYcQ==
X-Gm-Message-State: AOAM530Pr+8hMAbkdp1RY59kemOHHhQaY5yIO9Bu/bK8YbhZOi99y6/3
        IgrAtnwhocZJ7FMA2Umry4g=
X-Google-Smtp-Source: ABdhPJxQkwKiYUaaBNiT8Nsgr0bnfGl6O9wNO7fgmh3rUNFYdz8A4F2uZnmkScIsxPgjEg40IgJLMg==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr20453301pjb.66.1595180580493;
        Sun, 19 Jul 2020 10:43:00 -0700 (PDT)
Received: from localhost.localdomain ([182.69.248.222])
        by smtp.gmail.com with ESMTPSA id e191sm13906083pfh.42.2020.07.19.10.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jul 2020 10:42:59 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v7 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Sun, 19 Jul 2020 23:12:03 +0530
Message-Id: <1595180527-11320-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DMA controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

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
        * Fixed typo in commit message.
        * Placed owl-s700-powergate.h in alphabetical order.
Changes since v2:
        * added power-domain property as sps
          is enabled now and DMA needs it.
Changes since v1:
        * No Change.
Changes since RFC:
        * No Change.
---
 arch/arm64/boot/dts/actions/s700.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index f8eb72bb4125..2c78caebf515 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/clock/actions,s700-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/owl-s700-powergate.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
 
 / {
@@ -244,5 +245,19 @@
 				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		dma: dma-controller@e0230000 {
+			compatible = "actions,s700-dma";
+			reg = <0x0 0xe0230000 0x0 0x1000>;
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <10>;
+			dma-requests = <44>;
+			clocks = <&cmu CLK_DMAC>;
+			power-domains = <&sps S700_PD_DMA>;
+		};
 	};
 };
-- 
2.7.4

