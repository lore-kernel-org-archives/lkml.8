Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1ACC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8E624654
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gwxfcX4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBHLUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:20:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35003 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:20:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so850607plt.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rE+Lqr7BWztveqyxVXRSXM9/n2K29sIPVQRdU+Uw//I=;
        b=gwxfcX4bJmgje1uEWsgv/EduoPEhphtn2sGzVjXJlrjuHam9hILECZ4Z0gK+xhvHVx
         Sr9l9r/OFrPgQdA9PSSV3cvI0681UR3i55agmmkV/6LKsIcDSBPDnRXe1Wwd4hac8CkF
         6XF01dXtAnWo/gMQWJK96QwbJ0iIUoVCjL7GamiOaABIzt+QWyX3DUVh0NaWBsbk10bB
         tTt0eozkFC+9cyNjzSlwpgjU35TTDctT8dWtAvM+JX5fw6qycZG/GTcBnOzHnoiKr7YG
         3hFbqnekyP0ccTg4YVdAS3d1/Sze4z4rCzsvrTTQ1bDoRBjCy5uxh8KTWL+DQ95SOCYw
         LOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rE+Lqr7BWztveqyxVXRSXM9/n2K29sIPVQRdU+Uw//I=;
        b=JRXVlrrQgXcNsNciIP3V10fzXWF3/EBbrkrHZozGVm0PvbRcmF1jhFnRl+WbDSIGq9
         XiPEGIhoNzAjoJQPtE5ddRAEBsgTKcXemrxxKqdVuPXgwFE6o8N2++z5WYlr88wKQTQt
         9Hh60322vMHZarqRiKegbr2M2kLeKbENrhfxQv9MuFeRr0gC3NvCpNgD3n2EADqCDwFU
         M6a0HFxJi4hYc30aXMv/6hbOZpW1GrebMNqSf7EEBVQFHTyPuPWYGNUzAskkGOeRnzLU
         qSAl7AecgBeqB3cRMcsY+vLrptYrYNX3aClV3AKL3MmuF668PVlTQWZkh+vWwbsQpVgj
         oiJA==
X-Gm-Message-State: APjAAAWrtuNjmQiXZ+hzUFQBKrOrj1f5h7C2/OPdGOdDsJf4T0pTrHpz
        hEW5xRW1uA+4sBAe4T9KuSxfHg==
X-Google-Smtp-Source: APXvYqy2KvMQ3IcJoBowIYLSZxDRzT9b3NXXZcJoClRM9zbNhDkvEyZlJl8BQnuSNdgC+4bAOXuh9Q==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr3327247plp.339.1581160833789;
        Sat, 08 Feb 2020 03:20:33 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm5707281pju.11.2020.02.08.03.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:20:32 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 1/5] ARM: SoC platform updates
Date:   Sat,  8 Feb 2020 03:20:14 -0800
Message-Id: <20200208112018.29819-2-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208112018.29819-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of these are smaller fixes that have accrued, and some continued
cleanup of OMAP platforms towards shared frameworks.

One new SoC from Atmel/Microchip: sam9x60.

----------------------------------------------------------------

The following changes since commit a1a0cfaf7fb7c1a90201e6b0937f742c8c212d8e:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

for you to fetch changes up to d8430df172118336d050aa61999fb82e55102641:

  Merge tag 'omap-for-v5.6/soc-build-fix-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/soc

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
