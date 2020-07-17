Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96181C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742C222B4D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgGQUSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:18:09 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33861 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:18:07 -0400
Received: by mail-qt1-f195.google.com with SMTP id w34so8644176qte.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=po84J/oWM/Mk4bSxLHCPaPfI2tYpz1EeKchAg5NX+Rc=;
        b=LaqThSrz1O3gQmb/DVtjcjfYp5PQgsO3kUMcFyIeOVS7hSq2YkA1dvdvTvOC6Ao5RF
         k7ljSA4w7fd5hU84gECodymYytwhK+RBbuLJPEJutIeGhSRm7k6ar5IiMZT0Vx5uWpfl
         R9FCCTe/7BD1VSoSL/pPfNJuGGOEgHLKoPXLkpBQcbhjvG7X47IdIbAZvP5HzWwke1hd
         qguhaUSG3O6v6yuKkeBFjSb9BvWQlQezQzA7xJgO9THFL6bsglzDKLK+oGTSU+ee8diA
         OIsf52ZA4X9Dd5t6+C8Jy8m+TG8FimtKxkxQ/0Pr2TM5Q4+A5+GNGq8et2+8B8OPAT+I
         0wxQ==
X-Gm-Message-State: AOAM533WmNPRU2GHuizv//eyfJsMoP35ll6seBrXhF8EOPelQhPtQHSm
        zo0h3I8UbkoQWo35Wm8zb4w=
X-Google-Smtp-Source: ABdhPJwlGLnE6BBCru5XlS2GyDMBhqEo3dOL6nsSUC/G524d0Chv1Au2FA3OefmNV/xf0IYEkEwjpQ==
X-Received: by 2002:ac8:4f13:: with SMTP id b19mr12537727qte.146.1595017085423;
        Fri, 17 Jul 2020 13:18:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a28sm9509977qko.45.2020.07.17.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:18:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: [PATCH-next v5 2/7] x86/boot/compressed: Force hidden visibility for all symbol references
Date:   Fri, 17 Jul 2020 16:17:56 -0400
Message-Id: <20200717201801.3661843-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Eliminate all GOT entries in the decompressor binary, by forcing hidden
visibility for all symbol references, which informs the compiler that
such references will be resolved at link time without the need for
allocating GOT entries.

To ensure that no GOT entries will creep back in, add an assertion to
the decompressor linker script that will fire if the .got section has
a non-zero size.

[Arvind: move hidden.h to include/linux instead of making a copy]

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
From: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20200523120021.34996-3-ardb@kernel.org
---
 arch/x86/boot/compressed/Makefile      |  1 +
 arch/x86/boot/compressed/vmlinux.lds.S |  1 +
 drivers/firmware/efi/libstub/Makefile  |  2 +-
 drivers/firmware/efi/libstub/hidden.h  |  6 ------
 include/linux/hidden.h                 | 19 +++++++++++++++++++
 5 files changed, 22 insertions(+), 7 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 include/linux/hidden.h

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index b7beabecef8a..b6d7caaaef9e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -42,6 +42,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b17d218ccdf9..4bcc943842ab 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -81,6 +81,7 @@ SECTIONS
 	DISCARDS
 }
 
+ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
 #ifdef CONFIG_X86_64
 ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
 #else
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 2a156f7fec3b..8b350e5a65bc 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -27,7 +27,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
-				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
+				   -include $(srctree)/include/linux/hidden.h \
 				   -D__NO_FORTIFY \
 				   -ffreestanding \
 				   -fno-stack-protector \
diff --git a/drivers/firmware/efi/libstub/hidden.h b/drivers/firmware/efi/libstub/hidden.h
deleted file mode 100644
index 3493b041f419..000000000000
--- a/drivers/firmware/efi/libstub/hidden.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * To prevent the compiler from emitting GOT-indirected (and thus absolute)
- * references to any global symbols, override their visibility as 'hidden'
- */
-#pragma GCC visibility push(hidden)
diff --git a/include/linux/hidden.h b/include/linux/hidden.h
new file mode 100644
index 000000000000..49a17b6b5962
--- /dev/null
+++ b/include/linux/hidden.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * When building position independent code with GCC using the -fPIC option,
+ * (or even the -fPIE one on older versions), it will assume that we are
+ * building a dynamic object (either a shared library or an executable) that
+ * may have symbol references that can only be resolved at load time. For a
+ * variety of reasons (ELF symbol preemption, the CoW footprint of the section
+ * that is modified by the loader), this results in all references to symbols
+ * with external linkage to go via entries in the Global Offset Table (GOT),
+ * which carries absolute addresses which need to be fixed up when the
+ * executable image is loaded at an offset which is different from its link
+ * time offset.
+ *
+ * Fortunately, there is a way to inform the compiler that such symbol
+ * references will be satisfied at link time rather than at load time, by
+ * giving them 'hidden' visibility.
+ */
+
+#pragma GCC visibility push(hidden)
-- 
2.26.2

