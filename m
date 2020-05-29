Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A687C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A07A207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgE2I03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:26:29 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:34987 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2I01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:26:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TzyIzVr_1590740783;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzyIzVr_1590740783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 16:26:24 +0800
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
Subject: [PATCH V2 0/4] x86/entry: simply stack switching when exception on userspace
Date:   Fri, 29 May 2020 08:26:13 +0000
Message-Id: <20200529082618.1697-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87mu5roov6.fsf@nanos.tec.linutronix.de>
References: <87mu5roov6.fsf@nanos.tec.linutronix.de>
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

And recent x86/entry work makes interrupt also use idtentry
and makes all the interrupt code save the pt_regs on the sp0 stack
and then copy it to the thread stack like exception.

This is hot path (page fault, ipi), such overhead should be avoided.
And the original interrupt_entry directly switches to kernel stack
and pushes pt_regs to kernel stack. We should do it for error_entry.
This is the job of patch1.

Patch 2-4 simply stack switching for .Lerror_bad_iret by just doing
all the work in one function (fixup_bad_iret()).

The patch set is based on tip/x86/entry (28447ea41542) (May 20).

Changed from V1:
	based on tip/master -> based on tip/x86/entry

	patch 1 replaces the patch1,2 of V1, it borrows the
	original interrupt_entry's code into error_entry.

	patch2-4 is V1's patch3-5, unchanged (but rebased)

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

Lai Jiangshan (4):
  x86/entry: avoid calling into sync_regs() when entering from userspace
  x86/entry: directly switch to kernel stack when .Lerror_bad_iret
  x86/entry: remove unused sync_regs()
  x86/entry: don't copy to tmp in fixup_bad_iret

 arch/x86/entry/entry_64.S    | 52 +++++++++++++++++++++++-------------
 arch/x86/include/asm/traps.h |  1 -
 arch/x86/kernel/traps.c      | 42 ++++++++++++-----------------
 3 files changed, 51 insertions(+), 44 deletions(-)

-- 
2.20.1

