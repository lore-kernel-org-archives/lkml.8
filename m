Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF6FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598C920663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="dDt/3eIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgEVSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:01:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D446C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:01:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so5337832pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=rD8FJvrr0fC2ieKuRxFHZchacDqiMocM1Gb2Kxm//Vs=;
        b=dDt/3eITjzRN4TUYt+d7Zp8lrPurA2/TZD2ebIN5BAPbwEdBaQtDJyPNYul2loH6OG
         sH4zthUeuoWnFm1wXBDERLHVx5+LxPNrqrC+U+C1u5sg4nn17+dtK/VO/BcZ0v35HMB9
         LiDm/+lgyHC2CaRVrOUNeftcOPs/yZbGiK8fnnv6bjju/HyKCcVpSQcm8tEpqsTBpfla
         u904r5FiUoAhNt9ZIFfXXAY+nW1Vro+S58Hc69Weede8JkBU6FWd+5Opm+OIf5FeClJt
         EQ4viSX1ptlh9+aylekROeXpFArGMnJOFROr+EZOxnHUfHAbTTQ6rdD3bIGvyoOlxRHL
         TCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=rD8FJvrr0fC2ieKuRxFHZchacDqiMocM1Gb2Kxm//Vs=;
        b=uWAAmLbPj2aRtxJykj8JDNh7SlvpgDB4yO/xbWNMFXHOpeRP2Vt5h7WitIQr5Og5qc
         wHsfytYyGujMd8OgWHk3buClxzUrRqu1GhN6bqD5DwvgwSq2meTA5tgQCJ4eMGsO2uAW
         q9zfBnIddOGL8LwHyKlAcvxTChc+goaaN3NEXVOv7N7L9O41Ds+KLGDx8RdLVPyoY/W4
         29503CHO63vTwjyMdDAXZjmm9K9kIPe2QROGDxW0tZCnI6ChU9hzA/FFZB5KnglsKo1M
         edSi3VCrNSf5NV9kD0L3SS1mmRAP2Wnifbqlj8vf90TS8dbqqbR+5UL6l0/c8zqONW2n
         aKzQ==
X-Gm-Message-State: AOAM533aCQMcwC+YkqTkyqvVZYr9+uX/VDJQHqi8/x/HkCgnLX6ISoaW
        dEUlmdYe/Sf5U1ZxRsyI0VnRzk4vaR4KcA==
X-Google-Smtp-Source: ABdhPJxjmVU9uuWtPRJsTb3MP4L7ia/njIBcR4S0BXftGNI5B0ZPqVM7lLCKJWfVpeRv0/YQHhOZWA==
X-Received: by 2002:a62:b503:: with SMTP id y3mr5073233pfe.3.1590170466372;
        Fri, 22 May 2020 11:01:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w12sm5950957pjb.11.2020.05.22.11.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 11:01:05 -0700 (PDT)
Date:   Fri, 22 May 2020 11:01:05 -0700 (PDT)
X-Google-Original-Date: Fri, 22 May 2020 10:54:02 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.7-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-258df3d4-aa39-484e-9fde-7d93432f3205@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.7-rc7

for you to fetch changes up to 8356c379cfba8b1b90b0a2423f6afbbe2cdc5d91:

  RISC-V: gp_in_global needs register keyword (2020-05-21 13:28:26 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.7-rc7

This tag contains two fixes:

* Another !MMU build fix that was a straggler from last week.
* A fix to use the "register" keyword for the GP global register variable.

----------------------------------------------------------------
Kefeng Wang (1):
      riscv: Fix print_vm_layout build error if NOMMU

Palmer Dabbelt (1):
      RISC-V: gp_in_global needs register keyword

 arch/riscv/kernel/process.c | 2 +-
 arch/riscv/mm/init.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
