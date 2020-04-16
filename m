Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8990AC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D0421927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051184;
	bh=qmD2AabpT/gSApKTT7ytFVEBPKgxs9NvEOjVgOMFvy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r1PwFwL4b/E8cwMKb1dsY0V8tj7ELZ4MiKMTESE/yS8pSF9YeSwyacnO0b/v0+Fzd
	 d3Z+33pP1kKPVa7xDeOYDvC675ysIs/lkwOZeIgL3vFINemsUwBLcs7oPn5lYqDwv5
	 7n9TkC+ApLWMUgYs83jirZzzWlv1rEjyFmFWql5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442485AbgDPPdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897763AbgDPNlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:41:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15ED22222D;
        Thu, 16 Apr 2020 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044505;
        bh=qmD2AabpT/gSApKTT7ytFVEBPKgxs9NvEOjVgOMFvy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJbS4hW+tk4dVwi8Ssd6IiQ5pPWWxw+MjgVmSeZZfeEeqrgaBZvR8LHflULn+1RBQ
         qUqvCWagKt/jj7hDtSe4WauKYyTb5Zg9czi8C6QLSKXqg1ERdu2rmz6A88HJR91sM2
         xkdbsAinMBm4TTtE9Y7NVvsSiEoCf53xkJEmVjug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 243/257] powerpc/64: Prevent stack protection in early boot
Date:   Thu, 16 Apr 2020 15:24:54 +0200
Message-Id: <20200416131356.189312593@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 7053f80d96967d8e72e9f2a724bbfc3906ce2b07 upstream.

The previous commit reduced the amount of code that is run before we
setup a paca. However there are still a few remaining functions that
run with no paca, or worse, with an arbitrary value in r13 that will
be used as a paca pointer.

In particular the stack protector canary is stored in the paca, so if
stack protector is activated for any of these functions we will read
the stack canary from wherever r13 points. If r13 happens to point
outside of memory we will get a machine check / checkstop.

For example if we modify initialise_paca() to trigger stack
protection, and then boot in the mambo simulator with r13 poisoned in
skiboot before calling the kernel:

  DEBUG: 19952232: (19952232): INSTRUCTION: PC=0xC0000000191FC1E8: [0x3C4C006D]: addis   r2,r12,0x6D [fetch]
  DEBUG: 19952236: (19952236): INSTRUCTION: PC=0xC00000001807EAD8: [0x7D8802A6]: mflr    r12 [fetch]
  FATAL ERROR: 19952276: (19952276): Check Stop for 0:0: Machine Check with ME bit of MSR off
  DEBUG: 19952276: (19952276): INSTRUCTION: PC=0xC0000000191FCA7C: [0xE90D0CF8]: ld      r8,0xCF8(r13) [Instruction Failed]
  INFO: 19952276: (19952277): ** Execution stopped: Mambo Error, Machine Check Stop,  **
  systemsim % bt
  pc:                             0xC0000000191FCA7C      initialise_paca+0x54
  lr:                             0xC0000000191FC22C      early_setup+0x44
  stack:0x00000000198CBED0        0x0     +0x0
  stack:0x00000000198CBF00        0xC0000000191FC22C      early_setup+0x44
  stack:0x00000000198CBF90        0x1801C968      +0x1801C968

So annotate the relevant functions to ensure stack protection is never
enabled for them.

Fixes: 06ec27aea9fc ("powerpc/64: add stack protector support")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200320032116.1024773-2-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/paca.c     |    4 ++--
 arch/powerpc/kernel/setup.h    |    6 ++++++
 arch/powerpc/kernel/setup_64.c |    2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -176,7 +176,7 @@ static struct slb_shadow * __init new_sl
 struct paca_struct **paca_ptrs __read_mostly;
 EXPORT_SYMBOL(paca_ptrs);
 
-void __init initialise_paca(struct paca_struct *new_paca, int cpu)
+void __init __nostackprotector initialise_paca(struct paca_struct *new_paca, int cpu)
 {
 #ifdef CONFIG_PPC_PSERIES
 	new_paca->lppaca_ptr = NULL;
@@ -205,7 +205,7 @@ void __init initialise_paca(struct paca_
 }
 
 /* Put the paca pointer into r13 and SPRG_PACA */
-void setup_paca(struct paca_struct *new_paca)
+void __nostackprotector setup_paca(struct paca_struct *new_paca)
 {
 	/* Setup r13 */
 	local_paca = new_paca;
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -8,6 +8,12 @@
 #ifndef __ARCH_POWERPC_KERNEL_SETUP_H
 #define __ARCH_POWERPC_KERNEL_SETUP_H
 
+#ifdef CONFIG_CC_IS_CLANG
+#define __nostackprotector
+#else
+#define __nostackprotector __attribute__((__optimize__("no-stack-protector")))
+#endif
+
 void initialize_cache_info(void);
 void irqstack_early_init(void);
 
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -279,7 +279,7 @@ void __init record_spr_defaults(void)
  * device-tree is not accessible via normal means at this point.
  */
 
-void __init early_setup(unsigned long dt_ptr)
+void __init __nostackprotector early_setup(unsigned long dt_ptr)
 {
 	static __initdata struct paca_struct boot_paca;
 


