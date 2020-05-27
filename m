Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E351C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC3D20C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgE0HbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38328 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgE0HbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TzmxyRy_1590564671;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzmxyRy_1590564671)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:12 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 0/5] x86/entry: simply stack switching when exception on userspace
Date:   Wed, 27 May 2020 07:31:02 +0000
Message-Id: <20200527073107.2127-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
has resulted that when exception on userspace, the kernel (error_entry)
always push the pt_regs to entry stack(sp0), and then copy them to the
kernel stack.

This is a hot path (for example page fault) and interrupt_entry
directly switches to kernel stack and pushes pt_regs to kernel stack.
We should do it for error_entry. This is the job of patch1,2.

Patch 3-5 simply stack switching for .Lerror_bad_iret by just doing
all the work in one function (fixup_bad_iret()).

The patch set is based on tip/master (c021d3d8fe45) (Mon May 25).

The diffstat is "66 insertions(+), 66 deletions(-)", but actually
it mainly adds comments and deletes code.

Cc: Andy Lutomirski <luto@kernel.org>,
Cc: Thomas Gleixner <tglx@linutronix.de>,
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Borislav Petkov <bp@alien8.de>,
Cc: x86@kernel.org,
Cc: "H. Peter Anvin" <hpa@zytor.com>,
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Lai Jiangshan (5):
  x86/entry: introduce macro idtentry_swapgs_and_switch_to_kernel_stack
  x86/entry: avoid calling into sync_regs() when entering from userspace
  x86/entry: directly switch to kernel stack when .Lerror_bad_iret
  x86/entry: remove unused sync_regs()
  x86/entry: don't copy to tmp in fixup_bad_iret

 arch/x86/entry/entry_64.S    | 89 ++++++++++++++++++++----------------
 arch/x86/include/asm/traps.h |  1 -
 arch/x86/kernel/traps.c      | 42 +++++++----------
 3 files changed, 66 insertions(+), 66 deletions(-)

-- 
2.20.1

