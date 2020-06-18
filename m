Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F247C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C41120890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgFRUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:20 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4380 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731332AbgFRUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:31 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:25 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id CCDE5B2656;
        Thu, 18 Jun 2020 16:39:28 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 37/51] objtool: mcount: Simplify mcount name matching
Date:   Thu, 18 Jun 2020 13:38:23 -0700
Message-ID: <1e3e896fe04c5b4db32152ea4b7966ac22745f9d.1592510545.git.mhelsley@vmware.com>
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

Setting altmcount only when processing ARM ELF files is
not necessary -- we can make the code easier to read
by always checking for the string.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index ff52697613b1..7e621769c488 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -44,7 +44,6 @@
 #define R_ARM_THM_CALL		10
 
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
-static const char *altmcount;	/* alternate mcount symbol name */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
 
 static struct elf *lf;
@@ -173,7 +172,7 @@ static struct symbol *get_mcount_sym(struct reloc *reloc)
 	if (symname[0] == '.')
 		++symname;  /* ppc64 hack */
 	if (strcmp(mcount, symname) == 0 ||
-	    (altmcount && strcmp(altmcount, symname) == 0) ||
+	    (strcmp("__gnu_mcount_nc", symname) == 0) ||
 	    (strcmp(fentry, symname) == 0))
 		return sym;
 	return NULL;
@@ -567,7 +566,6 @@ static int do_file(char const *const fname)
 		break;
 	case EM_ARM:
 		reltype = R_ARM_ABS32;
-		altmcount = "__gnu_mcount_nc";
 		make_nop = make_nop_arm;
 		rel_type_nop = R_ARM_NONE;
 		is_fake_mcount = arm_is_fake_mcount;
-- 
2.20.1

