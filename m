Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B250206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="iiHDHGle"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgBLPmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:42:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgBLPmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:42:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so3035692wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Px26pf7EXM1W2V2xAjAh/vP9L1myxsWPT5mia8fyb6o=;
        b=iiHDHGleyiMEEbRFVTO5T0+iJy+NzduG/SZ3j/LsaT438a+ah2ZOpk6xVU54KoLTVu
         PX4Usu716O2rm0+bwNmlQpomsZGvjIwrYi1yYv5s5auhwMlcp4qtw0JsZT27tGROf6Xx
         1uCAinSeSG68QXsVsFp03rduLqSZ0dyIrupBKPw3EAHQkmtMTNsD5seR1JK2pWDB2/oy
         IreOw4Fea6Yts3IAM3WHzixkcaBpyAEmAFm8qXvhU5spd/vLH9I0ETXuDDHXAHUfaEwH
         tejNju+7uU3hAFgVhZY924LDQhTpiswmwDb65NVzf6pIlxwbGHfmirJrRgywgsfzWOel
         PkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Px26pf7EXM1W2V2xAjAh/vP9L1myxsWPT5mia8fyb6o=;
        b=m5EGS4H+ebp2mHQ0O+rJ95p3om/zfl6LcrylNQqbhogkbQ46CIGE/mKjjIgVuGsyk8
         vYJtZjAvTtyJRfTZEICPz7ErCRq3ENWN4aiXi2Egy0nI0hdSzvW3E//a5bQAL8qUabcl
         wMPCD1ForMlQ6TUT5MxLCDYYOVyOsGMksk96KNgNdUhZnLuZCfBnGHkj1Dgh4gQLcfrx
         OPSZaGjeoa4KupHWoM1cKoi3ES0LDfFouzv3aRz3TzyvsPhFOsKp9LnfQqQxfiPcEJRG
         U0u16g91naxgA7CaBvOQUQq+hMgLeXkYRtAnFWAPOf1X9lbURlJSUgOMjFY/NBQQGd36
         A/xQ==
X-Gm-Message-State: APjAAAUAlp8rqicc/UnUA6FD13BD30A1flHjip/nTcyaBEO10LzF4BcB
        +GKL0L/bgWMtF7v4uU5vYeyyiRlNt0EvUbNA
X-Google-Smtp-Source: APXvYqzooVJGC1YQxNy5tLKmbGFb3uxwSR328xav52qW4lNyZzFuzUwh5ZDo6+gW1ESNTOY+cC3ffQ==
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr13765397wmk.135.1581522150880;
        Wed, 12 Feb 2020 07:42:30 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id g2sm1000605wrw.76.2020.02.12.07.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 07:42:30 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/7] microblaze: Define SMP safe operations
Date:   Wed, 12 Feb 2020 16:42:22 +0100
Message-Id: <cover.1581522136.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is follow up series on the top of cleanup series available here.
https://lkml.org/lkml/2020/2/12/215
There are two things together.
1. Changes in cpuinfo structure in patches 1 and 2
2. Defining SMP safe operations instead of IRQ disabling

Microblaze has 32bit exclusive load/store instructions which should be used
instead of irq enable/disable. For more information take a look at
https://www.xilinx.com/support/documentation/sw_manuals/xilinx2019_2/ug984-vivado-microblaze-ref.pdf
starting from page 25.

Thanks,
Michal


Michal Simek (1):
  microblaze: timer: Don't use cpu timer setting

Stefan Asserhall (5):
  microblaze: Make cpuinfo structure SMP aware
  microblaze: Define SMP safe bit operations
  microblaze: Add SMP implementation of xchg and cmpxchg
  microblaze: Remove disabling IRQ while pte_update() run
  microblaze: Implement architecture spinlock

Stefan Asserhall load and store (1):
  microblaze: Do atomic operations by using exclusive ops

 arch/microblaze/include/asm/Kbuild           |   1 -
 arch/microblaze/include/asm/atomic.h         | 265 ++++++++++++++++++-
 arch/microblaze/include/asm/bitops.h         | 189 +++++++++++++
 arch/microblaze/include/asm/cmpxchg.h        |  87 ++++++
 arch/microblaze/include/asm/cpuinfo.h        |   2 +-
 arch/microblaze/include/asm/pgtable.h        |  19 +-
 arch/microblaze/include/asm/spinlock.h       | 240 +++++++++++++++++
 arch/microblaze/include/asm/spinlock_types.h |  25 ++
 arch/microblaze/kernel/cpu/cache.c           | 154 ++++++-----
 arch/microblaze/kernel/cpu/cpuinfo.c         |  38 ++-
 arch/microblaze/kernel/cpu/mb.c              | 207 ++++++++-------
 arch/microblaze/kernel/timer.c               |   2 +-
 arch/microblaze/mm/consistent.c              |   8 +-
 13 files changed, 1040 insertions(+), 197 deletions(-)
 create mode 100644 arch/microblaze/include/asm/bitops.h
 create mode 100644 arch/microblaze/include/asm/spinlock.h
 create mode 100644 arch/microblaze/include/asm/spinlock_types.h

-- 
2.25.0

