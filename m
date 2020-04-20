Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE7EC38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1440721927
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YQPKLkFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgDTQ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:56:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54609 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTQ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:56:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 495XsL4DYJz9txct;
        Mon, 20 Apr 2020 18:56:22 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YQPKLkFX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ia95URVpRcFs; Mon, 20 Apr 2020 18:56:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 495XsL3527z9txc3;
        Mon, 20 Apr 2020 18:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587401782; bh=8naV2yT/3Jan/cCUl+F/6oqhH9CCJ3NWFXowyqtwq6w=;
        h=From:Subject:To:Cc:Date:From;
        b=YQPKLkFXDfTrLeqB/NJuI38QF3DCOQPs/c2fYFvpNucqXa0OrJ26C3kvhjKlJaDwx
         Z2dsNp1mhKVWCzRYLB3UK3VDoE2GgNKzWAgQt8v9Z6rSjaItTHrxaYDjBGupRRH0ia
         8pj1YCKvBzyAV5hYb1s48pQ0vQcj36X3Yz5PkzrM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A6838B78E;
        Mon, 20 Apr 2020 18:56:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PbCr7gej4BIK; Mon, 20 Apr 2020 18:56:28 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4B0E8B78D;
        Mon, 20 Apr 2020 18:56:27 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A9AE7657AE; Mon, 20 Apr 2020 16:56:27 +0000 (UTC)
Message-Id: <cover.1587401492.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 0/7] powerpc: switch VDSO to C implementation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org
Date:   Mon, 20 Apr 2020 16:56:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh version of a series to switch powerpc VDSO to
generic C implementation.

Main changes since v6 are:
- Added -fasynchronous-unwind-tables in CFLAGS
- Split patch 2 in two parts
- Split patch 5 (which was patch 4) in two parts

This series applies on today's powerpc/merge branch.

See the last two patches for details on changes and performance.

Christophe Leroy (7):
  powerpc/vdso64: Switch from __get_datapage() to get_datapage inline
    macro
  powerpc/vdso: Remove __kernel_datapage_offset and simplify
    __get_datapage()
  powerpc/vdso: Remove unused \tmp param in __get_datapage()
  powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
  powerpc/vdso: Prepare for switching VDSO to generic C implementation.
  powerpc/vdso: Switch VDSO to generic C implementation.
  [NOT TO BE MERGED] Export sysrq_mask

 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/clocksource.h       |   7 +
 arch/powerpc/include/asm/processor.h         |  10 +-
 arch/powerpc/include/asm/vdso/clocksource.h  |   7 +
 arch/powerpc/include/asm/vdso/gettimeofday.h | 175 +++++++++++
 arch/powerpc/include/asm/vdso/processor.h    |  23 ++
 arch/powerpc/include/asm/vdso/vsyscall.h     |  25 ++
 arch/powerpc/include/asm/vdso_datapage.h     |  50 ++--
 arch/powerpc/kernel/asm-offsets.c            |  49 +---
 arch/powerpc/kernel/time.c                   |  91 +-----
 arch/powerpc/kernel/vdso.c                   |  58 +---
 arch/powerpc/kernel/vdso32/Makefile          |  32 +-
 arch/powerpc/kernel/vdso32/cacheflush.S      |   2 +-
 arch/powerpc/kernel/vdso32/config-fake32.h   |  34 +++
 arch/powerpc/kernel/vdso32/datapage.S        |   7 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S    | 291 +------------------
 arch/powerpc/kernel/vdso32/vdso32.lds.S      |   7 +-
 arch/powerpc/kernel/vdso32/vgettimeofday.c   |  29 ++
 arch/powerpc/kernel/vdso64/Makefile          |  23 +-
 arch/powerpc/kernel/vdso64/cacheflush.S      |   9 +-
 arch/powerpc/kernel/vdso64/datapage.S        |  31 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S    | 243 +---------------
 arch/powerpc/kernel/vdso64/vdso64.lds.S      |   7 +-
 arch/powerpc/kernel/vdso64/vgettimeofday.c   |  29 ++
 drivers/tty/sysrq.c                          |   1 +
 25 files changed, 444 insertions(+), 798 deletions(-)
 create mode 100644 arch/powerpc/include/asm/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/clocksource.h
 create mode 100644 arch/powerpc/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/powerpc/include/asm/vdso/processor.h
 create mode 100644 arch/powerpc/include/asm/vdso/vsyscall.h
 create mode 100644 arch/powerpc/kernel/vdso32/config-fake32.h
 create mode 100644 arch/powerpc/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/powerpc/kernel/vdso64/vgettimeofday.c

-- 
2.25.0

