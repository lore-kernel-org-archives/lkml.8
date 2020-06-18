Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9F720890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgFRUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:38 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731400AbgFRUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:37 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:28 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A249CB265A;
        Thu, 18 Jun 2020 16:39:30 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 39/51] objtool: mcount: Verify x86 instruction with memcmp()
Date:   Thu, 18 Jun 2020 13:38:25 -0700
Message-ID: <1a5496d5031c7d4ff50b61a34973a8c975fb4972.1592510545.git.mhelsley@vmware.com>
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

Instead of hard-coding what amounts to a memcmp() use memcmp to
determine if the instruction we wish to replace matches what we
expect. This makes the x86 code more like that of, for instance,
ARM.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 4d6596a031bf..5c59df0df97b 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -47,9 +47,10 @@ extern int warn_on_notrace_sect; /* warn when section has mcount not being recor
 
 static struct elf *lf;
 
-static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
-static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
-static unsigned char *ideal_nop;
+static const unsigned char ip_relative_call_x86[5] = { 0xe8, 0x00, 0x00, 0x00, 0x00 };
+static const unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static const unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
+static const unsigned char *ideal_nop;
 
 static char rel_type_nop;
 
@@ -57,20 +58,12 @@ static int (*make_nop)(struct section *, size_t const offset);
 
 static int make_nop_x86(struct section *txts, size_t const offset)
 {
-	uint32_t *ptr;
-	unsigned char *op;
-	void *map = txts->data->d_buf;
+	unsigned char *op = txts->data->d_buf + offset - 1;
 
 	if (offset < 1)
 		return -1;
 
-	/* Confirm we have 0xe8 0x0 0x0 0x0 0x0 */
-	ptr = map + offset;
-	if (*ptr != 0)
-		return -1;
-
-	op = map + offset - 1;
-	if (*op != 0xe8)
+	if (memcmp(op, ip_relative_call_x86, 5) != 0)
 		return -1;
 
 	/* convert to nop */
-- 
2.20.1

