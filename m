Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7149C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7B62080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578677045;
	bh=Zrp/bYduXHUDshMwetSqyu6k+WIom7m5BMG2ujk6Q/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFAEYIBfeKUp2HMSaa0FBeDquqH5hg+gdwyw5j47I2DDZEj9+qelFKOMmMRs/x2QZ
	 t6zo4z5xg9Pv8NKJp+gElWvQ/gV7Dh4N7BY0+jfzvMbpuL2/sMy5AQSh5aMSGQpTxM
	 +l687rZ7n35gHKDrAzejraaj9cME+3NTO3aqEWaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgAJRYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgAJRYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:24:03 -0500
Received: from localhost.localdomain (unknown [83.218.167.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D0B520838;
        Fri, 10 Jan 2020 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578677042;
        bh=Zrp/bYduXHUDshMwetSqyu6k+WIom7m5BMG2ujk6Q/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgWWNNi1eNoiCSVsH/ZYHgci6DzQxPXTOSL0f5FKKpUHCrrQAODGuWexQIQbCpXl5
         tlsG/WXgS+47Mg+pud2l/0zJfoGH4cUyhD7QnxfUNtwGP/UsdLSo6lR2Y/e4tfMKGH
         FRoI1zTCYmXJWWnHe7ymw34K1LKu/koOGw31mZPg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] ARM: dts: Pull for v5.6
Date:   Fri, 10 Jan 2020 18:23:31 +0100
Message-Id: <20200110172334.4767-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110172334.4767-1-krzk@kernel.org>
References: <20200110172334.4767-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-5.6

for you to fetch changes up to dc48a3a795ca5998a053060456a9bf807f619a42:

  ARM: dts: exynos: Enable FIMD node and add proper panel node to Tiny4412 (2020-01-08 21:17:38 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v5.6

1. Couple ARM and wcore bus regulators on Exynos542x so higher
   frequencies could be used with dynamic voltage and frequency scaling.
   Enable this higher frequencies.
2. Correct the polarity of USB3503 hub GPIOs.
3. Adjust the bus frequencies (scaled with devfreq framework) on
   Exynos5422 Odroid boards to match values possible to obtain from root
   PLLs.
4. Add display to Tiny4412 board.
5. Cleanups and minor improvements.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: dts: exynos: Add missing CPU frequencies for Exynos5422/5800

Krzysztof Kozlowski (1):
      ARM: dts: samsung: Rename Samsung and Exynos to lowercase

Marek Szyprowski (4):
      ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
      ARM: dts: exynos: Correct USB3503 GPIOs polarity
      ARM: dts: exynos: Move Exynos5420 bus related OPPs to the Odroid boards DTS
      ARM: dts: exynos: Adjust bus related OPPs to the values correct for Exynos5422 Odroids

Sylwester Nawrocki (1):
      ARM: dts: exynos: Remove syscon compatible from chipid node on Exynos5

Yangtao Li (1):
      ARM: dts: exynos: Enable FIMD node and add proper panel node to Tiny4412

 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   2 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts          |  25 ++
 arch/arm/boot/dts/exynos5.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   4 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   4 +-
 arch/arm/boot/dts/exynos5260.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |   2 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   4 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   6 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   2 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |   2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   4 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 289 ++-------------------
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |   2 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 279 +++++++++++++++++++-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |  64 ++---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  78 +++---
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |  58 +++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  13 +
 arch/arm/boot/dts/exynos5800.dtsi                  |  58 +++--
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   2 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts             |   4 +-
 24 files changed, 526 insertions(+), 392 deletions(-)
