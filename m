Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC729206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 09:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JnDdYOfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgC2JlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 05:41:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39246 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgC2JlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 05:41:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qrF8086Sz9tyY1;
        Sun, 29 Mar 2020 11:41:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JnDdYOfj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Nk15TEoLAvxt; Sun, 29 Mar 2020 11:40:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qrF75sJ9z9tyXy;
        Sun, 29 Mar 2020 11:40:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585474859; bh=W+exIu2nrW5h+fvxXBzSczFg6UNdEpgTjuvWpuQyc8Y=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=JnDdYOfjd5pPGyyfLA/+bEiKC7b5vbeiHB25f97WLzdheBp3RVLdCFEcGnosyMleW
         VnS3zK0GnHaDKDlvrNlf8WoP5TFHsQfBB3wwKxHwPTAfifuPhAgoUiys5BmhPZvSQr
         WZqQ5H8sce/M8z5Jfqc7MCO0zh2bg0ABSxH4tY3M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BFEC68B770;
        Sun, 29 Mar 2020 11:41:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qnBZbROU2wwQ; Sun, 29 Mar 2020 11:41:02 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 867998B752;
        Sun, 29 Mar 2020 11:41:02 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5A7D165653; Sun, 29 Mar 2020 09:41:02 +0000 (UTC)
Message-Id: <c7eac7fc41a4cd31b0769c824697811045514a68.1585474724.git.christophe.leroy@c-s.fr>
In-Reply-To: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 02/12] powerpc/82xx: Blacklist pq2_restart() for kprobe
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 29 Mar 2020 09:41:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kprobe does not handle events happening in real mode, all
functions running with MMU disabled have to be blacklisted.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
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

