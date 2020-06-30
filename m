Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F081B208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593538729;
	bh=Nj4BN+7NnXhh61WQDEI6UbIUFYmU1fy6kUCipohTCBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKjYKw55iG03YdlQa3WaK1E8mBKWC671tSEqYflXYsxN3LhYpz7lO+P2xe1C19KsI
	 BJAHRFS29WYFXwDYScGZGPVMkOTD89uOp8T0Ua6wgCdNdQdoX0THT3xUKsK5lCwLaY
	 HaN7RWKocawmUjPK9U3iwz4sSVFdCcT2vq99H6ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbgF3Rir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390427AbgF3Rin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:38:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C732320885;
        Tue, 30 Jun 2020 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593538722;
        bh=Nj4BN+7NnXhh61WQDEI6UbIUFYmU1fy6kUCipohTCBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6yYtsjbY8R1ClJ3fY+7A7bbvC/aZHA1hUFoAbMbyuIq/syGV9xhTj3PJm0G6VSla
         nwocC351b9y0ZourX74cQDGe/IlY2yw9QWoOA/o5IHFN/STBYBJOiX3HhSPTH6MAle
         Ae8qGQc8EkaQmft9biQIUeKHE6kUJlNgX5R/mtvM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
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
Subject: [PATCH 14/18] arm64: Reduce the number of header files pulled into vmlinux.lds.S
Date:   Tue, 30 Jun 2020 18:37:30 +0100
Message-Id: <20200630173734.14057-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although vmlinux.lds.S smells like an assembly file and is compiled
with __ASSEMBLY__ defined, it's actually just fed to the preprocessor to
create our linker script. This means that any assembly macros defined
by headers that it includes will result in a helpful link error:

| aarch64-linux-gnu-ld:./arch/arm64/kernel/vmlinux.lds:1: syntax error

In preparation for an arm64-private asm/rwonce.h implementation, which
will end up pulling assembly macros into linux/compiler.h, reduce the
number of headers we include directly and transitively in vmlinux.lds.S

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |  2 +-
 arch/arm64/include/asm/memory.h         | 11 ++++++-----
 arch/arm64/include/asm/uaccess.h        |  1 +
 arch/arm64/kernel/entry.S               |  1 +
 arch/arm64/kernel/vmlinux.lds.S         |  1 -
 arch/arm64/kvm/hyp-init.S               |  1 +
 6 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 3bf626f6fe0c..329fb15f6bac 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
-#include <linux/pgtable.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/sparsemem.h>
 
 /*
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index a1871bb32bb1..9d4bf58cf7b3 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -10,11 +10,8 @@
 #ifndef __ASM_MEMORY_H
 #define __ASM_MEMORY_H
 
-#include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/sizes.h>
-#include <linux/types.h>
-#include <asm/bug.h>
 #include <asm/page-def.h>
 
 /*
@@ -157,11 +154,15 @@
 #endif
 
 #ifndef __ASSEMBLY__
-extern u64			vabits_actual;
-#define PAGE_END		(_PAGE_END(vabits_actual))
 
 #include <linux/bitops.h>
+#include <linux/compiler.h>
 #include <linux/mmdebug.h>
+#include <linux/types.h>
+#include <asm/bug.h>
+
+extern u64			vabits_actual;
+#define PAGE_END		(_PAGE_END(vabits_actual))
 
 extern s64			physvirt_offset;
 extern s64			memstart_addr;
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index bc5c7b091152..8d7c466f809b 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 
 #include <asm/cpufeature.h>
+#include <asm/mmu.h>
 #include <asm/ptrace.h>
 #include <asm/memory.h>
 #include <asm/extable.h>
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5304d193c79d..b668aad3b762 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -15,6 +15,7 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/asm_pointer_auth.h>
+#include <asm/bug.h>
 #include <asm/cpufeature.h>
 #include <asm/errno.h>
 #include <asm/esr.h>
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..e1e7c0431b4d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -10,7 +10,6 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
-#include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 6e6ed5581eed..076544393c3c 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -6,6 +6,7 @@
 
 #include <linux/linkage.h>
 
+#include <asm/alternative.h>
 #include <asm/assembler.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
-- 
2.27.0.212.ge8ba1cc988-goog

