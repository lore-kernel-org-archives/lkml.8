Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD521C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02A020732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgFRUk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:26 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728225AbgFRUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:30 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:20 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 93D2AB2656;
        Thu, 18 Jun 2020 16:39:23 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 31/51] objtool: mcount: Use objtool relocation section
Date:   Thu, 18 Jun 2020 13:38:17 -0700
Message-ID: <19fca156c1171bb723ea98f911b4f0e38ec4d8f0.1592510545.git.mhelsley@vmware.com>
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

Now that we add an initially-empty relocation section and share
the libelf data buffer from the beginning, we can safely use
objtools elf_create_reloc_section() function to simplify the
code further -- use the anticipated base section name, avoid
the need to set sh_info, etc. The only remaining difference
between this and the old recordmcount code is we didn't set
SHF_INFO_LINK so we clear the sh_flags as before.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 1d11dfc40d09..fc6346a7eaf5 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -92,7 +92,7 @@ static int do_func(unsigned const reltype)
 	GElf_Sxword r_offset = 0;
 
 	struct section *sec, *mlocs, *mrels;
-	const char *mc_name;
+	const char * const mc_name =  "__mcount_loc";
 
 	unsigned int rel_entsize = 0;
 	int result = -1;
@@ -119,12 +119,9 @@ static int do_func(unsigned const reltype)
 	}
 
 	is_rela = (sizeof(Elf_Rela) == rel_entsize);
-	mc_name = is_rela
-			? ".rela__mcount_loc"
-			:  ".rel__mcount_loc";
 
 	/* add section: __mcount_loc */
-	mlocs = elf_create_section(lf, mc_name + (is_rela ? 1 : 0) + strlen(".rel"), sizeof(*mloc0), 0);
+	mlocs = elf_create_section(lf, mc_name, sizeof(*mloc0), 0);
 	if (!mlocs)
 		goto out;
 	mlocs->sh.sh_link = 0;
@@ -134,17 +131,12 @@ static int do_func(unsigned const reltype)
 	mlocs->data->d_type = ELF_T_ADDR; /* elf_xlatetof() conversion */
 
 	/* add section .rel[a]__mcount_loc */
-	mrels = elf_create_section(lf, mc_name, rel_entsize, 0);
+	mrels = elf_create_reloc_section(lf, mlocs,
+					 is_rela ? SHT_RELA : SHT_REL);
 	if (!mrels)
 		goto out;
-	/* Like elf_create_rela_section() without the name bits */
-	mrels->sh.sh_type = is_rela ? SHT_RELA : SHT_REL;
-	mrels->sh.sh_flags = 0; /* clear SHF_ALLOC */
-	mrels->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
-	mrels->sh.sh_info = mlocs->idx;
-	mrels->sh.sh_addralign = 8;
+	mrels->sh.sh_flags = 0; /* clear SHF_INFO_LINK */
 	mrels->data->d_buf = mrel0;
-	mrels->data->d_type = is_rela ? ELF_T_RELA : ELF_T_REL; /* elf_xlatetof() conversion */
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
-- 
2.20.1

