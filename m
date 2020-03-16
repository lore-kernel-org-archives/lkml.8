Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A690205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WoTOWTbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbgCPMgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:36:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43841 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730919AbgCPMf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:35:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48gwkv4f8Hz9tygx;
        Mon, 16 Mar 2020 13:35:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WoTOWTbX; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hourlX5lNtQy; Mon, 16 Mar 2020 13:35:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48gwkv3PLSz9tyg5;
        Mon, 16 Mar 2020 13:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584362151; bh=vEpeAOuN9+u+UqwhKp0hocFZ/JQ7NbtdHfn7EsmiUSI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=WoTOWTbXXU7UmzKkG2XJaYwy0kVNDxUHcdPdHmuwISNWhfWJnLuQJtDJ5X0omumUj
         er9euVJYZjdmQ0zPXLT1njU8aoDE3Pn00sBDyMsAZvugLXqqzj6PSRuHVkw3KgiVgp
         AAlaghV4Sb/zklOkFt2STvZmyHFdrSPhzbA/GNF4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D7618B7D0;
        Mon, 16 Mar 2020 13:35:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id plUrLy4ru3Kw; Mon, 16 Mar 2020 13:35:56 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5055A8B7CB;
        Mon, 16 Mar 2020 13:35:56 +0100 (CET)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 47D5765595; Mon, 16 Mar 2020 12:35:56 +0000 (UTC)
Message-Id: <755f29975957f229f445b600686b4fba9ee9399a.1584360344.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1584360343.git.christophe.leroy@c-s.fr>
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 11/46] powerpc/ptdump: Display size of BATs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Mar 2020 12:35:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the size of areas mapped with BATs.

For that, the size display for pages is refactorised.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/ptdump/bats.c   |  4 ++++
 arch/powerpc/mm/ptdump/ptdump.c | 23 ++++++++++++++---------
 arch/powerpc/mm/ptdump/ptdump.h |  2 ++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index d3a5d6b318d1..d6c660f63d71 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -10,6 +10,8 @@
 #include <asm/pgtable.h>
 #include <asm/cpu_has_feature.h>
 
+#include "ptdump.h"
+
 static char *pp_601(int k, int pp)
 {
 	if (pp == 0)
@@ -42,6 +44,7 @@ static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
 #else
 	seq_printf(m, "0x%08x ", pbn);
 #endif
+	pt_dump_size(m, size);
 
 	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
 
@@ -88,6 +91,7 @@ static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool
 #else
 	seq_printf(m, "0x%08x ", brpn);
 #endif
+	pt_dump_size(m, size);
 
 	if (k == 1)
 		seq_puts(m, "User ");
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index d92bb8ea229c..1f97668853e3 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -112,6 +112,19 @@ static struct addr_marker address_markers[] = {
 		seq_putc(m, c);		\
 })
 
+void pt_dump_size(struct seq_file *m, unsigned long size)
+{
+	static const char units[] = "KMGTPE";
+	const char *unit = units;
+
+	/* Work out what appropriate unit to use */
+	while (!(size & 1023) && unit[1]) {
+		size >>= 10;
+		unit++;
+	}
+	pt_dump_seq_printf(m, "%9lu%c ", size, *unit);
+}
+
 static void dump_flag_info(struct pg_state *st, const struct flag_info
 		*flag, u64 pte, int num)
 {
@@ -146,8 +159,6 @@ static void dump_flag_info(struct pg_state *st, const struct flag_info
 
 static void dump_addr(struct pg_state *st, unsigned long addr)
 {
-	static const char units[] = "KMGTPE";
-	const char *unit = units;
 	unsigned long delta;
 
 #ifdef CONFIG_PPC64
@@ -164,13 +175,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
 		delta = (addr - st->start_address) >> 10;
 	}
-	/* Work out what appropriate unit to use */
-	while (!(delta & 1023) && unit[1]) {
-		delta >>= 10;
-		unit++;
-	}
-	pt_dump_seq_printf(st->seq, "%9lu%c", delta, *unit);
-
+	pt_dump_size(st->seq, delta);
 }
 
 static void note_prot_wx(struct pg_state *st, unsigned long addr)
diff --git a/arch/powerpc/mm/ptdump/ptdump.h b/arch/powerpc/mm/ptdump/ptdump.h
index 5d513636de73..b91f65f162d6 100644
--- a/arch/powerpc/mm/ptdump/ptdump.h
+++ b/arch/powerpc/mm/ptdump/ptdump.h
@@ -17,3 +17,5 @@ struct pgtable_level {
 };
 
 extern struct pgtable_level pg_level[5];
+
+void pt_dump_size(struct seq_file *m, unsigned long delta);
-- 
2.25.0

