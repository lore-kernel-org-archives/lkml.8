Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BA0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D80B206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od5TnW0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgDCUWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:22:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39873 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:22:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id e9so9112939wme.4;
        Fri, 03 Apr 2020 13:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBk8iLmWQH2Q1E3LPZMZsmnW3Pw4Pve//DMaP+9GRcw=;
        b=Od5TnW0JX69JZejRiSOQThcew53V/qQb6Bmp6Vc+2d9xpKE2425nPNWuX88VYBUfZ+
         qF2XxHpkbaakJQuCqAsUOlkMvgaBc44RqeuD699hg/i9hgXmwam3uvyQFXk17RHPmdmB
         GpXFfwbg/7Q7iaGkxBxhlZG/SXan1awKaIqdUcAIbnE/FTScJGstz9CjLNP5LoNA0bKi
         g6l9Ilx5E5Dz1tE1mhFjItCWZJibjJVkKGYVijQnuUyFO7o5qBZB8QCuzpxXyw7aG3j7
         IeF5lamSzViZWOz7go6RH9vELnnjuxlI8JswhF1upoupVYxR3F0FNGiT4hsV+dxmXEFc
         VkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yBk8iLmWQH2Q1E3LPZMZsmnW3Pw4Pve//DMaP+9GRcw=;
        b=OTCdUobJgKsIBceLJ2DzoynkJKymPO/ON+jRaM28jM0mJoMcBxLydWVfAoJztaHcqK
         VlNBOSb18Cpv8jjggyTZ0qwfYETFRDosFbGxHLyd6vWdMlJyn9N59vomymioSxgzYnLS
         zCPrT/0wnRIdRtHJ1g0evzGpP6NVxPyafLMZH+gebPpp0cwGJbQwL9fzymmWzTdjLqMf
         lmvfDWPo6Qfj3yNTr0oE0t6tBSjYLyYCUtFMdahbYLFD/LrD3ZKfZ/HuLNd6GG3O+vd4
         mr5UJ/inM6vJpTL7k9dUTRXvcjpZm2nvZ/Aj8DzurHN0TsnKQDtn7ULciZ/zHS0AEvOQ
         ilMA==
X-Gm-Message-State: AGi0PuYH++d/OFAYMzU7DkTixLElO+X65ZEkAPYcs0YLnHHd3TntR8lw
        zAXJc6FRWh1hDNx57LVyPwk=
X-Google-Smtp-Source: APiQypJFOCUi4tKAeio05/zqLHzv/WlrXWSL+xY0XP5qgkzVVDY4z9ITgTTBC8omEPQy6x01r07Qwg==
X-Received: by 2002:a1c:2489:: with SMTP id k131mr10731983wmk.86.1585945336217;
        Fri, 03 Apr 2020 13:22:16 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id n7sm12843237wmf.4.2020.04.03.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:22:15 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] clocksource: Add NVIDIA Tegra186 timers support
Date:   Fri,  3 Apr 2020 22:22:02 +0200
Message-Id: <20200403202209.299823-1-thierry.reding@gmail.com>
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
itself currently only exposes a couple of clock sources and a
watchdog, which in turn relies on the counter provided by one of
the timers. The timers themselves are not used at the moment because
the SoC also has an architected timer and there's currently no use
for the additional timers provided by this hardware block.

I suggest that patches 1 & 2 go through the clocksource tree, while
I can carry the DTS changes in the Tegra tree for v5.8.

Changes in v3:
- request IRQ at the end of ->probe() to avoid potential race condition
- only enable/disable watchdog when it's active
- use _relaxed variants of register accessors
- drop unneeded tegra186_timer.irq field

Changes in v2:
- address review comments on the bindings
- make the driver buildable as a module
- support various clock sources

Thierry

Thierry Reding (7):
  dt-bindings: timer: Add bindings for NVIDIA Tegra186 timers
  clocksource: Add Tegra186 timers support
  arm64: tegra: Order nodes by unit-address on Tegra194
  arm64: tegra: Add native timer support on Tegra186
  arm64: tegra: Enable native timers on Jetson TX2
  arm64: tegra: Add native timer support on Tegra194
  arm64: tegra: Enable native timers on Jetson AGX Xavier

 .../bindings/timer/nvidia,tegra186-timer.yaml |  61 +++
 .../arm64/boot/dts/nvidia/tegra186-p3310.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  16 +
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  81 +--
 drivers/clocksource/Kconfig                   |   8 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-tegra186.c          | 508 ++++++++++++++++++
 8 files changed, 651 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.24.1

