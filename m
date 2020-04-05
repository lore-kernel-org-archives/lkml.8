Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8F4C2BA1E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7537320659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 17:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VyYb0ulP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDERoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 13:44:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4807 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgDERou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 13:44:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wLf53zdWz9ty3Q;
        Sun,  5 Apr 2020 19:44:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VyYb0ulP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IigNQAjZ64TR; Sun,  5 Apr 2020 19:44:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wLf52z2rz9ty2y;
        Sun,  5 Apr 2020 19:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586108685; bh=ffqSqnUxF9bgCueBowfyUL1MJP20n3WBc3ECSrkihEg=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=VyYb0ulP9DquYNGfs4vZtZXqqijhq2+PWm2a9hlEEKUc9CBHNKhTcOnGvovPNi3gB
         D5eOSAvlEmK16cZJlEVqUp6dH/DukUPbUGigxpxyrISq5+sjRcoHTabpzSQH1ErBv9
         hsa4xSNkIjw8UrpJBKYv/Ue6HnEY9aYVXmH3Y5kw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 068B98B783;
        Sun,  5 Apr 2020 19:44:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SDE5wrZTNIWY; Sun,  5 Apr 2020 19:44:48 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C592F8B774;
        Sun,  5 Apr 2020 19:44:48 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 96D1A6571C; Sun,  5 Apr 2020 17:44:48 +0000 (UTC)
Message-Id: <3b9257ea1f3e107b81437671fa9d3942e31c6735.1586108649.git.christophe.leroy@c-s.fr>
In-Reply-To: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 13/13] powerpc/kernel: Do not use READ_ONCE() to access
 current thread_info flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun,  5 Apr 2020 17:44:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current is a volatile pointer hold by r2 register.

READ_ONCE() is not required.

Before: 327 cycles on null_syscall
Before: 325 cycles on null_syscall

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 34fd66fd11a2..3d2f285b8a01 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -164,7 +164,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 again:
 #endif
 	local_irq_disable();
-	ti_flags = READ_ONCE(*ti_flagsp);
+	ti_flags = current_thread_info()->flags;
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
 		if (ti_flags & _TIF_NEED_RESCHED) {
@@ -180,7 +180,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 			do_notify_resume(regs, ti_flags);
 		}
 		local_irq_disable();
-		ti_flags = READ_ONCE(*ti_flagsp);
+		ti_flags = current_thread_info()->flags;
 	}
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && IS_ENABLED(CONFIG_PPC_FPU)) {
-- 
2.25.0

