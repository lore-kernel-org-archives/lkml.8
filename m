Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D72DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D4208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgFRUj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:27 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3944 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730866AbgFRUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:07 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:00 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id E5C91B2661;
        Thu, 18 Jun 2020 16:39:03 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 07/51] objtool: mcount: Move nhdr into find_symtab()
Date:   Thu, 18 Jun 2020 13:37:53 -0700
Message-ID: <7bf31e46fa228ea4d8e47f4767b2c6f2e4180942.1592510545.git.mhelsley@vmware.com>
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

Since it's no longer needed in the rest of do_func() we can move
it to where it's needed rather than pass it as a parameter.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index b46e855d32bf..4bd61c9d1fd5 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -229,9 +229,10 @@ static int get_shstrndx(Elf_Ehdr const *ehdr, Elf_Shdr const *shdr0)
 }
 
 static void find_symtab(Elf_Ehdr *const ehdr, Elf_Shdr const *shdr0,
-			unsigned const nhdr, Elf32_Word **symtab,
+			Elf32_Word **symtab,
 			Elf32_Word **symtab_shndx)
 {
+	unsigned const nhdr = get_shnum(ehdr, shdr0);
 	Elf_Shdr const *relhdr;
 	unsigned k;
 
@@ -593,7 +594,6 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 {
 	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff)
 		+ (void *)ehdr);
-	unsigned const nhdr = get_shnum(ehdr, shdr0);
 	Elf_Shdr *const shstr = &shdr0[get_shstrndx(ehdr, shdr0)];
 	char const *const shstrtab = (char const *)(_w(shstr->sh_offset)
 		+ (void *)ehdr);
@@ -638,7 +638,7 @@ static int do_func(Elf_Ehdr *const ehdr, char const *const fname,
 		return -1;
 	}
 
-	find_symtab(ehdr, shdr0, nhdr, &symtab, &symtab_shndx);
+	find_symtab(ehdr, shdr0, &symtab, &symtab_shndx);
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		char const *txtname;
-- 
2.20.1

