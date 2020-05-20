Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C055C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D13206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjP80/UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgETRHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbgETRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=35ZCXy2Dn7KKbGEv+8UKYqquAHcZGCvp8VaN0rwdcno=;
        b=GjP80/UL4YLvkBExwa0pmdQuNfu2R0JcMg4CP3yCuHmCgKkjVFC5JMlqs7OfdHItjvn8LC
        8Vzabxhag1vzVttP/dMbwfJOh2GwPoCpgvVEKkJZHVEZBupUj6MPRVnCCfZPSAY9Wb9Scz
        t6iq9JvJsnVvSCLXrJCKi2LtkIDdXaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-tmC3zbP_MzCtgFBCYA7N9g-1; Wed, 20 May 2020 13:07:44 -0400
X-MC-Unique: tmC3zbP_MzCtgFBCYA7N9g-1
Received: by mail-wm1-f72.google.com with SMTP id v23so1096845wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35ZCXy2Dn7KKbGEv+8UKYqquAHcZGCvp8VaN0rwdcno=;
        b=LsqfT83MUJOEZVYxJtauJTG98f3WJpOQH9YOL+MUkH2WR0OZRyqEapoBSzNy/vnZuj
         5VsgtbvqLNJN5iAUgqH5dobYrVBM/1Xo6/AjBq8l5V7O5JdwwACih/KXEy8EQgWYKaqZ
         KYoLEcxjBKqDosnJznTvhwDxRGJwyuCrDN+19RhhV1LH4uqraKiIdV3+fObepaCH79uN
         tnPLoopRnNyLUFbt/akjMcOpLjDkpKyemrmuncv5laMfF8y85qxdY9HXdOB0PEtmI+2R
         I1wXORnvMHGmpBYUeIo2O6C8IAxm3rOCIUbo5IaaSANps73GTdW0dGzD6cb5wAxWpuQg
         92+g==
X-Gm-Message-State: AOAM531gHLxsoSygjJb4jxmNXCoTQB27L23cBCt9d2p9Ey/SLKM462Cq
        02pCEB1PnkgTRbEFGNZzaHkW2pzbiNtP/ovhDsLXaa3wLFzvGS3oO+VWqOxYqJLgNrhAFQ0M150
        1/rawW1fjQulMON19zPyDObWj
X-Received: by 2002:a7b:c932:: with SMTP id h18mr5310555wml.22.1589994463181;
        Wed, 20 May 2020 10:07:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTQtTA8po3reFSaSHtePbpBRzrZws+C9pf+VUmERup1Y7IVOnLClixRh/d9MwDRUAxMb9v6w==
X-Received: by 2002:a7b:c932:: with SMTP id h18mr5310538wml.22.1589994462760;
        Wed, 20 May 2020 10:07:42 -0700 (PDT)
Received: from steredhat.redhat.com (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id s8sm522512wrg.50.2020.05.20.10.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:42 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 5/5] Add test/eventfd-disable.c test case
Date:   Wed, 20 May 2020 19:07:14 +0200
Message-Id: <20200520170714.68156-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520170714.68156-1-sgarzare@redhat.com>
References: <20200520170714.68156-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new test checks if the mechanism to enable/disable notifications
through eventfd when a request is completed works correctly.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1 -> v2:
- renamed io_uring_cq_eventfd_toggle()
---
 .gitignore             |   1 +
 test/Makefile          |   6 +-
 test/eventfd-disable.c | 148 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 2 deletions(-)
 create mode 100644 test/eventfd-disable.c

diff --git a/.gitignore b/.gitignore
index 19c47d9..fee76e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@
 /test/defer
 /test/eeed8b54e0df-test
 /test/eventfd
+/test/eventfd-disable
 /test/eventfd-ring
 /test/fadvise
 /test/fallocate
diff --git a/test/Makefile b/test/Makefile
index 61825d1..7df550d 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -21,7 +21,8 @@ all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register
 		file-update accept-reuse poll-v-poll fadvise madvise \
 		short-read openat2 probe shared-wq personality eventfd \
 		send_recv eventfd-ring across-fork sq-poll-kthread splice \
-		lfs-openat lfs-openat-write iopoll d4ae271dfaae-test
+		lfs-openat lfs-openat-write iopoll d4ae271dfaae-test \
+		eventfd-disable
 
 include ../Makefile.quiet
 
@@ -53,7 +54,8 @@ test_srcs := poll.c poll-cancel.c ring-leak.c fsync.c io_uring_setup.c \
 	file-update.c accept-reuse.c poll-v-poll.c fadvise.c \
 	madvise.c short-read.c openat2.c probe.c shared-wq.c \
 	personality.c eventfd.c eventfd-ring.c across-fork.c sq-poll-kthread.c \
