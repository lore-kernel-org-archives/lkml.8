Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1F8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F1B20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFBTvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:24 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728404AbgFBTvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:07 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:04 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 5154140BED;
        Tue,  2 Jun 2020 12:51:05 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 24/32] objtool: mcount: Reduce usage of _size wrapper
Date:   Tue, 2 Jun 2020 12:50:17 -0700
Message-ID: <a420cea8b31cb3e9a611f251090da64799bb0360.1591125127.git.mhelsley@vmware.com>
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

Use a new loc_size parameter to append_func() rather than
use the wrapper's _size macro directly.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index e1be7243742b..e2de71f99566 100644
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
@@ -83,14 +84,14 @@ static int append_func(uint_t const *const mloc0,
 	unsigned const old_shnum = lf->ehdr.e_shnum;
 
 	/* add section: __mcount_loc */
-	sec = elf_create_section(lf, mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"), _size, mlocp - mloc0);
+	sec = elf_create_section(lf, mc_name + (sizeof(Elf_Rela) == rel_entsize) + strlen(".rel"), loc_size, mlocp - mloc0);
 	if (!sec)
 		return -1;
 
 	// created sec->sh.sh_size = (void *)mlocp - (void *)mloc0;
 	sec->sh.sh_link = 0;/* TODO objtool uses this? */
 	sec->sh.sh_info = 0;/* TODO objtool uses this? */
-	sec->sh.sh_addralign = _size;
+	sec->sh.sh_addralign = loc_size;
 	// created sec->sh.sh_entsize = _size;
 
 	// assert sec->data->d_size == (void *)mlocp - (void *)mloc0
@@ -109,7 +110,7 @@ static int append_func(uint_t const *const mloc0,
 	sec->sh.sh_flags = 0;
 	sec->sh.sh_link = find_section_by_name(lf, ".symtab")->idx;
 	sec->sh.sh_info = old_shnum;
-	sec->sh.sh_addralign = _size;
+	sec->sh.sh_addralign = loc_size;
 
 	// assert sec->data->d_size == (void *)mrelp - (void *)mrel0
 	memcpy(sec->data->d_buf, mrel0, sec->data->d_size);
@@ -231,7 +232,7 @@ static int do_func(unsigned const reltype)
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

