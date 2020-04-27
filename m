Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A79BC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59665206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD0GQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:56982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgD0GQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:16:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52C331B;
        Sun, 26 Apr 2020 23:16:10 -0700 (PDT)
Received: from nicgas01-03-arm-vm.shanghai.arm.com (nicgas01-03-arm-vm.shanghai.arm.com [10.169.139.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35E833F73D;
        Sun, 26 Apr 2020 23:16:08 -0700 (PDT)
From:   Nick Gasson <nick.gasson@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Nick Gasson <nick.gasson@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf jvmti: Fix jitdump for methods without debug info
Date:   Mon, 27 Apr 2020 14:15:14 +0800
Message-Id: <20200427061520.24905-2-nick.gasson@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200427061520.24905-1-nick.gasson@arm.com>
References: <20200427061520.24905-1-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a Java class is compiled with -g:none to omit debug information, the
JVMTI plugin won't write jitdump entries for any method in this class
and prints a lot of errors like:

    java: GetSourceFileName failed with JVMTI_ERROR_ABSENT_INFORMATION

The call to GetSourceFileName is used to derive the file name `fn`, but
this value is not actually used since commit ca58d7e64bdf ("perf jvmti:
Generate correct debug information for inlined code") which moved the
file name lookup into fill_source_filenames(). So the call to
GetSourceFileName and related code can be safely removed.

Signed-off-by: Nick Gasson <nick.gasson@arm.com>
---
 tools/perf/jvmti/libjvmti.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index c441a34cb1c0..50ef524b5cd4 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -246,8 +246,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 	char *class_sign = NULL;
 	char *func_name = NULL;
 	char *func_sign = NULL;
-	char *file_name = NULL;
-	char fn[PATH_MAX];
 	uint64_t addr = (uint64_t)(uintptr_t)code_addr;
 	jvmtiError ret;
 	int nr_lines = 0; /* in line_tab[] */
@@ -282,12 +280,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 		}
 	}
 
-	ret = (*jvmti)->GetSourceFileName(jvmti, decl_class, &file_name);
-	if (ret != JVMTI_ERROR_NONE) {
-		print_error(jvmti, "GetSourceFileName", ret);
-		goto error;
-	}
-
 	ret = (*jvmti)->GetClassSignature(jvmti, decl_class,
 					  &class_sign, NULL);
 	if (ret != JVMTI_ERROR_NONE) {
@@ -302,8 +294,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 		goto error;
 	}
 
-	copy_class_filename(class_sign, file_name, fn, PATH_MAX);
-
 	/*
 	 * write source line info record if we have it
 	 */
@@ -323,7 +313,6 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)func_name);
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)func_sign);
 	(*jvmti)->Deallocate(jvmti, (unsigned char *)class_sign);
-	(*jvmti)->Deallocate(jvmti, (unsigned char *)file_name);
 	free(line_tab);
 	while (line_file_names && (nr_lines > 0)) {
 	    if (line_file_names[nr_lines - 1]) {
-- 
2.26.1

