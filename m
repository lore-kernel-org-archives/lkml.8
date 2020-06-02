Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B38B20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgFBTwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:52:33 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728322AbgFBTvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:00 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:50:55 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id E925E40BF1;
        Tue,  2 Jun 2020 12:50:55 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 12/32] objtool: mcount: Replace MIPS offset types
Date:   Tue, 2 Jun 2020 12:50:05 -0700
Message-ID: <0d0d88eefe95c90a4fa0bb08cccb15303d2a089d.1591125127.git.mhelsley@vmware.com>
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

Replace MIPS is_fake_mcount code using Elf_Addr with
unsigned long for the offsets. This is consistent with the way
that objtool more generally treats offsets and removes the
last use of the Elf_Addr wrapper.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index a3fb62e88450..1a39f7acac11 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -28,7 +28,6 @@
 #undef has_rel_mcount
 #undef tot_relsize
 #undef do_func
-#undef Elf_Addr
 #undef Elf_Ehdr
 #undef Elf_Shdr
 #undef Elf_Rel
@@ -53,7 +52,6 @@
 # define fn_is_fake_mcount	fn_is_fake_mcount64
 # define MIPS_is_fake_mcount	MIPS64_is_fake_mcount
 # define mcount_adjust		mcount_adjust_64
-# define Elf_Addr		Elf64_Addr
 # define Elf_Ehdr		Elf64_Ehdr
 # define Elf_Shdr		Elf64_Shdr
 # define Elf_Rel		Elf64_Rel
@@ -77,7 +75,6 @@
 # define fn_is_fake_mcount	fn_is_fake_mcount32
 # define MIPS_is_fake_mcount	MIPS32_is_fake_mcount
 # define mcount_adjust		mcount_adjust_32
-# define Elf_Addr		Elf32_Addr
 # define Elf_Ehdr		Elf32_Ehdr
 # define Elf_Shdr		Elf32_Shdr
 # define Elf_Rel		Elf32_Rel
@@ -129,11 +126,11 @@ static int mcount_adjust = 0;
 
 static int MIPS_is_fake_mcount(struct reloc const *reloc)
 {
-	static Elf_Addr old_r_offset = ~(Elf_Addr)0;
-	Elf_Addr current_r_offset = reloc->offset;
+	static unsigned long old_r_offset = ~0UL;
+	unsigned long current_r_offset = reloc->offset;
 	int is_fake;
 
-	is_fake = (old_r_offset != ~(Elf_Addr)0) &&
+	is_fake = (old_r_offset != ~0UL) &&
 		(current_r_offset - old_r_offset == MIPS_FAKEMCOUNT_OFFSET);
 	old_r_offset = current_r_offset;
 
-- 
2.20.1

