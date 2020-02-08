Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F346C352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC092464B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="VmwHIX6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBHVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44241 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so1191589plo.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0QrHmOjBYJLOlZUdGvVzGtML1wpwP+3z7xpNTsntik=;
        b=VmwHIX6GsItbvy3Tl9geBJjCjF/zE5rSuZIlhZew8ypsJ1mZI9qceiFwxkNsW7nVy1
         soC49iJQv4S9p0FNL87V56d1g5DnAfTZ6p6bhcYj9i1MaPt2uRaRxLMU1/mYI/hNdilW
         tUpmozrjikTyQDN8gTUClfeIgjp5ooCCbcH+XRRuQ8DHVNnHnpX0bazp/i2uH045AuoV
         m/XL7yEmK/p5h0rQfDGfnc2fjsIYQ/TQcONE5D+TYIYqcPEqFojotDod8as7bt0aF5W+
         OzwOH5IkFOL7c8apBUtY+XLf4uuexL3uI2ibFrx61wBCsI3Il7irA344NQ3joBHkNVBv
         3mCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0QrHmOjBYJLOlZUdGvVzGtML1wpwP+3z7xpNTsntik=;
        b=TB77AnyDoy/VVUtytVhYAmUNlb9vwRSawt6rOIVgoi3QWaYZANPQ+BwuJUwcblphaM
         Sn5IO2QUF1IscSJHyG+eqze32y17bmAa8t254EGohpWYaEfASRGvFYyxYgTDuX2GHvrD
         xm5dJEswt1H+TZnzGZXgqFx9KPtudgj9I6kPtrYKx/kK91Vo1FC/K6SgzUIizd7n/buY
         maIaA0EeHE1KR102e0L4fFM6OWpdWs/jQNKAuL2fAlPpScW3AYON743EFL4jnCFdML+V
         6lyrF1SEb4AQBVn4NkiOZ5FWpc8vgPDTgfT4rs7j50gJx9MZRKA8AfsuniZkhMSTLfIj
         AP3w==
X-Gm-Message-State: APjAAAV8MTmTkFXZ1PXD98iyA/twCT8aKElpftn6/Zyg8aAmfguZdEkt
        RwyEZrSqLOhsmnl3gkp3RW7O3Q==
X-Google-Smtp-Source: APXvYqydTFB7oo5LE5PZVVdKSgl31mNPVX8/S+Mru+TEh2EBmy4WtfiTnHqOyFX2UgClcjekCJlPtA==
X-Received: by 2002:a17:902:bc89:: with SMTP id bb9mr5226103plb.162.1581197141112;
        Sat, 08 Feb 2020 13:25:41 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:39 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/5 v2] ARM: SoC platform updates
Date:   Sat,  8 Feb 2020 13:25:29 -0800
Message-Id: <20200208212533.30744-2-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208212533.30744-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208212533.30744-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of these are smaller fixes that have accrued, and some continued
cleanup of OMAP platforms towards shared frameworks.

One new SoC from Atmel/Microchip: sam9x60.

----------------------------------------------------------------

The following changes since commit f757165705e92db62f85a1ad287e9251d1f2cd82:

  Merge tag 'fuse-fixes-5.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

for you to fetch changes up to d8430df172118336d050aa61999fb82e55102641:

  Merge tag 'omap-for-v5.6/soc-build-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/soc

----------------------------------------------------------------

Andrew F. Davis (5):
      ARM: OMAP2+: Add omap_secure_init callback hook for secure initialization
      ARM: OMAP2+: Introduce check for OP-TEE in omap_secure_init()
      ARM: OMAP2+: Use ARM SMC Calling Convention when OP-TEE is available
      ARM: OMAP2+: sleep43xx: Call secure suspend/resume handlers
      ARM: OMAP2+: Fix undefined reference to omap_secure_init

Anson Huang (2):
      ARM: imx: Add i.MX7ULP SoC serial number support
      ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D

Arnd Bergmann (1):
      ARM: imx: only select ARM_ERRATA_814220 for ARMv7-A

Claudiu Beznea (9):
      ARM: at91: Kconfig: add sam9x60 pll config flag
      ARM: at91: Kconfig: add config flag for SAM9X60 SoC
      ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
      drivers: soc: atmel: move sam9x60 under its own config flag
      power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
      drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
      ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
      ARM: at91: pm: use SAM9X60 PMC's compatible
      ARM: at91: pm: use of_device_id array to find the proper shdwc node

Dave Gerlach (1):
      ARM: OMAP2+: am43xx: Add lcdc clockdomain

Florian Fainelli (1):
      ARM: bcm: Select ARM_AMBA for ARCH_BRCMSTB

Geert Uytterhoeven (2):
      ARM: exynos: Drop unneeded select of MIGHT_HAVE_CACHE_L2X0
      ARM: s3c64xx: Drop unneeded select of TIMER_OF

Justin Chen (1):
      ARM: brcmstb: Add debug UART entry for 7216

