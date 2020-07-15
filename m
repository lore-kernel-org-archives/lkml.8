Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8286620674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGOAlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:41:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32962 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGOAln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:41:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id j80so311486qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3dAHOozOs1omUhldPU8mrRrQvLJloQ7s4y2Okp5/t0=;
        b=BLZEvfgjbOHyYQ2oaQftrChz4NAGdtw/0a1Qge9kK3ZgTuo+7NV45hLHW1yfKk5GVr
         rzhhsV0m4DI7bCzuRl/K21MyaCn01fUanjdOTWuRfeLwSRecjBJdD0qwBQOzoeoR6U/+
         7SQRiXd3TeAzQsNXfFIuRlsZjDFPweBXhB86twq4cvOX6nmnUPC5Revt+NVeSbMjcqfa
         DIEtgjNBbIewJGXTd+e+7Dz98huhxRXpshNoDN5P+NdQW9VeuvAYkSp/xd/ou9yjBocC
         RGlKK6K4SDLakzsqvy+ALUAivv8Lw/G/Foc4CTk0Rs/1r/CsKCwapNn9a4WQMkfP+K+8
         LDjw==
X-Gm-Message-State: AOAM532ocjlvUKpPbZyKxQvJU6kormIciQ9Q4OwIUIS3EFJeGL+UzqaH
        qDZK9j7Sl4eVZq+MYHPGb04=
X-Google-Smtp-Source: ABdhPJwja79fVS/BTpzLHvAq19y5/5mwbGfta2Ymj1PN+IvNdtMP7BTnDv2fGvwuE3TAoK4LLmKKig==
X-Received: by 2002:a37:3d4:: with SMTP id 203mr6870758qkd.420.1594773702036;
        Tue, 14 Jul 2020 17:41:42 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm524776qko.24.2020.07.14.17.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 17:41:41 -0700 (PDT)
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
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] x86/boot: Check that there are no run-time relocations
Date:   Tue, 14 Jul 2020 20:41:33 -0400
Message-Id: <20200715004133.1430068-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714023836.2310569-1-nivedita@alum.mit.edu>
References: <20200714023836.2310569-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a linker script check that there are no run-time relocations, and
remove the old one that tries to check via looking for specially-named
sections in the object files.

Drop the tests for -fPIE compiler option and -pie linker option, as they
are available in all supported gcc and binutils versions (as well as
clang and lld).

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
 arch/x86/boot/compressed/vmlinux.lds.S |  8 ++++++++
 2 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index ae2c0dc98a6a..a9e082b8c720 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -29,7 +29,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
 
 KBUILD_CFLAGS := -m$(BITS) -O2
-KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
+KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small
@@ -51,7 +51,7 @@ UBSAN_SANITIZE :=n
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
-LDFLAGS_vmlinux := $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
@@ -86,30 +86,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
 
-# The compressed kernel is built with -fPIC/-fPIE so that a boot loader
-# can place it anywhere in memory and it will still run. However, since
-# it is executed as-is without any ELF relocation processing performed
-# (and has already had all relocation sections stripped from the binary),
-# none of the code can use data relocations (e.g. static assignments of
-# pointer values), since they will be meaningless at runtime. This check
-# will refuse to link the vmlinux if any of these relocations are found.
-quiet_cmd_check_data_rel = DATAREL $@
-define cmd_check_data_rel
-	for obj in $(filter %.o,$^); do \
-		$(READELF) -S $$obj | grep -qF .rel.local && { \
-			echo "error: $$obj has data relocations!" >&2; \
-			exit 1; \
-		} || true; \
-	done
-endef
-
-# We need to run two commands under "if_changed", so merge them into a
-# single invocation.
-quiet_cmd_check-and-link-vmlinux = LD      $@
-      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
-
 $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
-	$(call if_changed,check-and-link-vmlinux)
+	$(call if_changed,ld)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index a4a4a59a2628..29df99b6cc64 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -42,6 +42,12 @@ SECTIONS
 		*(.rodata.*)
 		_erodata = . ;
 	}
+	.rel.dyn : {
+		*(.rel.*)
+	}
+	.rela.dyn : {
+		*(.rela.*)
+	}
 	.got : {
 		*(.got)
 	}
@@ -85,3 +91,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
 #else
 ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
 #endif
+
+ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
-- 
2.26.2

