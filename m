Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22823C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD3F20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="A7oUzo4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgCaQDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28535 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731229AbgCaQDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sDdh3H0fz9twdW;
        Tue, 31 Mar 2020 18:03:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=A7oUzo4C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 26lFx3Wyfu6f; Tue, 31 Mar 2020 18:03:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sDdg74DBz9twdT;
        Tue, 31 Mar 2020 18:03:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585670616; bh=aiA10aQwJFJQJHEkFc2uMUtIcc46uj6nfeI/8CpTGoY=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=A7oUzo4CVxadUNxnKXs4vHVifbb1KzzK3pfj7Xx3dhXX4e9KM6tRFmDIXrQxouCLi
         ZZMKA9OcP2Z0tL1Yfs7Xqlf/UTX+m4AmU4/9v6FWz1scBZrZT2kKh632RcmGjM3Q6p
         +dwiBh1WZYfsnBF69PE1dca7XaQgKmg3Wr1Xlh5I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 99FBF8B868;
        Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DlF0JSikage0; Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E0E78B752;
        Tue, 31 Mar 2020 18:03:37 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4E9A3656AC; Tue, 31 Mar 2020 16:03:37 +0000 (UTC)
Message-Id: <5dca36682383577a3c2b2bca4d577e8654944461.1585670437.git.christophe.leroy@c-s.fr>
In-Reply-To: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
References: <1ae02b6637b87fc5aaa1d5012c3e2cb30e62b4a3.1585670437.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 02/12] powerpc/82xx: Blacklist pq2_restart() for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 31 Mar 2020 16:03:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/82xx/pq2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 1cdd5ed9d896..3b5cb39a564c 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -10,6 +10,8 @@
  * Copyright (c) 2006 MontaVista Software, Inc.
  */
 
+#include <linux/kprobes.h>
+
 #include <asm/cpm2.h>
 #include <asm/io.h>
 #include <asm/pci-bridge.h>
@@ -29,6 +31,7 @@ void __noreturn pq2_restart(char *cmd)
 
 	panic("Restart failed\n");
 }
+NOKPROBE_SYMBOL(pq2_restart)
 
 #ifdef CONFIG_PCI
 static int pq2_pci_exclude_device(struct pci_controller *hose,
-- 
2.25.0

