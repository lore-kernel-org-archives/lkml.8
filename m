Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A7F2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clbtUx0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WajytSjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXOtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:49:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:49:35 -0400
Date:   Fri, 24 Jul 2020 14:49:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595602172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATbl/u2dQd6EcdjMgMGONSkJ4CS692XiOwgztKaON3M=;
        b=clbtUx0hlCrQdk2PKdbJClsolg1tHf/VXG1GdlIUgSQAx7UdiiFmcnDRklCBd5uTQSJNQn
        HsiggVHuxqg+nc/iUJDVER5fMS1kJKCJP73rddogUxYZdo+imIRo0ZHaWREGu14/yUfcde
        qTFlDacWnEQ/rf74NrWF2veBvopWkF9QTIcl+MDOhu01Xk4UcTahVTPCWsUWF0AVcJbMW4
        Py1zfH7TEZqTvJW9UxS9HozJMozXC6P3naDNIXgpuJcwHiFadlPrUqwo/xU9wJoHJXnMFO
        WH/+7MEeNwSKukSjBB45y3uGwAptxwwiwydwXXDXFdclPKDpifr9a9LD/Pah/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595602172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATbl/u2dQd6EcdjMgMGONSkJ4CS692XiOwgztKaON3M=;
        b=WajytSjcaoah4Enu+w4hrunUlJay7XOAHGhMBcn8OR3Ou4sYABUgLYcUUhTPLYOurt0Z3J
        DAFMaTKxc7IharAg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Move max-page-size option to LDFLAGS_vmlinux
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722184334.3785418-1-nivedita@alum.mit.edu>
References: <20200722184334.3785418-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159560217177.4006.6819251464761042205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     587af649bcc04eb016822f209a975005c0092151
Gitweb:        https://git.kernel.org/tip/587af649bcc04eb016822f209a975005c0092151
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Wed, 22 Jul 2020 14:43:34 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Jul 2020 16:39:27 +02:00

x86/build: Move max-page-size option to LDFLAGS_vmlinux

This option is only required for vmlinux on 64-bit, to enforce 2MiB
alignment, so set it in LDFLAGS_vmlinux instead of KBUILD_LDFLAGS. Also
drop the ld-option check: this option was added in binutils-2.18 and all
the other places that use it already don't have the check.

This reduces the size of the intermediate ELF files
arch/x86/boot/setup.elf and arch/x86/realmode/rm/realmode.elf by about
2MiB each. The binary versions are unchanged.

Move the LDFLAGS settings to all be together and just after CFLAGS
settings are done.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Link: https://lore.kernel.org/r/20200722184334.3785418-1-nivedita@alum.mit.edu
---
 arch/x86/Makefile | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378d..1e634d7 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -47,10 +47,6 @@ export REALMODE_CFLAGS
 # e.g.: obj-y += foo_$(BITS).o
 export BITS
 
-ifdef CONFIG_X86_NEED_RELOCS
-        LDFLAGS_vmlinux := --emit-relocs --discard-none
-endif
-
 #
 # Prevent GCC from generating any FP code by mistake.
 #
@@ -177,17 +173,6 @@ ifeq ($(ACCUMULATE_OUTGOING_ARGS), 1)
 	KBUILD_CFLAGS += $(call cc-option,-maccumulate-outgoing-args,)
 endif
 
-KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
-
-#
-# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
-# the linker to force 2MB page size regardless of the default page size used
-# by the linker.
-#
-ifdef CONFIG_X86_64
-KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
-endif
-
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -207,6 +192,23 @@ ifdef CONFIG_RETPOLINE
   endif
 endif
 
+KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+
+ifdef CONFIG_X86_NEED_RELOCS
+LDFLAGS_vmlinux := --emit-relocs --discard-none
+else
+LDFLAGS_vmlinux :=
+endif
+
+#
+# The 64-bit kernel must be aligned to 2MB.  Pass -z max-page-size=0x200000 to
+# the linker to force 2MB page size regardless of the default page size used
+# by the linker.
+#
+ifdef CONFIG_X86_64
+LDFLAGS_vmlinux += -z max-page-size=0x200000
+endif
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
