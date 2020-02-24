Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22C8C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A8420836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VqRcwZtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBXSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:02:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42488 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBXSCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:02:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48R8z16g7cz9v9kQ;
        Mon, 24 Feb 2020 19:02:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VqRcwZtj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JrN8DRE25OKN; Mon, 24 Feb 2020 19:02:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48R8z15d9Zz9v9kP;
        Mon, 24 Feb 2020 19:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582567325; bh=CNFLih4PSoPyQOKHdwh0bZCil4LvN1c7uLrlcFFy9Dg=;
        h=From:Subject:To:Cc:Date:From;
        b=VqRcwZtjprMistze4TollXwv7njS+9K1lRrSm8r6JAlNw/EdWMvGMj/2pJsk70fec
         7GT6v67BhGwXY/wQqOLOhwYI37P9DNk2D7iURtYEgO9cokdU4gN9VUITGCjj34JDtS
         LQtEra6Bmk8g5g3ZiZOkZks+gG6KL8ZOAHMhP/A0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29D5F8B80C;
        Mon, 24 Feb 2020 19:02:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TsW2Zfb04y9p; Mon, 24 Feb 2020 19:02:11 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB8428B7FC;
        Mon, 24 Feb 2020 19:02:10 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B6840653B3; Mon, 24 Feb 2020 18:02:10 +0000 (UTC)
Message-Id: <7f24b5961a6839ff01df792816807f74ff236bf6.1582567319.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/kprobes: Use probe_address() to read instructions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 24 Feb 2020 18:02:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid Oopses, use probe_address() to read the
instruction at the address where the trap happened.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/kprobes.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 84567406b53d..a35320b79e16 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -276,14 +276,18 @@ int kprobe_handler(struct pt_regs *regs)
 
 	p = get_kprobe(addr);
 	if (!p) {
-		if (*addr != BREAKPOINT_INSTRUCTION) {
+		unsigned int instr;
+
+		if (probe_kernel_address(addr, instr))
+			goto no_kprobe;
+
+		if (instr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * PowerPC has multiple variants of the "trap"
 			 * instruction. If the current instruction is a
 			 * trap variant, it could belong to someone else
 			 */
-			kprobe_opcode_t cur_insn = *addr;
-			if (is_trap(cur_insn))
+			if (is_trap(instr))
 				goto no_kprobe;
 			/*
 			 * The breakpoint instruction was removed right
-- 
2.25.0

