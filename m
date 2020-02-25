Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75BC4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB324684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgBYXab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:30:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55543 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgBYXZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:52 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jZw-0004W0-9S; Wed, 26 Feb 2020 00:25:28 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9EAD3100375;
        Wed, 26 Feb 2020 00:25:27 +0100 (CET)
Message-Id: <20200225213636.689276920@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 22:36:36 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 00/10] x86/entry: Consolidation - Part I
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the first batch of a 73 patches series which consolidates the x86
entry code.

This work started off as a trivial 5 patches series moving the heavy
lifting of POSIX CPU timers out of interrupt context into thread/process
context. This discovered that KVM is lacking to handle pending work items
before entering guest mode and added the handling to the x86 KVM
code. Review requested to make this a generic infrastructure.

The next series grew to 25 patches implementing the generic infrastructure,
converting x86 (and as a POC ARM64) over, but it turned out that this was
slightly incomplete and still had some entanglement with the rest of the
x86 entry code as some of that functionality is shared between syscall and
interrupt entry/exit. And it also unearthed the nastyness of IOPL which got
already addressed in mainline.

This series addresses these issues in order to prepare for making the entry
from userspace and exit to userspace (and it's counterpart enter guest) a
generic infrastructure in order to restrict the necessary ASM work to the
bare minimum.

The series is split into 5 parts:

    - General cleanups and bugfixes

    - Consolidation of the syscall entry/exit code

    - Autogenerate simple exception/trap code and reduce the difference
      between 32 and 64 bit

    - Autogenerate complex exception/trap code and provide different entry
      points for #DB and #MC exceptions which allows to address the
      recently discovered RCU vs. world issues in a more structured way

    - Convert the device interrupt entry code to use the same mechanism as
      exceptions and traps and finally convert the system vectors over as
      well. The last step after all those cleanups is to move the return
      from exception/interrupt logic (user mode work, kernel preemption)
      completely from ASM into C-code, so the ASM code just has to take
      care about returning from the exception, which is horrible and
      convoluted enough already.

At the end the x86 entry code is ready to move the syscall parts out into
generic code and finally tackle the initial problem which started all of
this.

The complete series is available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

which contains all 73 patches. The individual parts are tagged, so this
part can be retrieved via:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part1

Thanks,

	tglx

8<---------------
 entry/entry_32.S          |   19 +++++++------------
 include/asm/irq.h         |    2 +-
 include/asm/mce.h         |    3 ---
 include/asm/traps.h       |   17 +++++++----------
 kernel/cpu/mce/core.c     |   12 ++++++++++--
 kernel/cpu/mce/internal.h |    3 +++
 kernel/irq.c              |    3 +--
 kernel/traps.c            |   41 ++++++++++++++++++++++++++++++++++-------
 8 files changed, 63 insertions(+), 37 deletions(-)
