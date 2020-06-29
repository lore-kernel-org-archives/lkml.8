Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D184A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgF2SvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:51:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40014 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgF2Su4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:56 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wQ1j4VTjz9v040;
        Mon, 29 Jun 2020 13:17:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H2YRpVdWyF5x; Mon, 29 Jun 2020 13:17:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wQ1j3kf7z9v03v;
        Mon, 29 Jun 2020 13:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1882A8B79E;
        Mon, 29 Jun 2020 13:17:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BmjMbQuvKpJa; Mon, 29 Jun 2020 13:17:20 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF1B68B799;
        Mon, 29 Jun 2020 13:17:19 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A030365B29; Mon, 29 Jun 2020 11:17:19 +0000 (UTC)
Message-Id: <a284a809f01c705bbaab303b06fda216f147a99a.1593429426.git.christophe.leroy@csgroup.eu>
In-Reply-To: <610d6b1a60ad0bedef865a90153c1110cfaa507e.1593429426.git.christophe.leroy@csgroup.eu>
References: <610d6b1a60ad0bedef865a90153c1110cfaa507e.1593429426.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/2] powerpc/ptdump: Refactor update of pg_state
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:17:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In note_page(), the pg_state is updated the same way in two places.

Add note_page_update_state() to do it.

Also include the display of boundary markers there as it is missing
"no level" leg, leading to a mismatch when the first two markers
are at the same address and the first displayed area uses that
address.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/ptdump.c | 34 +++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 20a039867934..c911cd757f7d 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -199,6 +199,24 @@ static void note_prot_wx(struct pg_state *st, unsigned long addr)
 	st->wx_pages += (addr - st->start_address) / PAGE_SIZE;
 }
 
+static void note_page_update_state(struct pg_state *st, unsigned long addr,
+				   unsigned int level, u64 val, unsigned long page_size)
+{
+	u64 flag = val & pg_level[level].mask;
+	u64 pa = val & PTE_RPN_MASK;
+
+	st->level = level;
+	st->current_flags = flag;
+	st->start_address = addr;
+	st->start_pa = pa;
+	st->page_size = page_size;
+
+	while (addr >= st->marker[1].start_address) {
+		st->marker++;
+		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+	}
+}
+
 static void note_page(struct pg_state *st, unsigned long addr,
 	       unsigned int level, u64 val, unsigned long page_size)
 {
@@ -207,12 +225,8 @@ static void note_page(struct pg_state *st, unsigned long addr,
 
 	/* At first no level is set */
 	if (!st->level) {
-		st->level = level;
-		st->current_flags = flag;
-		st->start_address = addr;
-		st->start_pa = pa;
-		st->page_size = page_size;
 		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+		note_page_update_state(st, addr, level, val, page_size);
 	/*
 	 * Dump the section of virtual memory when:
 	 *   - the PTE flags from one entry to the next differs.
@@ -244,15 +258,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		 * Address indicates we have passed the end of the
 		 * current section of virtual memory
 		 */
-		while (addr >= st->marker[1].start_address) {
-			st->marker++;
-			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
-		}
-		st->start_address = addr;
-		st->start_pa = pa;
-		st->page_size = page_size;
-		st->current_flags = flag;
-		st->level = level;
+		note_page_update_state(st, addr, level, val, page_size);
 	}
 	st->last_pa = pa;
 }
-- 
2.25.0

