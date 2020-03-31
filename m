Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FEC2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1C02145D
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="wHDzmtI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgCaQEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:04:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63917 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbgCaQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdl1NYYz9twdZ;
        Tue, 31 Mar 2020 18:03:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wHDzmtI3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id RUXVmZQCXCTh; Tue, 31 Mar 2020 18:03:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdl0MQbz9twdT;
        Tue, 31 Mar 2020 18:03:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670619; bh=6dnGmEP9kaYDu3frjLwq4tVxGR7ljMwwBq0u7Py+ixo=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=wHDzmtI3V9cWHr3qGCm13i2VIkk8rPqqIdSzI4Lk2Gwqr+2ewxYhwIXQgpFTAO9Ue
         E9tb1oI+RAypim8lEbsIQMPfwQgKIXmVbekJrQ833H5EiosPy45ZQEvQgOcUfa0LSr
         xH6W1ranwAOD+QrKNapFZfg0RNJFggXEA8y8S57A=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC9D18B868;
        Tue, 31 Mar 2020 18:03:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cwxwwFWIHa4z; Tue, 31 Mar 2020 18:03:40 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6FFC38B752;
        Tue, 31 Mar 2020 18:03:40 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 60447656AC; Tue, 31 Mar 2020 16:03:40 +0000 (UTC)
Message-Id: <eaab3bff961c3bfe149f1d0bd3593291ef939dcc.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/12] powerpc/mem: Blacklist flush_dcache_icache_phys()
 for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9b4f5fb719e0..bcb6af6ba29a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -32,6 +32,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memremap.h>
 #include <linux/dma-direct.h>
+#include <linux/kprobes.h>
 
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
@@ -466,6 +467,7 @@ static void flush_dcache_icache_phys(unsigned long physaddr)
 		: "r" (nb), "r" (msr), "i" (bytes), "r" (msr0)
 		: "ctr", "memory");
 }
+NOKPROBE_SYMBOL(flush_dcache_icache_phys)
 #endif // !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC64)
 
 /*
-- 
2.25.0

