Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13032177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fI+pW0eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHGGfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:35:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277EEC061757
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 23:35:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so431701pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50MUj2R7toUKF7VHpxGtW/Td7eJ1OvtH6BtVT9drbTY=;
        b=fI+pW0eAwMvjGgaYZ4rzVhyJobnL4NKFGmBytxtt8YDDnioxvhzHFzC1x9TvSYYcCI
         7KSvBxq0L44O0sL6LZKZaJK2b8D8ByKLm+ZxdnubQt0xIZvnTQWS+pEN40Zc6zClVdPX
         lV43urjiJyJMeOS8yTj47UkCDj0HHoO9vuZYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50MUj2R7toUKF7VHpxGtW/Td7eJ1OvtH6BtVT9drbTY=;
        b=EuBkDP5XS39IngN5fnjZ9B01ycvs/fWuoJnPow2uJdu9Q9a5K67dAzfLMGKZ3Shd6I
         J/9rbqUdP3zJgGoJ8/+4CkAXHr8WkVZskSpJ2JhrI4D0iWUFJreCaPOKlXLx2h7uYggK
         ZuEe1/mLKy2zjk8tfO8dOMiMqYyYi4clIHRlsJASKfVmkTpTBh9fQvMzzbvn9dPsOiv8
         BNEKj3fCvpLOsJpCBn/mx02iaV0Bl1S3nGG0WKlyOEDgenwNcqMd0FnTYFHDuNuq8/yS
         JCTE37PO15DNJmK9bhhk4jwEdvkOJgij0hjGh46OGV6odQnNO6YD3ihQ8IqUzD7LUn1v
         OXqA==
X-Gm-Message-State: AOAM530M6LgFGJ0W2vwrvi7H4ro3njHReXg9I0g8tzs0JBpZOvQGeT1r
        SWIAtq0HtcXpzQ6wILaK1ebuedKGFpE=
X-Google-Smtp-Source: ABdhPJxTu8qb0neUxKMA8SiKGJ8hD62n5hMdDbnhD9noclgDabjCUrt2YwAtkOrCQhiIsRrC1tV1kQ==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr11467668plt.158.1596782149670;
        Thu, 06 Aug 2020 23:35:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r28sm10646360pfg.158.2020.08.06.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 23:35:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests: splice: Check behavior of full and short splices
Date:   Thu,  6 Aug 2020 23:35:39 -0700
Message-Id: <20200807063539.2620154-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200807063539.2620154-1-keescook@chromium.org>
References: <20200807063539.2620154-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to help catch regressions in splice vs read behavior in certain
special files, test a few with various different kinds of internal
kernel helpers.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/splice/.gitignore     |  1 +
 tools/testing/selftests/splice/Makefile       |  4 +-
 tools/testing/selftests/splice/config         |  1 +
 tools/testing/selftests/splice/settings       |  1 +
 .../selftests/splice/short_splice_read.sh     | 56 ++++++++++++++++++
 tools/testing/selftests/splice/splice_read.c  | 57 +++++++++++++++++++
 6 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/splice/config
 create mode 100644 tools/testing/selftests/splice/settings
 create mode 100755 tools/testing/selftests/splice/short_splice_read.sh
 create mode 100644 tools/testing/selftests/splice/splice_read.c

diff --git a/tools/testing/selftests/splice/.gitignore b/tools/testing/selftests/splice/.gitignore
index d5a2da428752..be8266f5d04c 100644
--- a/tools/testing/selftests/splice/.gitignore
+++ b/tools/testing/selftests/splice/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 default_file_splice_read
+splice_read
diff --git a/tools/testing/selftests/splice/Makefile b/tools/testing/selftests/splice/Makefile
index e519b159b60d..541cd826d5a5 100644
--- a/tools/testing/selftests/splice/Makefile
+++ b/tools/testing/selftests/splice/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := default_file_splice_read.sh
-TEST_GEN_PROGS_EXTENDED := default_file_splice_read
+TEST_PROGS := default_file_splice_read.sh short_splice_read.sh
+TEST_GEN_PROGS_EXTENDED := default_file_splice_read splice_read
 
 include ../lib.mk
