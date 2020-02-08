Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA3C352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5F922522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="iocXsOmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBHVZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38283 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgBHVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so1624257pfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLvBYI2Cs8Bqj8AtKjZ3LbYsK+wgnbwS8xmH1fw8LUE=;
        b=iocXsOmYDNEJhcmn0s6CfRKvzrur8gvwcI6sn1xfv9/mQUpwMxVv4tHLQ0zWziHlpC
         MSeXEUv+BrYYcBcXl4vLAgrliRJfwKonU6r6mG6ZL/UDORBBao3XMCKOH3saLr1CGaXv
         5nOqvZjiAODTN8bvumkARJsc9OtI508/7QQGasxp3diTa+BlGDHDArRtnSRIOQACdQDn
         jLmJFQVeaRih88riMqJzG7fWsJYb0D9n1ILZJqlTlCeeoBYrJ6CPFgKy7uY0vdVMrPr9
         gyOUDkHEYeS/jNtNOc3XG9zB7LTL/gurAohD32U4/RpPJaVtE2YDswoba/PfkVxl2kO5
         w/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLvBYI2Cs8Bqj8AtKjZ3LbYsK+wgnbwS8xmH1fw8LUE=;
        b=VnwnoK/GPTw+B+A6E4fIe0tvf8nb9hSePLKkq+CaWSS6mzYYVbaJjrFzbHg/9L3XXS
         8UEOve0h+EJhksU5TytakUGpo9S+WtLMKi/3bRKgPbCMa6dr6oKO0ueDVjcE2+2dK/Gy
         gt0S0Gk1BuNGnEYFu1K7QeSKWhcKc3VvNM0QHfEwHDtaeeAJMMgvWuEUgZe/5ZGZzVS/
         RMjZtCG2k/OPinHnMrjYo0B+tDJdGxK5GY3WxIUoRNKI5RKZNSFxDkAI+83Lev3M4ZUC
         juPm/sSFXfit8MNTc+pPApwOxgAtr5nh4DE3ASJ7qwLnesNUnNYoIagRbtZxQPvYg+GS
         tMwA==
X-Gm-Message-State: APjAAAX4oCqOl/KSr1cqwGF6VC9yrh0bArL7V2h0WhjhetPxpwZmVQQp
        3k7A7ylkHBCGwGu6lXNJlyMuXA==
X-Google-Smtp-Source: APXvYqwMKBKiTov+97bU8fnWEswPWzrQg+oWfNRBZ6gUneIMMFcY7rpYzAtRF8MHgqGsNLv6YKxOSg==
X-Received: by 2002:a65:6812:: with SMTP id l18mr6352755pgt.41.1581197147312;
        Sat, 08 Feb 2020 13:25:47 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:46 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 5/5 v2] ARM: SoC: late updates
Date:   Sat,  8 Feb 2020 13:25:33 -0800
Message-Id: <20200208212533.30744-6-olof@lixom.net>
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

This is some material that we picked up into our tree late, or that had
more complex dependencies on more than one topic branch that makes sense
to keep separately.

- TI support for secure accelerators and hwrng on OMAP4/5

- TI camera changes for dra7 and am437x and SGX improvement due to better
reset control support on am335x, am437x and dra7

- Davinci moves to proper clocksource on DM365, and regulator/audio
improvements for DM365 and DM644x eval boards

----------------------------------------------------------------

The following changes since commit a1a0cfaf7fb7c1a90201e6b0937f742c8c212d8e:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

for you to fetch changes up to a832eb203ecd34e486bdde0042cf166e687eb227:

  Merge tag 'davinci-for-v5.6/soc' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into arm/late

----------------------------------------------------------------

Bartosz Golaszewski (3):
      clocksource: davinci: only enable clockevents once tim34 is initialized
      ARM: davinci: dm365: switch to using the clocksource driver
      ARM: davinci: remove legacy timer support

Benoit Parrot (11):
      ARM: dts: dra7: add cam clkctrl node
      ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP only
      ARM: dts: dra7-l4: Add ti-sysc node for CAM
      ARM: dts: DRA72: Add CAL dtsi node
      arm: dts: dra72-evm-common: Add entries for the CSI2 cameras
      arm: dtsi: dra76x: Add CAL dtsi node
      arm: dts: dra76-evm: Add CAL and OV5640 nodes
      ARM: dts: am437x-sk-evm: Add VPFE and OV2659 entries
      ARM: dts: am43x-epos-evm: Add VPFE and OV2659 entries
      ARM: dts: dra7: add vpe clkctrl node
      ARM: dts: dra7: Add ti-sysc node for VPE

Olof Johansson (3):
      Merge tag 'omap-for-v5.6/ti-sysc-drop-pdata-crypto-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'omap-for-v5.6/dt-late-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'davinci-for-v5.6/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into arm/late

Peter Ujfalusi (2):
      ARM: davinci: dm365-evm: Add Fixed regulators needed for tlv320aic3101
      ARM: davinci: dm644x-evm: Add Fixed regulators needed for tlv320aic33

Tero Kristo (1):
      ARM: dts: am43xx: add support for clkout1 clock

Tony Lindgren (17):
      ARM: dts: Add missing omap4 secure clocks
      ARM: dts: Add missing omap5 secure clocks
      ARM: dts: Configure omap4 rng to probe with ti-sysc
      ARM: dts: Configure omap5 rng to probe with ti-sysc
      ARM: dts: Configure interconnect target module for omap4 sham
      ARM: dts: Configure interconnect target module for omap4 aes
      ARM: dts: Configure interconnect target module for omap4 des
      ARM: OMAP2+: Drop legacy platform data for omap4 aes
      ARM: OMAP2+: Drop legacy platform data for omap4 sham
      ARM: OMAP2+: Drop legacy platform data for omap4 des
      Merge branch 'omap-for-v5.6/ti-sysc-omap45-rng' into omap-for-v5.6/ti-sysc-drop-pdata
      Merge branch 'omap-for-v5.6/ti-sysc-dt-cam' into omap-for-v5.6/dt
      ARM: dts: Configure rstctrl reset for am335x SGX
      ARM: dts: Configure sgx for dra7
      ARM: dts: Configure interconnect target module for am437x sgx
      ARM: dts: motorola-cpcap-mapphone: Configure calibration interrupt
      ARM: dts: omap4-droid4: Enable hdq for droid4 ds250x 1-wire battery nvmem


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
