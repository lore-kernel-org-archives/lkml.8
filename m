Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD428C47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3732073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mL83tX9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgEEOgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729471AbgEEOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:36:36 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:36:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id p12so2113356qvm.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hrH61edaLUEJRAvPeM4JFBLkOGEqCCVVpU1XV+EHNB4=;
        b=mL83tX9zs90/YhPWaREuPGD5S802mnlhL2lG4jHCpnDDRP5yfDdy8i/4ZoDNIn5Nv+
         ezUyoimm/IKFjhtlS2Kmu/0s6+knAFxHGpooQrs3V76zsP+SvV8IpSaikJkE2o2RSaJD
         iY2sfjX0Y/ARXqLTT9DwftfUxQ5D5Vu+Tl9pFKH/DuCeJyb6QRpMs1DoQ8xBWi3HxsgO
         nqIavUOS9ycgxLp9/1wzNnef5Vh7e31V7UdMukaA3KNj42Ba+H87N9diueACjLziuObi
         fWaYbB5UDcgkPSzyogt2tELx+VBjSQ3MsYo7lRJIkuhomuYWs33uF5ClMPctgjO/KOxa
         MNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hrH61edaLUEJRAvPeM4JFBLkOGEqCCVVpU1XV+EHNB4=;
        b=izua2gkdvMaoAxpUwu+bVqNbiESePmPIA7+72ci92cZjtJTLUgX7n+goT7jEXVXjKX
         DqPXtm7dOHmR8C82R2h5EGYIC9XT2t89tA734tHHSN6os5LQwZ3g22FnTc7Nv91O2fId
         HUZcnnhCRAcINV2jRzkM6Gip0aa2fC7k5l3QFuo3NnT5DFMfG8NRwwiyp6FVMmdwI1HK
         wEhVtkVBKNdIO23jAdkgGro6qKRjrUMrVQagcOv6luYQ2KN1sPNkqJ2c4OblMyrNqM14
         ePTfw6EGMdREzD+OJzEYSjLLVAGgHT/uP0CvWJp7h2MWuy9yN4/5LQEAt3sE9oKtzEaS
         ioIQ==
X-Gm-Message-State: AGi0PuariTaWwOBV89KE6S8e2o30x1f74c+bed1IbtmgmultelXB8q3Z
        t/DeQG1LCoXxHb9W65Ok+2E9qP5bHJ97
X-Google-Smtp-Source: APiQypKlJNzSM/g1DTJ4UPNAHj8RsOLGo0eDA0sssPMIxqXzlRoCuVDZyrop9ZCae3cXVfuWQkRLSemiNFQj
X-Received: by 2002:a0c:b604:: with SMTP id f4mr3045752qve.40.1588689394617;
 Tue, 05 May 2020 07:36:34 -0700 (PDT)
Date:   Tue,  5 May 2020 07:36:24 -0700
In-Reply-To: <20200505143625.147832-1-irogers@google.com>
Message-Id: <20200505143625.147832-3-irogers@google.com>
Mime-Version: 1.0
References: <20200505143625.147832-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v3 2/3] lib kallsyms: parse using io api
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
 2 files changed, 45 insertions(+), 39 deletions(-)

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
index 1a7a9f877095..1f2f519a4e3f 100644
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
@@ -28,61 +30,62 @@ int hex2u64(const char *ptr, u64 *long_val)
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
+	int err;
 
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

