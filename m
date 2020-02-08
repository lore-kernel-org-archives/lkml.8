Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2AC352A4
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DE622522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="hq8OE18U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBHVZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:49 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54197 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgBHVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:46 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so2457757pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9rGiKNqbXk3HaxSFA2diA4cQgh5i28qPpTMmO3QMZ0=;
        b=hq8OE18UXfWKxsT/m7DSNIZlvlNPcMPUMZXAlbCCOFPykaDOQkt+YapECDGDEvz4U+
         73JU5iUH7LNwDiUmHvuWrdUIxBTWmeuT9VXMBLqiI2W+X3+diDhMlsemE2lwsabDgrl+
         sUKTmI4pMUnmLGk+5ADSvB8jiowy7WPu9rCZW6MPP+5TXtU0zNCfEj3GO8LRaVFS/3L/
         t4K7n80TOhEzpu/Tl/KqpzMHwUA+SZq1yxIs0Dqe04OWhoZdO48V1uh/AXg/e6I/VOuR
         x+Yci5RdEdajbXNWUQy7XWecKutcPEAnHWLflv11+QSv2r9PXvmM9R5q3iL0ozBrqCy3
         MPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9rGiKNqbXk3HaxSFA2diA4cQgh5i28qPpTMmO3QMZ0=;
        b=K0uSaF6SFk4onn+DsrpYk1yjk6gTwOWDPt88bGdqKnMuyAk335Api8OFWgBK4rjhUz
         ABf3F00iBUgfECbuZowkWEmQ6iE1pI9jyuTHRvnYtmAr4gEzQpGMqskgSk3tCxne7WVr
         wqR6ygrO7f7nvu4FcHoxSYsdeepYTk2uMCSY2lH6o5fVYWu/RWCsmQRxNO7xodEtdQkP
         vuHA86ly5atLw7OTdOi5jHNromkmQkT7Q7B3gEbHZfBELzG64m59QzSSolfoMxtd1LeQ
         Ce9W9sMNmQ8g78DIF27qrckhJlpvFCAl3jxowjaik2pZBeun8LnRFnpAuu5ZLOTHCAiK
         MYtw==
X-Gm-Message-State: APjAAAW1DI0hA+gPQ4YijhmrxPuOQg+N/TM0nL0DEwZ4IlpZi+/FWWQl
        zYz3nmDUlRC2A2VrKYpAKGZ/lA==
X-Google-Smtp-Source: APXvYqyZLtGWZ4mVUaPT0p1RQaRYX2X49FyRlvtOmZInnaErWXYBHyINz5B1ZZiH/y8BitQSBKJx3Q==
X-Received: by 2002:a17:902:9f86:: with SMTP id g6mr5120840plq.299.1581197145958;
        Sat, 08 Feb 2020 13:25:45 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:44 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/5 v2] ARM: SoC defconfig updates
Date:   Sat,  8 Feb 2020 13:25:32 -0800
Message-Id: <20200208212533.30744-5-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208212533.30744-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208212533.30744-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep this in a separate branch to avoid cross-branch conflicts, but
most of the material here is fairly boring -- some new drivers turned on
for hardware since they were merged, and some refreshed files due to
time having moved a lot of entries around.

----------------------------------------------------------------

The following changes since commit a51020f9dd797d520285048180f91b0bcd15a338:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to 1342a6aa4abf6a56e83ce24ce5e84243c365ab4d:

  Merge tag 'samsung-defconfig-5.6' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/defconfig

----------------------------------------------------------------

Adam Ford (2):
      ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_ILI210X
      arm64: defconfig: Enable CRYPTO_DEV_FSL_CAAM

Amit Kucheria (1):
      arm64: defconfig: Enable QCOM PMIC thermal

Anson Huang (1):
      arm64: defconfig: Enable CONFIG_CLK_IMX8MP by default

