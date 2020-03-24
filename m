Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE62C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F33D21473
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9H1UW53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgCXQMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36936 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgCXQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=C3SBLsl5IQm3J/77kbkHaTHa59IzxaTUSyP9RsjyyXI=; b=P9H1UW53DazYAghbnn3x363Z34
        OJDeHEL00kKXi+7jHwClPuRD2dfdWQqUhK/T8UALDHYrGRZLfowy/LXpJjOeWm4RKpGvGGHQbsVOI
        aROy/OxHDk/B3czvmhxACl0B/o4PDgHOhsDYdkGDtGYnDyDBpJkf7suYJYnTyOEfwXNB9+/BBFQKj
        PZvyjBm0D+s0Y93sjJerHkKk6DUQHT9e2FjOA8+cFgsfWn3k8MDJIG1DsYJp7O877N/FJGyKq2XWN
        cCz0yHWOJDry7Y6knf36r9kYofXXMHGb/ByczTXdb2Zxa0LRJEtsm3JDX9K0JedXM3OF9xZmiMy0H
        gXNunKpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9L-0006bU-79; Tue, 24 Mar 2020 16:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4679F3070F4;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2C68529A490F7; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160924.321381240@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 07/26] objtool: Add a statistics mode
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Have it print a few numbers which can be used to size the hashtables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
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
@@ -239,6 +239,7 @@ static int decode_instructions(struct ob
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
+	unsigned long nr_insns = 0;
 	int ret;
 
 	for_each_sec(file, sec) {
@@ -274,6 +275,7 @@ static int decode_instructions(struct ob
 
 			hash_add(file->insn_hash, &insn->hash, insn->offset);
 			list_add_tail(&insn->list, &file->insn_list);
+			nr_insns++;
 		}
 
 		list_for_each_entry(func, &sec->symbol_list, list) {
@@ -291,6 +293,9 @@ static int decode_instructions(struct ob
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
@@ -202,6 +203,9 @@ static int read_sections(struct elf *elf
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


