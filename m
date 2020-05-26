Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B590C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE8207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgEZBm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:42:26 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43339 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387794AbgEZBm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:42:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TzfuFxZ_1590457343;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzfuFxZ_1590457343)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 09:42:24 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [RFC PATCH V2 0/7] x86/DB: protects more cpu entry data and
Date:   Tue, 26 May 2020 01:42:14 +0000
Message-Id: <20200526014221.2119-1-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

The patchset is based on (tag: entry-v9-the-rest, tglx-devel/x86/entry).
And it is complement of 3ea11ac991d
("x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area").

After reading the code, we can see that more data needs to be protected
against hw_breakpoint, otherwise it may cause
dangerous/recursive/unwanted #DB.

This patch also remove IST-shifting(patch 5-7). Because tglx work includes
debug_enter() which disables nested #DB.
Patch 5-7 depends tglx'w work only by now; they don't depends on Peter's
patchset[3], but this patch 6 should be discarded when they are mareged
with Peter's work.

Actually, I beg/hope Peter incorporate this V2 patchset into his patchset
which will be incorporated to tglx work. Because this V2 patchset
doesn't protect debug_idt_table and patch6 conflicts with Peter's
work.

Changed from V1
  Protect the full cpu_tlbstate structure to be sure. Suggested
	by Peter.
  Drop the last patch of the V1 because debug_idt_table is removed
	in Peter's patchset[3].
  remove IST-shifting

Lai Jiangshan (7):
  x86/hw_breakpoint: add within_area() to check data breakpoints
  x86/hw_breakpoint: Prevent data breakpoints on direct GDT
  x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
  x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask
  x86/entry: don't shift stack on #DB
  x86/entry: is_debug_stack() don't check of DB1 stack
  x86/entry: remove DB1 stack and DB2 hole from cpu entry area

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20200505134058.272448010@linutronix.de
Link: https://lore.kernel.org/lkml/20200521200513.656533920@linutronix.de
Link: https://lkml.kernel.org/r/20200522204738.645043059@infradead.org

 arch/x86/entry/entry_64.S             | 17 --------
 arch/x86/include/asm/cpu_entry_area.h | 12 ++---
 arch/x86/kernel/asm-offsets_64.c      |  5 ---
 arch/x86/kernel/dumpstack_64.c        | 10 ++---
 arch/x86/kernel/hw_breakpoint.c       | 63 +++++++++++++++++++++++----
 arch/x86/kernel/nmi.c                 |  7 +--
 arch/x86/mm/cpu_entry_area.c          |  4 +-
 7 files changed, 63 insertions(+), 55 deletions(-)

-- 
2.20.1

