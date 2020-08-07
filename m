Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3160B22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHGIid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:38:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:59566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgHGIid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:38:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 058FFAAC7;
        Fri,  7 Aug 2020 08:38:49 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Subject: [PATCH v3 0/7] Remove 32-bit Xen PV guest support
Date:   Fri,  7 Aug 2020 10:38:19 +0200
Message-Id: <20200807083826.16794-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The long term plan has been to replace Xen PV guests by PVH. The first
victim of that plan are now 32-bit PV guests, as those are used only
rather seldom these days. Xen on x86 requires 64-bit support and with
Grub2 now supporting PVH officially since version 2.04 there is no
need to keep 32-bit PV guest support alive in the Linux kernel.
Additionally Meltdown mitigation is not available in the kernel running
as 32-bit PV guest, so dropping this mode makes sense from security
point of view, too.

Changes in V3:
- addressed comments to V2
- split patch 1 into 2 patches
- new patches 3 and 7

Changes in V2:
- rebase to 5.8 kernel
- addressed comments to V1
- new patches 3 and 4

Juergen Gross (7):
  x86/xen: remove 32-bit Xen PV guest support
  x86/xen: eliminate xen-asm_64.S
  x86/xen: drop tests for highmem in pv code
  x86/paravirt: remove 32-bit support from PARAVIRT_XXL
  x86/paravirt: cleanup paravirt macros
  x86/paravirt: use CONFIG_PARAVIRT_XXL instead of CONFIG_PARAVIRT
  x86/entry/32: revert "Fix XEN_PV build dependency"

 arch/x86/entry/entry_32.S                   | 109 +----
 arch/x86/entry/entry_64.S                   |   4 +-
 arch/x86/entry/vdso/vdso32/note.S           |  30 --
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/idtentry.h             |   4 +-
 arch/x86/include/asm/paravirt.h             | 107 +----
 arch/x86/include/asm/paravirt_types.h       |  21 -
 arch/x86/include/asm/pgtable-3level_types.h |   5 -
 arch/x86/include/asm/proto.h                |   2 +-
 arch/x86/include/asm/required-features.h    |   2 +-
 arch/x86/include/asm/segment.h              |   6 +-
 arch/x86/kernel/cpu/common.c                |   8 -
 arch/x86/kernel/head_32.S                   |  31 --
 arch/x86/kernel/kprobes/core.c              |   1 -
 arch/x86/kernel/kprobes/opt.c               |   1 -
 arch/x86/kernel/paravirt.c                  |  18 -
 arch/x86/kernel/paravirt_patch.c            |  17 -
 arch/x86/xen/Kconfig                        |   3 +-
 arch/x86/xen/Makefile                       |   3 +-
 arch/x86/xen/apic.c                         |  17 -
 arch/x86/xen/enlighten_pv.c                 |  78 +---
 arch/x86/xen/mmu_pv.c                       | 488 ++++----------------
 arch/x86/xen/p2m.c                          |   6 +-
 arch/x86/xen/setup.c                        |  36 +-
 arch/x86/xen/smp_pv.c                       |  18 -
 arch/x86/xen/vdso.h                         |   6 -
 arch/x86/xen/xen-asm.S                      | 193 +++++++-
 arch/x86/xen/xen-asm_32.S                   | 185 --------
 arch/x86/xen/xen-asm_64.S                   | 192 --------
 arch/x86/xen/xen-head.S                     |   6 -
 drivers/xen/Kconfig                         |   4 +-
 32 files changed, 305 insertions(+), 1299 deletions(-)
 delete mode 100644 arch/x86/xen/vdso.h
 delete mode 100644 arch/x86/xen/xen-asm_32.S
 delete mode 100644 arch/x86/xen/xen-asm_64.S

-- 
2.26.2

