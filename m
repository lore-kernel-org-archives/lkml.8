Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2458C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26D9208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgFRUjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3944 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730998AbgFRUjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:11 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:05 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A8BBFB2656;
        Thu, 18 Jun 2020 16:39:08 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 13/51] objtool: mcount: Return symbol from mcountsym
Date:   Thu, 18 Jun 2020 13:37:59 -0700
Message-ID: <11eeca2d50d0609e0d63dc1760692ca00ee6e660.1592510545.git.mhelsley@vmware.com>
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

Before we can move this function out of the wrapper and into
wordsize-independent code we need to return the relocation
symbol information in a size-independent fashion. Previously
we compared the raw info bits but that requires passing around
an unsigned long. Instead we just use a pointer to the objtool
struct symbol which callers can use as-needed.

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Matt Helsley <mhelsley@vmware.com>
Co-developed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>

--

Thanks to Kamalesh Babulal for reporting this problem and suggesting
a fix. Thanks to Peter Zijlstra for recommending an enhancement to
the fix.
---
 tools/objtool/recordmcount.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index df8384f8e9e7..6ac120aa45af 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -271,7 +271,7 @@ static int append_func(Elf_Ehdr *const ehdr,
 	return elf_write(lf);
 }
 
-static unsigned get_mcountsym(struct reloc *reloc)
+static struct symbol *get_mcountsym(struct reloc *reloc)
 {
 	struct symbol *sym = reloc->sym;
 	char const *symname = sym->name;
@@ -283,8 +283,8 @@ static unsigned get_mcountsym(struct reloc *reloc)
 	if (strcmp(mcount, symname) == 0 ||
 	    (altmcount && strcmp(altmcount, symname) == 0) ||
 	    (strcmp(fentry, symname) == 0))
-		return GELF_R_INFO(reloc->sym->idx, reloc->type);
-	return 0;
+		return sym;
+	return NULL;
 }
 
 /*
@@ -303,14 +303,14 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	uint_t *const mloc0 = mlocp;
 	Elf_Rel *mrelp = *mrelpp;
 	unsigned int rel_entsize = rels->sh.sh_entsize;
-	unsigned mcountsym = 0;
+	struct symbol *mcountsym = NULL;
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
 		if (!mcountsym)
 			mcountsym = get_mcountsym(reloc);
 
-		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
+		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
 			uint_t const addend =
 				_w(reloc->offset - recval + mcount_adjust);
 			mrelp->r_offset = _w(offbase
@@ -342,7 +342,7 @@ static int nop_mcount(struct section * const rels,
 		+ (void *)ehdr);
 	struct reloc *reloc;
 	Elf_Shdr const *const shdr = &shdr0[rels->sh.sh_info];
-	unsigned mcountsym = 0;
+	struct symbol *mcountsym = NULL;
 	int once = 0;
 
 	list_for_each_entry(reloc, &rels->reloc_list, list) {
@@ -351,7 +351,7 @@ static int nop_mcount(struct section * const rels,
 		if (!mcountsym)
 			mcountsym = get_mcountsym(reloc);
 
-		if (mcountsym == GELF_R_INFO(reloc->sym->idx, reloc->type) && !is_fake_mcount(reloc)) {
+		if (mcountsym == reloc->sym && !is_fake_mcount(reloc)) {
 			if (make_nop) {
 				ret = make_nop((void *)ehdr, _w(shdr->sh_offset) + reloc->offset);
 				if (ret < 0)
-- 
2.20.1

