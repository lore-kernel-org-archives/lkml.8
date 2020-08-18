Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6024320658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHRRTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:19:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63725 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgHRRTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhR02Vhz9vCy0;
        Tue, 18 Aug 2020 19:19:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QR2C2RWcSnPU; Tue, 18 Aug 2020 19:19:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhQ6BFNz9vCxg;
        Tue, 18 Aug 2020 19:19:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC6038B7EC;
        Tue, 18 Aug 2020 19:19:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vn9GlGY2W_gF; Tue, 18 Aug 2020 19:19:20 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BA928B7D7;
        Tue, 18 Aug 2020 19:19:20 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5C71D65CF4; Tue, 18 Aug 2020 17:19:20 +0000 (UTC)
Message-Id: <900b93744732ed0887f28f5b6a40730fb04a43fa.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 08/25] powerpc/signal: Move access_ok() out of
 get_sigframe()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This access_ok() will soon be performed by user_access_begin().
So move it out of get_sigframe().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.c    | 4 ----
 arch/powerpc/kernel/signal_32.c | 4 ++--
 arch/powerpc/kernel/signal_64.c | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 3b56db02b762..1be5fd01f866 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -154,10 +154,6 @@ void __user *get_sigframe(struct ksignal *ksig, unsigned long sp,
 	oldsp = sigsp(oldsp, ksig);
 	newsp = (oldsp - frame_size) & ~0xFUL;
 
-	/* Check access */
-	if (!access_ok((void __user *)newsp, oldsp - newsp))
-		return NULL;
-
         return (void __user *)newsp;
 }
 
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 8cbc9ac1343d..61621acacc63 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -768,7 +768,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Put a Real Time Context onto stack */
 	rt_sf = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*rt_sf), 1);
 	addr = rt_sf;
-	if (unlikely(rt_sf == NULL))
+	if (!access_ok(rt_sf, sizeof(*rt_sf)))
 		goto badframe;
 
 	/* Put the siginfo & fill in most of the ucontext */
@@ -1227,7 +1227,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 
 	/* Set up Signal Frame */
 	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 1);
-	if (unlikely(frame == NULL))
+	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 	sc = (struct sigcontext __user *) &frame->sctx;
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index cae612bdde5f..d3db78732070 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -823,7 +823,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 #endif
 
 	frame = get_sigframe(ksig, get_tm_stackpointer(tsk), sizeof(*frame), 0);
-	if (unlikely(frame == NULL))
+	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 
 	err |= __put_user(&frame->info, &frame->pinfo);
-- 
2.25.0

