Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8961C2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgFBTxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:53:23 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:29399 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728087AbgFBTxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:53:05 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:08 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 20C2C40BEC;
        Tue,  2 Jun 2020 12:51:09 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 29/32] objtool: mcount: Remove wrapper for ELF relocation type
Date:   Tue, 2 Jun 2020 12:50:22 -0700
Message-ID: <f5f77d19b84bc82237dbfdf07c89524353a8fd2c.1591125127.git.mhelsley@vmware.com>
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

Remove the last use of the Elf_Rela wrapper by passing the
size of the relocations we're dealing with as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 4 ++--
 tools/objtool/recordmcount.h | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 601be2504666..096507829b0c 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -574,7 +574,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 4;
-		rc = do32(reltype);
+		rc = do32(reltype, sizeof(Elf32_Rela));
 		break;
 	case ELFCLASS64: {
 		if (lf->ehdr.e_ehsize != sizeof(Elf64_Ehdr)
@@ -592,7 +592,7 @@ static int do_file(char const *const fname)
 			is_fake_mcount = MIPS_is_fake_mcount;
 		}
 		loc_size = 8;
-		rc = do64(reltype);
+		rc = do64(reltype, sizeof(Elf64_Rela));
 		break;
 	}
 	}  /* end switch */
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index f12189331e27..50104d52d9bf 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -18,19 +18,16 @@
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
@@ -71,7 +68,7 @@ static int do_func(unsigned const reltype)
 		return -1;
 	}
 
-	is_rela = (sizeof(Elf_Rela) == rel_entsize);
+	is_rela = (rela_size == rel_entsize);
 	mc_name = is_rela
 			? ".rela__mcount_loc"
 			:  ".rel__mcount_loc";
-- 
2.20.1

