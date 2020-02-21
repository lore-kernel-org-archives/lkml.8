Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62352C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4012424653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBUJvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:51:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbgBUJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:51:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j54xR-00079p-8C; Fri, 21 Feb 2020 10:50:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DFF261C20BF;
        Fri, 21 Feb 2020 10:50:52 +0100 (CET)
Date:   Fri, 21 Feb 2020 09:50:52 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Fix clang switch table edge case
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com>
References: <263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158227865267.28353.1809834371587369139.tip-bot2@tip-bot2>
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

Commit-ID:     113d4bc9048336ba7c3d2ad972dbad4aef6e148a
Gitweb:        https://git.kernel.org/tip/113d4bc9048336ba7c3d2ad972dbad4aef6e148a
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 17 Feb 2020 21:41:53 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 21 Feb 2020 10:12:52 +01:00

objtool: Fix clang switch table edge case

Clang has the ability to create a switch table which is not a jump
table, but is rather a table of string pointers.  This confuses objtool,
because it sees the relocations for the string pointers and assumes
they're part of a jump table:

  drivers/ata/sata_dwc_460ex.o: warning: objtool: sata_dwc_bmdma_start_by_tag()+0x3a2: can't find switch jump table
  net/ceph/messenger.o: warning: objtool: ceph_con_workfn()+0x47c: can't find switch jump table

Make objtool's find_jump_table() smart enough to distinguish between a
switch jump table (which has relocations to text addresses in the same
function as the original instruction) and other anonymous rodata (which
may have relocations to elsewhere).

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/485
Link: https://lkml.kernel.org/r/263f6aae46d33da0b86d7030ced878cb5cab1788.1581997059.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b038de2..4d6e283 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1025,7 +1025,7 @@ static struct rela *find_jump_table(struct objtool_file *file,
 				      struct instruction *insn)
 {
 	struct rela *text_rela, *table_rela;
-	struct instruction *orig_insn = insn;
+	struct instruction *dest_insn, *orig_insn = insn;
 	struct section *table_sec;
 	unsigned long table_offset;
 
@@ -1077,10 +1077,17 @@ static struct rela *find_jump_table(struct objtool_file *file,
 		    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 			continue;
 
-		/* Each table entry has a rela associated with it. */
+		/*
+		 * Each table entry has a rela associated with it.  The rela
+		 * should reference text in the same function as the original
+		 * instruction.
+		 */
 		table_rela = find_rela_by_dest(table_sec, table_offset);
 		if (!table_rela)
 			continue;
+		dest_insn = find_insn(file, table_rela->sym->sec, table_rela->addend);
+		if (!dest_insn || !dest_insn->func || dest_insn->func->pfunc != func)
+			continue;
 
 		/*
 		 * Use of RIP-relative switch jumps is quite rare, and
