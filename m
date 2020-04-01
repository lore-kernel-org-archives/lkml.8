Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DC1C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB987214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDcKkUMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgDAXkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:40:40 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42401 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgDAXkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:40:37 -0400
Received: by mail-pf1-f201.google.com with SMTP id j2so1187101pfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 16:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fsEYkltAk53T4eVq5RRzWlbTbMOd4svtDSnBJvpHQdk=;
        b=NDcKkUMOriuYimgHJd4d/VEiqxHwtB1/16eBKDGA7KsvYyjkjwQlF4tdBvTjjl+x9L
         hSgf1Mng2yxrrlJfQkjB8hD5w7fHu1wxPOodaUqwlygN/mWaDp15ypUhk6D8y4uUAhx4
         WojDNX4earli9b3B3di3uBP2+WL75Iq83q8Lurr3wptmHlo5XN5A6Pv/3sjrI/4t9tg0
         NVp4zZLNHrr0UWDy0HRKVFmoOFCoa9EB5+ucf9KQ2TGPdTEz7asfYYs2xN2EhCIeLc65
         xg16cuzQcEBL4ldg9BzGj4almrEYRA3H8kics1hOpa6siRt/aHCHQrqG3XX52G1s3dZk
         9Mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fsEYkltAk53T4eVq5RRzWlbTbMOd4svtDSnBJvpHQdk=;
        b=a5zP0YqM8kEopkGunq/Biir6k0EcY9ZxByLR5o+zF6kBXix99GCeNdxLdmOKbdPHYI
         aGN6zsHtJc4gRn8YPS7n+C/QGAn3LDaqsHN8zIQlWdKZBm7stVVrx8LBgKklPtcXw6h9
         jBAjiinur6yr2Oo4QT5UQEvwoQzdjVulS1rn2+T3ojXTZiALh16rsbGAp1oz3ySw8D1f
         yyILMvNZT6KeXplz8zvReqAEwEjfVQ4Cdz5LpAmiAuBx1OXRKkX9nPzIaBsXTPc7JW20
         dKwsmyEUod7gFMM7XDoZwJPf3FCb9+GukeempM02LDmXVdH+jXtYto+6v84f4OMlT6YN
         Oacg==
X-Gm-Message-State: AGi0PuYeyjll+fPzKNEQiL6Qx+7VEEftgrUVkIHSsQhhSPny9TUgKji/
        6rlXdaQlnvathW65ycs4wVrf0GNc1p7d
X-Google-Smtp-Source: APiQypKfsK9wGqvQE+rekoOQNYyQQsHqDnX8p+IMhEY/HnQBXPRbJMv0NxVhfl/rixOQq95PstRAzl/pIv9a
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr619148pjn.34.1585784434838;
 Wed, 01 Apr 2020 16:40:34 -0700 (PDT)
Date:   Wed,  1 Apr 2020 16:39:44 -0700
In-Reply-To: <20200401233945.133550-1-irogers@google.com>
Message-Id: <20200401233945.133550-5-irogers@google.com>
Mime-Version: 1.0
References: <20200401233945.133550-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH 4/5] tools api: add a lightweight buffered reading api
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
 tools/lib/api/io.h | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 tools/lib/api/io.h

diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
new file mode 100644
index 000000000000..e88d76c59440
--- /dev/null
+++ b/tools/lib/api/io.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lightweight buffered reading library.
+ *
+ * Copyright 2019 Google LLC.
+ */
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
+static inline void init_io(struct io *io, int fd,
+			   char *buf, unsigned int buf_len)
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
+static inline int get_char(struct io *io)
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
+static inline int get_hex(struct io *io, __u64 *hex)
+{
+	bool first_read = true;
+
+	*hex = 0;
+	while (true) {
+		char ch = get_char(io);
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
+static inline int get_dec(struct io *io, __u64 *dec)
+{
+	bool first_read = true;
+
+	*dec = 0;
+	while (true) {
+		char ch = get_char(io);
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
-- 
2.26.0.rc2.310.g2932bb562d-goog

