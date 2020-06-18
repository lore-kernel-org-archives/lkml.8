Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA475C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8DB20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgFRUjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:31 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730895AbgFRUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:08 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:38:59 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 83FB5B2659;
        Thu, 18 Jun 2020 16:39:02 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 05/51] objtool: recordmcount: Search for __mcount_loc before walking the sections
Date:   Thu, 18 Jun 2020 13:37:51 -0700
Message-ID: <99f8b7e372de14f3a046a2b47ff39a7615c78098.1592510545.git.mhelsley@vmware.com>
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

recordmcount iterates over the sections in the order they're
listed in the ELF file and checks whether the section name
indicates it's of interest. Objtool's elf code works differently
 -- it scans the elf file and builds up data structures
representing the headers, sections, etc. and then supplies
functions to search these structures. Both walk the elf file
in order, however objtool uses more memory to enable faster
searches it needs for other tools such as the reliable backtrace
support offered by the ORC unwinder.

Rather than walk the section table a second time in the recordmcount
code, we use objtool's elf code to search for the section
recordmcount is interested in. This also simplifies flow and means
we can easily check for already-processed object files before we
do any of the more complex things recordmcount does.

This also allows us to remove the already_has_rel_mcount string
pointer trick.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c |  4 ----
 tools/objtool/recordmcount.h | 17 +++--------------
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index b2c606eb269b..f585bf7f45f5 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -208,8 +208,6 @@ static void *mmap_file(char const *fname)
 	} else
 		mmap_failed = 0;
 out:
-	elf_close(lf);
-	lf = NULL;
 	fd_map = -1;
 
 	file_end = file_map + sb.st_size;
@@ -424,8 +422,6 @@ static int is_mcounted_section_name(char const *const txtname)
 		strcmp(".cpuidle.text", txtname) == 0;
 }
 
-static char const *already_has_rel_mcount = "success"; /* our work here is done! */
-
 /* 32 bit and 64 bit are very similar */
 #include "recordmcount.h"
 #define RECORD_MCOUNT_64
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index f9b19524da11..a96ffcef515a 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -554,11 +554,6 @@ static char const * __has_rel_mcount(Elf_Shdr const *const relhdr, /* reltype */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
-	if (strcmp("__mcount_loc", txtname) == 0) {
-		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
-			fname);
-		return already_has_rel_mcount;
-	}
 	if (w(txthdr->sh_type) != SHT_PROGBITS ||
 	    !(_w(txthdr->sh_flags) & SHF_EXECINSTR))
 		return NULL;
@@ -587,10 +582,6 @@ static unsigned tot_relsize(Elf_Shdr const *const shdr0,
 
 	for (; nhdr; --nhdr, ++shdrp) {
 		txtname = has_rel_mcount(shdrp, shdr0, shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			totrelsz = 0;
-			break;
-		}
 		if (txtname && is_mcounted_section_name(txtname))
 			totrelsz += _w(shdrp->sh_size);
 	}
@@ -628,6 +619,9 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 
 	int result = 0;
 
+	if (find_section_by_name(lf, "__mcount_loc") != NULL)
+		return 0;
+
 	totrelsz = tot_relsize(shdr0, nhdr, shstrtab, fname);
 	if (totrelsz == 0)
 		return 0;
@@ -649,11 +643,6 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 	for (relhdr = shdr0, k = nhdr; k; --k, ++relhdr) {
 		char const *const txtname = has_rel_mcount(relhdr, shdr0,
 			shstrtab, fname);
-		if (txtname == already_has_rel_mcount) {
-			result = 0;
-			file_updated = 0;
-			goto out; /* Nothing to be done; don't append! */
-		}
 		if (txtname && is_mcounted_section_name(txtname)) {
 			unsigned int recsym;
 			uint_t recval = 0;
-- 
2.20.1

