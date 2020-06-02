Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E42C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7842072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgFBTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:23 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728395AbgFBTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:07 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:03 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id BE47C40BEB;
        Tue,  2 Jun 2020 12:51:03 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 22/32] objtool: mcount: Use ELF header from objtool
Date:   Tue, 2 Jun 2020 12:50:15 -0700
Message-ID: <b5c4c748f8d83f0a0406a4f53357bbe489d3eb13.1591125127.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1591125127.git.mhelsley@vmware.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF header is the very first structure in an ELF file.
Rather than cast it from the file mapping we use the ELF
header extracted via objtool's ELF code.

This is the last usage of the open-coded mapping of the ELF
file which we will remove in a later step.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 85e95e1ea6f6..bfed27f53f75 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -523,21 +523,19 @@ static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
 static int do_file(char const *const fname)
 {
 	unsigned int reltype = 0;
-	Elf32_Ehdr *ehdr;
 	int rc = -1;
 
-	ehdr = mmap_file(fname);
-	if (!ehdr)
+	if (!mmap_file(fname))
 		goto out;
 
 	w = w4nat;
 	w2 = w2nat;
 	w8 = w8nat;
-	switch (ehdr->e_ident[EI_DATA]) {
+	switch (lf->ehdr.e_ident[EI_DATA]) {
 		static unsigned int const endian = 1;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
-			ehdr->e_ident[EI_DATA], fname);
+			lf->ehdr.e_ident[EI_DATA], fname);
 		goto out;
 	case ELFDATA2LSB:
 		if (*(unsigned char const *)&endian != 1) {
@@ -566,18 +564,18 @@ static int do_file(char const *const fname)
 		push_bl_mcount_thumb = push_bl_mcount_thumb_be;
 		break;
 	}  /* end switch */
-	if (memcmp(ELFMAG, ehdr->e_ident, SELFMAG) != 0 ||
-	    w2(ehdr->e_type) != ET_REL ||
-	    ehdr->e_ident[EI_VERSION] != EV_CURRENT) {
+	if (memcmp(ELFMAG, lf->ehdr.e_ident, SELFMAG) != 0 ||
+	    lf->ehdr.e_type != ET_REL ||
+	    lf->ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
 		fprintf(stderr, "unrecognized ET_REL file %s\n", fname);
 		goto out;
 	}
 
 	gpfx = '_';
-	switch (w2(ehdr->e_machine)) {
+	switch (lf->ehdr.e_machine) {
 	default:
 		fprintf(stderr, "unrecognized e_machine %u %s\n",
-			w2(ehdr->e_machine), fname);
+			lf->ehdr.e_machine, fname);
 		goto out;
 	case EM_386:
 		reltype = R_386_32;
@@ -618,37 +616,36 @@ static int do_file(char const *const fname)
 		break;
 	}  /* end switch */
 
-	switch (ehdr->e_ident[EI_CLASS]) {
+	switch (lf->ehdr.e_ident[EI_CLASS]) {
 	default:
 		fprintf(stderr, "unrecognized ELF class %d %s\n",
-			ehdr->e_ident[EI_CLASS], fname);
+			lf->ehdr.e_ident[EI_CLASS], fname);
 		goto out;
 	case ELFCLASS32:
-		if (w2(ehdr->e_ehsize) != sizeof(Elf32_Ehdr)
-		||  w2(ehdr->e_shentsize) != sizeof(Elf32_Shdr)) {
+		if (lf->ehdr.e_ehsize != sizeof(Elf32_Ehdr)
+		||  lf->ehdr.e_shentsize != sizeof(Elf32_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
 			goto out;
 		}
-		if (w2(ehdr->e_machine) == EM_MIPS) {
+		if (lf->ehdr.e_machine == EM_MIPS) {
 			reltype = R_MIPS_32;
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		rc = do32(reltype);
 		break;
 	case ELFCLASS64: {
-		Elf64_Ehdr *const ghdr = (Elf64_Ehdr *)ehdr;
-		if (w2(ghdr->e_ehsize) != sizeof(Elf64_Ehdr)
-		||  w2(ghdr->e_shentsize) != sizeof(Elf64_Shdr)) {
+		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
+		||  lf->ehdr.e_shentsize != sizeof(Elf64_Shdr)) {
 			fprintf(stderr,
 				"unrecognized ET_REL file: %s\n", fname);
 			goto out;
 		}
-		if (w2(ghdr->e_machine) == EM_S390) {
+		if (lf->ehdr.e_machine == EM_S390) {
 			reltype = R_390_64;
 			mcount_adjust_64 = -14;
 		}
-		if (w2(ghdr->e_machine) == EM_MIPS) {
+		if (lf->ehdr.e_machine == EM_MIPS) {
 			reltype = R_MIPS_64;
 			Elf64_r_info = MIPS64_r_info;
 			is_fake_mcount = MIPS_is_fake_mcount;
-- 
2.20.1

