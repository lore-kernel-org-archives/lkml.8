Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75278C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A72073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bXMX1Hmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgC2JlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16391 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgC2JlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrFC0XT6z9tyhR;
        Sun, 29 Mar 2020 11:41:03 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bXMX1Hmi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XsfIWBa2dWSt; Sun, 29 Mar 2020 11:41:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrFB6WFRz9tyXy;
        Sun, 29 Mar 2020 11:41:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474862; bh=JungB4serAEioDrEQ2W47YjKE+qd5j8Iq5EoS3Vfg1I=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=bXMX1HmiXoYm2DiotDJNKcdn0ftnKFJX4bhe1oT9aNob+yZeOr28wi75cTXbG8FOS
         o3GRjMt3G+VQNOyV60CIAtK7O9mISZ0vgXll2TEVOfi9NrkaZHESkHOTPHF7pAxFh/
         /R9BbFHfz3MvCf+Ko2A9SFmHopuUTu7qAjHFj56I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D4B058B770;
        Sun, 29 Mar 2020 11:41:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8gLQ9jD531AP; Sun, 29 Mar 2020 11:41:05 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B4198B752;
        Sun, 29 Mar 2020 11:41:05 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 6E57D65653; Sun, 29 Mar 2020 09:41:05 +0000 (UTC)
Message-Id: <1418e94e9b380c78be7487c5a15adc055e349fda.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 05/12] powerpc/mem: Blacklist flush_dcache_icache_phys() for
 kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
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

