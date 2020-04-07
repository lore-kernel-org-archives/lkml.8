Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCD5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5312078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ga88shwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgDGNN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:13:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61041 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgDGNNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:13:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48xSXc0v7mz9ty2T;
        Tue,  7 Apr 2020 15:13:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ga88shwg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Qz2HClTgpfVO; Tue,  7 Apr 2020 15:13:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48xSXb6sw4z9vDCK;
        Tue,  7 Apr 2020 15:13:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586265232; bh=UPDaSeoTITdgPbCgjM+NltBDEuNbcuKw8CZpyU9Hygc=;
        h=From:Subject:To:Cc:Date:From;
        b=ga88shwg2cV5JbrbDN0iaLvKTTDp6xX/kUFvNXkf06MwgEuWn8G9ut4c4/Gkt1cEy
         E9PH1gUTmE5XdHek3cBS7Q1jq4VQCPEhK7u7eYXsFjP4+ZLEDU3+ezn6OUbSS5+scv
         6I0l+QqwO35OVqI+hWCYdhksoyyChP/4/EyF3KRA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2A4E8B7B9;
        Tue,  7 Apr 2020 15:13:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TngpBxE_ZTa0; Tue,  7 Apr 2020 15:13:52 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 825F58B79C;
        Tue,  7 Apr 2020 15:13:52 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 374F765746; Tue,  7 Apr 2020 13:13:52 +0000 (UTC)
Message-Id: <cover.1586265010.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 0/4] powerpc: switch VDSO to C implementation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org
Date:   Tue,  7 Apr 2020 13:13:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sixth version of a series to switch powerpc VDSO to generic
C implementation. There is no major change since v5, mainly rebasing.
Generic changes are all in linus/master now, so the series only
includes powerpc parts now.

Patch 3 is new, required following rework of header files for VDSO.

This series applies on today's powerpc/merge branch.

See the last patch for details on changes and performance.

Christophe Leroy (4):
  powerpc/vdso64: Switch from __get_datapage() to get_datapage inline
    macro
  powerpc/vdso: Remove __kernel_datapage_offset and simplify
    __get_datapage()
  powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
  powerpc/vdso: Switch VDSO to generic C implementation.

 arch/powerpc/Kconfig                         |   2 +
 arch/powerpc/include/asm/clocksource.h       |   7 +
 arch/powerpc/include/asm/processor.h         |  10 +-
 arch/powerpc/include/asm/vdso/clocksource.h  |   7 +
 arch/powerpc/include/asm/vdso/gettimeofday.h | 175 +++++++++++
 arch/powerpc/include/asm/vdso/processor.h    |  23 ++
 arch/powerpc/include/asm/vdso/vsyscall.h     |  25 ++
 arch/powerpc/include/asm/vdso_datapage.h     |  51 ++--
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
 24 files changed, 443 insertions(+), 799 deletions(-)
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

