Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4200C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B423D21D7A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbgFSPHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:07:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390694AbgFSPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49pMbF4KHNz9v09k;
        Fri, 19 Jun 2020 17:06:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MKUyKzZbmliB; Fri, 19 Jun 2020 17:06:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49pMbF3KBSz9v09j;
        Fri, 19 Jun 2020 17:06:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 803898B879;
        Fri, 19 Jun 2020 17:06:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id txvLaR4ia8Ej; Fri, 19 Jun 2020 17:06:51 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E4088B868;
        Fri, 19 Jun 2020 17:06:51 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 11F0B65AF4; Fri, 19 Jun 2020 15:06:50 +0000 (UTC)
Message-Id: <cover.1592578278.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 0/8] powerpc/32s: Allocate modules outside of vmalloc space for STRICT_KERNEL_RWX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Jun 2020 15:06:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3s32 (hash), exec protection is set per 256Mb segments with NX bit.
Instead of clearing NX bit on vmalloc space when CONFIG_MODULES is selected,
allocate modules in a dedicated segment (0xb0000000-0xbfffffff by default).
This allows to keep exec protection on vmalloc space while allowing exec
on modules.

Christophe Leroy (8):
  powerpc/ptdump: Refactor update of st->last_pa
  powerpc/ptdump: Refactor update of pg_state
  powerpc: Set user/kernel boundary at TASK_SIZE instead of PAGE_OFFSET
  powerpc/lib: Prepare code-patching for modules allocated outside
    vmalloc space
  powerpc: Use MODULES_VADDR if defined
  powerpc/32s: Only leave NX unset on segments used for modules
  powerpc/32s: Kernel space starts at TASK_SIZE
  powerpc/32s: Use dedicated segment for modules with STRICT_KERNEL_RWX

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/book3s/32/pgtable.h | 15 ++----
 arch/powerpc/include/asm/page.h              |  2 +-
 arch/powerpc/kernel/head_32.S                | 12 ++---
 arch/powerpc/kernel/module.c                 | 11 ++++
 arch/powerpc/lib/code-patching.c             |  2 +-
 arch/powerpc/mm/book3s32/hash_low.S          |  2 +-
 arch/powerpc/mm/book3s32/mmu.c               | 17 +++++--
 arch/powerpc/mm/kasan/kasan_init_32.c        |  6 +++
 arch/powerpc/mm/ptdump/ptdump.c              | 53 ++++++++++++--------
 10 files changed, 78 insertions(+), 43 deletions(-)

-- 
2.25.0

