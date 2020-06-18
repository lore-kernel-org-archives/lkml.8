Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C4720732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732148AbgFRUkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:39 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731423AbgFRUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:39 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:31 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 3BCA8B265D;
        Thu, 18 Jun 2020 16:39:34 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 41/51] objtool: mcount: Convert nop writes to elf_write_insn()
Date:   Thu, 18 Jun 2020 13:38:27 -0700
Message-ID: <b5ee19c9cadd4e786cf64dea893b47b181d80089.1592510545.git.mhelsley@vmware.com>
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

objtool's elf_write_insn() does extra checking when writing to
an instruction so use that rather than a plain memcpy().

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 629eb7222ef3..029e6e72c972 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -66,9 +66,7 @@ static int make_nop_x86(struct section *txts, size_t const offset)
 	if (memcmp(op, ip_relative_call_x86, 5) != 0)
 		return -1;
 
-	/* convert to nop */
-	memcpy(op, ideal_nop, 5);
-	return 0;
+	return elf_write_insn(lf, txts, offset, 5, ideal_nop);
 }
 
 static const char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
@@ -117,7 +115,8 @@ static int make_nop_arm(struct section *txts, size_t const offset)
 
 	/* Convert to nop */
 	do {
-		memcpy(map + off, ideal_nop, nop_size);
+		if (elf_write_insn(lf, txts, off, nop_size, ideal_nop))
+			return -1;
 		off += nop_size;
 	} while (--cnt > 0);
 
@@ -136,8 +135,7 @@ static int make_nop_arm64(struct section *txts, size_t const offset)
 		return -1;
 
 	/* Convert to nop */
-	memcpy(map + offset, ideal_nop, 4);
-	return 0;
+	return elf_write_insn(lf, txts, offset, 4, ideal_nop);
 }
 
 /* Names of the sections that could contain calls to mcount. */
-- 
2.20.1

