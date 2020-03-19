Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADEC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC7120739
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCSLPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:15:31 -0400
Received: from foss.arm.com ([217.140.110.172]:33516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSLP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:15:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9FE3FEC;
        Thu, 19 Mar 2020 04:15:26 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (unknown [10.162.16.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 275233FA45;
        Thu, 19 Mar 2020 00:39:32 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>
Subject: [PATCH 1/2] arm64/crash_core: Export KERNELPACMASK in vmcoreinfo
Date:   Thu, 19 Mar 2020 13:09:10 +0530
Message-Id: <1584603551-23845-1-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARMv8.3-A mandated feature Pointer Authentication may needs this change.
If this feature is enabled in the kernel and the hardware supports address
authentication then the return addresses are signed and stored in the stack
to prevent ROP kind of attack.

User tools like "crash" may need the kernel pac mask information to
generate the correct return address for stacktrace purpose.

This patch is similar to commit ec6e822d1a22d0eef ("arm64: expose user PAC
bit positions via ptrace") which exposes pac mask information via ptrace
interfaces.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Dave Anderson <anderson@redhat.com>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 
An implementation of this field used by crash tool can be found here [1].

The patches in this series are based on in-kernel Pointer Authentication
patches present for-next tree [2].

[1]: http://linux-arm.org/git?p=crash-ak.git;a=commit;h=1775c6c33bed9269964719b90064b43a24ce97a5
[2]: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/kernel-ptrauth

 arch/arm64/include/asm/compiler.h | 3 +++
 arch/arm64/kernel/crash_core.c    | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index eece20d..32d5900 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -19,6 +19,9 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
+#else  /* !CONFIG_ARM64_PTR_AUTH */
+#define	ptrauth_user_pac_mask()		0ULL
+#define	ptrauth_kernel_pac_mask()	0ULL
 #endif /* CONFIG_ARM64_PTR_AUTH */
 
 #endif /* __ASM_COMPILER_H */
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index ca4c3e1..25cf2ce 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -6,6 +6,7 @@
 
 #include <linux/crash_core.h>
 #include <asm/memory.h>
+#include <asm/pointer_auth.h>
 
 void arch_crash_save_vmcoreinfo(void)
 {
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

