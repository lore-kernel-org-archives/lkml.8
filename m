Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9CC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD4C20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA2l3Ah+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgCaWTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:19:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42734 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:19:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so28135173wrx.9;
        Tue, 31 Mar 2020 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hv5w97MVc2OxbT4cCnlK/0UNfmgvgpT5Fhi8G4KpGY=;
        b=vA2l3Ah+jvHWpWZFORoCZ8hzYl0jI51cpTQrB/z4rSF+t79wy0itoCLNNIaNE0FVW8
         xAoWkV6tkLOhQXn9m7bZfSPi3nVwzAoVKs6mL/OIWxvpcoNyYiHeBPyH1usc+l4DAWQO
         fzL8Sj52TceXiMR/y0JynuqQ2J09CdN81aXMpryRKsbjrpxnOhp7h8A2+pcvkul01M/g
         GvAL7cWQaYRshTBHmKnnq9rJaBgnDnnul1I58W/DS3j9Tt56InJx1mi9UWpOq9l8n8Sr
         GIldz1r7aI+NZcMSApJdShy8ZJHw5cOEGwMe6QsVXcY77K/6Wc1YV/59K2m1+3yuV9sd
         tISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+hv5w97MVc2OxbT4cCnlK/0UNfmgvgpT5Fhi8G4KpGY=;
        b=q3V4KjKkVX0abNxVhIXVEGHMRdv5Ap7aMVpIA20Nn6fYPZLwT9nKo9svzGl2UNjgxY
         iEDdvuxN7Xb5HHciLU2JitlI0trdjEYp6glN/CFyTmsvyS1vu6Q7wOVoxBTetDKdxx6o
         dN5huyYwdGtQ3BXU813H17EpSn4rqtkEx+ZmyZTHu8fpU9RvhUeWKFZxDIks8AoAkzL+
         LJZXzG973wPrsdbbqz9MgU8eiqpeLW0UlyKruIfcw3olTrVdrQl5mxdosPBaBDM3F9YA
         h+NDDItxq6msJULodjRZENUBX4NOtrNc3vo0rExeXxgywLJBH/7DqgHvu88CH5kt4O5r
         WX1A==
X-Gm-Message-State: ANhLgQ3p4GRmaIs4bkh9JbX8acvinHqfTtKUJVFZwg7HktetMPq4V8y7
        ZHD8eJmtmInztoIU5eKYPVo=
X-Google-Smtp-Source: ADFU+vsIvkV49QVqdU9afjo6Mrv40hT+u2GGh099fQrGkcB8oJJptB7eCc+5YbOoSn6AbQFQR5b+jg==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr22221588wru.325.1585693162868;
        Tue, 31 Mar 2020 15:19:22 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id y15sm171337wrh.50.2020.03.31.15.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 15:19:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] clocksource: Add NVIDIA Tegra186 timers support
Date:   Wed,  1 Apr 2020 00:19:07 +0200
Message-Id: <20200331221914.2966407-1-thierry.reding@gmail.com>
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
 drivers/clocksource/timer-tegra186.c          | 505 ++++++++++++++++++
 8 files changed, 648 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
 create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
2.24.1

