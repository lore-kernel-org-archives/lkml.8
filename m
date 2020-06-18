Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1947C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A162820890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgFRUla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:41:30 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:10322 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731501AbgFRUjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:43 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:39 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 66886B2656;
        Thu, 18 Jun 2020 16:39:42 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 51/51] objtool: mcount: Remove stale description
Date:   Thu, 18 Jun 2020 13:38:37 -0700
Message-ID: <acaf876d23dc8452d13cc395d5b869081ffecf52.1592510545.git.mhelsley@vmware.com>
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

The comments at the top no longer reflect how we process the ELF
contents. More helpful comments are inline with the code so we
don't need the top comments either.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index a74625aed09b..fa99bd2e9195 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -8,19 +8,6 @@
  *  Copyright 2010 Steven Rostedt <srostedt@redhat.com>, Red Hat Inc.
  */
 
-/*
- * Strategy: alter the .o file in-place.
- *
- * Append a new STRTAB that has the new section names, followed by a new array
- * ElfXX_Shdr[] that has the new section headers, followed by the section
- * contents for __mcount_loc and its relocations.  The old shstrtab strings,
- * and the old ElfXX_Shdr[] array, remain as "garbage" (commonly, a couple
- * kilobytes.)  Subsequent processing by /bin/ld (or the kernel module loader)
- * will ignore the garbage regions, because they are not designated by the
- * new .e_shoff nor the new ElfXX_Shdr[].  [In order to remove the garbage,
- * then use "ld -r" to create a new file that omits the garbage.]
- */
-
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
-- 
2.20.1

