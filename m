Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FA0C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A42086A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 19:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0yOtJwki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgBOTtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 14:49:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39956 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgBOTtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 14:49:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so14401234ljo.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=+jGJTXJE5uxAW7727uFygAR1k6UQ7Fe+Mfr4AYT7cvw=;
        b=0yOtJwkidkegSoBVcque+HJM2Gdbk1BMCtiqjk/CjQ4HpwMZoBlX7M0ZLl+mDWEMd7
         kFNez4MIG16UBHCoVFPZLZappNA5Wlufnk7Vp26KqE5/lRqW6Wzm220ssN4j656qJHdQ
         kvC39+kVnhLGGDtD3A/+hhzKhKGxuXIODX7ydSR4aLi8SZC/+jA9Bl64m3SB9YqBmaAA
         n2HEA0t/ZE6twuz0uCf3Xzg8UihVBqsZs+mobqf4Is58I+yNyQkXjCtKzsgUKcPSD7yM
         TNzStpOPzqidgH9jm4LM0hrAWULVdmiqPHrSESHQ1Eu7t8LE7sbRLmUDNwjZIZ2SP7KL
         xiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=+jGJTXJE5uxAW7727uFygAR1k6UQ7Fe+Mfr4AYT7cvw=;
        b=VA5HoSj2TIMXA+LW4NizcqkfIrYDVAKJz31m1L6dZFbmmZLkDeBHjg2tsYRCdzMP1s
         kWbCn9LSPl8imMakf3nRvq+aSTnq86kPD0eSJaNpmMO3omK9O+6UE8kcHZPWFvoGAV63
         ypGJq5qnd5SqEGcuKNz7H5DHIWdHb9RFXzDAFNpVwc0BDcZjiKlIWXa/60G6aqvx4MHP
         EzP3pNeEA3VbOR3vX+m1MqXmutl1c8fkknkQ7kHdZl1oHuyaKCaDxchd9UK/lRP1LAub
         b7hjOvhS7gRBvUBG4ZKvtTZw04lWJtkW4ZzaekbhrVDYvS8JtiNbrQYZwKtiiLjSezUU
         5hKw==
X-Gm-Message-State: APjAAAW545ajQWyzKHjgGghDb61Mn/L7N+Fc69V6wL7vq9R7YBpABI+4
        vUgKcDCqQ6ujz5OeHo46AgabRQ==
X-Google-Smtp-Source: APXvYqzNYMV8X9A5VdM1P4f/bomCxn/rLnVRdxZxCuvTWt/Yk8OF+myP3RG9xJI28OT4AoBNmASV0w==
X-Received: by 2002:a2e:880a:: with SMTP id x10mr5735386ljh.211.1581796160174;
        Sat, 15 Feb 2020 11:49:20 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id j7sm4759869lfh.25.2020.02.15.11.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Feb 2020 11:49:18 -0800 (PST)
Date:   Sat, 15 Feb 2020 11:49:10 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20200215194910.jmvolzk6xsngpcbr@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 3bf3c9744694803bd2d6f0ee70a6369b980530fd:

  bus: moxtet: fix potential stack buffer overflow (2020-02-15 10:33:19 -0800)

----------------------------------------------------------------
ARM: SoC fixes

A handful of fixes that have come in since the merge window:

 - Fix of PCI interrupt map on arm64 fast model (SW emulator)

 - Fixlet for sound on ST platforms and a small cleanup of deprecated DT properties

 - A stack buffer overflow fix for moxtet

 - Fuse driver build fix for Tegra194

 - A few config updates to turn on new drivers merged this cycle

----------------------------------------------------------------
Jagan Teki (1):
      arm64: defconfig: Enable DRM_SUN6I_DSI

Krzysztof Kozlowski (2):
      ARM: npcm: Bring back GPIOLIB support
      ARM: configs: Cleanup old Kconfig options

Kuninori Morimoto (1):
      ARM: dts: sti: fixup sound frame-inversion for stihxxx-b2120.dtsi

Marc Zyngier (1):
      arm64: dts: fast models: Fix FVP PCI interrupt-map property

Marek Behún (1):
      bus: moxtet: fix potential stack buffer overflow

Nicolas Saenz Julienne (1):
      arm64: defconfig: Set bcm2835-dma as built-in

Olof Johansson (6):
      Merge tag 'juno-fix-5.6' of git://git.kernel.org/.../sudeep.holla/linux into arm/fixes
      Merge tag 'v5.6-rc1' into arm/fixes
      Merge tag 'sunxi-config64-for-5.6-2' of https://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'sunxi-config-for-5.6-2' of https://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'arm-soc/for-5.6/defconfig-arm64-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'sti-dt-for-5.7-round1' of git://git.kernel.org/.../pchotard/sti into arm/fixes

Patrice Chotard (1):
      ARM: dts: sti: Remove deprecated snps PHY properties for stih410-b2260

Thierry Reding (1):
      soc/tegra: fuse: Fix build with Tegra194 configuration

Yangtao Li (2):
      ARM: sunxi: Enable CONFIG_SUN8I_THERMAL
      arm64: defconfig: Enable CONFIG_SUN8I_THERMAL

 arch/arm/boot/dts/stih410-b2260.dts       | 3 ---
 arch/arm/boot/dts/stihxxx-b2120.dtsi      | 2 +-
 arch/arm/configs/am200epdkit_defconfig    | 2 --
 arch/arm/configs/axm55xx_defconfig        | 1 -
 arch/arm/configs/clps711x_defconfig       | 1 -
 arch/arm/configs/cns3420vb_defconfig      | 2 +-
 arch/arm/configs/colibri_pxa300_defconfig | 1 -
 arch/arm/configs/collie_defconfig         | 2 --
 arch/arm/configs/davinci_all_defconfig    | 2 --
 arch/arm/configs/efm32_defconfig          | 2 --
 arch/arm/configs/ep93xx_defconfig         | 1 -
 arch/arm/configs/eseries_pxa_defconfig    | 2 --
 arch/arm/configs/ezx_defconfig            | 1 -
 arch/arm/configs/h3600_defconfig          | 2 --
 arch/arm/configs/h5000_defconfig          | 1 -
 arch/arm/configs/imote2_defconfig         | 1 -
 arch/arm/configs/imx_v4_v5_defconfig      | 2 --
 arch/arm/configs/lpc18xx_defconfig        | 4 ----
 arch/arm/configs/magician_defconfig       | 2 --
 arch/arm/configs/moxart_defconfig         | 1 -
 arch/arm/configs/mxs_defconfig            | 2 --
 arch/arm/configs/omap1_defconfig          | 2 --
 arch/arm/configs/palmz72_defconfig        | 2 --
 arch/arm/configs/pcm027_defconfig         | 2 --
 arch/arm/configs/pleb_defconfig           | 2 --
 arch/arm/configs/realview_defconfig       | 1 -
 arch/arm/configs/sama5_defconfig          | 3 ---
 arch/arm/configs/stm32_defconfig          | 2 --
 arch/arm/configs/sunxi_defconfig          | 1 +
 arch/arm/configs/u300_defconfig           | 2 --
 arch/arm/configs/vexpress_defconfig       | 2 --
 arch/arm/configs/viper_defconfig          | 1 -
 arch/arm/configs/zeus_defconfig           | 2 --
 arch/arm/configs/zx_defconfig             | 1 -
 arch/arm/mach-npcm/Kconfig                | 2 +-
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 8 ++++----
 arch/arm64/configs/defconfig              | 4 +++-
 drivers/bus/moxtet.c                      | 2 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c     | 3 ++-
 39 files changed, 14 insertions(+), 65 deletions(-)
