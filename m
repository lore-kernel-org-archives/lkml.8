Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCBC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0CE20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgBXXVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:21:33 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42535 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgBXXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:21:33 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so4916123qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qgdvNENjdppslkpYoe+OSQTy4MavzCmuXPJ3KTJBw0=;
        b=eBST/fs+fCe9gKckuo0Rcp0KtSuTiZvs5aJSRzHUOPdiWkWkOw34ODZcia458ZEt/O
         GG0SIP030dxjC9/h2HNhIy2h9Gz8CQ15I+eT3rkwuBAatMLqekvNxcz8Iuye/GDaONqg
         47wUWEUMdboYJlU3cMtnMsmZeBRZEDktW1/kIEJv3lej/RvvTcyq2uNi43N8jGAsUB5/
         PyZn1l0g/J6Rg712zihSi9ZhGcFMNldwtmzcqclV+IquL53AN7sHmQsZ/AjGyhVBoLDu
         er+IdWD1hTy+3daVbrOikWeWaUxEJmfn4VffuWu7nkr4xLQ1YU0ykaq9SaKXEZFgRisB
         Wp+Q==
X-Gm-Message-State: APjAAAWrD8WwCJvc0LUx5KwWvZS+PJGsA42j1MCcvzIS87o025gSeAl2
        RhIg+AxeIHsLvc8nPjN5z28=
X-Google-Smtp-Source: APXvYqx9dlzhwA0Zu/OkbSFwDKwfHZa4kgk1b/nDyIrtx81FRgNfJ9soihwo8X3+nmwoI0E1osR36Q==
X-Received: by 2002:a0c:ab13:: with SMTP id h19mr46293624qvb.243.1582586491902;
        Mon, 24 Feb 2020 15:21:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 202sm3757849qkg.132.2020.02.24.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:21:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
Date:   Mon, 24 Feb 2020 18:21:28 -0500
Message-Id: <20200224232129.597160-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
since their linker scripts also just discard it.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-By: Fangrui Song <maskray@google.com>
[1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/
---
 arch/x86/boot/Makefile                | 1 +
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/realmode/rm/Makefile         | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 012b82fc8617..24f011e0adf1 100644
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
index 26050ae0b27e..c33111341325 100644
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
index 99b6332ba540..b11ec5d8f8ac 100644
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
index 98a81576213d..a1140c4ee478 100644
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
-- 
2.24.1