-	splice.c lfs-openat.c lfs-openat-write.c iopoll.c d4ae271dfaae-test.c
+	splice.c lfs-openat.c lfs-openat-write.c iopoll.c d4ae271dfaae-test.c \
+	eventfd-disable.c
 
 ifdef CONFIG_HAVE_STATX
 test_srcs += statx.c
diff --git a/test/eventfd-disable.c b/test/eventfd-disable.c
new file mode 100644
index 0000000..ad086d4
--- /dev/null
+++ b/test/eventfd-disable.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Description: test disable/enable notifications through eventfd
+ *
+ */
+#include <errno.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/poll.h>
+#include <sys/eventfd.h>
+
+#include "liburing.h"
+
+int main(int argc, char *argv[])
+{
+	struct io_uring_params p = {};
+	struct io_uring_sqe *sqe;
+	struct io_uring_cqe *cqe;
+	struct io_uring ring;
+	uint64_t ptr;
+	struct iovec vec = {
+		.iov_base = &ptr,
+		.iov_len = sizeof(ptr)
+	};
+	int ret, evfd, i;
+
+	ret = io_uring_queue_init_params(64, &ring, &p);
+	if (ret) {
+		fprintf(stderr, "ring setup failed: %d\n", ret);
+		return 1;
+	}
+
+	evfd = eventfd(0, EFD_CLOEXEC);
+	if (evfd < 0) {
+		perror("eventfd");
+		return 1;
+	}
+
+	ret = io_uring_register_eventfd(&ring, evfd);
+	if (ret) {
+		fprintf(stderr, "failed to register evfd: %d\n", ret);
+		return 1;
+	}
+
+	if (!io_uring_cq_eventfd_enabled(&ring)) {
+		fprintf(stderr, "eventfd disabled\n");
+		return 1;
+	}
+
+	ret = io_uring_cq_eventfd_toggle(&ring, false);
+	if (ret) {
+		fprintf(stdout, "Skipping, CQ flags not available!\n");
+		return 0;
+	}
+
+	sqe = io_uring_get_sqe(&ring);
+	io_uring_prep_readv(sqe, evfd, &vec, 1, 0);
+	sqe->user_data = 1;
+
+	ret = io_uring_submit(&ring);
+	if (ret != 1) {
+		fprintf(stderr, "submit: %d\n", ret);
+		return 1;
+	}
+
+	for (i = 0; i < 63; i++) {
+		sqe = io_uring_get_sqe(&ring);
+		io_uring_prep_nop(sqe);
+		sqe->user_data = 2;
+	}
+
+	ret = io_uring_submit(&ring);
+	if (ret != 63) {
+		fprintf(stderr, "submit: %d\n", ret);
+		return 1;
+	}
+
+	for (i = 0; i < 63; i++) {
+		ret = io_uring_wait_cqe(&ring, &cqe);
+		if (ret) {
+			fprintf(stderr, "wait: %d\n", ret);
+			return 1;
+		}
+
+		switch (cqe->user_data) {
+		case 1: /* eventfd */
+			fprintf(stderr, "eventfd unexpected: %d\n", (int)ptr);
+			return 1;
+		case 2:
+			if (cqe->res) {
+				fprintf(stderr, "nop: %d\n", cqe->res);
+				return 1;
+			}
+			break;
+		}
+		io_uring_cqe_seen(&ring, cqe);
+	}
+
+	ret = io_uring_cq_eventfd_toggle(&ring, true);
+	if (ret) {
+		fprintf(stderr, "io_uring_cq_eventfd_toggle: %d\n", ret);
+		return 1;
+	}
+
+	sqe = io_uring_get_sqe(&ring);
+	io_uring_prep_nop(sqe);
+	sqe->user_data = 2;
+
+	ret = io_uring_submit(&ring);
+	if (ret != 1) {
+		fprintf(stderr, "submit: %d\n", ret);
+		return 1;
+	}
+
+	for (i = 0; i < 2; i++) {
+		ret = io_uring_wait_cqe(&ring, &cqe);
+		if (ret) {
+			fprintf(stderr, "wait: %d\n", ret);
+			return 1;
+		}
+
+		switch (cqe->user_data) {
+		case 1: /* eventfd */
+			if (cqe->res != sizeof(ptr)) {
+				fprintf(stderr, "read res: %d\n", cqe->res);
+				return 1;
+			}
+
+			if (ptr != 1) {
+				fprintf(stderr, "eventfd: %d\n", (int)ptr);
+				return 1;
+			}
+			break;
+		case 2:
+			if (cqe->res) {
+				fprintf(stderr, "nop: %d\n", cqe->res);
+				return 1;
+			}
+			break;
+		}
+		io_uring_cqe_seen(&ring, cqe);
+	}
+
+	return 0;
+}
-- 
2.25.4

