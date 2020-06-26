Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CC9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C36207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="GOIg3hTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgFZRka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFZRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:40:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A54C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:40:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so4525741plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=H5jNivKQc7Xy0+HbQegQizEbfkQBMIXMrjdDpo4xU28=;
        b=GOIg3hTtF5n+/he2cnf+Si31ylL8KVCeA64/aUZ6v0nVuzFHU7VxvWfuME1q7hbXes
         jwAnViQgZGQGyeXdPrjqHCxEBE52t+t4+eb9jhlN54o6viW1V7tltGamKof/8gSplttW
         VR0gPLMJeERAw0m7MABEBxVP6PcEealGaVAhl1JX2KZzFBoDCOA6vpiSIn0A0lnmjTEw
         0ORekmNdIp0NCVgTj9jdMcxVzXNHvLJEMzOkBfbq01VnX9M6IuEZD2LlEr7N6YzGpWTJ
         W06rMk2loOaAUAfJGYPXJN09XXwoOuHGSG8cNaGCsc7OaPDQNHHyDS6G6ziOufjs6raw
         EpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=H5jNivKQc7Xy0+HbQegQizEbfkQBMIXMrjdDpo4xU28=;
        b=lvKuzpRxsktjjfv4nUZjY19v9Bfyi2xQ12uoKZa42IyN24u52iVVop8DgtGnaftE9h
         ch1iKfwRXMC2+zKsrfQhd85jnMKUwe+tpdR63S0gOD9nRV3BMfCxiqCqOoKcr9tO2Wv2
         lnvNv43Zj3+cUtlvKbBQQqCQrKYcNa6qIL7YHm5QmtCzjTXwta9kVHGGJ6H/Ic8FuO+7
         21BLctgvSSrgDQF3DQC/7wfJZXIJRomywPsuO5muOChapHbXE02olwKF6hu8HjPWTjSd
         FU0f2H6Nmg3BLTPlOsph6+HPG28x3UDXYyAiTb/wApAJL3KVB0w8KzwdP/3Ofh91c2ML
         tdTA==
X-Gm-Message-State: AOAM532vKjX/zXAumRE3QXkpHHca2NBev1MG4EAJZltimcezVBseZopS
        f4MNp2qGQ7T0GmCePnjvTYKTz230zOzsPg==
X-Google-Smtp-Source: ABdhPJz19HMzR8QqhtQZxsKkdkG9LZ33lZPze8mK0ZqD92jHMiM1A6M2Ll2rpo23iGlWfetFLHsbIQ==
X-Received: by 2002:a17:90a:1b87:: with SMTP id w7mr4600230pjc.177.1593193229446;
        Fri, 26 Jun 2020 10:40:29 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n3sm21773706pgq.30.2020.06.26.10.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 10:40:28 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:40:28 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Jun 2020 10:40:26 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.8-rc3
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f93a0d3b-0f13-4426-8f7a-77c153f1098b@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc3

for you to fetch changes up to e05d57dcb8c71492268ff46ba9bfe9a9cfb1f95d:

  riscv: Fixup __vdso_gettimeofday broke dynamic ftrace (2020-06-25 15:38:39 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.8-rc3

This contains a handful of fixes I'd like to target for rc3.  Most of them fix
issues with the conversion of our vDSO to C.  There is also one fix to the
SiFive PRCI driver that I picked up as it's causing boot issues on the
hardware.

* A fix to allow kernels with dynamic ftrace to use the vDSO.
* Some build fixes for the C vDSO functions.
* A fix to the PRCI driver's memory allocation, which was the cause of some
  boot panics with FREELIST_RANDOM.

----------------------------------------------------------------
Guo Ren (1):
      riscv: Fixup __vdso_gettimeofday broke dynamic ftrace

Vincent Chen (3):
      riscv: Add -fPIC option to CFLAGS_vgettimeofday.o
      clk: sifive: allocate sufficient memory for struct __prci_data
      riscv: Add extern declarations for vDSO time-related functions

 arch/riscv/kernel/vdso/Makefile        | 5 ++++-
 arch/riscv/kernel/vdso/vgettimeofday.c | 6 ++++++
 drivers/clk/sifive/fu540-prci.c        | 5 ++++-
 3 files changed, 14 insertions(+), 2 deletions(-)