Krzysztof Kozlowski (2):
      ARM: exynos: Correct the help text for platform Kconfig option
      ARM: samsung: Rename Samsung and Exynos to lowercase

Nicolas Ferre (1):
      ARM: at91: Documentation: add sam9x60 product and datasheet

Olof Johansson (10):
      Merge tag 'omap-for-v5.6/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'arm-soc/for-5.6/soc' of https://github.com/Broadcom/stblinux into arm/soc
      Merge tag 'samsung-soc-5.6' of https://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'tegra-for-5.6-arm-core' of git://git.kernel.org/.../tegra/linux into arm/soc
      Merge tag 'imx-soc-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/soc
      Merge tag 'at91-5.6-soc' of git://git.kernel.org/.../at91/linux into arm/soc
      Merge tag 'omap-for-v5.6/soc-smc-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'zynq-soc-for-v5.6' of https://github.com/Xilinx/linux-xlnx into arm/soc
      Merge tag 'samsung-soc-5.6-2' of https://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'omap-for-v5.6/soc-build-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/soc

Quanyang Wang (1):
      ARM: zynq: use physical cpuid in zynq_slcr_cpu_stop/start

Stephen Warren (3):
      ARM: tegra: Enable PLLP bypass during Tegra124 LP1
      ARM: tegra: Modify reshift divider during LP1
      ARM: tegra: Use clk_m CPU on Tegra124 LP1 resume

Suman Anna (2):
      ARM: OMAP2+: Add workaround for DRA7 DSP MStandby errata i879
      ARM: OMAP2+: use separate IOMMU pdata to fix DRA7 IPU1 boot

Tero Kristo (3):
      ARM: OMAP2+: pdata-quirks: add PRM data for reset support
      ARM: OMAP4+: remove pdata quirks for omap4+ iommus
      ARM: OMAP2+: omap-iommu.c conversion to ti-sysc

Uwe Kleine-König (1):
      ARM: s3c24xx: Switch to atomic pwm API in rx1950


 Documentation/arm/microchip.rst                 |   6 +
 arch/arm/Kconfig.debug                          |   6 +-
 arch/arm/include/debug/brcmstb.S                |  24 ++--
 arch/arm/mach-at91/Kconfig                      |  24 +++-
 arch/arm/mach-at91/Makefile                     |   1 +
 arch/arm/mach-at91/at91sam9.c                   |  18 ---
 arch/arm/mach-at91/pm.c                         |  11 +-
 arch/arm/mach-at91/sam9x60.c                    |  34 +++++
 arch/arm/mach-bcm/Kconfig                       |   1 +
 arch/arm/mach-exynos/Kconfig                    |  37 +++---
 arch/arm/mach-exynos/common.h                   |   2 +-
 arch/arm/mach-exynos/exynos.c                   |   4 +-
 arch/arm/mach-exynos/include/mach/map.h         |   2 +-
 arch/arm/mach-exynos/pm.c                       |   2 +-
 arch/arm/mach-exynos/smc.h                      |   2 +-
 arch/arm/mach-exynos/suspend.c                  |   2 +-
 arch/arm/mach-imx/Kconfig                       |   2 +
 arch/arm/mach-imx/cpu.c                         |  30 ++++-
 arch/arm/mach-omap2/Makefile                    |   6 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c     |  10 ++
 arch/arm/mach-omap2/common.h                    |   2 +-
 arch/arm/mach-omap2/io.c                        |  11 ++
 arch/arm/mach-omap2/omap-iommu.c                | 128 ++++++++++++++++---
 arch/arm/mach-omap2/omap-secure.c               |  50 ++++++++
 arch/arm/mach-omap2/omap-secure.h               |  10 ++
 arch/arm/mach-omap2/omap-smc.S                  |   6 +-
 arch/arm/mach-omap2/pdata-quirks.c              |  43 +++++--
 arch/arm/mach-omap2/pm33xx-core.c               |  24 ++++
 arch/arm/mach-omap2/prcm43xx.h                  |   1 +
 arch/arm/mach-s3c24xx/Kconfig                   |  16 +--
 arch/arm/mach-s3c24xx/mach-rx1950.c             |  19 ++-
 arch/arm/mach-s3c64xx/Kconfig                   |   1 -
 arch/arm/mach-tegra/sleep-tegra30.S             |  30 ++++-
 arch/arm/mach-zynq/platsmp.c                    |   6 +-
 arch/arm/plat-samsung/adc.c                     |   2 +-
 arch/arm/plat-samsung/devs.c                    |   2 +-
 arch/arm/plat-samsung/gpio-samsung.c            |   2 +-
 .../plat-samsung/include/plat/samsung-time.h    |   2 +-
 drivers/power/reset/Kconfig                     |   4 +-
 drivers/soc/atmel/soc.c                         |   5 +-
 40 files changed, 457 insertions(+), 131 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam9x60.c
