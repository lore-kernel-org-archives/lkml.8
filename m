Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA5C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8882082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgBYQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:53:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53928 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbgBYQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:53:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6dSV-0007Y9-0x; Tue, 25 Feb 2020 17:53:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9FB261C214D;
        Tue, 25 Feb 2020 17:53:22 +0100 (CET)
Date:   Tue, 25 Feb 2020 16:53:22 -0000
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/*/Makefile: Use -fno-asynchronous-unwind-tables
 to suppress .eh_frame sections
Cc:     Fangrui Song <maskray@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200224232129.597160-2-nivedita@alum.mit.edu>
References: <20200224232129.597160-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <158264960240.28353.7022349340832312858.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     003602ad5516e59940de42e44c8d8033387bb363
Gitweb:        https://git.kernel.org/tip/003602ad5516e59940de42e44c8d8033387bb363
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 24 Feb 2020 18:21:28 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 25 Feb 2020 13:18:29 +01:00

x86/*/Makefile: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections

While discussing a patch to discard .eh_frame from the compressed
vmlinux using the linker script, Fangrui Song pointed out [1] that these
sections shouldn't exist in the first place because arch/x86/Makefile
uses -fno-asynchronous-unwind-tables.

It turns out this is because the Makefiles used to build the compressed
kernel redefine KBUILD_CFLAGS, dropping this flag.

Add the flag to the Makefile for the compressed kernel, as well as the
EFI stub Makefile to fix this.

Also add the flag to boot/Makefile and realmode/rm/Makefile so that the
kernel's boot code (boot/setup.elf) and realmode trampoline
(realmode/rm/realmode.elf) won't be compiled with .eh_frame sections,
since their linker scripts also just discard them.

  [1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/

Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lkml.kernel.org/r/20200224232129.597160-2-nivedita@alum.mit.edu
---
 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/realmode/rm/Makefile         | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 012b82f..24f011e 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -68,6 +68,7 @@ clean-files += cpustr.h
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 26050ae..c331113 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 99b6332..b11ec5d 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -71,5 +71,6 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 98a8157..a1140c4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
-				   $(call cc-disable-warning, gnu)
+				   $(call cc-disable-warning, gnu) \
+				   -fno-asynchronous-unwind-tables
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
