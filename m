Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287AEC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F307220857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeNj/TKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgEAWN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgEAWN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:13:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3592C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:13:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ck5so11414199qvb.18
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=frAcSZ+bz+MYojhGLMEjosS66t/jdJlHqPdFYcpatpc=;
        b=ZeNj/TKJTWhfv7IjWrmaYvsJPjofCM3TF7S2BlBHhxArKWPd++HFws1WbzXyl14Yew
         edqGVO/JxsmGhfMtfUF6TRc+dFQQiYs6teEpwOENyC3xJ5ZAM6sPCXnHghL/GvJE0Sgt
         BRYd6uSi4cXdxTR06ZVrzkN64D2sFHcsFA1KW/J0/+zFKY45PTNhuJ/zL5wnzQZ7KAaV
         6/elnzMM5oEMtw/n+X/eWm9a9Litd7vTcQQ5ZpnyxSv+DdftGwNmoIe4JQCvO6Q2jFjP
         rZmwrdgy2z21Srn1vifHweaiuKM0vScYkxGCXmIV9Ya5NTjM5MiY1E9b4ieV1rF+NuMB
         xYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=frAcSZ+bz+MYojhGLMEjosS66t/jdJlHqPdFYcpatpc=;
        b=pZgIhesdLLRzrQ6QL1Ghh0VYt6HK+Qt+mGZMqH9gdhdzp+8LP9fav4ELukCDpXpTYv
         zRQPt+8z+XftH1QKGN5eOnRdcdY4hfzCq/XfIwfBn/830Lw6YYb83ws9UIlUVRcw23HI
         /NjkiO4xrMyiRoTvsQ27svaur/0cFmPH+wTZHENoOpYj1GnKb/Iiy3TXNeU1njxbAuo8
         QRs+nU0oUqVN7s+kRikHts3eujkNh2oCflVFCugfWa8Ng6cX6BNwSHxOuu/9hKTG8wA6
         PVhKV1bo8RXgC4kMTYu0bqWfQjYfKZCAH2KQ6raGQn5WGVFR8KTbPqqVXj/ilvFHOehH
         vmKw==
X-Gm-Message-State: AGi0PuY8k3c8+cm9XFtcyd+Gxk1+I8tem8DO7wXCBHkVahK9j+Vn8Wbz
        cWPxWDWPFaAcVywJNb3aQveYQf62ses7
X-Google-Smtp-Source: APiQypLe4kl4J2qQh9WZZsYDiL0EvN8rAmamWYAsY9M/3xVXXXpJufSY+0FTZ3eGvlUfXxEClsc/G4fgJxPU
X-Received: by 2002:a05:6214:a14:: with SMTP id dw20mr6025368qvb.179.1588371206087;
 Fri, 01 May 2020 15:13:26 -0700 (PDT)
Date:   Fri,  1 May 2020 15:13:14 -0700
In-Reply-To: <20200501221315.54715-1-irogers@google.com>
Message-Id: <20200501221315.54715-3-irogers@google.com>
Mime-Version: 1.0
References: <20200501221315.54715-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v2 2/3] lib kallsyms: parse using io api
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
 tools/lib/symbol/kallsyms.c | 86 ++++++++++++++++---------------------
 2 files changed, 41 insertions(+), 48 deletions(-)

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
index 1a7a9f877095..e335ac2b9e19 100644
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
@@ -15,74 +17,62 @@ bool kallsyms__is_function(char symbol_type)
 	return symbol_type == 'T' || symbol_type == 'W';
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
+static void read_to_eol(struct io *io)
 {
-	char *p;
+	int ch;
 
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
+	for (;;) {
+		ch = io__get_char(io);
+		if (ch < 0 || ch == '\n')
+			return;
+	}
 }
 
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
 {
-	char *line = NULL;
-	size_t n;
-	int err = -1;
-	FILE *file = fopen(filename, "r");
-
-	if (file == NULL)
-		goto out_failure;
-
-	err = 0;
+	struct io io;
+	char bf[BUFSIZ];
+	int err;
 
-	while (!feof(file)) {
-		u64 start;
-		int line_len, len;
-		char symbol_type;
-		char *symbol_name;
+	io.fd = open(filename, O_RDONLY, 0);
 
-		line_len = getline(&line, &n, file);
-		if (line_len < 0 || !line)
-			break;
+	if (io.fd < 0)
+		return -1;
 
-		line[--line_len] = '\0'; /* \n */
+	io__init(&io, io.fd, bf, sizeof(bf));
 
-		len = hex2u64(line, &start);
+	err = 0;
+	while (!io.eof) {
+		__u64 start;
+		int ch;
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
+	close(io.fd);
 	return err;
-
-out_failure:
-	return -1;
 }
-- 
2.26.2.526.g744177e7f7-goog

