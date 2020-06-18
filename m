Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C677620732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgFRUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:28 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:4380 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731323AbgFRUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:30 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:24 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 1322BB2656;
        Thu, 18 Jun 2020 16:39:28 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 36/51] objtool: mcount: Rename to mcount.c
Date:   Thu, 18 Jun 2020 13:38:22 -0700
Message-ID: <964892df89b56a11266ca2d9b41efceb5e09ca97.1592510545.git.mhelsley@vmware.com>
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

Now that we've converted recordmcount to a subcommand of objtool
rename the .c file in order to follow the convention of the other
objtool subcmds.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/Build                        | 2 +-
 tools/objtool/{recordmcount.c => mcount.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/objtool/{recordmcount.c => mcount.c} (100%)

diff --git a/tools/objtool/Build b/tools/objtool/Build
index f4f0515d4f91..7815a094c991 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,7 +7,7 @@ objtool-$(SUBCMD_CHECK) += special.o
 objtool-$(SUBCMD_ORC) += check.o
 objtool-$(SUBCMD_ORC) += orc_gen.o
 objtool-$(SUBCMD_ORC) += orc_dump.o
-objtool-$(SUBCMD_MCOUNT) += recordmcount.o
+objtool-$(SUBCMD_MCOUNT) += mcount.o
 
 objtool-y += builtin-check.o
 objtool-y += builtin-orc.o
diff --git a/tools/objtool/recordmcount.c b/tools/objtool/mcount.c
similarity index 100%
rename from tools/objtool/recordmcount.c
rename to tools/objtool/mcount.c
-- 
2.20.1

