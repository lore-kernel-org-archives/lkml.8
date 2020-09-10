Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D26206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OYY2o8e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgIJIpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729953AbgIJInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:43:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A913C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so3854236pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=at8Lpvb6ZG+uuZ2zkY59uCTG2IZirlY/86zTFsOHQQ0=;
        b=OYY2o8e4CsppjSNiU2YO845RlYgH0tMoejqblRDnxLZA6lRQMhtxjsu5YaPOVhDeej
         evNxHdOKwtC7K6+cZlbGxQkM+P8ecy1CD3+rieQvYMOftEZm/q0C0azussAbkNBRGzZB
         kuOdC0yJUsq5GcBAjNodBB/2jyLOcpjtxXX+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at8Lpvb6ZG+uuZ2zkY59uCTG2IZirlY/86zTFsOHQQ0=;
        b=Qb4g4fmdkF/cuQ7YQv5hpzCUpy1i/z7k0d7JwgnI9zwKljxGjztHmbfFe6d15L/YUI
         UbNAblAM07+JRLWy30zCdXzMD03xUGnKiy/qaxSFYf9p5MjzB5B1ezfC0wriQDuJpukZ
         5cHOhOdfEcnCkUDdvQAt1NrkaLQsx13AmEaFbVtGv7Tw/84NpO/ehRMpUXxD8Wdps7xH
         gg/2R4RpNRbc3rnHcMt2G6bP3dIhyte07IQcmZyxfGLIbdz8ra+rxae7j6uAiA69HWVN
         4L93/bFDZzY+M6EOMdX2BPvBNCLWRbnxMMIKvKEtEulw+1cPpcNKqONE+IrpP9bTTO30
         EKDw==
X-Gm-Message-State: AOAM530n3xOi77XjjMc4aokfOs+Bbrj4owY8LTs8OcZMV9IX3Rv/pfmn
        OA5HBLqcKgnVa12wn6EH47EOKg==
X-Google-Smtp-Source: ABdhPJy4i66YtpnY+rXnse34jMAcOef11wf8p8b69pJSqZSLJMzUeBVe0lcNCyOzSjqX1DdmFTLv3g==
X-Received: by 2002:a05:6a00:1507:b029:13e:d13d:a13c with SMTP id q7-20020a056a001507b029013ed13da13cmr4433394pfu.36.1599727394748;
        Thu, 10 Sep 2020 01:43:14 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id x29sm4357645pga.23.2020.09.10.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:43:14 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 2/2] arm64: dts: mt8183: Set uart to mmio32 iotype
Date:   Thu, 10 Sep 2020 16:43:04 +0800
Message-Id: <20200910084304.3429494-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910084304.3429494-1-hsinyi@chromium.org>
References: <20200910084304.3429494-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set uart iotype to mmio32 to make earlycon work with stdout-path.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 102105871db25..0bda97f912789 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -374,6 +374,8 @@ uart0: serial@11002000 {
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART0>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
@@ -384,6 +386,8 @@ uart1: serial@11003000 {
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART1>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
@@ -394,6 +398,8 @@ uart2: serial@11004000 {
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&clk26m>, <&infracfg CLK_INFRA_UART2>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
-- 
2.28.0.526.ge36021eeef-goog

