Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C03CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5631120709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgESFvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:51:12 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19687 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgESFs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:48:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4gn5n0fz9txly;
        Tue, 19 May 2020 07:48:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZJbhtjyuMP6g; Tue, 19 May 2020 07:48:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4gn4rrpz9txlx;
        Tue, 19 May 2020 07:48:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 180728B7A8;
        Tue, 19 May 2020 07:48:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2tbQfONmVIhL; Tue, 19 May 2020 07:48:53 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD4818B767;
        Tue, 19 May 2020 07:48:52 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B910C65A4A; Tue, 19 May 2020 05:48:52 +0000 (UTC)
Message-Id: <acf764eee231f0358e66ca9e819f052804055acc.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 10/45] powerpc/ptdump: Display size of BATs
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:48:52 +0000 (UTC)
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

