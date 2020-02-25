Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96909C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BAF24680
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 23:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgBYX2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:28:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgBYX0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 18:26:37 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6jaZ-0004qp-Sf; Wed, 26 Feb 2020 00:26:08 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 26D0D10408B;
        Wed, 26 Feb 2020 00:25:44 +0100 (CET)
Message-Id: <20200225223321.231477305@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 25 Feb 2020 23:33:21 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [patch 00/16] x86/entry: Consolidation - Part IV
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is the forth batch of a 73 patches series which consolidates the x86
entry code. The larger explanation is in the part I cover letter:

 https://lore.kernel.org/r/20200225213636.689276920@linutronix.de

I applies on top of part III which can be found here:

 https://lore.kernel.org/r/20200225221606.511535280@linutronix.de

This part consolidates the entry stub ASM code generation further by:

  - Converting the more complex exceptions to the new IDTENTRY scheme

  - Providing seperate C entry points for #DB and #MC (entry from
    user/kernel) to make addressing the RCU vs. world issues which were
    discussed in the last weeks simpler.

  - Moving the CR2 read for page fault handlers out of ASM code

This applies on top of part three which is available here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part3

To get part 1 - 4 pull from here:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v1-part4

Thanks,

	tglx

8<---------------
 entry/entry_32.S          |   77 +-----------
 entry/entry_64.S          |   89 ++------------
 include/asm/idtentry.h    |  287 +++++++++++++++++++++++++++++++++++++++++++++-
 include/asm/kvm_para.h    |    1 
 include/asm/mce.h         |    2 
 include/asm/traps.h       |   34 -----
 kernel/cpu/mce/core.c     |   25 ++--
 kernel/cpu/mce/inject.c   |    4 
 kernel/cpu/mce/internal.h |    2 
 kernel/cpu/mce/p5.c       |    2 
 kernel/cpu/mce/winchip.c  |    2 
 kernel/doublefault_32.c   |    7 -
 kernel/idt.c              |   24 +--
 kernel/kvm.c              |    8 -
 kernel/nmi.c              |    4 
 kernel/traps.c            |   49 +++++--
 kvm/vmx/vmx.c             |    2 
 mm/fault.c                |   20 ++-
 xen/enlighten_pv.c        |   17 +-
 xen/setup.c               |    4 
 xen/smp_pv.c              |    3 
 xen/xen-asm_32.S          |    8 -
 xen/xen-asm_64.S          |   14 +-
 xen/xen-ops.h             |    1 
 24 files changed, 432 insertions(+), 254 deletions(-)
