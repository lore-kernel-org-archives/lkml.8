Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B08C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968242071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gQqx9TCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgC0RxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:53:22 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33133 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0RxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:53:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id jz1so4542765pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=Mkw52LsZ6nlRtEJ4Q5T/LK/F7/IwJaCpYdC0S/qED7M=;
        b=gQqx9TCDA3CS4l5CXZeRA7PlcZd2Fhx1miA/bBkPZi1g4bcF+GRzy7QwsdaAxAOJoy
         MQsz07VWidxMup4R1X2YJ7+kZM/OZZ7pSkuaY8+0gE1fPuPMjxMOV9Io64MYcIxvVwLH
         jpOgmIO9zZ8vBtNpwRQdPOL0/yomu7/lbA71RxL5GD6RmEQua2puGLTfTkfJ3+vV504p
         7+TgWTZcUVQmpWsExjo91TS3MG9aUg9OtVy45s2GVytXkHcKWEi1pQ4dleuFrOy9SmNj
         nC5AgC+YcFZ8XJb8qLC/jzMrStdD7lSrIT/gcghDgb1UQ9O/BCnNZwlP26emYc35Fggb
         w6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Mkw52LsZ6nlRtEJ4Q5T/LK/F7/IwJaCpYdC0S/qED7M=;
        b=BPJAEAFDfRBb/3SxO0ntUTD1lOcAtemreZj6cJmnB3AG2E4FTC+oRuh6U7vmFo2NcD
         QGSfNfRCyWkKZrMwDJkyCqu3Vrf5bRCE18QgDmyEgbXMWk/NsyJAkmv1g596v5oRUCYz
         xPV3wNMa88XUMn4rFBOQFKs8lUZwiiPs1rAqrQ+43P7BWpsluyz7skABwh4uWnkeeNVA
         cziuY09c5MEK1JlzQNT0hXtqeMSKF+5pmLlQwy8Fmlbb3R2p7AGebREF84qwUGR/BrH5
         XHRKeXxoPG3MYb+8kS1s+uHE6hYH+L7bMmboD/IXPuK+UGvQUqAJgeP1q/0ZWFQ8yX68
         zdFg==
X-Gm-Message-State: ANhLgQ29uAXxQcUUMjvd062IjR3NLLnBMlvhurwLdZh4K2wLNFfMi+ay
        LhXk4uvRIpogR5jDr9k4iVse8YmQSos=
X-Google-Smtp-Source: ADFU+vvIc6Wjf8WOqjm9jzVUju2DkpVUYn57NK9O8ZTO+11p6gf0eYMgun2tKb/kqam7mst7Q8jYqg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr222750plp.252.1585331598822;
        Fri, 27 Mar 2020 10:53:18 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id m9sm4545957pff.93.2020.03.27.10.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 10:53:16 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:53:16 -0700 (PDT)
X-Google-Original-Date: Fri, 27 Mar 2020 10:52:27 PDT (-0700)
Subject: [GIT PULL] Last Minute RISC-V Patches for 5.6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-06e46f55-fd4f-48ab-b741-cf487976999b@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
