Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3453C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 942BD20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589563692;
	bh=fLJmnHjaGKDfs+Gb3LVnn2aRUVteAb4UfTr5WAVaLiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5zQ38rcWrKGMuMQN5WuqSsWE5Atv+byS5NpHmAqhFuYzXIBM/LytUKk7A6Nf1Axd
	 T0XZDNho3ygvFuEwHfR0gBUMsz0YK5j/Kn3OsDkUEEQL7XBb2Td3TOYB7ww0ME47/f
	 QVfOkaBNJQJM25RZpkBHs5s0s6l1QNrv8ohIfk9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgEOR2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEOR2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:28:09 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3E92073E;
        Fri, 15 May 2020 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589563688;
        bh=fLJmnHjaGKDfs+Gb3LVnn2aRUVteAb4UfTr5WAVaLiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUMdl8UVD1wbfLieayUNpca2emxYYKWi0iAXuBeyCak2VV0iNSLbcfw5GtTRdwo5l
         vzd4LIUFQNWi7JUqr2nb9ZCq8mQr0a/00VVMJBzmRtFd855hECkL4C6lSwGbEWPuqv
         K8AHLB7hqv4S5/iEUVX+vGGvRZhblP19B/Kx21II=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: [PATCH 1/6] arm64: scs: Store absolute SCS stack pointer value in thread_info
Date:   Fri, 15 May 2020 18:27:51 +0100
Message-Id: <20200515172756.27185-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515172756.27185-1-will@kernel.org>
References: <20200515172756.27185-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing the SCS information in thread_info as a {base,offset} pair
introduces an additional load instruction on the ret-to-user path,
since the SCS stack pointer in x18 has to be converted back to an offset
by subtracting the base.

Replace the offset with the absolute SCS stack pointer value instead
and avoid the redundant load.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/scs.h         | 9 ++++-----
 arch/arm64/include/asm/thread_info.h | 4 ++--
 arch/arm64/kernel/asm-offsets.c      | 2 +-
 include/linux/scs.h                  | 8 ++++----
 kernel/scs.c                         | 3 +--
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 96549353b0cb..6b8cf4352fe3 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -4,16 +4,15 @@
 
 #ifdef __ASSEMBLY__
 
+#include <asm/asm-offsets.h>
+
 #ifdef CONFIG_SHADOW_CALL_STACK
 	.macro scs_load tsk, tmp
-	ldp	x18, \tmp, [\tsk, #TSK_TI_SCS_BASE]
-	add	x18, x18, \tmp
+	ldr	x18, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 
 	.macro scs_save tsk, tmp
-	ldr	\tmp, [\tsk, #TSK_TI_SCS_BASE]
-	sub	\tmp, x18, \tmp
-	str	\tmp, [\tsk, #TSK_TI_SCS_OFFSET]
+	str	x18, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
 	.macro scs_load tsk, tmp
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 9df79c0a4c43..6ea8b6a26ae9 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -43,7 +43,7 @@ struct thread_info {
 	};
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
-	unsigned long		scs_offset;
+	void			*scs_sp;
 #endif
 };
 
@@ -107,7 +107,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
 	.scs_base	= init_shadow_call_stack,			\
-	.scs_offset	= 0,
+	.scs_sp		= init_shadow_call_stack,
 #else
 #define INIT_SCS
 #endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index d7934250b68c..a098a45f63d8 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -36,7 +36,7 @@ int main(void)
 #endif
 #ifdef CONFIG_SHADOW_CALL_STACK
   DEFINE(TSK_TI_SCS_BASE,	offsetof(struct task_struct, thread_info.scs_base));
-  DEFINE(TSK_TI_SCS_OFFSET,	offsetof(struct task_struct, thread_info.scs_offset));
+  DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
 #endif
   DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/include/linux/scs.h b/include/linux/scs.h
index 3f3662621a27..0eb2485ef832 100644
--- a/include/linux/scs.h
+++ b/include/linux/scs.h
@@ -27,7 +27,7 @@
 #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
 
 #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
-#define task_scs_offset(tsk)	(task_thread_info(tsk)->scs_offset)
+#define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
 
 void scs_init(void);
 int scs_prepare(struct task_struct *tsk, int node);
@@ -39,7 +39,7 @@ static inline void scs_task_reset(struct task_struct *tsk)
 	 * Reset the shadow stack to the base address in case the task
 	 * is reused.
 	 */
-	task_scs_offset(tsk) = 0;
+	task_scs_sp(tsk) = task_scs(tsk);
 }
 
 static inline unsigned long *__scs_magic(void *s)
@@ -50,9 +50,9 @@ static inline unsigned long *__scs_magic(void *s)
 static inline bool scs_corrupted(struct task_struct *tsk)
 {
 	unsigned long *magic = __scs_magic(task_scs(tsk));
+	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
 
-	return (task_scs_offset(tsk) >= SCS_SIZE - 1 ||
-		READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC);
+	return sz >= SCS_SIZE - 1 || READ_ONCE_NOCHECK(*magic) != SCS_END_MAGIC;
 }
 
 #else /* CONFIG_SHADOW_CALL_STACK */
diff --git a/kernel/scs.c b/kernel/scs.c
index 9389c28f0853..5ff8663e4a67 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -60,8 +60,7 @@ int scs_prepare(struct task_struct *tsk, int node)
 	if (!s)
 		return -ENOMEM;
 
-	task_scs(tsk) = s;
-	task_scs_offset(tsk) = 0;
+	task_scs(tsk) = task_scs_sp(tsk) = s;
 	scs_account(tsk, 1);
 	return 0;
 }
-- 
2.26.2.761.g0e0b3e54be-goog

