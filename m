Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E697220890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgFRUmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:40 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731310AbgFRUjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:23 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:17 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id E560FB2656;
        Thu, 18 Jun 2020 16:39:19 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 27/51] objtool: mcount: Reduce usage of _size wrapper
Date:   Thu, 18 Jun 2020 13:38:13 -0700
Message-ID: <073c4598c55fa978faa116dd0a5d04b7694729bc.1592510545.git.mhelsley@vmware.com>
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

Use a new loc_size parameter to append_func() rather than
use the wrapper's _size macro directly.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index fcc4f1a74d60..a74a80b3356e 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -72,6 +72,7 @@ static int append_func(uint_t const *const mloc0,
 			uint_t const *const mlocp,
 			Elf_Rel const *const mrel0,
 			Elf_Rel const *const mrelp,
+			unsigned int const loc_size,
 			unsigned int const rel_entsize,
 			unsigned int const symsec_sh_link)
 {
@@ -84,14 +85,14 @@ static int append_func(uint_t const *const mloc0,
 	/* add section: __mcount_loc */
 	mcount_loc_sec = elf_create_section(lf,
 		mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"),
-		_size, mlocp - mloc0);
+		loc_size, mlocp - mloc0);
 	if (!mcount_loc_sec)
 		return -1;
 	// created mcount_loc_sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
 	mcount_loc_sec->sh.sh_link = 0;
 	mcount_loc_sec->sh.sh_info = 0;
-	mcount_loc_sec->sh.sh_addralign = _size;
-	// created mcount_loc_sec->sh.sh_entsize = _size;
+	mcount_loc_sec->sh.sh_addralign = loc_size;
+	// created mcount_loc_sec->sh.sh_entsize = loc_size;
 
 	// assert mcount_loc_sec->data->d_size == (void *)mlocp - (void *)mloc0
 	memcpy(mcount_loc_sec->data->d_buf, mloc0,
@@ -108,7 +109,7 @@ static int append_func(uint_t const *const mloc0,
 	reloc_sec->sh.sh_flags = 0; /* clear SHF_ALLOC */
 	reloc_sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
 	reloc_sec->sh.sh_info = mcount_loc_sec->idx;
-	reloc_sec->sh.sh_addralign = _size;
+	reloc_sec->sh.sh_addralign = loc_size;
 
 	// assert reloc_sec->data->d_size == (void *)mrelp - (void *)mrel0
 	memcpy(reloc_sec->data->d_buf, mrel0, reloc_sec->data->d_size);
@@ -227,7 +228,7 @@ static int do_func(unsigned const reltype)
 	}
 	if (!result && mloc0 != mlocp)
 		result = append_func(mloc0, mlocp, mrel0, mrelp,
-				     rel_entsize, symsec_sh_link);
+				     _size, rel_entsize, symsec_sh_link);
 out:
 	free(mrel0);
 	free(mloc0);
-- 
2.20.1

