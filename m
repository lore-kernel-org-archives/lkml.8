Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E89C4BA09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E727F24681
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgBYX0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:26:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55584 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgBYXZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:25:57 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaB-0004c5-GX; Wed, 26 Feb 2020 00:25:43 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 6B659104083;
        Wed, 26 Feb 2020 00:25:36 +0100 (CET)
Message-Id: <20200225221606.511535280@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:16:06 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 00/24] x86/entry: Consolidation - Part III
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the third batch of a 73 patches series which consolidates the x86
entry code. The larger explanation is in the part I cover letter:

 https://lore.kernel.org/r/20200225213636.689276920@linutronix.de

I applies on top of part II which can be found here:

 https://lore.kernel.org/r/20200225220801.571835584@linutronix.de

This part consolidates the entry stub ASM code generation by:

  - Distangling the unreadable idtentry maze on 64bit

  - Providing idtentry for 32bit

  - Providing exception entry point macros which

     - Declare the required ASM, C and XEN/PV prototypes

     - Hide the underlying C-entry magic in the macros which are used for
       wrapping the actual C handler. This includes marking them notrace
       and exclude them from kprobes so in a later step irq flags tracing
       and enter from user space handling can be moved out from ASM into C
       into one central place

     - Have one header file (idtentry.h) which provides all the macros and
       also acts as a collection point for all idtentries which need to be
       emitted as ASM stubs.

  - Converting the trivial exceptions over to the new scheme

This is the first step to get rid of the pointless differences between 32
bit and 64 bit (arch_entry.h vs. random defines in entry_64.S) and having
consistent prototypes and exception C-handler mechanics all over the place
instead of a randomly chosen implementation here and there.

This applies on top of part two which is available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part2

To get part 1 - 3 pull from here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part3

Thanks,

	tglx

8<---------------
 entry/entry_32.S       |  167 ++++++-------------
 entry/entry_64.S       |  410 ++++++++++++++++++++++++++-----------------------
 include/asm/idtentry.h |  150 +++++++++++++++++
 include/asm/trapnr.h   |   31 +++
 include/asm/traps.h    |   74 --------
 kernel/idt.c           |   30 +--
 kernel/traps.c         |  129 +++++++++------
 xen/enlighten_pv.c     |   35 ++--
 xen/xen-asm_32.S       |    2 
 xen/xen-asm_64.S       |   30 +--
 10 files changed, 584 insertions(+), 474 deletions(-)

