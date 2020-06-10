Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF34B20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O3FQn37F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgFJIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgFJIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:30:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC5C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so1203346wru.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qPvfAK/wIPUWfgqcjzBx41M5rLQsIgGSEZcayEYX00=;
        b=O3FQn37Fw3dtMfw8SHlpmRruARSNx8N74Lbw/4/ptHL+LNio0fm7wjTBotWaYwVSz3
         4oy5ByC/54ljbNGuRvxSQNrTfw3cuisPIm0I2GNYTq7axQGCBJ8QwslTPzkl3L4ShVwF
         Hy18ra+U8NdU8JWLBzIw8eWkcUbSN1xPE7YE/k4O3Ai2zCyhUxV2zWAqrLUXOnUbW3i8
         injhSJjF2Urlm2O5UWnm/gGdjh2zTYMWNOfWd5XiYFvHzABBqVz6NwxmxM4XizSyWF1e
         VOJoZzZys/yzUtovAowiySYbNi4lPeC7viiqLivn8zYAY7Yo4WEzGgugorTaD1aqpcoW
         NuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7qPvfAK/wIPUWfgqcjzBx41M5rLQsIgGSEZcayEYX00=;
        b=bhOQwynAwTYS21bCmZiihO6Irav5uDWHFA8hIQkBgxIk08i+hWOZ70aTGygyjAJwLB
         OtYeUHWlmrW34JTh2iqh+pB+XKAGOi7Z9Nj1ICCZsrgLMRCVsm5cxpQmMXjgjXK+detu
         QcBc8KjDgWOvcT5AcPZo+8ZMeSigglmb4rL8gXDwhhE0N/RUSusa4lOD/LxDO4VcNAQC
         F7gDUQ9LCJJUfAojhAsOy6611no3vMBEg6iMwz3/ib6mvO2Yz/4rHS0jMRiEEuW8Docg
         kOi3HjHl48ls0jQYdoDNwNQY/qNH50Iv4Zk/SWph0Z0okq0DX4R05AYrtCw4phqgmS92
         Pwpg==
X-Gm-Message-State: AOAM531txJDdm6kpNRkIt2n8mVPo/nWPkggn8BIUMNIxqA1qvHK52HOf
        GVI6+96ScTTYIKHaezF93LPnew==
X-Google-Smtp-Source: ABdhPJxZayRZhbDG1jRiWiM/W4R2KNOE8PzRBwn1FswUR3YH+jLRTZo8j6B+3fmNEqqWXEDnTF+1Rg==
X-Received: by 2002:adf:93a3:: with SMTP id 32mr2321138wrp.344.1591777815512;
        Wed, 10 Jun 2020 01:30:15 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id u13sm6958974wrp.53.2020.06.10.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:30:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/2] clk: meson: g12a: Add the NNA source clocks
Date:   Wed, 10 Jun 2020 10:30:10 +0200
Message-Id: <20200610083012.5024-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the Neural Network Accelerator source clocks present
on the Amlogic SM1 SoCs family.

Dmitry Shmidt (2):
  dt-bindings: clk: g12a-clkc: Add NNA CLK Source clock IDs
  clk: meson: g12a: Add support for NNA CLK source clocks

 drivers/clk/meson/g12a.c              | 119 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |   7 +-
 include/dt-bindings/clock/g12a-clkc.h |   2 +
 3 files changed, 127 insertions(+), 1 deletion(-)

-- 
2.22.0

