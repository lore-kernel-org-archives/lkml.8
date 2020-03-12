Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30250C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DBA206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GWO0R2Jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCLNwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:52:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46826 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgCLNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oBLwvET+0k0j7X/OB8L4PKh3SR3S8WagzDhsOa3sVW4=; b=GWO0R2JnSFOXwfzonPIT+8oZDZ
        g+v+RTKMxiiALTvW28CQI9IXqtXWFI/dhnOZFwt0uYTj+VgrRcIeEl9d1mdv3Em1tZ3zVO0zHAkry
        JEly7eIFoWHnhG8cxdR57wPHLk89G5lxs76paWXKi0n1paqCIU1PEMJw1TpFMqobDij/wbrF5tCiM
        5cTAsjrnOh3JMSvmEo2gkGTo5NFHX8HVVAB+tfZRLvQARZlOFgeGq8YOd19dNxSLx6UIshXarznJG
        2vEfoWvlrtwIpJTSCqtSsj28dafExJis71ayV16fDSTEX8Qk75/68IDjGPgrFvYK/kJO39jQa7P/l
        TcWwmTBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOFN-0003AS-HJ; Thu, 12 Mar 2020 13:51:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4487B3060CA;
        Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A1E02B92DA0B; Thu, 12 Mar 2020 14:51:34 +0100 (CET)
Message-Id: <20200312135041.758571858@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 12 Mar 2020 14:41:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: [RFC][PATCH 06/16] objtool: Add a statistics mode
References: <20200312134107.700205216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have it print a few numbers which can be used to size the hashtables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c |    3 ++-
 tools/objtool/builtin.h       |    2 +-
 tools/objtool/check.c         |    5 +++++
 tools/objtool/elf.c           |   18 +++++++++++++++++-
 4 files changed, 25 insertions(+), 3 deletions(-)

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
 
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -234,6 +234,7 @@ static int decode_instructions(struct ob
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
+	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -268,6 +269,7 @@ static int decode_instructions(struct ob
 				goto err;
 
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
+			nr_insns++;
 			list_add_tail(&insn->list, &file->insn_list);
 		}
 
@@ -286,6 +288,9 @@ static int decode_instructions(struct ob
 		}
 	}
 
+	if (stats)
+		printf("nr_insns: %lu\n", nr_insns);
+
 	return 0;
 
 err:
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -15,6 +15,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include "builtin.h"
 
 #include "elf.h"
 #include "warn.h"
@@ -192,6 +193,9 @@ static int read_sections(struct elf *elf
 		sec->len = sec->sh.sh_size;
 	}
 
+	if (stats)
+		printf("nr_sections: %lu\n", (unsigned long)sections_nr);
+
 	/* sanity check, one more call to elf_nextscn() should return NULL */
 	if (elf_nextscn(elf->elf, s)) {
 		WARN("section entry mismatch");
@@ -290,6 +294,9 @@ static int read_symbols(struct elf *elf)
 		hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 	}
 
+	if (stats)
+		printf("nr_symbols: %lu\n", (unsigned long)symbols_nr);
+
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		list_for_each_entry(sym, &sec->symbol_list, list) {
@@ -351,6 +358,7 @@ static int read_relas(struct elf *elf)
 	struct rela *rela;
 	int i;
 	unsigned int symndx;
+	unsigned long nr_rela, max_rela = 0, tot_rela = 0;
 
 	list_for_each_entry(sec, &elf->sections, list) {
 		if (sec->sh.sh_type != SHT_RELA)
@@ -365,6 +373,7 @@ static int read_relas(struct elf *elf)
 
 		sec->base->rela = sec;
 
+		nr_rela = 0;
 		for (i = 0; i < sec->sh.sh_size / sec->sh.sh_entsize; i++) {
 			rela = malloc(sizeof(*rela));
 			if (!rela) {
@@ -392,8 +401,15 @@ static int read_relas(struct elf *elf)
 
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


