Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E827C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7B206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="RqjG6Pnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBLI6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45831 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgBLI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so1169244wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X7I2sHXgwnUmY5Vkr2RXcfgewlHlO/eg+zNxBV2bmAY=;
        b=RqjG6Pnkaa9BhAuADKTdZHnLAQ5drpDMM5J8CAWLTdqPhRuH4JLvaYvHRo+bBJKm72
         JIQnkujwqaRBM6rMdRNijve4CmQ7EdyYv2P2ygNXU5U1WNgzvmM50/eGiWYE64ziMnNM
         S+p+AK/0i/gPKGNxWyhQOr5QXocTF9ASVvgLGMadB98jUKq1xcrpL0St1LkRZU/pf8h3
         ENIsR47vMaBz7e7izzwGdeKiPBOBv4udtGeTVt2Cd1Y19i2aDHPspZ1e+CdYcCNOj6dn
         iOemIns/Wzhw0z3B8IqooCpLGIhw+BM9m1tBd8PZRHGeEokp6pzpNkMX2SHeEccb4Otp
         eNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=X7I2sHXgwnUmY5Vkr2RXcfgewlHlO/eg+zNxBV2bmAY=;
        b=XjiDOFly9nHFNyigj03QCf6riEz2e07/al+tvFUV1yRL+F//OKu+AWQAv1npXsyDZM
         I83fwMBgSOULrtCpVmsxgofrSMb8MT6dZMQcGbunjYwuZLRQATE/jqdtJ28BDTDFSNKU
         biCvKEWJKElMMk55aIUM8cMB2Diiaez0dv+uoLJUR0WIcN7gSc/pqF1fOSI9T+JkLZeR
         dHFtCcn8HrexYYkZwKtWs88vhmT/vNJQR1K7+I96odoFAbV4kZkvdKXZlXP5fHptwwBk
         9JOzcgL1cmcLWo5gQZwW+I9kCxrR8uDF65dhNG8p+gRxUvkbC43wNeuEEIwzMUeHCSeQ
         bdqA==
X-Gm-Message-State: APjAAAWYMvLDgH/MQTtaceFDNOfbchN/MaDAgCgFkWv4O/TqAEgVupsR
        3xnx17qb8RL7Ta7I0F/Xnc/TJaXywL4TfLHv
X-Google-Smtp-Source: APXvYqwA6qWzhLmYIKvP9xc4dkKi5GuC5WWanwljLzJcUKxYhtnJ5FREJgPrcAaS1CgYSlKPIHdoDQ==
X-Received: by 2002:a5d:55c1:: with SMTP id i1mr15134022wrw.347.1581497889048;
        Wed, 12 Feb 2020 00:58:09 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id x132sm9167703wmg.0.2020.02.12.00.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:08 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Cornelia Huck <cohuck@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mubin Sayyed <mubinusm@xilinx.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Siva Durga Prasad Paladugu <siva.durga.paladugu@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 00/10] Hi,
Date:   Wed, 12 Feb 2020 09:57:57 +0100
Message-Id: <cover.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am sending this series as before SMP support.
Most of these patches are clean ups and should be easy to review them. I
expect there will be more discussions about SMP support.

There could be some optimization added based on
https://lkml.org/lkml/2020/2/10/1528

Thanks,
Michal


Michal Simek (6):
  microblaze: Convert headers to SPDX license
  microblaze: Remove architecture tlb.h and use generic one
  microblaze: Remove early printk setup
  microblaze: Remove empty headers
  microblaze: Remove unused boot_cpuid variable
  microblaze: Use asm generic cmpxchg.h for !SMP case

Stefan Asserhall (4):
  microblaze: Define microblaze barrier
  microblaze: Add sync to tlb operations
  microblaze: Add missing irqflags.h header
  microblaze: Define percpu sestion in linker file

 arch/microblaze/include/asm/Kbuild            |  4 +-
 arch/microblaze/include/asm/barrier.h         | 13 ++++++
 arch/microblaze/include/asm/cache.h           |  5 +--
 arch/microblaze/include/asm/cacheflush.h      |  6 +--
 arch/microblaze/include/asm/checksum.h        |  5 +--
 arch/microblaze/include/asm/cmpxchg.h         | 40 ++-----------------
 arch/microblaze/include/asm/cpuinfo.h         |  5 +--
 arch/microblaze/include/asm/cputable.h        |  1 -
 arch/microblaze/include/asm/current.h         |  5 +--
 arch/microblaze/include/asm/delay.h           |  7 +---
 arch/microblaze/include/asm/dma.h             |  5 +--
 arch/microblaze/include/asm/elf.h             |  5 +--
 arch/microblaze/include/asm/entry.h           |  5 +--
 arch/microblaze/include/asm/exceptions.h      |  5 +--
 arch/microblaze/include/asm/fixmap.h          |  5 +--
 arch/microblaze/include/asm/flat.h            |  5 +--
 arch/microblaze/include/asm/hw_irq.h          |  1 -
 arch/microblaze/include/asm/io.h              |  5 +--
 arch/microblaze/include/asm/irq.h             |  5 +--
 arch/microblaze/include/asm/irqflags.h        |  5 +--
 arch/microblaze/include/asm/mmu.h             |  5 +--
 arch/microblaze/include/asm/mmu_context_mm.h  |  5 +--
 arch/microblaze/include/asm/module.h          |  5 +--
 arch/microblaze/include/asm/page.h            |  5 +--
 arch/microblaze/include/asm/pgalloc.h         |  5 +--
 arch/microblaze/include/asm/pgtable.h         |  5 +--
 arch/microblaze/include/asm/processor.h       |  5 +--
 arch/microblaze/include/asm/ptrace.h          |  5 +--
 arch/microblaze/include/asm/pvr.h             |  5 +--
 arch/microblaze/include/asm/registers.h       |  5 +--
 arch/microblaze/include/asm/sections.h        |  5 +--
 arch/microblaze/include/asm/setup.h           |  7 +---
 arch/microblaze/include/asm/string.h          |  5 +--
 arch/microblaze/include/asm/switch_to.h       |  5 +--
 arch/microblaze/include/asm/thread_info.h     |  5 +--
 arch/microblaze/include/asm/timex.h           |  5 +--
 arch/microblaze/include/asm/tlb.h             | 17 --------
 arch/microblaze/include/asm/tlbflush.h        |  5 +--
 arch/microblaze/include/asm/uaccess.h         |  5 +--
 arch/microblaze/include/asm/unaligned.h       |  5 +--
 arch/microblaze/include/asm/unistd.h          |  5 +--
 arch/microblaze/include/asm/unwind.h          |  5 +--
 arch/microblaze/include/asm/user.h            |  1 -
 arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c |  7 +---
 arch/microblaze/kernel/cpu/pvr.c              |  1 +
 arch/microblaze/kernel/misc.S                 |  3 +-
 arch/microblaze/kernel/setup.c                |  1 -
 arch/microblaze/kernel/vmlinux.lds.S          |  3 ++
 48 files changed, 62 insertions(+), 215 deletions(-)
 create mode 100644 arch/microblaze/include/asm/barrier.h
 delete mode 100644 arch/microblaze/include/asm/cputable.h
 delete mode 100644 arch/microblaze/include/asm/hw_irq.h
 delete mode 100644 arch/microblaze/include/asm/tlb.h
 delete mode 100644 arch/microblaze/include/asm/user.h

-- 
2.25.0

