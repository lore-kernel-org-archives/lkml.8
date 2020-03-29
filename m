Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B54C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C932073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="frgwwyW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgC2JlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18170 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgC2JlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrFQ4t7pz9v0Cf;
        Sun, 29 Mar 2020 11:41:14 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=frgwwyW8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OdyRlKg0hoWX; Sun, 29 Mar 2020 11:41:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrFQ3mRMz9v0Bs;
        Sun, 29 Mar 2020 11:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474874; bh=5Z80nlld36RF3eOx9WYuiv3G1+IfkGQr5tws21gb9v8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=frgwwyW8uuEtZGart6137dHKnFqR3QQnisuiQzZtt64mrfa9ZDh/Z6R2CKZhb8RHT
         Yvf/ZVOG61ExYE6xKoTQIXU2vlKHNXmB25NYyV+n99MyYsD7EH7F+0I6ubpmM5D8al
         49Ck/Dj1xHtzBvz2WynCKIDyEilrOXz5/2QEAeB4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63AA68B770;
        Sun, 29 Mar 2020 11:41:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ql--TI0mgLMC; Sun, 29 Mar 2020 11:41:12 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF09D8B752;
        Sun, 29 Mar 2020 11:41:11 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9E6EF65653; Sun, 29 Mar 2020 09:41:11 +0000 (UTC)
Message-Id: <51d2b8f8edf167a3084a08091a42c57f93ea4d8c.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 11/12] powerpc/entry32: Blacklist syscall exit points for
 kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode.

The very last part of syscall cannot support a trap.
Add a symbol syscall_exit_finish to identify that part and
blacklist it from kprobe.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9a1a45d6038a..7035e838d422 100644
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

