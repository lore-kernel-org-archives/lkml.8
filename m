Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03601C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78892073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="F/LJ87qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgGRRfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRRft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:35:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E8CC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:35:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so6796579plr.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=l2FZ7oR0iH+dV0VFe8SLUNQFAZ2SW0iIFMXf/4eW8nY=;
        b=F/LJ87qmPPTO72ZK++07I1iiJQOdrA97yTEzY7B88gKPqBo30ZJ0PWT57aqxfrYGW3
         QpUdY9qGjazdDiSZUuOR7+cSDDULQWid4lWd8vtlnuPDo729B8HJnSRu0L80cGUUJHvx
         ah4gkAEuIRYw9IT9e1Kzv/0xxnOOxBnaQ3m/Pr2LXckuCjCWFgEoXI67GZv5mBail87k
         k6pZShvqHbbg1d1HQtNbZ1Q63nqYQKgAeZP46r9TFlFaIYXFfZvsB4zbS66O5f8x5iMA
         tY1V9rmShtaQ92XJrALN73cVrgebvm+3zmlm5UUN14e/lQtdqMfvVhQ0KrjmrdBDXrCA
         0+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=l2FZ7oR0iH+dV0VFe8SLUNQFAZ2SW0iIFMXf/4eW8nY=;
        b=YO2Ov5ETOUzJZfhm/tj0ouWphYiKXXyOLLIESQzWKIK3U1cEa1PVjr7uiMafeIYVJa
         OCcWj1X7k4Pu9s23RRAM4JypqOK3ZxyzasNGTspHFtrYh1fd26vpxz7ZV/BzE0oLcgWi
         p0mPWgMyps6rb6TfaAbNAWH+6hpu+vYc4UUZWaDfxzBPXdCiRnLEKX/5+segBdgn3yuZ
         PBsg7Psus1ItfUdL63Kn96SrOBQBZekySQm+8FrfISWZapHPaZyMgauKsGjYV+M4gA12
         HcbkSECOFP7Amn/JFgXV18I2fCll1EBjAkUJo3SzRqzUTWm22Rh/b6Ey0frGU7csBp09
         XrLA==
X-Gm-Message-State: AOAM530PozdnJnRJdajkNrmjwX8ThPBJINmaN7Jl6BVf+VqVek0STYPx
        axclbIKSwQZ6oyhBCAHs0urVB9ON+9M=
X-Google-Smtp-Source: ABdhPJyM+7tjQzDyzZwemOxPVfXva4sA20bASkMza4n2t3bzqdHihtcvvhJf6uB4UNbxcHgdnz0ydA==
X-Received: by 2002:a17:902:7b90:: with SMTP id w16mr11167369pll.253.1595093748890;
        Sat, 18 Jul 2020 10:35:48 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r25sm6434604pgv.88.2020.07.18.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 10:35:48 -0700 (PDT)
Date:   Sat, 18 Jul 2020 10:35:48 -0700 (PDT)
X-Google-Original-Date: Sat, 18 Jul 2020 10:35:45 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.8-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8419056a-6b67-4a07-b5a2-6ca837bb9b9d@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-rc6

for you to fetch changes up to 38b7c2a3ffb1fce8358ddc6006cfe5c038ff9963:

  RISC-V: Upgrade smp_mb__after_spinlock() to iorw,iorw (2020-07-17 09:28:35 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.8-rc6

I have two fixes:

* 16KiB kernel stacks on rv64, which fixes a lot of crashes.
* Rolling an mmiowb() into the scheduled, which when combined with Will's fix
  to the mmiowb()-on-spinlock should fix the PREEMPT issues we've been seeing.

----------------------------------------------------------------
Andreas Schwab (1):
      riscv: use 16KB kernel stack on 64-bit

Palmer Dabbelt (1):
      RISC-V: Upgrade smp_mb__after_spinlock() to iorw,iorw

 arch/riscv/include/asm/barrier.h     | 10 +++++++++-
 arch/riscv/include/asm/thread_info.h |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)
