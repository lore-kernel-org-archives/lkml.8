Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5902072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgFBTvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:51:23 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36862 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728305AbgFBTvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:51:05 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 2 Jun 2020 12:51:01 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.200.192.49])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 2AE0340BEE;
        Tue,  2 Jun 2020 12:51:02 -0700 (PDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v4 20/32] objtool: mcount: Move relocation entry size detection
Date:   Tue, 2 Jun 2020 12:50:13 -0700
Message-ID: <09f1cee98423ea4be0e5c3a0a03e0be8f0e970df.1591125127.git.mhelsley@vmware.com>
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
index 248e49033538..6feb4e6b4113 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -457,7 +457,7 @@ static char const *has_rel_mcount(const struct section * const rels)
 	return txts->name;
 }
 
-static unsigned tot_relsize(void)
+static unsigned tot_relsize(unsigned int *rel_entsize)
 {
 	const struct section *sec;
 	unsigned totrelsz = 0;
@@ -465,8 +465,10 @@ static unsigned tot_relsize(void)
 
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
index f8d3e81c0129..352d2042be35 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -175,7 +175,7 @@ static int do_func(unsigned const reltype)
 	uint_t *      mloc0;
 	uint_t *      mlocp;
 
-	unsigned rel_entsize = 0;
+	unsigned int rel_entsize = 0;
 	unsigned symsec_sh_link = 0;
 
 	struct section *sec;
@@ -185,7 +185,7 @@ static int do_func(unsigned const reltype)
 	if (find_section_by_name(lf, "__mcount_loc") != NULL)
 		return 0;
 
-	totrelsz = tot_relsize();
+	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
 	mrel0 = umalloc(totrelsz);
@@ -215,7 +215,6 @@ static int do_func(unsigned const reltype)
 			if (result)
 				goto out;
 
-			rel_entsize = sec->sh.sh_entsize;
 			mlocp = sift_rel_mcount(mlocp,
 				(void *)mlocp - (void *)mloc0, &mrelp,
 				sec, recsym, (uint_t)recval, reltype);
-- 
2.20.1

