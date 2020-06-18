Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7434C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C7220890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgFRUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:14 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48844 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731337AbgFRUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:31 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:22 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 4CFFBB265A;
        Thu, 18 Jun 2020 16:39:25 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 33/51] objtool: mcount: Remove wrapper for ELF relocation type
Date:   Thu, 18 Jun 2020 13:38:19 -0700
Message-ID: <2dc80025d1c8c251f65c18c29393ea70d2e344d9.1592510545.git.mhelsley@vmware.com>
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

Remove the last uses of the Elf_Rela wrapper by passing the
size of the relocations we're dealing with as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 4 ++--
 tools/objtool/recordmcount.h | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index b9f15fc1f40e..6db035252b6c 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -575,7 +575,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 4;
-		rc = do32(reltype);
+		rc = do32(reltype, sizeof(Elf32_Rela));
 		break;
 	case ELFCLASS64: {
 		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
@@ -593,7 +593,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 8;
-		rc = do64(reltype);
+		rc = do64(reltype, sizeof(Elf64_Rela));
 		break;
 	}
 	}  /* end switch */
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 2dd303d51b78..07fc93917736 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -18,18 +18,15 @@
  * Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
 #undef do_func
-#undef Elf_Rela
 
 #ifdef RECORD_MCOUNT_64
 # define do_func		do64
-# define Elf_Rela		Elf64_Rela
 #else
 # define do_func		do32
-# define Elf_Rela		Elf32_Rela
 #endif
 
 /* Overall supervision for Elf32 ET_REL file. */
-static int do_func(unsigned const reltype)
+static int do_func(unsigned const reltype, size_t rela_size)
 {
 	/* Upper bound on space: assume all relevant relocs are for mcount. */
 	unsigned       totrelsz;
@@ -68,7 +65,7 @@ static int do_func(unsigned const reltype)
 		return -1;
 	}
 
-	is_rela = (sizeof(Elf_Rela) == rel_entsize);
+	is_rela = (rela_size == rel_entsize);
 
 	/* add section: __mcount_loc */
 	mlocs = elf_create_section(lf, mc_name, sizeof(*mloc0), 0);
-- 
2.20.1

