Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53BAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD2F206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 18:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="xqchFIz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGYSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 14:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGYSaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 14:30:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E36C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:30:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so7143177pgg.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 11:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=RpLA+fP+DoLvbUEvg6utInkVa5lt66wslkma7Mkucds=;
        b=xqchFIz3EfC5rjOlPK5SwVCU2Hutak9YpYOb4GS4j6KEy8w82eIBqWXUjJJl0vra0x
         jFtrQzf50jI+hRpAQo6UreFtU1A2Y2A5IHDPuxl6BuBOVzXt8jckw6w4BkMrdrRsBOEl
         XRrD+de4uODky1/HBnJjoaMcTJEbVSuTwGgi06M7IUeKdTNfXVGYISY0F4pSS+nsNn0h
         pVsBgDhzVlMOikrsFsi3XK+RgoI0EvzP2OTKhEL11N3YTXDoGz5lVWBcOzu48WpDBf8Q
         xBmEwTOJ1nXSliKHw9kpDyYIHH0pNKkw2XBDYjbCo9pxvzcvyLdDOGff1O74u9pBzFqd
         eQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=RpLA+fP+DoLvbUEvg6utInkVa5lt66wslkma7Mkucds=;
        b=DuBx9i3p5ZcHv1zefMhEc2U5kjzEMOgEhD/BrxUHU02ePSKpg8Q2S6dkAoswYzvnCe
         W+bgG1TnQbj+C0qcpPhEK/O/4O8vNHoLCzr58ZttTLepHT47abmNtvFfe1Vin5I2ak8T
         /oJOJANItSoyWA6Vgj2caJViaHHzOeQQxyjWui8AaKCyY7/2y7qWYUnS91bvWnSpTyh4
         ljDgSOLGbhNYxTFRBL/hrPdQfEB3W7JYwRWqOKdtvfw82pmHBXQM2SlZSe43u5wM7k85
         EiIR2CtLbgo522NI1NnK9BYUBnVImDHTdVAPUzDyOZNr+rV8wZO1VNPmVuX9N7RO9JTe
         l0Dg==
X-Gm-Message-State: AOAM533LADzCP40MPEMGEHbObY5hL2UpNvpSTZFkK4exOV2Zp7d73KZ9
        2s6lIMU4kdKWvremqt0apsEz/Q==
X-Google-Smtp-Source: ABdhPJzkcgAw5QaTaebC9kG4nrkATQ3qDp2O73dkpdQpImjpzDubCoAEBaBw4g8NzSFaCp5LppMGGw==
X-Received: by 2002:a62:b409:: with SMTP id h9mr13600700pfn.305.1595701854895;
        Sat, 25 Jul 2020 11:30:54 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u8sm9276274pjn.24.2020.07.25.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 11:30:54 -0700 (PDT)
Date:   Sat, 25 Jul 2020 11:30:54 -0700 (PDT)
X-Google-Original-Date: Sat, 25 Jul 2020 11:29:26 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.8-rc7
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f2bb3f7e-e2d6-48e5-a8f6-5e47edf5441e@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc7

for you to fetch changes up to fa5a198359053c8e21dcc2b39c0e13871059bc9f:

  riscv: Parse all memory blocks to remove unusable memory (2020-07-24 22:08:25 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.8-rc7

I have a few more fixes this week:

* A fix to avoid using SBI calls during kasan initialization, as the SBI calls
  themselves have not been probed yet.
* Three fixes related to systems with multiple memory regions.

----------------------------------------------------------------
Atish Patra (3):
      RISC-V: Set maximum number of mapped pages correctly
      RISC-V: Do not rely on initrd_start/end computed during early dt parsing
      riscv: Parse all memory blocks to remove unusable memory

Vincent Chen (1):
      riscv: kasan: use local_tlb_flush_all() to avoid uninitialized __sbi_rfence

 arch/riscv/mm/init.c       | 66 +++++++++++++++++++++++++++++++---------------
 arch/riscv/mm/kasan_init.c |  4 +--
 2 files changed, 47 insertions(+), 23 deletions(-)
