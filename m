Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5950C35254
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A9F24650
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="i3hd97LX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBHLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:20:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34341 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:20:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so1219344pgi.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 03:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMFbgcmbUqdQyIw1ejvMCost8AXkmggO/zCBoWfvSxE=;
        b=i3hd97LXx24Px0ZGFjjU7uJ73FH7e9RW3FRGWXIv+XGckgRMO0ijMvltyNq55Rm9AH
         n8PTDvC13k/+nAEbd+fWKk+hX4kmZn5+uvdrqsHxHFmaWxKD6WHsLMQp71SriTytULOU
         jG9Pqi7zz/b5bpLqRnZvJQNbGUvzJvQHoBfkd2Ti/E1ERYiC8cWvPpO+julcy6qLxDb5
         2zj621274YmNDrsaCY56F1lvVP8wKrVArOBv/gVjq+s2liwghEde0xlLZoxVtP3ENNp4
         v6uQIRFbP/Ouzdg/B9u4/OrVrbnN7Pf1ivzYUu67wQIDtDKDRxjwfUj9f0JXiar7jA8E
         ea7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMFbgcmbUqdQyIw1ejvMCost8AXkmggO/zCBoWfvSxE=;
        b=tVcfKUfef5n3TX5abW+XWUc94qHlKXRJjoGHqG2T/osWkCONiklMMUi5QQDgR8Vb/p
         yZOs4UijRzTNdW77QC64Ysmc6k2st2DcMMtNCIumOU2xVt+zz1VBXEbXp0dIYuZoL2v6
         TmYi43J3lxIFiTA+d0qE1niLkXSL0bZTFX6k2JerVWRSg3aAYVnz5E+NS+6zeWjX5pO0
         NnRxyPJNnwMQ5vhVEdEBrUlLoRAq500PJrvYcetD+6K6K47eNk/fTtQTCuTJtOe2EThx
         n0BHC7Orh11a4sa7erO9S54ssdt2zI/FlB5oHst7K9tckhwpejtGLPvbasWhvpn40qeK
         ZkSw==
X-Gm-Message-State: APjAAAWKAmpKxPo4KpIvoW0qiydqMNmd9SUGSJfGrog2GeMofCTfIof7
        CWB+Unz3Y1VV0V6wdQeXVc/35w==
X-Google-Smtp-Source: APXvYqwoaKHrcHXpwupKOYooh26scasFONqNkZ3DX99n3tUo/uMW5sozppYK49KlIvzdqiJ5/Nw/yg==
X-Received: by 2002:aa7:9829:: with SMTP id q9mr3892562pfl.31.1581160835640;
        Sat, 08 Feb 2020 03:20:35 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm5707281pju.11.2020.02.08.03.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:20:34 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/5] ARM: Device-tree updates
Date:   Sat,  8 Feb 2020 03:20:15 -0800
Message-Id: <20200208112018.29819-3-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208112018.29819-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New SoCs:

- Atmel/Microchip SAM9X60 (ARM926 SoC)

- OMAP 37xx gets split into AM3703/AM3715/DM3725, who are all variants
of it with different GPU/media IP configurations.

- ST stm32mp15 SoCs (1-2 Cortex-A7, CAN, GPU depending on SKU)

- ST Ericsson ab8505 (variant of ab8500) and db8520 (variant of db8500)

- Unisoc SC9863A SoC (8x Cortex-A55 mobile chipset w/ GPU, modem)

- Qualcomm SC7180 (8-core 64bit SoC, unnamed CPU class)

New boards:

- Allwinner
+ Emlid Neutis SoM (H3 variant)
+ Libre Computer ALL-H3-IT
+ PineH64 Model B

- Amlogic
+ Libretech Amlogic GX PC (s905d and s912-based variants)

- Atmel/Microchip:
+ Kizboxmini, sam9x60 EK, sama5d27 Wireless SOM (wlsom1)

- Marvell:
+ Armada 385-based SolidRun Clearfog GTR

- NXP:
+ Gateworks GW59xx boards based on i.MX6/6Q/6QDL
+ Tolino Shine 3 eBook reader (i.MX6sl)
+ Embedded Artists COM (i.MX7ULP)
+ SolidRun CLearfog CX/ITX and HoneyComb (LX2160A-based systems)
+ Google Coral Edge TPU (i.MX8MQ)

- Rockchip
+ Radxa Dalang Carrier (supports rk3288 and rk3399 SOMs)
+ Radxa Rock Pi N10 (RK3399Pro-based)
+ VMARC RK3399Pro SOM

- ST
+ Reference boards for stm32mp15

- ST Ericsson
+ Samsung Galaxy S III mini (GT-I8190)
+ HREF520 reference board for DB8520

- TI OMAP
+ Gen1 Amazon Echo (OMAP3630-based)

- Qualcomm
+ Inforce 6640 Single Board Computer (msm8996-based)
+ SC7180 IDP (SC7180-based)

----------------------------------------------------------------

The following changes since commit a1a0cfaf7fb7c1a90201e6b0937f742c8c212d8e:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to d030a0dd01306d45569c6a4449dee603f994744a:

  Merge tag 'ti-k3-soc-for-v5.6-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux into arm/dt

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
