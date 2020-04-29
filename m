Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC3C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA3821D79
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="S6rWdOZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgD2PxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgD2PxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:53:19 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CFFC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:53:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so2430174pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=bZ2uka4PKxjNOr47/snGSXxilpTApOVFg/i0FxlPvdM=;
        b=S6rWdOZYnP8kNPYHI1Fl1b/K810hbnXQ6gVm/FyWNk8SqPYUbaEU7qCKKEL/Wm3y59
         S2efPyMEdz+YVaK9i3VbjjQ9wWFsUyUfnxTsiE5ZcaeNeehVcXMLtq5uiRERk8lHSJIT
         DyGGFmLjwS9/jSwqDEfErRMRm3g3mSxEkmIuwxUSY+pz+DXuYMB4u0cD3gNOpcJ+A1gh
         ZirCaSMXbT0Q4qhjfoPOFtk4WQmeDTWGKOFmORXObnnEqtH5sFSwhGt7PZ87xTM3YgwW
         5JGDrbZWh5Vx+1EW6SqRnV5YCVWy6ksFLE/R6xcP8g5PnGVWZbm6Du0wO/55Rzie2KwG
         p0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=bZ2uka4PKxjNOr47/snGSXxilpTApOVFg/i0FxlPvdM=;
        b=JaThdHnn9+y9x7WAi7zgJ4snYrfqWI4HwkxMhPKmBjlE/6cAwEl7MBBUPeSsFQN/8F
         OwsJd4kaaEWFpgsfP617KREne/TeqIv82WB1YVXSg4IWlfLJOyfFbPrmZz+sVNrdnMOa
         R+ZqfZ3vFNgHAW1bQIZjLDWzV76qANps8wToPMwwRAckCm4wN7PPVygYsFu0nZBukH2v
         N3l7emCmjBLjj/7yvbqTytYRAzkE5gNQp8CGhVEShc7XHw59zCz79F0x1BgbRLBf7MQD
         YlT512cEIb10fnGCdeVbO2w9hzLaH/zja3mR5rEdVrlCC5GB+f1GJ5tJvGsLVWMu35Cp
         2R3A==
X-Gm-Message-State: AGi0PuZKiHkJeVxNms+5TAOKqo2Wu4F9nO8f/FjNL8Ns7y1FybxdS4eo
        duK7PralVgjjMPESzfcT6k0fmMxywFxA4A==
X-Google-Smtp-Source: APiQypLcUxgmaOGnEDrDSlI9lIATbE5uv3KudtostRSms2/dzW+4agHTHuO43W+rAFqwTqyo65XcXg==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr14809736plv.250.1588175597385;
        Wed, 29 Apr 2020 08:53:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u3sm1397943pfb.105.2020.04.29.08.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:53:16 -0700 (PDT)
Date:   Wed, 29 Apr 2020 08:53:16 -0700 (PDT)
X-Google-Original-Date: Wed, 29 Apr 2020 08:46:39 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.7-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-bd053cce-6f5a-40f4-9e58-a5ee70cc73a1@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc4

for you to fetch changes up to a5fe13c7b49478c95e74f31f5b8b8347735684a7:

  riscv: select ARCH_HAS_STRICT_KERNEL_RWX only if MMU (2020-04-24 11:40:40 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.7-rc4

This tag contains a handful of fixes that I'd like to target for 5.7.
Specifically:

* The change of a linker argument to allow linking with lld.
* A build fix for configurations without a frame pointer.
* A handful of build fixes related the SBI 0.1 vs 0.2 split.
* The removal of STRICT_KERNEL_RWX for !MMU, which isn't useful

----------------------------------------------------------------
Damien Le Moal (1):
      riscv: select ARCH_HAS_STRICT_KERNEL_RWX only if MMU

Guenter Roeck (1):
      RISC-V: stacktrace: Declare sp_in_global outside ifdef

Ilie Halip (1):
      riscv: fix vdso build with lld

Kefeng Wang (3):
      riscv: sbi: Correct sbi_shutdown() and sbi_clear_ipi() export
      tty: riscv: Using RISCV_SBI_V01 instead of RISCV_SBI
      riscv: sbi: Fix undefined reference to sbi_shutdown

 arch/riscv/Kconfig              |  2 +-
 arch/riscv/kernel/sbi.c         | 17 ++++++++++-------
 arch/riscv/kernel/stacktrace.c  |  4 ++--
 arch/riscv/kernel/vdso/Makefile |  6 +++---
 drivers/tty/hvc/Kconfig         |  2 +-
 drivers/tty/serial/Kconfig      |  2 +-
 6 files changed, 18 insertions(+), 15 deletions(-)
