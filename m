Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A19C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F99521924
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgCZKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:08:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50236 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgCZKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:08:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jHPRK-00048E-8g; Thu, 26 Mar 2020 11:08:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D19F11C0470;
        Thu, 26 Mar 2020 11:08:36 +0100 (CET)
Date:   Thu, 26 Mar 2020 10:08:36 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Add a statistics mode
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200324160924.321381240@infradead.org>
References: <20200324160924.321381240@infradead.org>
MIME-Version: 1.0
Message-ID: <158521731644.28353.18368440874745073752.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     1e11f3fdc326d7466e43185ea943b6156143387c
Gitweb:        https://git.kernel.org/tip/1e11f3fdc326d7466e43185ea943b6156143387c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Mar 2020 09:26:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Mar 2020 18:28:28 +01:00

objtool: Add a statistics mode

Have it print a few numbers which can be used to size the hashtables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200324160924.321381240@infradead.org
---
 tools/objtool/builtin-check.c |  3 ++-
 tools/objtool/builtin.h       |  2 +-
 tools/objtool/check.c         |  5 +++++
 tools/objtool/elf.c           | 18 +++++++++++++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c807984..10fbe75 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -17,7 +17,7 @@
 #include "builtin.h"
 #include "check.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -31,6 +31,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
 	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
 	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
+	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index a32736f..0b90790 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 43f7d3c..6df1bae 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -239,6 +239,7 @@ static int decode_instructions(struct objtool_file *file)
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
+	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -274,6 +275,7 @@ static int decode_instructions(struct objtool_file *file)
 
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
 			list_add_tail(&insn->list, &file->insn_list);
+			nr_insns++;
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
@@ -291,6 +293,9 @@ static int decode_instructions(struct objtool_file *file)
 		}
 	}
 
+	if (stats)
+		printf("nr_insns: %lu\n", nr_insns);
+
 	return 0;
 
 err:
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b188b3e..ff29306 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include "builtin.h"
 
 #include "elf.h"
 #include "warn.h"
@@ -202,6 +203,9 @@ static int read_sections(struct elf *elf)
 		sec->len = sec->sh.sh_size;
 	}
 
+	if (stats)
+		printf("nr_sections: %lu\n", (unsigned long)sections_nr);
+
 	/* sanity check, one more call to elf_nextscn() should return NULL */
 	if (elf_nextscn(elf->elf, s)) {
 		WARN("section entry mismatch");
@@ -299,6 +303,9 @@ static int read_symbols(struct elf *elf)
 		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 	}
 
+	if (stats)
+		printf("nr_symbols: %lu\n", (unsigned long)symbols_nr);
+
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
@@ -360,6 +367,7 @@ static int read_relas(struct elf *elf)
 	struct rela *rela;
 	int i;
 	unsigned int symndx;
+	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->sh.sh_type != SHT_RELA)
@@ -374,6 +382,7 @@ static int read_relas(struct elf *elf)
 
 		sec->base->rela = sec;
 
+		nr_rela = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
 			rela = malloc(sizeof(*rela));
 			if (!rela) {
@@ -401,8 +410,15 @@ static int read_relas(struct elf *elf)
 
 			list_add_tail(&rela->list, &sec->rela_list);
 			hash_add(sec->rela_hash, &rela->hash, rela->offset);
-
+			nr_rela++;
 		}
+		max_rela = max(max_rela, nr_rela);
+		tot_rela += nr_rela;
+	}
+
+	if (stats) {
+		printf("max_rela: %lu\n", max_rela);
+		printf("tot_rela: %lu\n", tot_rela);
 	}
 
 	return 0;