diff --git a/tools/testing/selftests/splice/config b/tools/testing/selftests/splice/config
new file mode 100644
index 000000000000..058c928368b8
--- /dev/null
+++ b/tools/testing/selftests/splice/config
@@ -0,0 +1 @@
+CONFIG_TEST_LKM=m
diff --git a/tools/testing/selftests/splice/settings b/tools/testing/selftests/splice/settings
new file mode 100644
index 000000000000..89cedfc0d12b
--- /dev/null
+++ b/tools/testing/selftests/splice/settings
@@ -0,0 +1 @@
+timeout=5
diff --git a/tools/testing/selftests/splice/short_splice_read.sh b/tools/testing/selftests/splice/short_splice_read.sh
new file mode 100755
index 000000000000..7810d3589d9a
--- /dev/null
+++ b/tools/testing/selftests/splice/short_splice_read.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+set -e
+
+ret=0
+
+do_splice()
+{
+	filename="$1"
+	bytes="$2"
+	expected="$3"
+
+	out=$(./splice_read "$filename" "$bytes" | cat)
+	if [ "$out" = "$expected" ] ; then
+		echo "ok: $filename $bytes"
+	else
+		echo "FAIL: $filename $bytes"
+		ret=1
+	fi
+}
+
+test_splice()
+{
+	filename="$1"
+
+	full=$(cat "$filename")
+	two=$(echo "$full" | grep -m1 . | cut -c-2)
+
+	# Make sure full splice has the same contents as a standard read.
+	do_splice "$filename" 4096 "$full"
+
+	# Make sure a partial splice see the first two characters.
+	do_splice "$filename" 2 "$two"
+}
+
+# proc_single_open(), seq_read()
+test_splice /proc/$$/limits
+# special open, seq_read()
+test_splice /proc/$$/comm
+
+# proc_handler, proc_dointvec_minmax
+test_splice /proc/sys/fs/nr_open
+# proc_handler, proc_dostring
+test_splice /proc/sys/kernel/modprobe
+# proc_handler, special read
+test_splice /proc/sys/kernel/version
+
+if ! [ -d /sys/module/test_module/sections ] ; then
+	modprobe test_module
+fi
+# kernfs, attr
+test_splice /sys/module/test_module/coresize
+# kernfs, binattr
+test_splice /sys/module/test_module/sections/.init.text
+
+exit $ret
diff --git a/tools/testing/selftests/splice/splice_read.c b/tools/testing/selftests/splice/splice_read.c
new file mode 100644
index 000000000000..46dae6a25cfb
--- /dev/null
+++ b/tools/testing/selftests/splice/splice_read.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	size_t size;
+	ssize_t spliced;
+
+	if (argc < 2) {
+		fprintf(stderr, "Usage: %s INPUT [BYTES]\n", argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		return EXIT_FAILURE;
+	}
+
+	if (argc == 3)
+		size = atol(argv[2]);
+	else {
+		struct stat statbuf;
+
+		if (fstat(fd, &statbuf) < 0) {
+			perror(argv[1]);
+			return EXIT_FAILURE;
+		}
+
+		if (statbuf.st_size > INT_MAX) {
+			fprintf(stderr, "%s: Too big\n", argv[1]);
+			return EXIT_FAILURE;
+		}
+
+		size = statbuf.st_size;
+	}
+
+	/* splice(2) file to stdout. */
+	spliced = splice(fd, NULL, STDOUT_FILENO, NULL,
+		      size, SPLICE_F_MOVE);
+	if (spliced < 0) {
+		perror("splice");
+		return EXIT_FAILURE;
+	}
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
-- 
2.25.1

