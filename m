Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3EFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7DB206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuNtZiYb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hGlyC+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgIAOUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgIALt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD70C06125E;
        Tue,  1 Sep 2020 04:48:04 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8Ycih3xgzcgJQspbDDbXUib9SIihncv3hUNubEFde8=;
        b=KuNtZiYbVuV2awUtAsN2XutyunVGF5+aHPZpMUdOJ8R3NLUzRQ44k4o1Al5oEd7QWdMvBJ
        C0e7N6ppCbWXason9evNq1q3zpHOEN01YRMbNQ+ekJyXl/Vizgvdfg/oc4h/TrRRkpa3Ww
        eCvPy6E0W1QTZ91x2uQi4lHe/sfQnXnDhajBWu4FqPKGuX+rCJfbtLg1WCrQ1e4v/ul5ve
        Vc4eMrnJLovyDZa77ZMzKVkojCGgr3MQtS4H4wKThslx96/1WWM8nPhamSCldWNwRcSLdr
        K8FDbY46YsdH/qtELiWTyKs/Z0ncBtCySM93BnYn7A1XwT0ZqOUtgIka6ZfeFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H8Ycih3xgzcgJQspbDDbXUib9SIihncv3hUNubEFde8=;
        b=0hGlyC+QqkJUY8QJ4XatLzC3HUPCONqgu5ILz/PIGV+7TVVk2Qsy0H9Fjg5oQAPjP1O2zS
        cZm3D0pBKxjbM5BQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] efi/libstub: Disable -mbranch-protection
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-8-keescook@chromium.org>
References: <20200821194310.3089815-8-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087901.20229.9435314794227577667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     e2179a09ab089d3423751bd2b0c884ddb3eabe84
Gitweb:        https://git.kernel.org/tip/e2179a09ab089d3423751bd2b0c884ddb3eabe84
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

efi/libstub: Disable -mbranch-protection

In preparation for adding --orphan-handling=warn to more architectures,
disable -mbranch-protection, as EFI does not yet support it[1].  This was
noticed due to it producing unwanted .note.gnu.property sections (prefixed
with .init due to the objcopy build step).

However, we must also work around a bug in Clang where the section is
still emitted for code-less object files[2], so also remove the section
during the objcopy.

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
[2] https://bugs.llvm.org/show_bug.cgi?id=46480

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-8-keescook@chromium.org
---
 drivers/firmware/efi/libstub/Makefile |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 5eefd60..0c911e3 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
@@ -66,6 +67,12 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+# Even when -mbranch-protection=none is set, Clang will generate a
+# .note.gnu.property for code-less object files (like lib/ctype.c),
+# so work around this by explicitly removing the unwanted section.
+# https://bugs.llvm.org/show_bug.cgi?id=46480
+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
