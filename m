Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D33EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7D4208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgFRUjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:54 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731176AbgFRUjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:15 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:09 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 2A13FB2656;
        Thu, 18 Jun 2020 16:39:12 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 17/51] objtool: mcount: Stop using ehdr in find_section_sym_index
Date:   Thu, 18 Jun 2020 13:38:03 -0700
Message-ID: <0a0a522dcbe7038109bd97571c965a2afba0123c.1592510545.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1592510545.git.mhelsley@vmware.com>
References: <cover.1592510545.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use the objtool GElf_Ehdr structure to access ehdr here.
This makes the function completely independent of the old
recordmcount ELF wrapper. The next step will be to promote it
to the C file.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 941f96e4f74b..cf420f9f64b0 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -225,7 +225,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 			       Elf_Rel **const mrelpp,
 			       const struct section * const rels,
 			       unsigned const recsym_index,
-			       uint_t const recval,
+			       unsigned long const recval,
 			       unsigned const reltype)
 {
 	uint_t *const mloc0 = mlocp;
@@ -319,9 +319,8 @@ static int nop_mcount(struct section * const rels,
  */
 static int find_section_sym_index(unsigned const txtndx,
 				char const *const txtname,
-				uint_t *const recvalp,
-				unsigned int *sym_index,
-				Elf_Ehdr const *const ehdr)
+				unsigned long *const recvalp,
+				unsigned int *sym_index)
 {
 	struct symbol *sym;
 	struct section *txts = find_section_by_index(lf, txtndx);
@@ -336,7 +335,7 @@ static int find_section_sym_index(unsigned const txtndx,
 		/* avoid symbols with weak binding */
 		if ((sym->bind == STB_LOCAL) || (sym->bind == STB_GLOBAL)) {
 			/* function symbols on ARM have quirks, avoid them */
-			if (w2(ehdr->e_machine) == EM_ARM
+			if (lf->ehdr.e_machine == EM_ARM
 			    && sym->type == STT_FUNC)
 				continue;
 
@@ -424,12 +423,12 @@ static int do_func(Elf_Ehdr *const ehdr,
 
 		txtname = has_rel_mcount(sec);
 		if (txtname && is_mcounted_section_name(txtname)) {
+			unsigned long recval = 0;
 			unsigned int recsym;
-			uint_t recval = 0;
 
 			symsec_sh_link = sec->sh.sh_link;
 			result = find_section_sym_index(sec->sh.sh_info,
-						txtname, &recval, &recsym, ehdr);
+						txtname, &recval, &recsym);
 			if (result)
 				goto out;
 
-- 
2.20.1

