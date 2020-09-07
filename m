Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1704B2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aINm/ndw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIGH1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgIGH1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:27:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDCC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:27:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so14588987wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO7kAaRIuc46KRi9qBhr94GTCP962q4RtdWLGTT2ldc=;
        b=aINm/ndw6Q2v7K4daYMViqWrKNS4SVsN1hg9nnxrFtKN7eZsn+kgp7je6OnA3lzVhq
         FDJ6FVTd0AZ8Y8z6a6ZBKHywenH151zGeteRjz7preM32Q0f3HxbkX2eaI5gvd8egECv
         VI9tysGsymzvf/CV0TRbX0nU4iAPpMhIIiFB+MyzLtsLS0c1kpg596lqJY3cngWM/9mD
         9LBSLgzw9VSCqV7mU9ZHSIRQ5NAnXQYV+Ugeu8ispkUCh3s1W67rb+Lo15ywfZ9Cplae
         MGAtuVYZuX+bFkNRe6FPq6sE/WUDmjbrDCWHF+1yC+XbqSGJQHoVJq3+UOgzsJdx9//I
         KP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RO7kAaRIuc46KRi9qBhr94GTCP962q4RtdWLGTT2ldc=;
        b=Ygd9JjbQj2CmMNCHwFVfcUmmP2UwFFEuoDhx5xVHQ4q/0Kb6wa8+oe6oeZZZCjaKSl
         +QycYkCHTEvabbI/F6gzkdhjv1fbgRl0+WYP20iJfvk5PqlPE4BG9ub/dqkprDSLJ0bo
         r49ujZ7bi8IZVa5TvutIxDZJPfJYIOp29VeUQPu0QXihw1MKt8OzZIkhoqSIgNKRXpg3
         FaZZR5zmhNiVfy2ZfXm8DDENxv5GuBuYOw2Kp8n1gqkGbQDd8l6l1y1PPXS7bWxxDnj/
         /ZtfP8rbVo3dRT7fQRdp1OKgBwHaLNHKiUDMK0P1qtYPvCLFR++Lr1DGOptQXVtdLHBa
         IXGQ==
X-Gm-Message-State: AOAM530opdf0CSb7OVgUUjdE/wsX5QOd30J/ibPgLy680y5YuBvxN00z
        Xkqjw5/aXYhwwrQjrFKgxB5ec1jubT4lqSgc
X-Google-Smtp-Source: ABdhPJydTgThvxg9PYNz0DaNMNjsl7DBRwxNwVmrkNpMs92cEhZdX/WVCy5LcrpstvtxwJ2OqQnIBA==
X-Received: by 2002:adf:c182:: with SMTP id x2mr20086098wre.400.1599463632925;
        Mon, 07 Sep 2020 00:27:12 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id x16sm25560500wrq.62.2020.09.07.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:27:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] phy: amlogic: Add support for AXG MIPI D-PHY
Date:   Mon,  7 Sep 2020 09:27:06 +0200
Message-Id: <20200907072708.26043-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXg SoCs embeds a MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This D-PHY depends on a separate analog PHY.

Neil Armstrong (2):
  dt-bindings: phy: add Amlogic AXG MIPI D-PHY bindings
  phy: amlogic: Add AXG MIPI D-PHY driver

 .../bindings/phy/amlogic,axg-mipi-dphy.yaml   |  68 +++
 drivers/phy/amlogic/Kconfig                   |  12 +
 drivers/phy/amlogic/Makefile                  |   1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c | 413 ++++++++++++++++++
 4 files changed, 494 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c

-- 
2.22.0

