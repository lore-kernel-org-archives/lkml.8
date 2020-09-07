Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FD0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208492145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yFUZp/06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgIGHfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgIGHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:34:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92DBC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:34:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so13352435wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FnyQ6M7lKnSyvb2WTqWDs4juP1iSvzr23umTcdcFBl4=;
        b=yFUZp/06NfwHE/K2aBTW0DdB2itxHC+OR2dfwK7I+7POKFdsnbScCsblQY9LA9yS7r
         ETrI8vkClVOCkFGLgkgUweusW8/j/aLvr2jMNpgIou0UUH4xTXAtcH79On//zAX3W09g
         jLeGoZaL2a8js7u+jEtOX3092kR2mF05Glo/hErZ7UPTAqq8YjuLVB6yi/dKunrbZ2v2
         EGoQnyGgQwDQLRa2KQKiq2Ce+mjEYeifnkQ/cYGF2pcsmGF1+O16OFvnWa5vwuGZ8zFq
         4aiDnchNriBgwQPbtmI1il+gRRnx0TYGK8kQXUiHLyUjCRTIvfFhfGMXhs9OxW2qtKV6
         sYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FnyQ6M7lKnSyvb2WTqWDs4juP1iSvzr23umTcdcFBl4=;
        b=nTzAw8dmfbadHJHsxmrFfRyKw9aJIGttjlsuJHAh73/66z3YqY0CSGPTPthL5qEhpv
         JhkLgca5trw/h+KrJG+zkJfmK71tzYcUCr4lkP5SEDFS6Oh4mva1IrEc67FB6ojzKFmA
         +TgFP/cAmTSFKUdYcNzU7bs4yaamlm+mVdOCLBCXX+AD4h8CfxNdKzX+GjNyZezQ7YGs
         SBz1oqRDtSuDL2+wQOM5KK7r90XojQg0hCuQ4P7sxv0SVz93JRaFJ69duZxz68uGt9uS
         sFJfaQem9AtA3fnEAs5ogksSCOWe9rUoGbbAIpKfs2sTvhnKfba7No0wBfKtSmywAw1s
         cdSg==
X-Gm-Message-State: AOAM532D2biZU1cCMZ6iHoMgLq9BM1vsrMl4SO2OYZhIEhyt2md4nG54
        9jabieywcug4xFQz62HYUPFArg==
X-Google-Smtp-Source: ABdhPJxkU//D39wU0M3fJ1RRtwypstB8RNHkXuu98ipJC3IiN1dKlgAJT4r/cOmwRdGakdSEQYMQSA==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr19927754wmj.80.1599464049140;
        Mon, 07 Sep 2020 00:34:09 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u66sm527689wme.1.2020.09.07.00.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:34:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/3] dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg attribute
Date:   Mon,  7 Sep 2020 09:34:00 +0200
Message-Id: <20200907073402.26674-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200907073402.26674-1-narmstrong@baylibre.com>
References: <20200907073402.26674-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG MIPI + PCIe Analog PHY should be a subnode of the hhi mfd
node like the axg-clkc node.

Thus the reg attribute is not needed.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index 18c1ec5e19ad..a9040aa387cf 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -13,15 +13,11 @@ properties:
   compatible:
     const: amlogic,axg-mipi-pcie-analog-phy
 
-  reg:
-    maxItems: 1
-
   "#phy-cells":
     const: 1
 
 required:
   - compatible
-  - reg
   - "#phy-cells"
 
 additionalProperties: false
-- 
2.22.0

