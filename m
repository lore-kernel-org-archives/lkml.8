Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D298FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A511820702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DjjLcbwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgF2DTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:19:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E520C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 35so6548571ple.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MX1npRs6E1BJMvrT9omJsOQIQGUgSUPJQrW7wHX73nA=;
        b=DjjLcbwY5BLsHDucAiJGHAt3gNsHaOg6PiLoaWZxOGruFvSbZQF4RW1hATXG1HnaWO
         pcZRJWshtmAxSLaRi/JtjxHj7PxLej/B40u2BarfoutSjccAyDxw2hcUwpex99gqqQb2
         9O3yqMDejj0DMYOFaiMYErhmu/2Fez6uwhyw8wgwxXrcc1yRNEkmuc8yM1x5s63g+AiZ
         enfWSmp4cHLHLk6qJkgylXKWsIYPPMmEsWXpb0kiUrlFJ7M5Cf/meUzPO5Kim1q1/NrW
         AQSaf1wD/krSAdzXwK7sbRUfAlua4GNPn5T1oGK4hVGstQcy3UrdJk7pyl0BaJ07C+f1
         ss4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MX1npRs6E1BJMvrT9omJsOQIQGUgSUPJQrW7wHX73nA=;
        b=Lvy3PvJc5WCfxiP0ZUX7jOhHWRKezj7l4m5k+qUvETHpd9DSzYlISTlPrtz92zfLfB
         89TIYd0X+Y7dxRt1HkGFF3Qu4zxKOxH0uqXS+MrZW4r7pV4ea+BavmulcHM2Xu7uq6Km
         c37S5hwVu7OUBd/bilTF7fD0e3k8Khv4fsrqIM/PKCzN/U2VHierRX+KkyQrnmM0xAXT
         vGAs0vOkWAjKCxkDhz1o80rFh1ixUotTrcYwDXkDy0NjwQ23V1Hd3qKXpZck5MLJEXzr
         3rJyBexXXg/ZCCDi/oN4stgkHAy8yYZu+9OCXcOMNlHoyYYpH3KZr40XY7VtHHd40arC
         35aA==
X-Gm-Message-State: AOAM532UPOGmV0mnd2syltXcKImGo5MfesKGetnTtJ+dtjxNUnzhbFLg
        0vKyv7cBTRtWbCOAKEC3GAB6XQ==
X-Google-Smtp-Source: ABdhPJwMpumCfd5Jtkmq2Tt8wb0YP3wqWSpHA4kY8SYSv0AOtdrJJ+gRAkE7qay+ZlKDrO56B2TLPA==
X-Received: by 2002:a17:90a:20ad:: with SMTP id f42mr5130595pjg.96.1593400760594;
        Sun, 28 Jun 2020 20:19:20 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j70sm12876254pfd.208.2020.06.28.20.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 20:19:20 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 0/6] Support raw event and DT for perf on RISC-V
Date:   Mon, 29 Jun 2020 11:19:09 +0800
Message-Id: <cover.1593397455.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds raw event support on RISC-V. In addition, we
introduce the DT mechanism to make our perf more generic and common.

Currently, we set the hardware events by writing the mhpmeventN CSRs, it
would raise an illegal instruction exception and trap into m-mode to
emulate event selector CSRs access. It doesn't make sense because we
shouldn't write the m-mode CSRs in s-mode. Ideally, we should set event
selector through standard SBI call or the shadow CSRs of s-mode. We have
prepared a proposal of a new SBI extension, called "PMU SBI extension",
but we also discussing the feasibility of accessing these PMU CSRs on
s-mode at the same time, such as delegation mechanism, so I was
wondering if we could use SBI calls first and make the PMU SBI extension
as legacy when s-mode access mechanism is accepted by Foundation? or
keep the current situation to see what would happen in the future.

This patch set also introduces the DT mechanism, we don't want to add too
much platform-dependency code in perf like other architectures, so we
put the mapping of generic hardware events to DT, then we can easy to
transfer generic hardware events to vendor's own hardware events without
any platfrom-dependency stuff in our perf.

Zong Li (6):
  dt-bindings: riscv: Add YAML documentation for PMU
  riscv: dts: sifive: Add DT support for PMU
  riscv: add definition of hpmcounter CSRs
  riscv: perf: Add raw event support
  riscv: perf: introduce DT mechanism
  riscv: remove PMU menu of Kconfig

 .../devicetree/bindings/riscv/pmu.yaml        |  59 +++
 arch/riscv/Kconfig                            |  13 -
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |  13 +
 arch/riscv/include/asm/csr.h                  |  58 +++
 arch/riscv/include/asm/perf_event.h           | 100 ++--
 arch/riscv/kernel/Makefile                    |   2 +-
 arch/riscv/kernel/perf_event.c                | 471 +++++++++++-------
 7 files changed, 471 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml

-- 
2.27.0

