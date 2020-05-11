Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923E4C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7805A20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgEKL2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:28:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:5263 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgEKLZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:25:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49LJWs66KRz9ty3s;
        Mon, 11 May 2020 13:25:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SHhRSs8UalBx; Mon, 11 May 2020 13:25:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49LJWs58RQz9ty3g;
        Mon, 11 May 2020 13:25:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6252B8B7B1;
        Mon, 11 May 2020 13:25:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FAKEqwHH8dui; Mon, 11 May 2020 13:25:36 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2675A8B7AD;
        Mon, 11 May 2020 13:25:36 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0B79065A0A; Mon, 11 May 2020 11:25:36 +0000 (UTC)
Message-Id: <4fc349f2cfe5910965e4ef198c6d4e5106455069.1589196133.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589196133.git.christophe.leroy@csgroup.eu>
References: <cover.1589196133.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 10/45] powerpc/ptdump: Display size of BATs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 May 2020 11:25:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display the size of areas mapped with BATs.

For that, the size display for pages is refactorised.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Add missing include of linux/seq_file.h (Thanks to kbuild test robot)
---
 arch/powerpc/mm/ptdump/bats.c   |  4 ++++
 arch/powerpc/mm/ptdump/ptdump.c | 23 ++++++++++++++---------
 arch/powerpc/mm/ptdump/ptdump.h |  3 +++
 3 files changed, 21 insertions(+), 9 deletions(-)

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
index 5d513636de73..154efae96ae0 100644
--- a/arch/powerpc/mm/ptdump/ptdump.h
+++ b/arch/powerpc/mm/ptdump/ptdump.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/types.h>
+#include <linux/seq_file.h>
 
 struct flag_info {
 	u64		mask;
@@ -17,3 +18,5 @@ struct pgtable_level {
 };
 
 extern struct pgtable_level pg_level[5];
+
+void pt_dump_size(struct seq_file *m, unsigned long delta);
-- 
2.25.0

