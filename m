Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE649C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DCE2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgEEOQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729295AbgEEOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC632C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:02 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMK-0001mm-ND; Tue, 05 May 2020 16:15:44 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 448D9FFC8D;
        Tue,  5 May 2020 16:15:44 +0200 (CEST)
Message-Id: <20200505134926.578885807@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:49:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 4 00/24] x86/entry: Entry/exception code rework, nasty
 exceptions
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

This is the forth part of the rework series. Part 3 can be found here:

 https://lore.kernel.org/r/20200505134354.774943181@linutronix.de

The series has a total of 138 patches and is split into 5 parts. The base
for this 4th series is:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-3

The full series with all parts applied is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-5

The forth part, i.e. this series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-4
 
This part contains the modifications for complex and nasty exceptions and traps:

 - Conversion of int3 including a full isolation of the text poke handler
   so it is fully self contained, i.e does not call out into any
   instrumentable code.

 - Conversion of NMI handling including protection against instrumentation

 - Conversion of #DB with separation of the user and kernel mode entries

 - Conversion of #MC and #DF

The objtool check for the noinstr.text correctness is not yet added to the
build machinery and has to be invoked manually for now:

   objtool check -fal vmlinux.o

The checking only works for builtin code as objtool cannot do a combined
analysis of vmlinux.o and a module.o

Thanks,

	tglx

8<----------
 arch/x86/entry/entry_32.S            |   38 ----
 arch/x86/entry/entry_64.S            |   35 +---
 arch/x86/include/asm/desc.h          |    8 
 arch/x86/include/asm/idtentry.h      |  235 +++++++++++++++++++++++++++++
 arch/x86/include/asm/mce.h           |    2 
 arch/x86/include/asm/ptrace.h        |    2 
 arch/x86/include/asm/text-patching.h |   11 -
 arch/x86/include/asm/traps.h         |   23 --
 arch/x86/kernel/alternative.c        |   25 +--
 arch/x86/kernel/cpu/common.c         |    6 
 arch/x86/kernel/cpu/mce/core.c       |   91 ++++++++---
 arch/x86/kernel/cpu/mce/inject.c     |    4 
 arch/x86/kernel/cpu/mce/internal.h   |    2 
 arch/x86/kernel/cpu/mce/p5.c         |    8 
 arch/x86/kernel/cpu/mce/winchip.c    |    8 
 arch/x86/kernel/doublefault_32.c     |   10 -
 arch/x86/kernel/hw_breakpoint.c      |    6 
 arch/x86/kernel/idt.c                |   22 +-
 arch/x86/kernel/nmi.c                |   14 -
 arch/x86/kernel/traps.c              |  283 ++++++++++++++++++++++++-----------
 arch/x86/kvm/vmx/vmx.c               |    2 
 arch/x86/xen/enlighten_pv.c          |   17 +-
 arch/x86/xen/xen-asm_64.S            |   12 -
 include/linux/bsearch.h              |   26 ++-
 kernel/time/timekeeping.c            |    2 
 lib/bsearch.c                        |   22 --
 26 files changed, 615 insertions(+), 299 deletions(-)
