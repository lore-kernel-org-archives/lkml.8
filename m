Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A1FC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C8D2465B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="OqaDX8gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBHLUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:20:40 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37592 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:20:39 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so847044plz.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tqOCfGmc24SMcvo9QfZYNC/dA0GyzzcRlwuea8hRFMw=;
        b=OqaDX8gDNZL7bzywbFeSnDV+PtO4S7hYYKnuWVX/uraVfLte8jworWXCZhFgRjQZnS
         f3wzGbRcbYAI4v8++onBGyVQkPK5u0xyaNeomOSQj7NOgK+1XldDxEfmuuKb75CrmuSc
         XOxN5VP7uUAiHc3CnXwdO7nNesP6JAOe+pV0k1F7KMXlrv00z/0FULCKj4JVkRmfvF3a
         tMrnnIxermPR29FRF1skIUgjkIyI4v2MnnMnHfnQAUT+XHhZ7JXw7B+x3lrWexVq1XTT
         myGJz2SItmq9CSLKPsaydYQ89j+LJQVzRipoTybRJ7tvlkNk9v9A2aPnOrwZzvIKEbOJ
         tuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tqOCfGmc24SMcvo9QfZYNC/dA0GyzzcRlwuea8hRFMw=;
        b=nHdD4vhXpj5E+RbIBDs3W8lSDLsbmrTGDfKFdxI3qStyTkKqEPBRLmYn5XN09HgCP4
         j5++GjEqaYSvAiz0MHj1CdGMSPZ9eLckAoWUV8x5Fa42iH2ceFmgk8T0xYCEMPBPrYf4
         oC3RA2iAEOKB7HnUs+UYhzDoZej4NoZMiI93f0OjOmh7H2un+0Pds0I0W0E0Ztie1H9g
         H+bqZ+N7U8YKQV3PDKLKxpyUJkqKrBDBWlA77Ma4dASt19QkMmSZb7JTKPqA+O5Zwmu3
         bfftV/zOeQa7h8lAn6VVWikJoTfUK9am42mOKM4rZg65lSJve75374MMHhgDF00yYBAo
         6vlA==
X-Gm-Message-State: APjAAAX5yeHj3XxGgN4Yf0VNM5QnI+y3m9Jyu6j21XPyZZXZipZqDYfF
        2oN/Rs3VNUaYPG8ZD/mx2eUN0A==
X-Google-Smtp-Source: APXvYqxe8hGUD4x10nmC2TNmnq+AB1g80fNxoA/xjcTn+r5/Z1yD2tbxM/klYVLPrsGHEtyLqNm3Ww==
X-Received: by 2002:a17:90a:7342:: with SMTP id j2mr9363054pjs.92.1581160837356;
        Sat, 08 Feb 2020 03:20:37 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm5707281pju.11.2020.02.08.03.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:20:36 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/5] ARM: SoC-related driver updates
Date:   Sat,  8 Feb 2020 03:20:16 -0800
Message-Id: <20200208112018.29819-4-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208112018.29819-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various driver updates for platforms:

- Nvidia: Fuse support for Tegra194, continued memory controller pieces
for Tegra30

- NXP/FSL: Refactorings of QuickEngine drivers to support ARM/ARM64/PPC

- NXP/FSL: i.MX8MP SoC driver pieces

- TI Keystone: ring accelerator driver

- Qualcomm: SCM driver cleanup/refactoring + support for new SoCs.

- Xilinx ZynqMP: feature checking interface for firmware. Mailbox
communication for power management

- Overall support patch set for cpuidle on more complex hierarchies
(PSCI-based)

+ Misc cleanups, refactorings of Marvell, TI, other platforms.



Conflicts:

drivers/soc/tegra/fuse/tegra-apbmisc.c:

This branch has one conflict due to ioremap_nocache() removal touching
same lines as some error path fixes for tegra.  Keep the ioremap()
version of the call, but the rest from this side.

----------------------------------------------------------------

The following changes since commit a1a0cfaf7fb7c1a90201e6b0937f742c8c212d8e:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-drivers

for you to fetch changes up to 88b4750151a2739761bb1af7fedeae1ff5d9aed9:

  Merge tag 'zynqmp-soc-for-v5.6' of https://github.com/Xilinx/linux-xlnx into arm/drivers

----------------------------------------------------------------


 arch/arm/boot/dts/am33xx.dtsi                   |  25 ++
 arch/arm/boot/dts/am4372.dtsi                   |  20 +
 arch/arm/boot/dts/am437x-sk-evm.dts             |  27 +-
 arch/arm/boot/dts/am43x-epos-evm.dts            |  23 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi            |  54 +++
 arch/arm/boot/dts/dra7-l4.dtsi                  |  71 +++-
 arch/arm/boot/dts/dra7.dtsi                     |  18 +
 arch/arm/boot/dts/dra72-evm-common.dtsi         |  31 ++
 arch/arm/boot/dts/dra72x.dtsi                   |  42 ++
 arch/arm/boot/dts/dra76-evm.dts                 |  35 ++
 arch/arm/boot/dts/dra76x.dtsi                   |  42 ++
 arch/arm/boot/dts/dra7xx-clocks.dtsi            |  32 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi  |   5 +-
 arch/arm/boot/dts/motorola-mapphone-common.dtsi |  19 +
 arch/arm/boot/dts/omap4-l4.dtsi                 |  49 ++-
 arch/arm/boot/dts/omap4.dtsi                    | 110 +++--
 arch/arm/boot/dts/omap44xx-clocks.dtsi          |  11 +-
 arch/arm/boot/dts/omap5-l4.dtsi                 |  20 +-
 arch/arm/boot/dts/omap54xx-clocks.dtsi          |  10 +-
 arch/arm/mach-davinci/Makefile                  |   3 +-
 arch/arm/mach-davinci/board-dm365-evm.c         |  20 +
 arch/arm/mach-davinci/board-dm644x-evm.c        |  20 +
 arch/arm/mach-davinci/devices-da8xx.c           |   1 -
 arch/arm/mach-davinci/devices.c                 |  19 -
 arch/arm/mach-davinci/dm365.c                   |  22 +-
 arch/arm/mach-davinci/include/mach/common.h     |  17 -
 arch/arm/mach-davinci/include/mach/time.h       |  33 --
 arch/arm/mach-davinci/time.c                    | 400 -------------------
 arch/arm/mach-omap2/clockdomains7xx_data.c      |   2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      | 135 -------
 drivers/clk/ti/clk-44xx.c                       |  13 +
 drivers/clk/ti/clk-54xx.c                       |  13 +
 drivers/clocksource/timer-davinci.c             |   8 +-
 include/dt-bindings/clock/omap4.h               |  11 +
 include/dt-bindings/clock/omap5.h               |  11 +
 35 files changed, 697 insertions(+), 675 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
