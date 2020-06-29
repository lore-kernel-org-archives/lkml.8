Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AFFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC7D208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgF2SvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:51:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38135 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbgF2Suz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wQ1h4CRKz9v03x;
        Mon, 29 Jun 2020 13:17:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iuSqKncCRLeh; Mon, 29 Jun 2020 13:17:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wQ1h380Lz9v03v;
        Mon, 29 Jun 2020 13:17:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01BE58B79F;
        Mon, 29 Jun 2020 13:17:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oz9GrzxMmbUc; Mon, 29 Jun 2020 13:17:18 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE2138B799;
        Mon, 29 Jun 2020 13:17:18 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9B6D265B29; Mon, 29 Jun 2020 11:17:18 +0000 (UTC)
Message-Id: <610d6b1a60ad0bedef865a90153c1110cfaa507e.1593429426.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/2] powerpc/ptdump: Refactor update of st->last_pa
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:17:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st->last_pa is always updated in note_page() so it can
be done outside the if/elseif/else block.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/ptdump.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index b2ed1ca4f254..20a039867934 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -211,7 +211,6 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->current_flags = flag;
 		st->start_address = addr;
 		st->start_pa = pa;
-		st->last_pa = pa;
 		st->page_size = page_size;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 	/*
@@ -251,13 +250,11 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		}
 		st->start_address = addr;
 		st->start_pa = pa;
-		st->last_pa = pa;
 		st->page_size = page_size;
 		st->current_flags = flag;
 		st->level = level;
-	} else {
-		st->last_pa = pa;
 	}
+	st->last_pa = pa;
 }
 
 static void walk_pte(struct pg_state *st, pmd_t *pmd, unsigned long start)
-- 
2.25.0

