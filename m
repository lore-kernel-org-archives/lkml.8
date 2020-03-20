Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B74C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED642076E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWGeFwmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCTNfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:35:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39238 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgCTNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:35:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id a9so3294480wmj.4;
        Fri, 20 Mar 2020 06:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JpJJSqOukJOsKyLepaL4D5XEBOAfU/5gRiIWf5kS00=;
        b=tWGeFwmmIfUGURV+x3JrUHC86CPH3NKeEMGtTBdc1A+DfSPGGiNReYcmajZYH2+ich
         +5FN4V1HavYjJe7g70Mo0/wQdMFRnYyUqHY3vK4eBDouL6MaUSQ8ILr9kYng6csNvrz/
         eXoI7v0tVchMsHGPIEYKBYGSHXwi/Q0IcCWts2Cbop+HNb3dqDoFMEXV/onSubem831w
         60n35DBHpHZ4UCuLnMw5uqJwVHEk3wrZtg/cU3L6DVeBUbYkUOXVzJXCWFWZM2/HPIj7
         J/v8p+2RsKLur432nfDKmFskUJ669cNO0D4rZNP88PwAknyTXSE87Y109Ba6Weqonkex
         UHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8JpJJSqOukJOsKyLepaL4D5XEBOAfU/5gRiIWf5kS00=;
        b=Yu7vOhCc1aX0GwrexinJUCU8jS+5Nu8n1RhZ+klgdQIiMzzaGRPjh89tvHzK+Drbf1
         cj5YrDzVJ7yAwEDClTtAsGBjtyr9WB8lhiaNxYzlvd9UyjDeppN1YnGw+KjgZKM540c0
         +dnYs6BQ5LqMsZMvDhLCDqvfAl8R6yhRr/gkd9FkMn9VrQlBbRwW2oma8lkccwKcs61E
         ktY4v1s9ZEsN65/HmMeeRVO+Fdd+UFsncGA7rXjNy9of7zajpMQ6mb1grSipSG2AJKNT
         aDcqeS8yfhz7NuGBnFJ9TgU9A3XVha34ETXY4IqN5Pi2xN6nmGz9/uTWQdTnHGd6ig3X
         PKYw==
X-Gm-Message-State: ANhLgQ05Rm+ou6GlzoFo27JTOBPn0IgPO27M+EhEXx0qcIAx1INueu4b
        tFL7WjP2WGKi3B2qiLRXLuA=
X-Google-Smtp-Source: ADFU+vvxQI36QYAS6CSxU3UCX1Mn7P2lPSkCX4OJhmBOZ6ftFFU+w5JwEkI1uI+eqtNjWnQmquQ91w==
X-Received: by 2002:a1c:8193:: with SMTP id c141mr10045018wmd.14.1584711302435;
        Fri, 20 Mar 2020 06:35:02 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id w11sm8617964wrv.86.2020.03.20.06.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:35:01 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] clocksource: Add NVIDIA Tegra186 timers support
Date:   Fri, 20 Mar 2020 14:34:45 +0100
Message-Id: <20200320133452.3705040-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This set of patches adds the device tree bindings and a simplified
driver for the timers found on Tegra186 and later SoCs. The driver
itself currently only implements a single watchdog, which in turn
relies on the counter provided by one of the timers. The timers
themselves are not used at the moment because the SoC also has an
architected timer and there's currently no use for the additional
timers provided by this hardware block.

I suggest that patches 1 & 2 go through the clocksource tree, while
I can carry the DTS changes in the Tegra tree for v5.8.

Thierry

Thierry Reding (7):
  dt-bindings: timer: Add bindings for NVIDIA Tegra186 timers
  clocksource: Add Tegra186 timers support
  arm64: tegra: Order nodes by unit-address on Tegra194
  arm64: tegra: Add native timer support on Tegra186
  arm64: tegra: Enable native timers on Jetson TX2
  arm64: tegra: Add native timer support on Tegra194
  arm64: tegra: Enable native timers on Jetson AGX Xavier

 .../bindings/timer/nvidia,tegra186-timer.yaml |  55 +++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  16 +
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  81 ++--
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra186.c          | 377 ++++++++++++++++++
 8 files changed, 514 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.24.1

