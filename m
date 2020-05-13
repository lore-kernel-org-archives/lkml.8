Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F39C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4ACF205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589364997;
	bh=VitKKeYByF8JOPCpvBM4yPr2Ywg+COvNNJJuR6fwXOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylrbI0kgYbe6TDD+DxdH2rLcp46DuW0qRQN33OrGiBWjwoLi40sez2ncC/Cr7K9Qb
	 szKWRXDq6EdpTAev0vFMUXxsj5uDR5sITubiTVoRUnAgr9ESIXbSJEyO7MtjFfub+3
	 bK1ziBj2IS7u0FbjE8He95iBwqbAVPMhE5v5IDts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733072AbgEMKQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729917AbgEMKQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:16:31 -0400
Received: from localhost.localdomain (unknown [42.120.72.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E5C205ED;
        Wed, 13 May 2020 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589364990;
        bh=VitKKeYByF8JOPCpvBM4yPr2Ywg+COvNNJJuR6fwXOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7fVCTf6xV+gWXfh/y2XalKbcNcHjeATBq/Ptr3/Ob7HM99plFvya2ebUBGjeDcgR
         ZdCQExzas5WLP8P6mIPjESH4ukWKNJevhfw5rpoVOsjOeO5yifp4nxyzU8AqmzPkOx
         YVIgxKxa0amA3gl76FZXdY5xKUcEEBmLkZFFvNKU=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 4/4] csky: Fixup remove unnecessary save/restore PSR code
Date:   Wed, 13 May 2020 18:16:17 +0800
Message-Id: <20200513101617.11588-4-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20200513101617.11588-1-guoren@kernel.org>
References: <20200513101617.11588-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

All processes' PSR could success from SETUP_MMU, so need set it
in INIT_THREAD again.

And use a3 instead of r7 in __switch_to for code convention.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/processor.h |  2 --
 arch/csky/kernel/asm-offsets.c    |  1 -
 arch/csky/kernel/entry.S          | 10 ++--------
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/csky/include/asm/processor.h b/arch/csky/include/asm/processor.h
index c6bcd7f7c720..79eaaaed3d23 100644
--- a/arch/csky/include/asm/processor.h
+++ b/arch/csky/include/asm/processor.h
@@ -42,7 +42,6 @@ extern struct cpuinfo_csky cpu_data[];
 
 struct thread_struct {
 	unsigned long  ksp;       /* kernel stack pointer */
-	unsigned long  sr;        /* saved status register */
 	unsigned long  trap_no;   /* saved status register */
 
 	/* FPU regs */
@@ -51,7 +50,6 @@ struct thread_struct {
 
 #define INIT_THREAD  { \
 	.ksp = sizeof(init_stack) + (unsigned long) &init_stack, \
-	.sr = DEFAULT_PSR_VALUE, \
 }
 
 /*
diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index f8be348df9e4..bbc259eed233 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -19,7 +19,6 @@ int main(void)
 
 	/* offsets into the thread struct */
 	DEFINE(THREAD_KSP,        offsetof(struct thread_struct, ksp));
-	DEFINE(THREAD_SR,         offsetof(struct thread_struct, sr));
 	DEFINE(THREAD_FESR,       offsetof(struct thread_struct, user_fp.fesr));
 	DEFINE(THREAD_FCR,        offsetof(struct thread_struct, user_fp.fcr));
 	DEFINE(THREAD_FPREG,      offsetof(struct thread_struct, user_fp.vr));
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 6a468ff75432..3760397fdd3d 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -330,9 +330,6 @@ ENTRY(__switch_to)
 	lrw	a3, TASK_THREAD
 	addu	a3, a0
 
-	mfcr	a2, psr			/* Save PSR value */
-	stw	a2, (a3, THREAD_SR)	/* Save PSR in task struct */
-
 	SAVE_SWITCH_STACK
 
 	stw	sp, (a3, THREAD_KSP)
@@ -343,12 +340,9 @@ ENTRY(__switch_to)
 
 	ldw	sp, (a3, THREAD_KSP)	/* Set next kernel sp */
 
-	ldw	a2, (a3, THREAD_SR)	/* Set next PSR */
-	mtcr	a2, psr
-
 #if  defined(__CSKYABIV2__)
-	addi	r7, a1, TASK_THREAD_INFO
-	ldw	tls, (r7, TINFO_TP_VALUE)
+	addi	a3, a1, TASK_THREAD_INFO
+	ldw	tls, (a3, TINFO_TP_VALUE)
 #endif
 
 	RESTORE_SWITCH_STACK
-- 
2.17.0

