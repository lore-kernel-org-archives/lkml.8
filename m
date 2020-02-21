Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056BBC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1DE206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBUJvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:51:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgBUJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:51:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j54xQ-00079o-VK; Fri, 21 Feb 2020 10:50:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8A36A1C1A47;
        Fri, 21 Feb 2020 10:50:52 +0100 (CET)
Date:   Fri, 21 Feb 2020 09:50:52 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Improve call destination function detection
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
References: <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158227865224.28353.12310568117533168509.tip-bot2@tip-bot2>
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

Commit-ID:     7acfe5315312fc56c2a94c9216448087b38ae909
Gitweb:        https://git.kernel.org/tip/7acfe5315312fc56c2a94c9216448087b38ae909
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 17 Feb 2020 21:41:54 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 21 Feb 2020 10:20:34 +01:00

objtool: Improve call destination function detection

A recent clang change, combined with a binutils bug, can trigger a
situation where a ".Lprintk$local" STT_NOTYPE symbol gets created at the
same offset as the "printk" STT_FUNC symbol.  This confuses objtool:

  kernel/printk/printk.o: warning: objtool: ignore_loglevel_setup()+0x10: can't find call dest symbol at .text+0xc67

Improve the call destination detection by looking specifically for an
STT_FUNC symbol.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/872
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25551
Link: https://lkml.kernel.org/r/0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 27 ++++++++++++++++++---------
 tools/objtool/elf.c   | 14 ++++++++++++--
 tools/objtool/elf.h   |  1 +
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4d6e283..6b6178e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -420,8 +420,8 @@ static void add_ignores(struct objtool_file *file)
 			break;
 
 		case STT_SECTION:
-			func = find_symbol_by_offset(rela->sym->sec, rela->addend);
-			if (!func || func->type != STT_FUNC)
+			func = find_func_by_offset(rela->sym->sec, rela->addend);
+			if (!func)
 				continue;
 			break;
 
@@ -665,10 +665,14 @@ static int add_call_destinations(struct objtool_file *file)
 					       insn->len);
 		if (!rela) {
 			dest_off = insn->offset + insn->len + insn->immediate;
-			insn->call_dest = find_symbol_by_offset(insn->sec,
-								dest_off);
+			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
+			if (!insn->call_dest)
+				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
 
-			if (!insn->call_dest && !insn->ignore) {
+			if (insn->ignore)
+				continue;
+
+			if (!insn->call_dest) {
 				WARN_FUNC("unsupported intra-function call",
 					  insn->sec, insn->offset);
 				if (retpoline)
@@ -676,11 +680,16 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
+			if (insn->func && insn->call_dest->type != STT_FUNC) {
+				WARN_FUNC("unsupported call to non-function",
+					  insn->sec, insn->offset);
+				return -1;
+			}
+
 		} else if (rela->sym->type == STT_SECTION) {
-			insn->call_dest = find_symbol_by_offset(rela->sym->sec,
-								rela->addend+4);
-			if (!insn->call_dest ||
-			    insn->call_dest->type != STT_FUNC) {
+			insn->call_dest = find_func_by_offset(rela->sym->sec,
+							      rela->addend+4);
+			if (!insn->call_dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%x",
 					  insn->sec, insn->offset,
 					  rela->sym->sec->name,
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index edba474..cc4601c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -62,8 +62,18 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 	struct symbol *sym;
 
 	list_for_each_entry(sym, &sec->symbol_list, list)
-		if (sym->type != STT_SECTION &&
-		    sym->offset == offset)
+		if (sym->type != STT_SECTION && sym->offset == offset)
+			return sym;
+
+	return NULL;
+}
+
+struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
+{
+	struct symbol *sym;
+
+	list_for_each_entry(sym, &sec->symbol_list, list)
+		if (sym->type == STT_FUNC && sym->offset == offset)
 			return sym;
 
 	return NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 4415020..a196325 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -77,6 +77,7 @@ struct elf {
 
 struct elf *elf_read(const char *name, int flags);
 struct section *find_section_by_name(struct elf *elf, const char *name);
+struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
