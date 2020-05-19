Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29000C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B7820709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgESFvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:51:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:9790 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgESFs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:48:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4gp1F6yz9txlx;
        Tue, 19 May 2020 07:48:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1eQOBIsgZyEn; Tue, 19 May 2020 07:48:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4gn5t0mz9txm1;
        Tue, 19 May 2020 07:48:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0DCC8B767;
        Tue, 19 May 2020 07:48:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5zEagKNegDrO; Tue, 19 May 2020 07:48:54 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 033148B7A7;
        Tue, 19 May 2020 07:48:54 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D2E2365A4B; Tue, 19 May 2020 05:48:53 +0000 (UTC)
Message-Id: <a07585f353c167b8db9597d83f992a5cb4fbf4c4.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 11/45] powerpc/ptdump: Standardise display of BAT flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:48:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display BAT flags the same way as page flags: rwx and wimg

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/bats.c | 37 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index d6c660f63d71..cebb58c7e289 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -15,12 +15,12 @@
 static char *pp_601(int k, int pp)
 {
 	if (pp == 0)
-		return k ? "NA" : "RWX";
+		return k ? "   " : "rwx";
 	if (pp == 1)
-		return k ? "ROX" : "RWX";
+		return k ? "r x" : "rwx";
 	if (pp == 2)
-		return k ? "RWX" : "RWX";
-	return k ? "ROX" : "ROX";
+		return "rwx";
+	return "r x";
 }
 
 static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
@@ -48,12 +48,9 @@ static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
 
 	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
 
-	if (lower & _PAGE_WRITETHRU)
-		seq_puts(m, "write through ");
-	if (lower & _PAGE_NO_CACHE)
-		seq_puts(m, "no cache ");
-	if (lower & _PAGE_COHERENT)
-		seq_puts(m, "coherent ");
+	seq_puts(m, lower & _PAGE_WRITETHRU ? "w " : "  ");
+	seq_puts(m, lower & _PAGE_NO_CACHE ? "i " : "  ");
+	seq_puts(m, lower & _PAGE_COHERENT ? "m " : "  ");
 	seq_puts(m, "\n");
 }
 
@@ -101,20 +98,16 @@ static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool
 		seq_puts(m, "Kernel/User ");
 
 	if (lower & BPP_RX)
-		seq_puts(m, is_d ? "RO " : "EXEC ");
+		seq_puts(m, is_d ? "r   " : "  x ");
 	else if (lower & BPP_RW)
-		seq_puts(m, is_d ? "RW " : "EXEC ");
+		seq_puts(m, is_d ? "rw  " : "  x ");
 	else
-		seq_puts(m, is_d ? "NA " : "NX   ");
-
-	if (lower & _PAGE_WRITETHRU)
-		seq_puts(m, "write through ");
-	if (lower & _PAGE_NO_CACHE)
-		seq_puts(m, "no cache ");
-	if (lower & _PAGE_COHERENT)
-		seq_puts(m, "coherent ");
-	if (lower & _PAGE_GUARDED)
-		seq_puts(m, "guarded ");
+		seq_puts(m, is_d ? "    " : "    ");
+
+	seq_puts(m, lower & _PAGE_WRITETHRU ? "w " : "  ");
+	seq_puts(m, lower & _PAGE_NO_CACHE ? "i " : "  ");
+	seq_puts(m, lower & _PAGE_COHERENT ? "m " : "  ");
+	seq_puts(m, lower & _PAGE_GUARDED ? "g " : "  ");
 	seq_puts(m, "\n");
 }
 
-- 
2.25.0

