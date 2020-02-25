Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ADC4BA06
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79F24685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgBYX1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:27:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55934 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbgBYX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:41 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jas-00051Q-1H; Wed, 26 Feb 2020 00:26:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id EBD051039F7;
        Wed, 26 Feb 2020 00:25:50 +0100 (CET)
Message-Id: <20200225224719.950376311@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:47:19 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 00/15] x86/entry: Consolidation - Part V
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the fifthh batch of a 73 patches series which consolidates the x86
entry code. The larger explanation is in the part I cover letter:

 https://lore.kernel.org/r/20200225213636.689276920@linutronix.de

I applies on top of part IV which can be found here:

 https://lore.kernel.org/r/20200225223321.231477305@linutronix.de

This is the last step of _this_ consolidation work:

  - Get rid of the odd vector number transport via pt_regs for do_IRQ() and
    spurious interrupt handlers by pushing the plain vector number into the
    error code location and providing it as second argument to the C
    functions. This also gets rid of thehistorical adjustment of the vector
    number into the -0x80 to 0x7f range which does not make any sense for
    at least 15 years but still survived until today

  - Get rid of the special entry code for device interrupts which just can
    use the common idtentry mechanisms as all other exceptions do.

  - Convert all the system vectors to the IDTENTRY mechanism and get rid of
    the pointless difference in evicting them on 32 and 64 bit

  - Finally move the return from exception work (prepare return to user
    mode and kernel preemption) into C-code and get rid of the ASM gunk.

This applies on top of part three which is available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part4

To get part 1 - 5 pull from here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part5

The diffstat for part V is appended below. The overall diffstat summary is:

 50 files changed, 1380 insertions(+), 1264 deletions(-)

but most importantly the overall diffstat for the ASM code is:

 3 files changed, 302 insertions(+), 759 deletions(-)

i.e. 457 lines of ASM gone...

and all idt entry points have now:

  - a central home in idtentry.h instead of being sprinkled aorund 10 files

  - a consistent naming scheme also vs. XEN/PV

  - the same entry/exit conventions and protections against all sorts of
    instrumentation which makes it harder to screw up for new entry points

This finally allows to move the sysall entry/exit work into a generic place
and fix the initial problem of moving POSIX CPu tiemrs hevay lifting into
thread context. But that's going to be another 25 patches which are coming
once this is resolved.

Thanks,

	tglx

8<---------------
 arch/x86/include/asm/acrn.h             |   11 -
 arch/x86/include/asm/entry_arch.h       |   56 ------
 b/arch/x86/entry/common.c               |   56 ++++--
 b/arch/x86/entry/entry_32.S             |  123 ++-----------
 b/arch/x86/entry/entry_64.S             |  296 +++++---------------------------
 b/arch/x86/hyperv/hv_init.c             |    3 
 b/arch/x86/include/asm/hw_irq.h         |   22 --
 b/arch/x86/include/asm/idtentry.h       |  143 +++++++++++++++
 b/arch/x86/include/asm/irq.h            |    6 
 b/arch/x86/include/asm/irq_work.h       |    1 
 b/arch/x86/include/asm/mshyperv.h       |   14 -
 b/arch/x86/include/asm/traps.h          |   10 -
 b/arch/x86/include/asm/uv/uv_bau.h      |    6 
 b/arch/x86/kernel/apic/apic.c           |   28 ++-
 b/arch/x86/kernel/apic/msi.c            |    3 
 b/arch/x86/kernel/apic/vector.c         |    2 
 b/arch/x86/kernel/cpu/acrn.c            |    6 
 b/arch/x86/kernel/cpu/mce/amd.c         |    2 
 b/arch/x86/kernel/cpu/mce/therm_throt.c |    2 
 b/arch/x86/kernel/cpu/mce/threshold.c   |    2 
 b/arch/x86/kernel/cpu/mshyperv.c        |   18 +
 b/arch/x86/kernel/idt.c                 |   34 +--
 b/arch/x86/kernel/irq.c                 |   21 +-
 b/arch/x86/kernel/irq_work.c            |    3 
 b/arch/x86/kernel/smp.c                 |   10 -
 b/arch/x86/platform/uv/tlb_uv.c         |    2 
 b/arch/x86/xen/enlighten_hvm.c          |    6 
 b/drivers/xen/events/events_base.c      |    3 
 b/include/xen/events.h                  |    7 
 29 files changed, 350 insertions(+), 546 deletions(-)



