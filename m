Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3ED20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbgFRUko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:40:44 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731419AbgFRUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:38 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:30 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 22B7DB265A;
        Thu, 18 Jun 2020 16:39:32 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 40/51] objtool: mcount: const-ify ARM instruction patterns
Date:   Thu, 18 Jun 2020 13:38:26 -0700
Message-ID: <97ecc9cc1a72e638ce9f370102777944a07a1037.1592510545.git.mhelsley@vmware.com>
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

Let the compiler know we won't be modifying the instruction
patterns we use to determine how to turn ARM instruction(s)
into nops, and the nop instruction(s) we'll put in their
place.

Also, while we're at it, convert to unsigned char because the
next patch will need that as well.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/mcount.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/mcount.c b/tools/objtool/mcount.c
index 5c59df0df97b..629eb7222ef3 100644
--- a/tools/objtool/mcount.c
+++ b/tools/objtool/mcount.c
@@ -47,10 +47,10 @@ extern int warn_on_notrace_sect; /* warn when section has mcount not being recor
 
 static struct elf *lf;
 
-static const unsigned char ip_relative_call_x86[5] = { 0xe8, 0x00, 0x00, 0x00, 0x00 };
-static const unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
-static const unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
-static const unsigned char *ideal_nop;
+static const char ip_relative_call_x86[5] = { 0xe8, 0x00, 0x00, 0x00, 0x00 };
+static const char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
+static const char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
+static const char *ideal_nop;
 
 static char rel_type_nop;
 
@@ -58,7 +58,7 @@ static int (*make_nop)(struct section *, size_t const offset);
 
 static int make_nop_x86(struct section *txts, size_t const offset)
 {
-	unsigned char *op = txts->data->d_buf + offset - 1;
+	char *op = txts->data->d_buf + offset - 1;
 
 	if (offset < 1)
 		return -1;
@@ -71,25 +71,25 @@ static int make_nop_x86(struct section *txts, size_t const offset)
 	return 0;
 }
 
-static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
-static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
-static unsigned char *ideal_nop4_arm;
+static const char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
+static const char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */
+static const char *ideal_nop4_arm;
 
-static unsigned char bl_mcount_arm_le[4] = { 0xfe, 0xff, 0xff, 0xeb }; /* bl */
-static unsigned char bl_mcount_arm_be[4] = { 0xeb, 0xff, 0xff, 0xfe }; /* bl */
-static unsigned char *bl_mcount_arm;
+static const char bl_mcount_arm_le[4] = { 0xfe, 0xff, 0xff, 0xeb }; /* bl */
+static const char bl_mcount_arm_be[4] = { 0xeb, 0xff, 0xff, 0xfe }; /* bl */
+static const char *bl_mcount_arm;
 
-static unsigned char push_arm_le[4] = { 0x04, 0xe0, 0x2d, 0xe5 }; /* push {lr} */
-static unsigned char push_arm_be[4] = { 0xe5, 0x2d, 0xe0, 0x04 }; /* push {lr} */
-static unsigned char *push_arm;
+static const char push_arm_le[4] = { 0x04, 0xe0, 0x2d, 0xe5 }; /* push {lr} */
+static const char push_arm_be[4] = { 0xe5, 0x2d, 0xe0, 0x04 }; /* push {lr} */
+static const char *push_arm;
 
-static unsigned char ideal_nop2_thumb_le[2] = { 0x00, 0xbf }; /* nop */
-static unsigned char ideal_nop2_thumb_be[2] = { 0xbf, 0x00 }; /* nop */
-static unsigned char *ideal_nop2_thumb;
+static const char ideal_nop2_thumb_le[2] = { 0x00, 0xbf }; /* nop */
+static const char ideal_nop2_thumb_be[2] = { 0xbf, 0x00 }; /* nop */
+static const char *ideal_nop2_thumb;
 
-static unsigned char push_bl_mcount_thumb_le[6] = { 0x00, 0xb5, 0xff, 0xf7, 0xfe, 0xff }; /* push {lr}, bl */
-static unsigned char push_bl_mcount_thumb_be[6] = { 0xb5, 0x00, 0xf7, 0xff, 0xff, 0xfe }; /* push {lr}, bl */
-static unsigned char *push_bl_mcount_thumb;
+static const char push_bl_mcount_thumb_le[6] = { 0x00, 0xb5, 0xff, 0xf7, 0xfe, 0xff }; /* push {lr}, bl */
+static const char push_bl_mcount_thumb_be[6] = { 0xb5, 0x00, 0xf7, 0xff, 0xff, 0xfe }; /* push {lr}, bl */
+static const char *push_bl_mcount_thumb;
 
 static int make_nop_arm(struct section *txts, size_t const offset)
 {
@@ -124,7 +124,7 @@ static int make_nop_arm(struct section *txts, size_t const offset)
 	return 0;
 }
 
-static unsigned char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
+static const char ideal_nop4_arm64[4] = {0x1f, 0x20, 0x03, 0xd5};
 static int make_nop_arm64(struct section *txts, size_t const offset)
 {
 	uint32_t *ptr;
-- 
2.20.1

