Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF49C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057B20801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgDJTlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:41:31 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36243 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:28 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:39:27 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 0C8B240BC0;
        Fri, 10 Apr 2020 12:39:32 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 34/36] objtool: mcount: Remove wrapper for ELF relocation type
Date:   Fri, 10 Apr 2020 12:35:57 -0700
Message-ID: <d3f91be1b3be23c1647750fa4bdb534192d4fbb9.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the last use of the Elf_Rela wrapper #defines by passing
the size of the relocations we're dealing with as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 4 ++--
 tools/objtool/recordmcount.h | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index a16611a352e5..e6aa1feb234d 100644
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
index 7db08ad9b4a7..d116032522e1 100644
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
@@ -70,7 +67,7 @@ static int do_func(unsigned const reltype)
 		return -1;
 	}
 
-	is_rela = (sizeof(Elf_Rela) == rel_entsize);
+	is_rela = (rela_size == rel_entsize);
 	mc_name = is_rela
 			? ".rela__mcount_loc"
 			:  ".rel__mcount_loc";
-- 
2.20.1

