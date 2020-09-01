Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C766C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E245221D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pCibZrkM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NctYPYsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIAOt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:49:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgIALs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:28 -0400
Date:   Tue, 01 Sep 2020 11:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yprgOg6foVyVlOsUjNUfwCAoBKJ5aj9iejk3iX51wyA=;
        b=pCibZrkMWB2oxaf7YVXBixb4wUIwC4qLiDgsekmfI66lBrF/25YfFIXz3gxaax6cT73Vvg
        IJXtaDpKgGgf0ZYtkO72Kp1bQWLeDU59CvvQLBsnaBsaWkGJtfxxSMZ3sbONjh25lK8uAw
        j6caGSZGcvoe0hUjc/0Sb5dtAOjo1riMx2awKi9KWhCfQDY3bF+oWLItCNBF7iaDzafpp+
        5wqItpBm/G7weWb2Rt80m0iFXM3et1MMQvkKS/vL7GNoZ4xn3SY0x/GyzwgcIWk3mM88H9
        mV3b+bmu5c+FD0f2F2gqaka9L3e+pGC4PGA/asBKQU43Vz2tBlntGbL7KeBgWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yprgOg6foVyVlOsUjNUfwCAoBKJ5aj9iejk3iX51wyA=;
        b=NctYPYsAtWE54wkvRrux0vJEc68qdDzR9WXLRDexSVquQBG4YDoPJLI+cXUNycJfAcj1bT
        K68mM5AnVP6ikmDA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/boot/compressed: Remove, discard, or assert for
 unwanted sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-28-keescook@chromium.org>
References: <20200821194310.3089815-28-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087273.20229.10147741624644072974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     d1c0272bc1c068f8c2cb3d1b395173602b0df6e7
Gitweb:        https://git.kernel.org/tip/d1c0272bc1c068f8c2cb3d1b395173602b0df6e7
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:43:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 10:03:18 +02:00

x86/boot/compressed: Remove, discard, or assert for unwanted sections

In preparation for warning on orphan sections, stop the linker from
generating the .eh_frame* sections, discard unwanted non-zero-sized
generated sections, and enforce other expected-to-be-zero-sized sections
(since discarding them might hide problems with them suddenly gaining
unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-28-keescook@chromium.org
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 753d572..5b7f6e1 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -50,6 +50,7 @@ GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index ca544a1..02f6feb 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -72,6 +72,11 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
+	/DISCARD/ : {
+		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
+		*(.hash) *(.gnu.hash)
+		*(.note.*)
+	}
 
 	.got.plt (INFO) : {
 		*(.got.plt)
@@ -93,13 +98,18 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 
+	.plt : {
+		*(.plt) *(.plt.*)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
 	.rel.dyn : {
-		*(.rel.*)
+		*(.rel.*) *(.rel_*)
 	}
 	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
 
 	.rela.dyn : {
-		*(.rela.*)
+		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
