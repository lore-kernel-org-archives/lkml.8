Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D248C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866F206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zUCc/TDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0Ryj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:54:39 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39244 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Ryj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:54:39 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so3559227pjr.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=Mkw52LsZ6nlRtEJ4Q5T/LK/F7/IwJaCpYdC0S/qED7M=;
        b=zUCc/TDavisIS/nEckngunG08U6GNKcmnEOHhEc46YIwW8rfTM/wP8COdeqcysBcf7
         vlgYbaIBL0ovzuzIcKWkwZ6i4coYZ7WxZjkcieWp+c9nLKoG7GKYgh8YQVKQaXZtjMuH
         aV18KHnEaWnOaSj6I+oSzJw/0www9/NR6vArfG20yGMAnESDiY4H3lX7z+EhCL1s7LJi
         1UGcX+0a9gTSWhHiVZtxUFfwjGObCee1PAHGW0SRPMu5iLloNFNnK5cNNiHpKtj7WpWg
         uNGK0dUcKToZQcIcXSdfTEmW6RxhzYE7g+FrLO4n+KQadJO3Unofx8cn2l6g8ESQVv0h
         7esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Mkw52LsZ6nlRtEJ4Q5T/LK/F7/IwJaCpYdC0S/qED7M=;
        b=WUj3xxnulpJqOdgqT7cT66txXSjtHH3e7Wk9L2zsmLexfUmh0mQWMyhVjfB+XnyAwm
         m7CtlJy72BJxvoxmjj0422fY5czrODvWaQO2uxInySJ/ZWdyfZ/Mf6JQZ6xoW37CA1Na
         CsZKoaxfgAGlQCWLdfDeAtEDDaSHgnJi3DrG44pcfmpd3tL6ObrMQdDFmHlWpaJWACu8
         8FGRxk6H6StvaP1UlwHKzTEDvauOlB3BUhArdTIZ3NlxwpQ5ywUzX5WxPEJ96UwDZZSV
         T9aRIXaka6+kRHUgoUR7ESOWjiBrXImDO/HkzC2jUSx0inWEARdCg+YPX/DhgIBK7rQk
         FDrg==
X-Gm-Message-State: ANhLgQ02u2Mf4UfbcrPiQHcjEAdrJr2F+/exa7RLjYQATUFCx47sat2C
        R+gg0WFNl/1EiBdaiILuLCPnxD9Niqk=
X-Google-Smtp-Source: ADFU+vumAh9nXlqDjpD0UVqFzkCeeTU2h8ixiixYjLbr95USmGkKSYGWcFFFU1M8p8dzYao6FtasFQ==
X-Received: by 2002:a17:902:a5c6:: with SMTP id t6mr220421plq.323.1585331676441;
        Fri, 27 Mar 2020 10:54:36 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id a3sm4572259pfg.172.2020.03.27.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:54:35 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:54:35 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Mar 2020 10:52:27 PDT (-0700)
Subject: [GIT PULL] Last Minute RISC-V Patches for 5.6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID:
 <mhng-06e46f55-fd4f-48ab-b741-cf487976999b@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200327175435.tRz8BMghUWmNCjeyEguEOv20vv6kkR3HS_Fz4sRvmFo@z>

The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.6

for you to fetch changes up to 2191b4f298fa360f2d1d967c2c7db565bea2c32e:

  RISC-V: Move all address space definition macros to one place (2020-03-26 19:26:11 -0700)

----------------------------------------------------------------
Last Minute RISC-V Patches for 5.6

Sorry for the last minute patches, but a few things fell through the cracks
recently.  I was on the fence about sending a late PR just for the M-mode
fixes, as we don't really have any users, but the last patch fixes the build
for Fedora which I consider pretty important.  Given that the M-mode fixes
should be very low risk, I figured it's worth sending them along as well.

This passes my standard "boot in QEMU" test.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: Only select essential drivers for SOC_VIRT config

Atish Patra (1):
      RISC-V: Move all address space definition macros to one place

Greentime Hu (2):
      riscv: uaccess should be used in nommu mode
      riscv: fix the IPI missing issue in nommu mode

 arch/riscv/Kconfig                |  1 -
 arch/riscv/Kconfig.socs           | 14 -------
 arch/riscv/configs/defconfig      | 16 +++++++-
 arch/riscv/configs/rv32_defconfig | 16 +++++++-
 arch/riscv/include/asm/clint.h    |  8 ++--
 arch/riscv/include/asm/pgtable.h  | 78 ++++++++++++++++++++-------------------
 arch/riscv/include/asm/uaccess.h  | 36 +++++++++---------
 arch/riscv/kernel/smp.c           |  2 +-
 arch/riscv/lib/Makefile           |  2 +-
 9 files changed, 95 insertions(+), 78 deletions(-)
