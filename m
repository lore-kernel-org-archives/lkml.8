Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03BD20890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgFRUmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:42:04 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36734 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730903AbgFRUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:39:35 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 18 Jun 2020 13:39:24 -0700
Received: from sc9-mailhost2.vmware.com (unknown [10.129.221.29])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 33D4DB265B;
        Thu, 18 Jun 2020 16:39:27 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH v5 35/51] objtool: mcount: Remove endian wrappers
Date:   Thu, 18 Jun 2020 13:38:21 -0700
Message-ID: <72408e62826ff1ef26568104cd63dd1851a96dd4.1592510545.git.mhelsley@vmware.com>
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

Now that they're no longer used we can remove these endian
wrappers.

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 63 ------------------------------------
 1 file changed, 63 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 7f4d18e83e24..ff52697613b1 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -149,53 +149,6 @@ static int make_nop_arm64(struct section *txts, size_t const offset)
 	return 0;
 }
 
-/* w8rev, w8nat, ...: Handle endianness. */
-
-static uint64_t w8rev(uint64_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (7 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (6 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (5 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (4 * 8))
-	       | ((0xff & (x >> (4 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (5 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (6 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (7 * 8))) << (0 * 8));
-}
-
-static uint32_t w4rev(uint32_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (3 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (2 * 8))
-	       | ((0xff & (x >> (2 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (3 * 8))) << (0 * 8));
-}
-
-static uint32_t w2rev(uint16_t const x)
-{
-	return   ((0xff & (x >> (0 * 8))) << (1 * 8))
-	       | ((0xff & (x >> (1 * 8))) << (0 * 8));
-}
-
-static uint64_t w8nat(uint64_t const x)
-{
-	return x;
-}
-
-static uint32_t w4nat(uint32_t const x)
-{
-	return x;
-}
-
-static uint32_t w2nat(uint16_t const x)
-{
-	return x;
-}
-
-static uint64_t (*w8)(uint64_t);
-static uint32_t (*w)(uint32_t);
-static uint32_t (*w2)(uint16_t);
-
 /* Names of the sections that could contain calls to mcount. */
 static int is_mcounted_section_name(char const *const txtname)
 {
@@ -571,22 +524,12 @@ static int do_file(char const *const fname)
 		goto out;
 	}
 
-	w = w4nat;
-	w2 = w2nat;
-	w8 = w8nat;
 	switch (lf->ehdr.e_ident[EI_DATA]) {
-		static unsigned int const endian = 1;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			lf->ehdr.e_ident[EI_DATA], fname);
 		goto out;
 	case ELFDATA2LSB:
-		if (*(unsigned char const *)&endian != 1) {
-			/* objtool is big endian, file.o is little endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
 		ideal_nop4_arm = ideal_nop4_arm_le;
 		bl_mcount_arm = bl_mcount_arm_le;
 		push_arm = push_arm_le;
@@ -594,12 +537,6 @@ static int do_file(char const *const fname)
 		push_bl_mcount_thumb = push_bl_mcount_thumb_le;
 		break;
 	case ELFDATA2MSB:
-		if (*(unsigned char const *)&endian != 0) {
-			/*  objtool is little endian, file.o is big endian. */
-			w = w4rev;
-			w2 = w2rev;
-			w8 = w8rev;
-		}
 		ideal_nop4_arm = ideal_nop4_arm_be;
 		bl_mcount_arm = bl_mcount_arm_be;
 		push_arm = push_arm_be;
-- 
2.20.1

