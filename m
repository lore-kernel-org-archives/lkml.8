Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA7C352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5B2465A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="XL+flBOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBHLUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 06:20:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38896 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgBHLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 06:20:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so1207933pgn.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 03:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TuNGFz1JcD7T6IDfh5rq70OidRyfNk4PEH1acEnm1Y=;
        b=XL+flBOTIWxg+yjbLL5ipgbB4fCNCmx0tdgckQrzylmHqrakQWwG3Tzo00aHR5IbBZ
         qCgEpK8hLISiwRNIMPD7vlYtJl6kwJjWoRfT3WHTRcQeWqPuoYGJynm74cp8C10a7UHV
         uA6+PS2g7C3llNBpmXKOA0yd/ARLVfHn+XWm5GYhaZaucXCrgbKcb1iXL0aOQiqGHKRT
         HCfEODsBoPgy8EDG7gZ6vFYrgq8brXMXOJZcIi0zLzrVodDDQgxagaybxmE5J1DccX91
         xu+sWn3PftBlZ1Rxt7zZD9XpWnRxnyABQ0svMzGAXwD5NfLMHR6R9RZlqnPdlsy+srnw
         NNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TuNGFz1JcD7T6IDfh5rq70OidRyfNk4PEH1acEnm1Y=;
        b=SCl+DL+rByMDJ7z9hYkrGymJBz4p+NQKgpY9BvfZv1xfFs1RY27c4OL12fE1NWabgk
         trw6eQRFXJb5lh2NSnf6C4RcVecXIBtCkkuVcerR03CqvKKvrBwVttFBsNUr/FfT3W/c
         KTw8AHXbPmKPtebjgNF6pmdXC1C6K906Ie5Tshv29k3DKfgWsrOUqiKv3LcQhVbNbgQK
         SmzyzMoKkQ5chmhilFO1/wZGOMx07jxfdM4Ez8Cc9vBQpQfVjnrLrABQurD0k23vH8Zq
         XGH9cAEyd/qViiL/HrllIbUDyZPXYdQcFoa6p+Hjv3x/IPlQxNaDzStaAjI77QrueSMQ
         SNJQ==
X-Gm-Message-State: APjAAAUpcT2ZbUr3MLRsArfyCXhsdPsKydAWYHcRQGd5lG23DpCZZnWS
        W4UyjsqeSY66d36VwTOE7FUsXQ==
X-Google-Smtp-Source: APXvYqzqcF7UHN6MhOG6LzgFQ1WYsym1a8kd+pbhCUGC6kcjiHgSR3d5X61zzw1f7lOjMzuhgJ4I8Q==
X-Received: by 2002:aa7:86c3:: with SMTP id h3mr3589889pfo.243.1581160839243;
        Sat, 08 Feb 2020 03:20:39 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a19sm5707281pju.11.2020.02.08.03.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 03:20:38 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/5] ARM: SoC defconfig updates
Date:   Sat,  8 Feb 2020 03:20:17 -0800
Message-Id: <20200208112018.29819-5-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208112018.29819-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
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

The following changes since commit a1a0cfaf7fb7c1a90201e6b0937f742c8c212d8e:

  Merge tag 'armsoc-defconfig' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to 1342a6aa4abf6a56e83ce24ce5e84243c365ab4d:

  Merge tag 'samsung-defconfig-5.6' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/defconfig

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
