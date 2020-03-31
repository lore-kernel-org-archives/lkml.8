Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992F2206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PXI7Bq5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgCaQD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63917 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbgCaQDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDds2sKfz9twdd;
        Tue, 31 Mar 2020 18:03:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PXI7Bq5I; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5bjtkLVkr8QV; Tue, 31 Mar 2020 18:03:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDds1h7Dz9twdT;
        Tue, 31 Mar 2020 18:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670625; bh=AdhmTaHIlNsd+is4s98PdEJlPbQ66cl8Xq7/7GQ0hd4=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=PXI7Bq5IaLJTX9f6ceBomZ5olRoDHJ8SofSODKRzfXj/hHtZkC9Xf/OikcO7W0d9t
         r/w5rI2e+nWpweeM3uVwPW8gPqr2CaZz4Q2r8K7R6+0+y1M4bTBypcDawZc06e847b
         WQud6PAcQagot1JUdYaNCW5bXLgN6sGwXi6fAWz0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DAF1B8B868;
        Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ko0Ri2ovZeRB; Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E5848B752;
        Tue, 31 Mar 2020 18:03:46 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 88195656AC; Tue, 31 Mar 2020 16:03:46 +0000 (UTC)
Message-Id: <23eddf49abb03d1359fa0be4206998eb3800f42c.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/12] powerpc/entry32: Blacklist syscall exit points for
 kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode.

The very last part of syscall cannot support a trap.
Add a symbol syscall_exit_finish to identify that part and
blacklist it from kprobe.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 215aa3a6d4f7..577d17fe0d94 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -463,6 +463,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	lwz	r7,_NIP(r1)
 	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
+syscall_exit_finish:
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
 	mtspr	SPRN_NRI, r0
 #endif
@@ -470,6 +471,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
 	mtspr	SPRN_SRR1,r8
 	SYNC
 	RFI
+_ASM_NOKPROBE_SYMBOL(syscall_exit_finish)
 #ifdef CONFIG_44x
 2:	li	r7,0
 	iccci	r0,r0
@@ -604,6 +606,7 @@ ret_from_kernel_syscall:
 	mtspr	SPRN_SRR1, r10
 	SYNC
 	RFI
+_ASM_NOKPROBE_SYMBOL(ret_from_kernel_syscall)
 
 /*
  * The fork/clone functions need to copy the full register set into
-- 
2.25.0

