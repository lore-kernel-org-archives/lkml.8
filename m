Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8666E2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFZMk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:40:58 -0400
Received: from sym2.noone.org ([178.63.92.236]:48568 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFZMk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:40:57 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49tc1h2HStzvjc1; Fri, 26 Jun 2020 14:40:56 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2] riscv: Allow building with kcov coverage
Date:   Fri, 26 Jun 2020 14:40:56 +0200
Message-Id: <20200626124056.29708-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200625183941.23093-1-tklauser@distanz.ch>
References: <20200625183941.23093-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_HAS_KCOV and HAVE_GCC_PLUGINS to the riscv Kconfig.
Also disable instrumentation of some early boot code and vdso.

Boot-tested on QEMU's riscv64 virt machine.

Cc: Björn Töpel <bjorn.topel@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/riscv/Kconfig              | 2 ++
 arch/riscv/boot/Makefile        | 2 ++
 arch/riscv/kernel/vdso/Makefile | 1 +
 arch/riscv/mm/Makefile          | 2 ++
 4 files changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 089293e4ad46..a7d7f8184f15 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_KCOV
 	select ARCH_HAS_MMIOWB
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SET_DIRECT_MAP
@@ -57,6 +58,7 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 3530c59b3ea7..c59fca695f9d 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -14,6 +14,8 @@
 # Based on the ia64 and arm64 boot/Makefile.
 #
 
+KCOV_INSTRUMENT := n
+
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
 targets := Image loader
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 29cf052f6541..4b0d3bcc44e5 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -29,6 +29,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
 
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 363ef01c30b1..c0185e556ca5 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -5,6 +5,8 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_init.o = -pg
 endif
 
+KCOV_INSTRUMENT_init.o := n
+
 obj-y += init.o
 obj-y += extable.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
-- 
2.27.0

