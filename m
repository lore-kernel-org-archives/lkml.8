Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB96C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A7F23B24
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgHOVoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:44:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgHOVnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:43:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01972B042;
        Sat, 15 Aug 2020 10:07:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v4 0/6] x86/paravirt: cleanup after 32-bit PV removal
Date:   Sat, 15 Aug 2020 12:06:35 +0200
Message-Id: <20200815100641.26362-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of cleanup after removal of 32-bit Xen PV guest support in
paravirt code.

Changes in V4:
- dropped patches 1-3, as already committed
- addressed comments to V3
- added new patches 5+6

Changes in V3:
- addressed comments to V2
- split patch 1 into 2 patches
- new patches 3 and 7

Changes in V2:
- rebase to 5.8 kernel
- addressed comments to V1
- new patches 3 and 4

Juergen Gross (6):
  x86/paravirt: remove 32-bit support from PARAVIRT_XXL
  x86/paravirt: cleanup paravirt macros
  x86/paravirt: use CONFIG_PARAVIRT_XXL instead of CONFIG_PARAVIRT
  x86/entry/32: revert "Fix XEN_PV build dependency"
  x86/paravirt: remove set_pte_at pv-op
  x86/paravirt: avoid needless paravirt step clearing page table entries

 arch/x86/entry/entry_64.S                   |   4 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/include/asm/fixmap.h               |   2 +-
 arch/x86/include/asm/idtentry.h             |   4 +-
 arch/x86/include/asm/paravirt.h             | 151 +++-----------------
 arch/x86/include/asm/paravirt_types.h       |  23 ---
 arch/x86/include/asm/pgtable-3level_types.h |   5 -
 arch/x86/include/asm/pgtable.h              |   7 +-
 arch/x86/include/asm/required-features.h    |   2 +-
 arch/x86/include/asm/segment.h              |   4 -
 arch/x86/kernel/cpu/common.c                |   8 --
 arch/x86/kernel/kprobes/core.c              |   1 -
 arch/x86/kernel/kprobes/opt.c               |   1 -
 arch/x86/kernel/paravirt.c                  |  19 ---
 arch/x86/kernel/paravirt_patch.c            |  17 ---
 arch/x86/xen/enlighten_pv.c                 |   6 -
 arch/x86/xen/mmu_pv.c                       |   8 --
 include/trace/events/xen.h                  |  20 ---
 18 files changed, 27 insertions(+), 256 deletions(-)

-- 
2.26.2

