Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA68C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583492064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Khk97yYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDFSQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:16:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38379 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgDFSQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzJW6Dg8z9v017;
        Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Khk97yYL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GABKz4NnB9jj; Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzJW5CNpz9v016;
        Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197003; bh=a5uur0JjQKV4vKxRMQhPMor8uQsgxQ5q+xZnIEjM+NE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=Khk97yYLUlxW26zWADAmoDOC09G4UoAithNqdRQx8UjowElgsl8MM0YGnJatyFcfz
         6A2h4lFBs2kPvIClvG8uv8rqU3q8pvHTW35X3T3v/eL05YF6QUcs8UUyFyGS0RM+nb
         OK9tsLTYeEwHHQVgRJkQD+wLMy5+BXeSv6yk1koc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A71D18B784;
        Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UHJQSiDgbw6w; Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FA468B775;
        Mon,  6 Apr 2020 20:16:43 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 45F9E656E9; Mon,  6 Apr 2020 18:16:43 +0000 (UTC)
Message-Id: <99c8590956536b6f40b9deeaec559a324ab5f81c.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 07/15] powerpc/irq: Add stub irq_soft_mask_return() for
 PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Apr 2020 18:16:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow building syscall_64.c smoothly on PPC32, add stub version
of irq_soft_mask_return().

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_irq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 8c30a72262fd..1c25a84a3159 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -293,6 +293,11 @@ static inline void set_softe(struct pt_regs *regs, unsigned long val)
 }
 #else /* CONFIG_PPC64 */
 
+static inline notrace unsigned long irq_soft_mask_return(void)
+{
+	return 0;
+}
+
 static inline unsigned long arch_local_save_flags(void)
 {
 	return mfmsr();
-- 
2.25.0

