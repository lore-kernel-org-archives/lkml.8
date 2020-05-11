Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77432C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B62420746
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgEKNCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:02:14 -0400
Received: from foss.arm.com ([217.140.110.172]:60036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKNCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:02:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E454D6E;
        Mon, 11 May 2020 06:02:13 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.17.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 548B83F68F;
        Mon, 11 May 2020 06:02:10 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 1/2] arm64/crash_core: Export KERNELPACMASK in vmcoreinfo
Date:   Mon, 11 May 2020 18:31:55 +0530
Message-Id: <1589202116-18265-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently arm64 linux kernel added support for Armv8.3-A Pointer
Authentication feature. If this feature is enabled in the kernel and the
hardware supports address authentication then the return addresses are
signed and stored in the stack to prevent ROP kind of attack. Kdump tool
will now dump the kernel with signed lr values in the stack.

Any user analysis tool for this kernel dump may need the kernel pac mask
information in vmcoreinfo to generate the correct return address for
stacktrace purpose as well as to resolve the symbol name.

This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
bit positions via ptrace") which exposes pac mask information via ptrace
interfaces.

The config gaurd ARM64_PTR_AUTH is removed form asm/compiler.h so macros
like ptrauth_kernel_pac_mask can be used ungaurded. This config protection
is confusing as the pointer authentication feature may be missing at
runtime even though this config is present.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
Changes since v2:
* Removed CONFIG_ARM64_PTR_AUTH config guard as suggested by Will.
* A commit log change.

An implementation of this new KERNELPACMASK vmcoreinfo field used by crash
tool can be found here[1]. This change is accepted by crash utility
maintainer [2].

[1]: https://www.redhat.com/archives/crash-utility/2020-April/msg00095.html
[2]: https://www.redhat.com/archives/crash-utility/2020-April/msg00099.html

 arch/arm64/include/asm/compiler.h | 4 ----
 arch/arm64/kernel/crash_core.c    | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index eece20d..51a7ce8 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_COMPILER_H
 #define __ASM_COMPILER_H
 
-#if defined(CONFIG_ARM64_PTR_AUTH)
-
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
@@ -19,6 +17,4 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
-#endif /* CONFIG_ARM64_PTR_AUTH */
-
 #endif /* __ASM_COMPILER_H */
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e1..1f646b0 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/crash_core.h>
+#include <asm/cpufeature.h>
 #include <asm/memory.h>
 
 void arch_crash_save_vmcoreinfo(void)
@@ -16,4 +17,7 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",
 						PHYS_OFFSET);
 	vmcoreinfo_append_str("KERNELOFFSET=%lx\n", kaslr_offset());
+	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
+						system_supports_address_auth() ?
+						ptrauth_kernel_pac_mask() : 0);
 }
-- 
2.7.4

