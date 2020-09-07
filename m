Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C114C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E92145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CqUz0UAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgIGHeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIGHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:34:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED2C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:34:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so13163013wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vj8HWAVrpRy1isn5QaCtQMf3ecM7tJijiOroIqActls=;
        b=CqUz0UAulnbLvDtdUuMuICb27QDT1ayBqFVQ1Ox81QjldlBZor+TMFwG//o8suMq2n
         DeEaw5b2NzdC7u/6Ov8ttU74GGIsmbQxWiY2DRpUuqhqG06UDrQXzMPm7P/pEdlihdTa
         3bC3JcDbhlLxaSugwyG0roFO4Y3srOE76AJhmaVUlasEqIfxsV5czWVf8nVwcBO6mcze
         B3cGRKIHIj8jE51IQigYWg1nfJX7U9APLy6TDcTH1uHQR2YG5cutuixwBH/KItRD4NMQ
         6c+uQpGibnl2Pyi+3CHIkk3b6MTHa87t1Yha1bLvCweDhmjYpQ/XLMaNQPaSiEfdahBm
         qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vj8HWAVrpRy1isn5QaCtQMf3ecM7tJijiOroIqActls=;
        b=iFijX4EIlJl9mYfoOlr/jjK8oB9RmtsXPhEEfwz3/Tokh725lhoS4lUozx4p4tUhEM
         0QvFsO0eZ1r6sFxYIIhJZ7bIc/MoAZFT+0XeE6sXC3kM5RNRtV1332a88/qpBWq634vV
         rGficVmE+LkwV90eL9wksCfq/K4TXeUtaBthwbt2o2AaQJAf4d9mZ11aBUQZrCbrq6NL
         69SUmW58N9mWWZvoppJqUYT67+rtNe6Pmkf9/IwUihSmtq5SA5xxhTqoqfegKuycFwKF
         oUzm/bC2mahWjTfVemkBDj5Wx7EuwM0h6z13wAms8sOEqos8G/BBHvlalcFE2VV7M5s+
         CAVA==
X-Gm-Message-State: AOAM532FnhogauIO4yXLZRAsEidysXftRvVfrW3Lo8smEcJTstUweziu
        L6W8DaCmktptYZekhAuKKcgbEg==
X-Google-Smtp-Source: ABdhPJxP+CeEp26KlgvP1XIailxIhFzY+zlCYZbvdzjmkb3Q5Bd+qcAFR0fyT5HL9Fx9W/57dqcD4w==
X-Received: by 2002:a1c:bbd7:: with SMTP id l206mr20503113wmf.185.1599464047762;
        Mon, 07 Sep 2020 00:34:07 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id u66sm527689wme.1.2020.09.07.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:34:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, repk@triplefau.lt
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] phy: amlogic: add MIPI DSI function to analog MIPI+PCIe PHY
Date:   Mon,  7 Sep 2020 09:33:59 +0200
Message-Id: <20200907073402.26674-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXG Analog MIPI-DSI PHY also provides functions to the PCIe PHY,
thus we need to have inclusive support for both interfaces at runtime.

This fixes the regmap get from parent node, removes cell param
to select a mode and implement runtime configuration & power on/off
for both functions since they are not exclusive.

Neil Armstrong (3):
  dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove reg
    attribute
  dt-bindings: phy: amlogic,meson-axg-mipi-pcie-analog: remove phy cell
    parameter
  phy: amlogic: phy-meson-axg-mipi-pcie-analog: add support for MIPI DSI
    analog

 .../amlogic,meson-axg-mipi-pcie-analog.yaml   |   8 +-
 drivers/phy/amlogic/Kconfig                   |   1 +
 .../amlogic/phy-meson-axg-mipi-pcie-analog.c  | 204 ++++++++++++------
 3 files changed, 138 insertions(+), 75 deletions(-)

-- 
2.22.0

