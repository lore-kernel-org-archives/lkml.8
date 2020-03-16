Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FC0C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B41B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hLw8Nux6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbgCPMgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37771 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731047AbgCPMf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkw4bsVz9v02f;
        Mon, 16 Mar 2020 13:35:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hLw8Nux6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xVySYLiVKTXs; Mon, 16 Mar 2020 13:35:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkw3c5tz9tyg5;
        Mon, 16 Mar 2020 13:35:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362152; bh=7T2j7aCGb8NtMk1LhfHLJamKiLLolKEjkaTJMMTZcqE=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=hLw8Nux6C7NgL4F6SDj0cxq17ate88zw0jjhI7/tnkXeE+hwCm3WMbY6/t8kJ+U6D
         lICvcifOwO8mgSKTROYGkPcAUc9SpnXqxAk5gK4nrjwM4sdw/6/x60hujFw/JltvQ+
         MpSNxpBpEMaVwhWiuDdGgwk9H14pdtevxv41mbzE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B38B8B7D2;
        Mon, 16 Mar 2020 13:35:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ocbX3nmRNadO; Mon, 16 Mar 2020 13:35:57 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5948B8B7D0;
        Mon, 16 Mar 2020 13:35:57 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5138465595; Mon, 16 Mar 2020 12:35:57 +0000 (UTC)
Message-Id: <435eef455d86828626ac4d064c0d8b8aca0c706b.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 12/46] powerpc/ptdump: Standardise display of BAT flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display BAT flags the same way as page flags: rwx and wimg

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
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

