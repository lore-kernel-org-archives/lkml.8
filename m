Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD1C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4628C2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b3HdyWTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389502AbgDBPoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:44:16 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49293 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389485AbgDBPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:44:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id l2so2869579pld.16
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7gXpeqckpwQ44bfU327VZsCirSAnwIgzhx4tHJH9S9E=;
        b=b3HdyWTx6A1PAhiA+OzR5zisfpsi4tLGVY9djuY5LWxa2pdaNOw4+w4kEy7ULtZCdt
         0v8WqdL+lT4bsW4EJO+VwlOsFMfOSRu+ZVl6EJ63ctZhLvgQtsbIxe5D1V/J1C1iDBMb
         a4yw1ytqPlPgrMb8XEKMa3XFBM6KPueTQcESaz9m1cdcKj5hRdYCE1xny+JeHu+giSe7
         +Mdir9OD3h95Z/hdopITRsVavYakFzOCC9iAYLxFUKmjrTPYqhXrKa+SksYoNiQ5iZTe
         00GK8NSt8HLjmKsZ0fdHRAmTek59K9shPjx9pygD33jqheiaxO66XjW4weJ3v17mfANi
         Vnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7gXpeqckpwQ44bfU327VZsCirSAnwIgzhx4tHJH9S9E=;
        b=mkCjdid3kBYfGLHFPtoWCJ693DZmwX0rZeXtZSWH0BFFiCA2HBmP8rzMgJhSVqIi8q
         U1R3sQ8we7kdPp4gB5AvB84M7F+SBJLA5RLKB0zcxa9HggZFKxY9jjicLorPt42UkC4M
         DcbDt/y1QnjZz23xrg358diYD/Ed3hjPLNz/4KAzcbue3JZSUrF6gMUMDDRzBaoNspky
         1VFzF7EWEjGH+gzcqMytp/ynukQAEJU3P1WJdATcjEVrPcD679QbTTsj3dZuMG09MrFE
         REQ6TP793PSzzdZq6DU2yBrxd33GohkFI5owuvAFLGdDZfnNnfn8OurJgB3jGjsLzNbM
         z8tQ==
X-Gm-Message-State: AGi0PuaLQ3eT3F/Exyz69Z7280tQCoVyfFYcEMjv/14cRVN3MpsAk7LA
        UWtwdNMFtYnf1Pd2TnwjqWJdnC6itZq6
X-Google-Smtp-Source: APiQypIf4ojHHMLNIrpSpic4PqWzqwZGXeDLG3tPVucAC1eJV1Y/84p5fAIZAjz5Ma8TDsK/MAooKDvORG4X
X-Received: by 2002:a63:7b57:: with SMTP id k23mr3983859pgn.307.1585842251942;
 Thu, 02 Apr 2020 08:44:11 -0700 (PDT)
Date:   Thu,  2 Apr 2020 08:43:56 -0700
In-Reply-To: <20200402154357.107873-1-irogers@google.com>
Message-Id: <20200402154357.107873-5-irogers@google.com>
Mime-Version: 1.0
References: <20200402154357.107873-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v2 4/5] tools api: add a lightweight buffered reading api
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthesize benchmark shows the majority of execution time going to
fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
reading library that will be used to replace these calls in a follow-up
CL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 tools/lib/api/io.h

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
new file mode 100644
index 000000000000..5aa5b0e26a7a
--- /dev/null
+++ b/tools/lib/api/io.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lightweight buffered reading library.
+ *
+ * Copyright 2019 Google LLC.
+ */
+#ifndef __API_IO__
+#define __API_IO__
+
+struct io {
+	/* File descriptor being read/ */
+	int fd;
+	/* Size of the read buffer. */
+	unsigned int buf_len;
+	/* Pointer to storage for buffering read. */
+	char *buf;
+	/* End of the storage. */
+	char *end;
+	/* Currently accessed data pointer. */
+	char *data;
+	/* Set true on when the end of file on read error. */
+	bool eof;
+};
+
+static inline void io__init(struct io *io, int fd,
+			    char *buf, unsigned int buf_len)
+{
+	io->fd = fd;
+	io->buf_len = buf_len;
+	io->buf = buf;
+	io->end = buf;
+	io->data = buf;
+	io->eof = false;
+}
+
+/* Reads one character from the "io" file with similar semantics to fgetc. */
+static inline int io__get_char(struct io *io)
+{
+	char *ptr = io->data;
+
+	if (ptr == io->end) {
+		ssize_t n = read(io->fd, io->buf, io->buf_len);
+
+		if (n <= 0) {
+			io->eof = true;
+			return -1;
+		}
+		ptr = &io->buf[0];
+		io->end = &io->buf[n];
+	}
+	io->data = ptr + 1;
+	return *ptr;
+}
+
+/* Read a hexadecimal value with no 0x prefix into the out argument hex.
+ * Returns -1 on error or if nothing is read, otherwise returns the character
+ * after the hexadecimal value.
+ */
+static inline int io__get_hex(struct io *io, __u64 *hex)
+{
+	bool first_read = true;
+
+	*hex = 0;
+	while (true) {
+		char ch = io__get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*hex = (*hex << 4) | (ch - '0');
+		else if (ch >= 'a' && ch <= 'f')
+			*hex = (*hex << 4) | (ch - 'a' + 10);
+		else if (ch >= 'A' && ch <= 'F')
+			*hex = (*hex << 4) | (ch - 'A' + 10);
+		else if (first_read)
+			return -1;
+		else
+			return ch;
+		first_read = false;
+	}
+}
+
+/* Read a decimal value into the out argument dec.
+ * Returns -1 on error or if nothing is read, otherwise returns the character
+ * after the decimal value.
+ */
+static inline int io__get_dec(struct io *io, __u64 *dec)
+{
+	bool first_read = true;
+
+	*dec = 0;
+	while (true) {
+		char ch = io__get_char(io);
+
+		if (ch < 0)
+			return ch;
+		if (ch >= '0' && ch <= '9')
+			*dec = (*dec * 10) + ch - '0';
+		else if (first_read)
+			return -1;
+		else
+			return ch;
+		first_read = false;
+	}
+}
+
+#endif /* __API_IO__ */
-- 
2.26.0.rc2.310.g2932bb562d-goog

