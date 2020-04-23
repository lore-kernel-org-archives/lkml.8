Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00997C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC6D206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgDWPSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:18:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:55247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgDWPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:18:15 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8QNs-1jW1KP2LNw-004Qo8 for <linux-kernel@vger.kernel.org>; Thu, 23 Apr
 2020 17:18:13 +0200
Received: by mail-lj1-f178.google.com with SMTP id y4so6614597ljn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:18:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuYsN5JIj1v9n/myXB9bIaUrt5ZrQV7cFLysqmvbYHM2treRh9w4
        d7XFULTwDHyePX1+qHqEU5Vq+xWdUeCdmTokKmY=
X-Google-Smtp-Source: APiQypJZExUtcD94RDruX3xk8SuY1awdgvcATE7ZOMREsLTA2azO4fgL4AgWM4ZPRu8nw8wtzLgPpXRvAVCqNgtH2QE=
X-Received: by 2002:a05:651c:107a:: with SMTP id y26mr2746346ljm.80.1587655093051;
 Thu, 23 Apr 2020 08:18:13 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Apr 2020 17:17:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2rtR9y15Vx1Vgsv2xpaQyf7eNgV8JsCCOYaWTWZhMNAg@mail.gmail.com>
Message-ID: <CAK8P3a2rtR9y15Vx1Vgsv2xpaQyf7eNgV8JsCCOYaWTWZhMNAg@mail.gmail.com>
Subject: [GIT PULL] ARM: soc fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8gBhmzVpdf9N0xHV/DQ/VXWjr69L23itMPGzosYrx7lC2g9klDO
 xdWRB/4Tgebp60EvwFCM+R+wAmDTBm4rRSiKwBS5aClgfGFV24molaW2ua6SxLptvkVvXhm
 cP/0Vo7gzfacSR1aFo9Y6WfCroPGAjr7+fLH7g4qNmtEyWzEKtz9xu8R0EDm5O15R+91Z4V
 B//0jHsOEdPsJzNjnqCoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ev6dD7dqRQ0=:3X5hZnOKJDQ14q4sRUYItt
 DbKfYzKNR7KPM9Fa2Gfi8ymQNXbOGJqZOTMwLhpxNy42sxD2aLBmr6SlblslwJJk06bIL9LzH
 ktZlnkKSfTeUv2jCTn8kPF3tgliZW1orGbJR5nYEmThQFavEHSGCKlHeP44s+dd7r1ssdr7PO
 4KENlNLtn8oVQa6GnvzWpmZ5rHD51KPHST5I1rb8YGbepUnXiRltn0UFn9F3P5mLF138eUTaf
 /J36LM3MbQRXmIDpYYMDYfTwvKNOyYkAAAAMMJsTF+efNYbtaksZhzrG7c+19qQQbVTMLkLTD
 bsDuTveWFJsErKY2b+cXQV6S1oQOEny7p58VDlt5zY2ixX66yjMiT9+t8yRYcz2ON0++KYy7I
 cB58x8AFQbWzfJKLMu3udc4pmZvVKSx8b9z/gY7b84m2MPD8ug5mBoJ9q5yPixIkQwNEuKeH/
 0SgXIFnzrXg44mh01Wz4gf5bFcYtfcmhP6rZDQ46Xm19FsVnwGOOY5MIO445x2VbR81saScy+
 X9ldvMePz0rS9NrRZpJXBD1sbOoJZ8tx+dwvKOGvupHOAqxD5WvKufPKIVroN6HZD2vmwk0Hj
 aejuOG8+ohsEurAdi1V7pIW/cYbZOdx6ZsRVgfejNEY62l1y3hTCvicNpY8kkX0iPFOdbnsiO
 pQbuvGjrLkygNzOXB3Fs61Hn5tFbcjMwVPTSDUmKoaJH9m3AfPesNszMPz+DQzWiBhjBQk+RY
 FJ+QLihfwQyufKuEzwX/I/16Hzdv9LBiecSS9XUjesiGxmMdIqF6rjjgbL25zUR0pbycWEwfi
 qLJFvRuwRD06O0lK/8I8X4OyIKmh5eh/bOxwWoQcRgTBgQK3AM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to f42ae4cd4cae92408bffec2c0a4c110447e908e0:

  Merge tag 'arm-soc/for-5.7/devicetree-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes (2020-04-23
17:12:48 +0200)

----------------------------------------------------------------
ARM: SoC fixes

A few smaller fixes for v5.7-rc3: The majority are fixes for bugs I found
after restarting my randconfig build testing that had been dormant for
a while.

On the Nokia N950/N9 phone, a DT fix is required to address a boot
regression.

For the bcm283x (Raspberry Pi), two DT fixes address minor issues.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: dts: OMAP3: disable RNG on N950/N9

Ahmad Fatoum (1):
      ARM: imx: provide v7_cpu_resume() only on ARM_CPU_SUSPEND=y

Arnd Bergmann (8):
      drivers: soc: xilinx: fix firmware driver Kconfig dependency
      soc: fsl: dpio: fix incorrect pointer conversions
      soc: fsl: dpio: avoid stack usage warning
      soc: tegra: fix tegra_pmc_get_suspend_mode definition
      soc: imx8: select SOC_BUS
      Merge tag 'omap-for-v5.6/fixes-rc7-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'zynqmp-soc-for-v5.7-rc3' of
https://github.com/Xilinx/linux-xlnx into arm/fixes
      Merge tag 'arm-soc/for-5.7/devicetree-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-fixes-2020-03-27' into devicetree/fixes

Jason Yan (1):
      firmware: xilinx: make firmware_debugfs_root static

Nicolas Saenz Julienne (2):
      ARM: dts: bcm283x: Add cells encoding format to firmware bus
      ARM: dts: bcm283x: Disable dsi0 node

 arch/arm/boot/dts/bcm2835-rpi.dtsi     |  3 +++
 arch/arm/boot/dts/bcm283x.dtsi         |  1 +
 arch/arm/boot/dts/omap3-n950-n9.dtsi   |  5 +++++
 arch/arm/mach-imx/Makefile             |  2 ++
 drivers/firmware/xilinx/zynqmp-debug.c |  2 +-
 drivers/soc/fsl/dpio/dpio-service.c    | 19 ++++++++++++++-----
 drivers/soc/fsl/dpio/qbman-portal.c    |  6 ++----
 drivers/soc/imx/Kconfig                |  1 +
 drivers/soc/xilinx/Kconfig             |  4 ++--
 include/soc/tegra/pmc.h                | 15 +++++++++------
 10 files changed, 40 insertions(+), 18 deletions(-)
