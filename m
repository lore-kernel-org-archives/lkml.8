Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84CFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C653D20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgFRUj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:39:58 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4267 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731222AbgFRUjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:17 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:13 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id D573BB2656;
        Thu, 18 Jun 2020 16:39:16 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 23/51] objtool: mcount: Move relocation entry size detection
Date:   Thu, 18 Jun 2020 13:38:09 -0700
Message-ID: <1ee0a207d05cd9f405ad5ee03f9982a7bf643a44.1592510545.git.mhelsley@vmware.com>
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

Move where we detect the size of relocation entries we wish to
use into the first loop over the sections. This will allow us
to allocate the mcount location and relocation sections before
the next loop that collects them.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 8 +++++---
 tools/objtool/recordmcount.h | 5 ++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 918e47217379..29f299e5bb52 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -458,7 +458,7 @@ static char const *has_rel_mcount(const struct section * const rels)
 	return txts->name;
 }
 
-static unsigned tot_relsize(void)
+static unsigned tot_relsize(unsigned int *rel_entsize)
 {
 	const struct section *sec;
 	unsigned totrelsz = 0;
@@ -466,8 +466,10 @@ static unsigned tot_relsize(void)
 
 	list_for_each_entry(sec, &lf->sections, list) {
 		txtname = has_rel_mcount(sec);
-		if (txtname && is_mcounted_section_name(txtname))
-			totrelsz += sec->sh.sh_size;
+		if (!(txtname && is_mcounted_section_name(txtname)))
+			continue;
+		totrelsz += sec->sh.sh_size;
+		*rel_entsize = sec->sh.sh_entsize;
 	}
 	return totrelsz;
 }
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 2733f7fde51d..5ca488f3471c 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -171,7 +171,7 @@ static int do_func(unsigned const reltype)
 	uint_t *      mloc0;
 	uint_t *      mlocp;
 
-	unsigned rel_entsize = 0;
+	unsigned int rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
 	struct section *sec;
@@ -181,7 +181,7 @@ static int do_func(unsigned const reltype)
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize();
+	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -211,7 +211,6 @@ static int do_func(unsigned const reltype)
 			if (result)
 				goto out;
 
-			rel_entsize = sec->sh.sh_entsize;
 			mlocp = sift_rel_mcount(mlocp,
 				(void *)mlocp - (void *)mloc0, &mrelp,
 				sec, recsym, (uint_t)recval, reltype);
-- 
2.20.1

