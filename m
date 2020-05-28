Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF304C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42572089D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgE1FlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:41:08 -0400
Received: from foss.arm.com ([217.140.110.172]:47330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbgE1FlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:41:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42FF930E;
        Wed, 27 May 2020 22:41:02 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.138.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5BF63F52E;
        Wed, 27 May 2020 22:40:59 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf jvmti: Remove redundant jitdump line table entries
Date:   Thu, 28 May 2020 13:40:49 +0800
Message-Id: <20200528054049.13662-1-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each PC/BCI pair in the JVMTI compiler inlining record table, the
jitdump plugin emits debug line table entries for every source line in
the method preceding that BCI. Instead only emit one source line per
PC/BCI pair. Reported by Ian Rogers. This reduces the .dump size for
SPECjbb from ~230MB to ~40MB.

Signed-off-by: Nick Gasson <nick.gasson@arm.com>
---
Changes in v2:
- Split the unrelated DWARF debug fix into a separate patch
- Added a comment about the use of c->methods

 tools/perf/jvmti/libjvmti.c | 78 ++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index c5d30834a64c..fcca275e5bf9 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -32,38 +32,41 @@ static void print_error(jvmtiEnv *jvmti, const char *msg, jvmtiError ret)
 
 #ifdef HAVE_JVMTI_CMLR
 static jvmtiError
-do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
-		    jvmti_line_info_t *tab, jint *nr)
+do_get_line_number(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
+		   jvmti_line_info_t *tab)
 {
-	jint i, lines = 0;
-	jint nr_lines = 0;
+	jint i, nr_lines = 0;
 	jvmtiLineNumberEntry *loc_tab = NULL;
 	jvmtiError ret;
+	jint src_line = -1;
 
 	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
 	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
 		/* No debug information for this method */
-		*nr = 0;
-		return JVMTI_ERROR_NONE;
+		return ret;
 	} else if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "GetLineNumberTable", ret);
 		return ret;
 	}
 
-	for (i = 0; i < nr_lines; i++) {
-		if (loc_tab[i].start_location < bci) {
-			tab[lines].pc = (unsigned long)pc;
-			tab[lines].line_number = loc_tab[i].line_number;
-			tab[lines].discrim = 0; /* not yet used */
-			tab[lines].methodID = m;
-			lines++;
-		} else {
-			break;
-		}
+	for (i = 0; i < nr_lines && loc_tab[i].start_location <= bci; i++) {
+		src_line = i;
+	}
+
+	if (src_line != -1) {
+		tab->pc = (unsigned long)pc;
+		tab->line_number = loc_tab[src_line].line_number;
+		tab->discrim = 0; /* not yet used */
+		tab->methodID = m;
+
+		ret = JVMTI_ERROR_NONE;
+	} else {
+		ret = JVMTI_ERROR_ABSENT_INFORMATION;
 	}
+
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)loc_tab);
-	*nr = lines;
-	return JVMTI_ERROR_NONE;
+
+	return ret;
 }
 
 static jvmtiError
@@ -71,9 +74,8 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 {
 	const jvmtiCompiledMethodLoadRecordHeader *hdr;
 	jvmtiCompiledMethodLoadInlineRecord *rec;
-	jvmtiLineNumberEntry *lne = NULL;
 	PCStackInfo *c;
-	jint nr, ret;
+	jint ret;
 	int nr_total = 0;
 	int i, lines_total = 0;
 
@@ -86,24 +88,7 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 	for (hdr = compile_info; hdr != NULL; hdr = hdr->next) {
 		if (hdr->kind == JVMTI_CMLR_INLINE_INFO) {
 			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
-			for (i = 0; i < rec->numpcs; i++) {
-				c = rec->pcinfo + i;
-				nr = 0;
-				/*
-				 * unfortunately, need a tab to get the number of lines!
-				 */
-				ret = (*jvmti)->GetLineNumberTable(jvmti, c->methods[0], &nr, &lne);
-				if (ret == JVMTI_ERROR_NONE) {
-					/* free what was allocated for nothing */
-					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
-					nr_total += (int)nr;
-				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION ||
-					   ret == JVMTI_ERROR_NATIVE_METHOD) {
-					/* No debug information for this method */
-				} else {
-					print_error(jvmti, "GetLineNumberTable", ret);
-				}
-			}
+			nr_total += rec->numpcs;
 		}
 	}
 
@@ -122,14 +107,17 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 			rec = (jvmtiCompiledMethodLoadInlineRecord *)hdr;
 			for (i = 0; i < rec->numpcs; i++) {
 				c = rec->pcinfo + i;
-				nr = 0;
-				ret = do_get_line_numbers(jvmti, c->pc,
-							  c->methods[0],
-							  c->bcis[0],
-							  *tab + lines_total,
-							  &nr);
+                                /*
+                                 * c->methods is the stack of inlined method calls
+                                 * at c->pc. [0] is the leaf method. Caller frames
+                                 * are ignored at the moment.
+                                 */
+				ret = do_get_line_number(jvmti, c->pc,
+							 c->methods[0],
+							 c->bcis[0],
+							 *tab + lines_total);
 				if (ret == JVMTI_ERROR_NONE)
-					lines_total += nr;
+					lines_total++;
 			}
 		}
 	}
-- 
2.26.2

