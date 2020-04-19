Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1EEC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A079B21974
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 20:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDSUgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 16:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgDSUgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 16:36:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D2C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 13:36:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQGfa-0007IU-1J; Sun, 19 Apr 2020 22:36:02 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id BC673FFBA2;
        Sun, 19 Apr 2020 22:36:00 +0200 (CEST)
Message-Id: <20200419203137.214111265@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 19 Apr 2020 22:31:37 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [patch 00/15] x86/tlb: Unexport per-CPU tlbstate
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per-CPU tlbstate contains sensitive information which should be really
only accessible in core code. It is exported to modules because some inline
functions which are required by KVM need access to it.

The following series creates regular exported functions for the few things
which are needed by KVM and hides the struct definition and some low level
helpers from modules.

The series is also available from git:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel x86/tlb

Thanks,

	tglx

8<-----------------
 arch/x86/events/core.c             |   11 
 arch/x86/include/asm/mmu_context.h |   88 -------
 arch/x86/include/asm/paravirt.h    |   12 
 arch/x86/include/asm/pgtable_32.h  |    2 
 arch/x86/include/asm/tlbflush.h    |  454 ++++---------------------------------
 arch/x86/kernel/alternative.c      |   55 ++++
 arch/x86/kernel/cpu/common.c       |   25 +-
 arch/x86/kernel/cpu/mtrr/generic.c |    4 
 arch/x86/kernel/paravirt.c         |   21 -
 arch/x86/kernel/process.c          |   11 
 arch/x86/mm/init.c                 |   14 +
 arch/x86/mm/init_64.c              |    2 
 arch/x86/mm/ioremap.c              |    2 
 arch/x86/mm/kmmio.c                |    2 
 arch/x86/mm/mem_encrypt.c          |    2 
 arch/x86/mm/pat/set_memory.c       |    2 
 arch/x86/mm/pgtable.c              |    8 
 arch/x86/mm/pgtable_32.c           |    2 
 arch/x86/mm/tlb.c                  |  367 +++++++++++++++++++++++++++++
 arch/x86/platform/uv/tlb_uv.c      |    2 
 drivers/xen/privcmd.c              |    1 
 21 files changed, 556 insertions(+), 531 deletions(-)