Bjorn Andersson (7):
      arm64: defconfig: Enable Qualcomm remoteproc dependencies
      arm64: defconfig: Enable Qualcomm SPI and QSPI controller
      arm64: defconfig: Enable Qualcomm socinfo driver
      arm64: defconfig: Enable Qualcomm CPUfreq HW driver
      arm64: defconfig: Enable Qualcomm pseudo rng
      arm64: defconfig: Enable Qualcomm watchdog driver
      arm64: defconfig: Enable ATH10K_SNOC

Brian Masney (2):
      ARM: qcom_defconfig: add msm8974 interconnect support
      ARM: qcom_defconfig: add anx78xx HDMI bridge support

Claudiu Beznea (3):
      ARM: configs: at91: use savedefconfig
      ARM: configs: at91: enable config flags for sam9x60 SoC
      ARM: configs: at91: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select the TFP410 driver

Fabrizio Castro (1):
      ARM: shmobile: defconfig: Enable support for panels from EDT

Jeffrey Hugo (2):
      arm64: defconfig: Enable QCA Bluetooth over UART
      arm64: defconfig: Enable SN65DSI86 display bridge

Jerome Brunet (1):
      arm64: defconfig: enable FUSB302 as module

Jorge Ramirez-Ortiz (1):
      arm64: defconfig: Enable HFPLL

Krzysztof Kozlowski (3):
      ARM: exynos_defconfig: Bring back explicitly wanted options
      ARM: exynos_defconfig: Enable NFS v4.1 and v4.2
      ARM: multi_v7_defconfig: Enable NFS v4.1 and v4.2

Lina Iyer (1):
      arm64: defconfig: enable PDC interrupt controller for Qualcomm SDM845

Linus Walleij (2):
      ARM: defconfig: u8500: activate cpufreq
      ARM: defconfig: gemini: Update defconfig

Manivannan Sadhasivam (1):
      arm64: defconfig: Enable Actions Semi specific drivers

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable devfreq thermal integration
      ARM: multi_v7_defconfig: Enable devfreq thermal integration

Nagarjuna Kristam (1):
      arm64: defconfig: Enable tegra XUDC support

Nicolas Saenz Julienne (2):
      arm64: defconfig: Enable Broadcom's STB PCIe controller
      arm64: defconfig: Enable Broadcom's GENET Ethernet controller

Niklas Cassel (2):
      arm64: defconfig: enable CONFIG_QCOM_CPR
      arm64: defconfig: enable CONFIG_ARM_QCOM_CPUFREQ_NVMEM

Olof Johansson (10):
      Merge tag 'renesas-arm-defconfig-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'amlogic-defconfig' of https://git.kernel.org/.../khilman/linux-amlogic into arm/defconfig
      Merge tag 'tegra-for-5.6-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'at91-5.6-defconfig' of git://git.kernel.org/.../at91/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.6' of https://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'qcom-defconfig-for-5.6' of https://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'arm-soc/for-5.6/defconfig-arm64' of https://github.com/Broadcom/stblinux into arm/defconfig
      Merge tag 'at91-5.6-defconfig-2' of git://git.kernel.org/.../at91/linux into arm/defconfig
      Merge tag 'samsung-defconfig-5.6' of https://git.kernel.org/.../krzk/linux into arm/defconfig

Peter Chen (1):
      ARM: configs: imx_v6_v7_defconfig: enable USB ACM

Sascha Hauer (1):
      ARM: imx_v6_v7_defconfig: Enable NFS_V4_1 and NFS_V4_2 support


 arch/arm/configs/at91_dt_defconfig   | 59 ++++++++++++++++---------------
 arch/arm/configs/exynos_defconfig    |  9 +++++
 arch/arm/configs/gemini_defconfig    | 24 +++++++++----
 arch/arm/configs/imx_v6_v7_defconfig |  5 +++
 arch/arm/configs/multi_v7_defconfig  |  3 ++
 arch/arm/configs/qcom_defconfig      |  4 +++
 arch/arm/configs/shmobile_defconfig  |  3 ++
 arch/arm/configs/u8500_defconfig     |  4 ++-
 arch/arm64/configs/defconfig         | 38 ++++++++++++++++++++
 9 files changed, 113 insertions(+), 36 deletions(-)
