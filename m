Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7247C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9289620656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izQVltS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD3TgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgD3TgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:36:05 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7EC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:05 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id f56so8296744qte.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VxBsN/GRbDtVHcw/pvZPECyHS8yJyf/4bbXn0GoLXoA=;
        b=izQVltS7GbFcf63fhnQqQG9kfcFsZEdEnuW2iJMm/aDuBz0fY612h7n/Jb4CGWjLtz
         OvAsA8ZsyxJKPFCkPcIIqwRIE5Ag5HZ1rmRI1lbkiPWM8QmNN8AIbDMIPFM+EHqV2REq
         CMEyvuWfVxnHC+cXuTGq+ltE1ldKAaiadZsdgAr8uc+7JMqiA1t/MoMETzeEMe6v/43Q
         V0LN6/IrD8Bx3cpXAQ3UumzO4iYWRxEAbQ8vQ/ZBJ08zddE5rPQQd/nydFCqMVipEx4N
         LSyH6O7/2Zd94dLuLkZNb//JtKEUtUfE2M08objmJ+SKJcPNuWX8yNnpNh4CbxSIvaHU
         VDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VxBsN/GRbDtVHcw/pvZPECyHS8yJyf/4bbXn0GoLXoA=;
        b=iaisW4n+SGh5vbN9KFAjsslOynTEsvJIocd6FqWt2KCmq3oamB/i6kGuUFP1LsW6RA
         X6dAEM1q8Y/M6vdgQ44oolqapUfvnePK7KnDa1YxMgoCRggFVJ2089Y08xOYU/2x18My
         8eZbAxkKcg7+l1VUNmqmPOhvo00v6lDa0mjoGRooqth+I4o+d66f0SJkwZjgjQKdq0gT
         sCyb9ndUiFI0isafd28l5u0xQ7rXAk+/hDWe76Gt3J1sDFmOwE34zm9d4Hv53ejFGBvb
         luwpGq3nU6UMXIVNeo7SShDeDDWOxEkyvAQrg7JDwyMhXX2yBOhPeXeVkhLjqlMgK2bS
         8s/Q==
X-Gm-Message-State: AGi0PuYyIWMDI5DVZs6IE3H37F/9ER88GScy5RlKPoCWvk9hYDtaBs1Y
        V/X9uk7GDU4Vm4NDbAVKbxGNLrSiLj6a
X-Google-Smtp-Source: APiQypIFhMiMOeBk1nl+d+sNCxmgH2jn+7la/kygx7M3joPdZ2GMo2Jd7SgsU0BqSejv54JP6HvsjYvoG9/H
X-Received: by 2002:a0c:9e6d:: with SMTP id z45mr527231qve.206.1588275364722;
 Thu, 30 Apr 2020 12:36:04 -0700 (PDT)
Date:   Thu, 30 Apr 2020 12:35:57 -0700
In-Reply-To: <20200430193557.101831-1-irogers@google.com>
Message-Id: <20200430193557.101831-3-irogers@google.com>
Mime-Version: 1.0
References: <20200430193557.101831-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 2/2] lib kallsyms: parse using io api
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf record will call kallsyms__parse 4 times during startup and process
megabytes of data. This changes kallsyms__parse to use the io library
rather than fgets to improve performance of the user code by over 8%.

Before:
  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 103.988 ms (+- 0.203 ms)
After:
  Running 'internals/kallsyms-parse' benchmark:
  Average kallsyms__parse took: 95.571 ms (+- 0.006 ms)

For a workload like:
$ perf record /bin/true
Run under 'perf record -e cycles:u -g' the time goes from:
Before
30.10%     1.67%  perf     perf                [.] kallsyms__parse
After
25.55%    20.04%  perf     perf                [.] kallsyms__parse
So a little under 5% of the start-up time is removed. A lot of what
remains is on the kernel side, but caching kallsyms within perf would
at least impact memory footprint.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h          |  3 ++
 tools/lib/symbol/kallsyms.c | 81 +++++++++++++++++++------------------
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
index b7e55b5f8a4a..777c20f6b604 100644
--- a/tools/lib/api/io.h
+++ b/tools/lib/api/io.h
@@ -7,6 +7,9 @@
 #ifndef __API_IO__
 #define __API_IO__
 
+#include <stdlib.h>
+#include <unistd.h>
+
 struct io {
 	/* File descriptor being read/ */
 	int fd;
diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 1a7a9f877095..1ef61b68332a 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "symbol/kallsyms.h"
+#include "api/io.h"
 #include <stdio.h>
-#include <stdlib.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 u8 kallsyms2elf_type(char type)
 {
@@ -28,61 +30,60 @@ int hex2u64(const char *ptr, u64 *long_val)
 	return p - ptr;
 }
 
+static void read_to_eol(struct io *io)
+{
+	int ch;
+
+	for (;;) {
+		ch = io__get_char(io);
+		if (ch < 0 || ch == '\n')
+			return;
+	}
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
 {
-	char *line = NULL;
-	size_t n;
-	int err = -1;
-	FILE *file = fopen(filename, "r");
+	struct io io;
+	char bf[BUFSIZ];
 
-	if (file == NULL)
-		goto out_failure;
+	io.fd = open(filename, O_RDONLY, 0);
 
-	err = 0;
-
-	while (!feof(file)) {
-		u64 start;
-		int line_len, len;
-		char symbol_type;
-		char *symbol_name;
-
-		line_len = getline(&line, &n, file);
-		if (line_len < 0 || !line)
-			break;
+	if (io.fd < 0)
+		return -1;
 
-		line[--line_len] = '\0'; /* \n */
+	io__init(&io, io.fd, bf, sizeof(bf));
 
-		len = hex2u64(line, &start);
+	while (!io.eof) {
+		__u64 start;
+		int ch, err;
+		size_t i;
+		char symbol_type;
+		char symbol_name[KSYM_NAME_LEN + 1];
 
-		/* Skip the line if we failed to parse the address. */
-		if (!len)
+		if (io__get_hex(&io, &start) != ' ') {
+			read_to_eol(&io);
 			continue;
-
-		len++;
-		if (len + 2 >= line_len)
+		}
+		symbol_type = io__get_char(&io);
+		if (io__get_char(&io) != ' ') {
+			read_to_eol(&io);
 			continue;
-
-		symbol_type = line[len];
-		len += 2;
-		symbol_name = line + len;
-		len = line_len - len;
-
-		if (len >= KSYM_NAME_LEN) {
-			err = -1;
-			break;
 		}
+		for (i = 0; i < sizeof(symbol_name); i++) {
+			ch = io__get_char(&io);
+			if (ch < 0 || ch == '\n')
+				break;
+			symbol_name[i]  = ch;
+		}
+		symbol_name[i]  = '\0';
 
 		err = process_symbol(arg, symbol_name, symbol_type, start);
 		if (err)
 			break;
 	}
 
-	free(line);
-	fclose(file);
-	return err;
-
-out_failure:
-	return -1;
+	close(io.fd);
+	return 0;
 }
-- 
2.26.2.526.g744177e7f7-goog

