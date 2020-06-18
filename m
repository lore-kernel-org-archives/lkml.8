Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D224420890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbgFRUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:43 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:40437 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731404AbgFRUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:33 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 616F7B265A;
        Thu, 18 Jun 2020 16:39:36 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 43/51] objtool: check: Use class to recognize kcov calls
Date:   Thu, 18 Jun 2020 13:38:29 -0700
Message-ID: <5edc3b938d5c234b012227699f12e6f3980094b8.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-001.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/check.c | 3 +--
 tools/objtool/elf.c   | 7 +++++++
 tools/objtool/elf.h   | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 78375908acda..d08714b878c5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -771,8 +771,7 @@ static int add_call_destinations(struct objtool_file *file)
 		 * so they need a little help, NOP out any KCOV calls from noinstr
 		 * text.
 		 */
-		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		if (insn->sec->noinstr && insn->call_dest->class == SYM_KCOV) {
 			if (reloc) {
 				reloc->type = R_NONE;
 				elf_write_reloc(file->elf, reloc);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d55d8fef11b4..666cbc01c332 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -402,6 +402,11 @@ static bool is_mcount_sym(const char *name)
 	return false;
 }
 
+static bool is_kcov_symbol(const char *name)
+{
+	return !strncmp(name, "__sanitize_cov_", 16);
+}
+
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
@@ -473,6 +478,8 @@ static int read_symbols(struct elf *elf)
 
 		if (is_mcount_sym(sym->name))
 			sym->class = SYM_MCOUNT;
+		else if (is_kcov_symbol(sym->name))
+			sym->class = SYM_KCOV;
 
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 13935edaff54..f0b02824f9d3 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -45,6 +45,7 @@ struct section {
 enum symbol_class {
 	SYM_REGULAR = 0,
 	SYM_MCOUNT = 1,
+	SYM_KCOV = 2,
 };
 
 struct symbol {
-- 
2.20.1

