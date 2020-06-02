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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB80C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE422077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghMInwgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFBRh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgFBRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:37:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF9C08C5C0;
        Tue,  2 Jun 2020 10:37:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o6so5398545pgh.2;
        Tue, 02 Jun 2020 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7CYQyvLGj5QNvVPjw4aTn4anzvpER/v1jXVlD72wch4=;
        b=ghMInwgHNwx69CMuNiOe7XroFlb4h04VAjpV63eho2HgPiR9HVgkZ87hXQmc7qykwR
         um4RSoNF9d/bYJyCzDLnls9mX7CKniMnxO381OCpmOYoms1g502RQ1Wx+qWqSTUTDexg
         YxddG6tAdNF8+NIalFRXI4g5mO1vHSSdDSiMNoHzUIlVk1iwdVuLHEt0a1+Ue8ZuEDWv
         59zh/uZ4S5GXGEkKODU5pU9mwb5TXBDAeLuKYn0VO3u7SddNWUXvrpnq+YRfP4q3tIeJ
         rHyvfEmY4VIPir6VCrgNbZ56MaWMiJvl+UGwy6SAkUojXTrql0dk2qG1IEBjIQGITYWa
         pkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7CYQyvLGj5QNvVPjw4aTn4anzvpER/v1jXVlD72wch4=;
        b=brsabj4YByuSfY5Tok4EAewT0XoTbp+0YNRejRbIEOCes9lEfvL6aZOqtCq24xKxb0
         nnmb1YI0EqPuzyaSHVkGTrpdREvHJkjwNmuw/b9xeBqRSzE3oNBQ//0dwNN7A53z/aGy
         6EyzrTSHIRKnOwW1AAtHNZEcp6bXAGI8h/poPCk1kItmuFuDGUDSkQL/+LYjkg4qOr6Z
         WX0asgRzDOsFhHKyD0+m3J0pwR+aJksSDNIrH92J4RqtA7h+XYNL1o/mbVsmUN5udIX7
         R8jQszqHvTxwouol7f1oE5boMPsDS6heW7GR9V02iTzQRZHz8yBUWILok1Yol28lPcoV
         W73A==
X-Gm-Message-State: AOAM5325G6U/+DauQRaUyIjnaCjaEQnjxFsZ0wR2GlQh3MnVKf4AN6I9
        ej11gevb9MEGHre0F/ZQGdI=
X-Google-Smtp-Source: ABdhPJyRQJFkq7C072d1XT+4f01Rh5JspsgsZUVHKnkBrd9NOzWfxn7GBf/UNhn+ZR9trRKjspm1/Q==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr12308743pfm.281.1591119476069;
        Tue, 02 Jun 2020 10:37:56 -0700 (PDT)
Received: from localhost.localdomain ([223.235.152.125])
        by smtp.gmail.com with ESMTPSA id i22sm2864382pfo.92.2020.06.02.10.37.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:37:55 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, robh+dt@kernel.org
Cc:     dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 06/10] arm64: dts: actions: Add DMA Controller for S700
Date:   Tue,  2 Jun 2020 23:03:08 +0530
Message-Id: <1591119192-18538-7-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
References: <1591119192-18538-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds DAM controller present on Actions S700, it differs from
S900 in terms of number of dma channels and requests.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
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
index f8eb72bb4125..605594dd7a0e 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/actions,s700-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/actions,s700-reset.h>
+#include <dt-bindings/power/owl-s700-powergate.h>
 
 / {
 	compatible = "actions,s700";
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

