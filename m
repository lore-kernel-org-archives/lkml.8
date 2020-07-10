Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A563C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044AD206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400019;
	bh=whhs7oG4eHwGU4eTV3G4HHpSTjSYq15t2QvyL7KoLOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1SCPGBoYxyCAd0IxG//w8acd0Q4i8KDagBWbyN11HpbOWyRz45x/2QTKgfqR2KnQo
	 ZTvue5KiThRr+7cd/4ltjKFvz0V1SHi0LBfWeiiGLx/E5X2eYJyIRFUKFqw3HKbPZ8
	 lfygJLf5jh/ZVYlvMy7eux4LoC4QaNQ1cqNd5ehI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGJQxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgGJQx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:29 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83FD20870;
        Fri, 10 Jul 2020 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400009;
        bh=whhs7oG4eHwGU4eTV3G4HHpSTjSYq15t2QvyL7KoLOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJVGcKh/R1hwa/3n0Lq+mqdvEmG0AHuCSSUcXFmNcyOVuLckQGiOAeoG18ntgAIKM
         WmwfJTW++NgmCHIA0mRueiz/gUwGYbIBvUtW0VRWUoaU1fiwJaV8kF4CYord+yvYLM
         7jd8EIzwRW6LPQbt5GXxC6xX39zMMchRx1itqKRY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 19/19] arm64: lto: Strengthen READ_ONCE() to acquire when CONFIG_LTO=y
Date:   Fri, 10 Jul 2020 17:52:03 +0100
Message-Id: <20200710165203.31284-20-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with LTO, there is an increased risk of the compiler
converting an address dependency headed by a READ_ONCE() invocation
into a control dependency and consequently allowing for harmful
reordering by the CPU.

Ensure that such transformations are harmless by overriding the generic
READ_ONCE() definition with one that provides acquire semantics when
building with LTO.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/rwonce.h   | 63 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 arch/arm64/kernel/vdso32/Makefile |  2 +-
 3 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/include/asm/rwonce.h

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
new file mode 100644
index 000000000000..d78eb4cb795b
--- /dev/null
+++ b/arch/arm64/include/asm/rwonce.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Google LLC.
+ */
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#ifdef CONFIG_LTO
+
+#include <linux/compiler_types.h>
+#include <asm/alternative-macros.h>
+
+#ifndef BUILD_VDSO
+
+#ifdef CONFIG_AS_HAS_LDAPR
+#define __LOAD_RCPC(sfx, regs...)					\
+	ALTERNATIVE(							\
+		"ldar"	#sfx "\t" #regs,				\
+		".arch_extension rcpc\n"				\
+		"ldapr"	#sfx "\t" #regs,				\
+	ARM64_HAS_LDAPR)
+#else
+#define __LOAD_RCPC(sfx, regs...)	"ldar" #sfx "\t" #regs
+#endif /* CONFIG_AS_HAS_LDAPR */
+
+#define __READ_ONCE(x)							\
+({									\
+	typeof(&(x)) __x = &(x);					\
+	int atomic = 1;							\
+	union { __unqual_scalar_typeof(*__x) __val; char __c[1]; } __u;	\
+	switch (sizeof(x)) {						\
+	case 1:								\
+		asm volatile(__LOAD_RCPC(b, %w0, %1)			\
+			: "=r" (*(__u8 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 2:								\
+		asm volatile(__LOAD_RCPC(h, %w0, %1)			\
+			: "=r" (*(__u16 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 4:								\
+		asm volatile(__LOAD_RCPC(, %w0, %1)			\
+			: "=r" (*(__u32 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	case 8:								\
+		asm volatile(__LOAD_RCPC(, %0, %1)			\
+			: "=r" (*(__u64 *)__u.__c)			\
+			: "Q" (*__x) : "memory");			\
+		break;							\
+	default:							\
+		atomic = 0;						\
+	}								\
+	atomic ? (typeof(*__x))__u.__val : (*(volatile typeof(__x))__x);\
+})
+
+#endif	/* !BUILD_VDSO */
+#endif	/* CONFIG_LTO */
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_RWONCE_H */
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 45d5cfe46429..60df97f2e7de 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -28,7 +28,7 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 	     $(btildflags-y) -T
 
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
-ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
 KBUILD_CFLAGS			+= $(DISABLE_LTO)
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index d88148bef6b0..4fdf3754a058 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -43,7 +43,7 @@ cc32-as-instr = $(call try-run,\
 # As a result we set our own flags here.
 
 # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
-VDSO_CPPFLAGS := -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
+VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
 VDSO_CPPFLAGS += $(LINUXINCLUDE)
 
 # Common C and assembly flags
-- 
2.27.0.383.g050319c2ae-goog

