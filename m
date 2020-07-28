Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E481CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4482065E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 20:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgG1UWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:22:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56820 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgG1UWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 16:22:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2473328EA02
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/6] Reclaim x86 psABI TIF flags
Date:   Tue, 28 Jul 2020 16:22:23 -0400
Message-Id: <20200728202229.1195682-1-krisman@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set reduces the number of arch-specific TIF_ flags in x86, as
a clean up to reduce the pressure over the few remaining x86_32 TIF
bits and as a preparation to have the arch-agnostic TIF_ flags shared by
different architectures by the common syscall entry code recently
published by Thomas Gleixner.

This is based on top of:

git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

It was tested by booting and running an i386 rootfs over the 64bit
kernel, and also by running x32 binaries on top of it.

There is one remaining use of TIF_IA32 in User Mode Linux which is
turned off by a bogus define, such that I think it is currently dead
code and apparently a bug.  I think, it was wired to an old TIF_IA32
flag definition that doesn't exist anymore in arch/um.  I think it
deserves a fix other than dropping that code, but it is a different
piece of work that I will tackle next.

Gabriel Krisman Bertazi (6):
  arch: x86: Don't use TIF flags for mm context
  arch: x86: Wrap TIF_IA32 checks
  arch: x86: Wrap TIF_X32 checks
  arch: x86: Expose psABI on thread_info
  arch: x86: Reclaim TIF_IA32 flag
  arch: x86: Reclaim TIF_X32 flag

 arch/x86/entry/vdso/vma.c          |  2 +-
 arch/x86/events/core.c             |  4 ++--
 arch/x86/events/intel/ds.c         |  2 +-
 arch/x86/events/intel/lbr.c        |  2 +-
 arch/x86/include/asm/compat.h      |  2 +-
 arch/x86/include/asm/elf.h         |  2 +-
 arch/x86/include/asm/mmu_context.h |  2 +-
 arch/x86/include/asm/thread_info.h | 15 +++++++++++----
 arch/x86/kernel/perf_regs.c        |  2 +-
 arch/x86/kernel/process_64.c       | 16 ++++++----------
 arch/x86/oprofile/backtrace.c      |  2 +-
 11 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.27.0

