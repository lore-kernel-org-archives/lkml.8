Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FD3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B312220857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgDVW0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgDVWZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91685C03C1A9;
        Wed, 22 Apr 2020 15:25:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnU-0001RI-5O; Thu, 23 Apr 2020 00:24:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A7D5B1C0450;
        Thu, 23 Apr 2020 00:24:44 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:44 -0000
From:   "tip-bot2 for Sami Tolvanen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use gelf_getsymshndx() to handle >64k sections
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158759428414.28353.13399607572117733113.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     01a919f8e8eb9285d76024bee32e23cc125cad48
Gitweb:        https://git.kernel.org/tip/01a919f8e8eb9285d76024bee32e23cc125cad48
Author:        Sami Tolvanen <samitolvanen@google.com>
AuthorDate:    Tue, 21 Apr 2020 15:08:42 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Apr 2020 18:49:18 -05:00

objtool: Use gelf_getsymshndx() to handle >64k sections

Currently, objtool fails to load the correct section for symbols when
the index is greater than SHN_LORESERVE. Use gelf_getsymshndx() instead
of gelf_getsym() to handle >64k sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/elf.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c20dfe1..43748cb 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -327,12 +327,14 @@ static int read_sections(struct elf *elf)
 
 static int read_symbols(struct elf *elf)
 {
-	struct section *symtab, *sec;
+	struct section *symtab, *symtab_shndx, *sec;
 	struct symbol *sym, *pfunc;
 	struct list_head *entry;
 	struct rb_node *pnode;
 	int symbols_nr, i;
 	char *coldstr;
+	Elf_Data *shndx_data = NULL;
+	Elf32_Word shndx;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
@@ -340,6 +342,10 @@ static int read_symbols(struct elf *elf)
 		return -1;
 	}
 
+	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+	if (symtab_shndx)
+		shndx_data = symtab_shndx->data;
+
 	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
 
 	for (i = 0; i < symbols_nr; i++) {
@@ -353,8 +359,9 @@ static int read_symbols(struct elf *elf)
 
 		sym->idx = i;
 
-		if (!gelf_getsym(symtab->data, i, &sym->sym)) {
-			WARN_ELF("gelf_getsym");
+		if (!gelf_getsymshndx(symtab->data, shndx_data, i, &sym->sym,
+				      &shndx)) {
+			WARN_ELF("gelf_getsymshndx");
 			goto err;
 		}
 
@@ -368,10 +375,13 @@ static int read_symbols(struct elf *elf)
 		sym->type = GELF_ST_TYPE(sym->sym.st_info);
 		sym->bind = GELF_ST_BIND(sym->sym.st_info);
 
-		if (sym->sym.st_shndx > SHN_UNDEF &&
-		    sym->sym.st_shndx < SHN_LORESERVE) {
-			sym->sec = find_section_by_index(elf,
-							 sym->sym.st_shndx);
+		if ((sym->sym.st_shndx > SHN_UNDEF &&
+		     sym->sym.st_shndx < SHN_LORESERVE) ||
+		    (shndx_data && sym->sym.st_shndx == SHN_XINDEX)) {
+			if (sym->sym.st_shndx != SHN_XINDEX)
+				shndx = sym->sym.st_shndx;
+
+			sym->sec = find_section_by_index(elf, shndx);
 			if (!sym->sec) {
 				WARN("couldn't find section for symbol %s",
 				     sym->name);
