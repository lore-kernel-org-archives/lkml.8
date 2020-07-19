Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D1C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11BF22CA0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aR1gXZAF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObeCLGfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGSLIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:08:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgGSLIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 07:08:50 -0400
Date:   Sun, 19 Jul 2020 11:08:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595156927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDqW2b2XMZ5wAfg7sHuZmu/331vudy3InpUCbJNlWrM=;
        b=aR1gXZAFaI1Q39Drw77XkX4Q8wvHew5oB9eXK6JaGK9m7/DfgGOFfhaw+tM1GbgcejdrLs
        7+MqznXKrD+n1kEztcGVIxOHxvqDlpyJ1rOoj7ijemTU7qoJg8TTzUzbh5yjw8Xuji1hEk
        m5EPSjWCP0qF3DIQyxuSL5d9jmX40Ir9Rrp6qk3ksWJISuI9/V7v3L4pPerR3Sre4eDx/S
        lwJYGoYnBKgmVbwjn6WXB/H3c5faI7PFkfnpz2RC9nogrt4Zo3oP0Eomwq9zTaas9lZB15
        M0E9sucVeEfrceRqgYO4Xo4vG+UWFuDT315JUjKfuMJ2iK0W7vNfjG1lXCerAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595156927;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDqW2b2XMZ5wAfg7sHuZmu/331vudy3InpUCbJNlWrM=;
        b=ObeCLGfw56kpNeC70VXK280Blxlc3PkyyI0XWrA7BRQk7UK8WMqd/GwkAd8barjNIz1lVn
        wSMJN27fqVqobmAQ==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Don't add the EFI stub to targets
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200715032631.1562882-1-nivedita@alum.mit.edu>
References: <20200715032631.1562882-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <159515692603.4006.6720081328208221414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     da05b143a308bd6a7a444401f9732678ae63fc70
Gitweb:        https://git.kernel.org/tip/da05b143a308bd6a7a444401f9732678ae63fc70
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Tue, 14 Jul 2020 23:26:31 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 19 Jul 2020 13:07:11 +02:00

x86/boot: Don't add the EFI stub to targets

vmlinux-objs-y is added to targets, which currently means that the EFI
stub gets added to the targets as well. It shouldn't be added since it
is built elsewhere.

This confuses Makefile.build which interprets the EFI stub as a target
	$(obj)/$(objtree)/drivers/firmware/efi/libstub/lib.a
and will create drivers/firmware/efi/libstub/ underneath
arch/x86/boot/compressed, to hold this supposed target, if building
out-of-tree. [0]

Fix this by pulling the stub out of vmlinux-objs-y into efi-obj-y.

[0] See scripts/Makefile.build near the end:
    # Create directories for object files if they do not exist

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200715032631.1562882-1-nivedita@alum.mit.edu

---
 arch/x86/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742..5a828fd 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -90,8 +90,8 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
@@ -115,7 +115,7 @@ endef
 quiet_cmd_check-and-link-vmlinux = LD      $@
       cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
