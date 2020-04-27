Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C279C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14AE7206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD0GQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:16:20 -0400
Received: from foss.arm.com ([217.140.110.172]:56996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0GQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:16:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9061131B;
        Sun, 26 Apr 2020 23:16:17 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.139.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8F03F73D;
        Sun, 26 Apr 2020 23:16:14 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] perf jvmti: Do not report error when missing debug information
Date:   Mon, 27 Apr 2020 14:15:15 +0800
Message-Id: <20200427061520.24905-3-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427061520.24905-1-nick.gasson@arm.com>
References: <20200427061520.24905-1-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the Java sources are compiled with -g:none to disable debug
information the perf JVMTI plugin reports a lot of errors like:

  java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
  java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
  java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
  java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
  java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION

Instead if GetLineNumberTable returns JVMTI_ERROR_ABSENT_INFORMATION
simply skip emitting line number information for that method. Unlike the
previous patch these errors don't affect the jitdump generation, they
just generate a lot of noise.

Similarly for native methods which also don't have line tables.

Signed-off-by: Nick Gasson <nick.gasson@arm.com>
---
 tools/perf/jvmti/libjvmti.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index 50ef524b5cd4..a9a056d68416 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -41,7 +41,11 @@ do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
 	jvmtiError ret;
 
 	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
-	if (ret != JVMTI_ERROR_NONE) {
+	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
+		/* No debug information for this method */
+		*nr = 0;
+		return JVMTI_ERROR_NONE;
+	} else if (ret != JVMTI_ERROR_NONE) {
 		print_error(jvmti, "GetLineNumberTable", ret);
 		return ret;
 	}
@@ -93,6 +97,9 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
 					/* free what was allocated for nothing */
 					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
 					nr_total += (int)nr;
+				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
+					   || ret == JVMTI_ERROR_NATIVE_METHOD) {
+					/* No debug information for this method */
 				} else {
 					print_error(jvmti, "GetLineNumberTable", ret);
 				}
@@ -262,7 +269,9 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 	if (has_line_numbers && map && map_length) {
 		ret = get_line_numbers(jvmti, compile_info, &line_tab, &nr_lines);
 		if (ret != JVMTI_ERROR_NONE) {
-			warnx("jvmti: cannot get line table for method");
+			if (ret != JVMTI_ERROR_NOT_FOUND) {
+				warnx("jvmti: cannot get line table for method");
+			}
 			nr_lines = 0;
 		} else if (nr_lines > 0) {
 			line_file_names = malloc(sizeof(char*) * nr_lines);
-- 
2.26.1

