Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07ABC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACFB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omQFDvmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCJTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:49:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41937 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCJTtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:49:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so5853696plr.8;
        Tue, 10 Mar 2020 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV1J0A0v5kI8D38QP7LZPmQe7Wa000FUtKtwbl8DovA=;
        b=omQFDvmGHKXBdHPsEv5IagMxub/5iBhsEZmDaDrMaDmj83PBhBnWKghEHz1xDxVE/9
         Qjv2aylL4IGJ68Vl7le/MblWPzJjGKCp3aXlLvHEMRVhZ46N73odzodpu6FpNAZv/Eck
         PWZwGHXw1oX4PvVurLKthhe6L11KOstjo6vhjvntDQ+8Gvifd30uLLebpxa3Xu6LIF00
         v6QEmjiLzkmfsaF+H8/+rrXtk9evm0g+0REDRbi2n8sMiayFE0k1YBnxCjz/4DZrjcsv
         RbqS7ZddV8FUWKdJ/oFptjHk/VWRq8Lc3NVksZMv2fYCYNqf7OSAzMva6m/hpYKwwF7O
         LfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jV1J0A0v5kI8D38QP7LZPmQe7Wa000FUtKtwbl8DovA=;
        b=Kc8byvatzN6+6/xGaHPslJ1GiS9/BFeZbhEj6/udPO2aHz3rjU9V5kGsFqbmcZqdrn
         89voG0S7O8nEr8cdFaU6MOsfXWJKcTI1IJcrJVswghRz6+wJMs+LjsJkyXTZHjzOCoYy
         p/RIr3JzKL7lLF3SRXEiQw4KPwVmUBDrqSh3fAuaLXDP9S4NoIdkKicfH2GMW4kJnmLF
         SAjnOIyyIpamtAKlS72KIYLlRdlhBI91NCZvTfI8W26Iynp73ZtbX52AM9kn/3zw5t0k
         pSGeJOSskFGN1TnTj9NhaoY/7yZWiOs2bV2eX7qWMVIWQK1eYDEBhogf4bFldpdZVIqo
         2uWQ==
X-Gm-Message-State: ANhLgQ3r4YH4in1WvgrsvYBZlZ3OM9jXh9RSpzVglSoBRUZoJFsvVO9f
        QVJhokpzt0+CzpnTRz0qnvASS0wO
X-Google-Smtp-Source: ADFU+vtvXRamWjX5o9KmUQeFzpOaqpVccOT2iNJrsaFhgH3WFG/4Ot9KKwImz4WPKGmca+i1AEEBjw==
X-Received: by 2002:a17:90a:2ec7:: with SMTP id h7mr3449555pjs.107.1583869749046;
        Tue, 10 Mar 2020 12:49:09 -0700 (PDT)
Received: from localhost.localdomain ([45.114.62.228])
        by smtp.gmail.com with ESMTPSA id d19sm3784490pfd.82.2020.03.10.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:49:08 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCHv3 0/5] Add support for FSYS power domain and enable suspend clk for Exynos542x SoC 
Date:   Tue, 10 Mar 2020 19:48:49 +0000
Message-Id: <20200310194854.831-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series build and tested on linux next-20200306.

This patch series tries to enable FSYS power domain
for USBDRD3, PDMA and USB2.0 devices.
Some new patches is added to enable this feature.

Summary: 
# powerdebug -d
...

FSYS:
current_state: on
active_time: 236786 ms
total_idle_time: 1914 ms
Idle States:
             State            Time
             S0               1914
Devices:
         /devices/platform/soc/10010000.clock-controller/exynos5-subcmu.6.auto
         /devices/platform/soc/12130000.phy
         /devices/platform/soc/12100000.phy
         /devices/platform/soc/12500000.phy
         /devices/platform/soc/soc:amba/121a0000.pdma
         /devices/platform/soc/soc:amba/121b0000.pdma
         /devices/platform/soc/12110000.usb
         /devices/platform/soc/12120000.usb
         /devices/platform/soc/soc:usb3-0
         /devices/platform/soc/soc:usb3-1

This patch series tries to enable suspend clk using
exynos dwc3 driver, for this I have added new
compatible string "samsung,exynos5420-dwusb3"
so that we could add new suspend clk in addition
to the core clk. exynos dwc3 driver will help
enable/disable these clk.

This series PatchV2.
--Added the clk names for exynos5420 compatible.
--Added missing support for Exyno5410 SoC suspend clock.
--Update the commit message to support suspend clk usages.

---
Long time ago I tried to add suspend clk for dwc3 phy
which was wrong appoch, see below.

[0] https://lore.kernel.org/patchwork/patch/837635/
[1] https://lore.kernel.org/patchwork/patch/837636/

Previous changes V3 (It was send with wrong Patch version)
[2] https://patchwork.kernel.org/cover/11373043/

-Anand

Anand Moon (5):
  devicetree: bindings: exynos: Add new compatible for Exynos5420 dwc3
    clocks support
  ARM: dts: exynos: Add missing usbdrd3 suspend clk
  ARM: dts: exynos: Add FSYS power domain to Exynos542x USB nodes
  usb: dwc3: exynos: Add support for Exynos5422 suspend clk
  clk: samsung: exynos542x: Move FSYS subsystem clocks to its sub-CMU

 .../devicetree/bindings/usb/exynos-usb.txt    |  5 ++-
 arch/arm/boot/dts/exynos5410.dtsi             |  8 ++--
 arch/arm/boot/dts/exynos5420.dtsi             | 24 ++++++++--
 arch/arm/boot/dts/exynos54xx.dtsi             |  4 +-
 drivers/clk/samsung/clk-exynos5420.c          | 45 ++++++++++++++-----
 drivers/usb/dwc3/dwc3-exynos.c                |  9 ++++
 6 files changed, 73 insertions(+), 22 deletions(-)

-- 
2.25.1

