Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B704FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D582054F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHQFqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:46:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2279 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgHQFqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:46:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNMb4NNFz9tytm;
        Mon, 17 Aug 2020 07:46:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BF9zu5YcO0s8; Mon, 17 Aug 2020 07:46:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNMb30Ryz9tytl;
        Mon, 17 Aug 2020 07:46:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DA2C8B772;
        Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H2O5bNNzOIr4; Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F1498B75B;
        Mon, 17 Aug 2020 07:46:40 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0451D65CDD; Mon, 17 Aug 2020 05:46:39 +0000 (UTC)
Message-Id: <9d11143d4e27ba8274369a926968756917584868.1597643153.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1] powerpc/process: Remove unnecessary #ifdef
 CONFIG_FUNCTION_GRAPH_TRACER
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:46:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_graph_ret_addr() is always defined and returns 'ip' when
CONFIG_FUNCTION GRAPH_TRACER is not set.

So the #ifdef is not needed, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ffbe79960c73..e86e28c28259 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2096,10 +2096,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack,
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
 	int firstframe = 1;
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	unsigned long ret_addr;
 	int ftrace_idx = 0;
-#endif
 
 	if (tsk == NULL)
 		tsk = current;
@@ -2127,12 +2125,10 @@ void show_stack(struct task_struct *tsk, unsigned long *stack,
 		if (!firstframe || ip != lr) {
 			printk("%s["REG"] ["REG"] %pS",
 				loglvl, sp, ip, (void *)ip);
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			ret_addr = ftrace_graph_ret_addr(current,
 						&ftrace_idx, ip, stack);
 			if (ret_addr != ip)
 				pr_cont(" (%pS)", (void *)ret_addr);
-#endif
 			if (firstframe)
 				pr_cont(" (unreliable)");
 			pr_cont("\n");
-- 
2.25.0

