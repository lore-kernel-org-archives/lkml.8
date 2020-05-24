Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83693C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638C12076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="dYUpyeZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbgEXVGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 17:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387848AbgEXVGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 17:06:22 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D4BC08C5C1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:21 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e16so6671047qtg.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33GqBqRR2Gx5o9WCKvD5zP6xFK/J0f9ce+9hLTx+wyU=;
        b=dYUpyeZ88WeTWem/FswXsS44lrLQiybUFroMePC5CksOBACVAc+AP08HWM0w7Pb7Ac
         F0NoPLjN8bl8FC/TOlPXgTDCHIwz9ScxlWhB+CCPJnvHPGin2bMTIy4i0dFKet5Uea+I
         Ftpgtp3RfC4VlgKd07iaGfRxJQlavPnhVAETIyqC3PDPlQa3J/cWM70oWOXfKfWWjQrd
         8mzF01SO6Lcs9PufgS4krp4OOJtNL/Etl+uokDY8imEP8PtmHaBekkQ6nLyEuIbpSq4u
         /BM8C6gDx+6Mh7POr+o8fX9mWZ9Z+Hj0udzDuFnmZmicTN8UQx/A2Gy1I2bhd0IlZmk9
         ZA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33GqBqRR2Gx5o9WCKvD5zP6xFK/J0f9ce+9hLTx+wyU=;
        b=G+26GBZOI/E9A69viPzoHplOETYMnhXQCVUsiEznrcZTHsad0koJD0wx9AwxsNf24D
         Fk5JSf9ztv4TrqpnxErrEpNe8XVcSpgBbViPGFkOL7RyNCmRkpqM0LZwDfHtDW4+QS7a
         801iWo42wuhasdZlLmRU0HAtj6zoLbxxNOZKAa65C+q5gf/HcygYlR6Sq0dSUNtuHQac
         cMwCkE1URCSKYrE6mjd60c15ANrV+Bbvtknvq40GNwC8b+6f8FoMzGz5d5TcP4xSrqSV
         5B4HStkkdvJkpWEmcMgB6bveBrksFJF3KT3AscZ2w5qbCdJdhL+ONF+cnmHIYrNs5kgb
         /Blg==
X-Gm-Message-State: AOAM531MIUHIYfsw1e+4pssoV7oV5fiEDcH/Y5b513Noii+4wTxXJ+jj
        wVGppG2WTMR5U8fiN7Ywhw2u9g==
X-Google-Smtp-Source: ABdhPJwI1QyBwhsjxuoHpJ6tCXkyyAyYdQsPyhYI0RaCc5ILD7mHRyhYvqVq1nEthHB/cp/9qysgug==
X-Received: by 2002:aed:2452:: with SMTP id s18mr11569062qtc.137.1590354379884;
        Sun, 24 May 2020 14:06:19 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g51sm4401769qtb.69.2020.05.24.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 14:06:19 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 00/10] Enable GPU for SM8150 and SM8250
Date:   Sun, 24 May 2020 17:06:01 -0400
Message-Id: <20200524210615.17035-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the missing clock drivers and dts nodes to enable
the GPU on both SM8150 and SM8250.

Adreno 640/650 support was recently added to drm/msm [1], but an
extra patch [2] is still required for GPU to actually work on SM8250.

[1] https://patchwork.freedesktop.org/series/76198/
[2] https://gist.github.com/flto/784f1aca761ebf2fe6c105719a4a04ca

Jonathan Marek (10):
  clk: qcom: clk-alpha-pll: remove unused/incorrect PLL_CAL_VAL
  clk: qcom: clk-alpha-pll: same regs and ops for trion and lucid
  clk: qcom: clk-alpha-pll: use the right PCAL_DONE value for lucid pll
  clk: qcom: gcc: remove unnecessary vco_table from SM8150
  dt-bindings: clock: Introduce SM8150 QCOM Graphics clock bindings
  dt-bindings: clock: Introduce SM8250 QCOM Graphics clock bindings
  clk: qcom: Add graphics clock controller driver for SM8150
  clk: qcom: Add graphics clock controller driver for SM8250
  arm64: dts: qcom: add sm8150 GPU nodes
  arm64: dts: qcom: add sm8250 GPU nodes

 arch/arm64/boot/dts/qcom/sm8150.dtsi          | 132 +++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 139 ++++++
 drivers/clk/qcom/Kconfig                      |  16 +
 drivers/clk/qcom/Makefile                     |   2 +
 drivers/clk/qcom/clk-alpha-pll.c              |  70 ++-
 drivers/clk/qcom/clk-alpha-pll.h              |  15 +-
 drivers/clk/qcom/gcc-sm8150.c                 |  18 +-
 drivers/clk/qcom/gpucc-sm8150.c               | 429 ++++++++++++++++
 drivers/clk/qcom/gpucc-sm8250.c               | 458 ++++++++++++++++++
 include/dt-bindings/clock/qcom,gpucc-sm8150.h |  40 ++
 include/dt-bindings/clock/qcom,gpucc-sm8250.h |  40 ++
 11 files changed, 1304 insertions(+), 55 deletions(-)
 create mode 100644 drivers/clk/qcom/gpucc-sm8150.c
 create mode 100644 drivers/clk/qcom/gpucc-sm8250.c
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8250.h

-- 
2.26.1

