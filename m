Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4C8C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B212467A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgAJRyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:54:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59201 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgAJRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTL-0001mo-4Q; Fri, 10 Jan 2020 18:53:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AC9D1C2D5A;
        Fri, 10 Jan 2020 18:53:18 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:18 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf mmap: Declare type for cpu mask of arbitrary length
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com>
References: <0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157867879823.30329.8276302610164757060.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9c080c0279a80057cad3dfc05d09fb283ddf72f4
Gitweb:        https://git.kernel.org/tip/9c080c0279a80057cad3dfc05d09fb283ddf72f4
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Tue, 03 Dec 2019 14:44:18 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:09 -03:00

perf mmap: Declare type for cpu mask of arbitrary length

Declare a dedicated struct map_cpu_mask type for cpu masks of arbitrary
length.

The mask is available thru bits pointer and the mask length is kept in
nbits field. MMAP_CPU_MASK_BYTES() macro returns mask storage size in
bytes.

The mmap_cpu_mask__scnprintf() function can be used to log text
representation of the mask.

Committer notes:

To print the 'nbits' struct member we must use %zd, since it is a
size_t, this fixes the build in some toolchains/arches.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 12 ++++++++++++
 tools/perf/util/mmap.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 063d1b9..2ee4faa 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,6 +23,18 @@
 #include "mmap.h"
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
+#include <linux/bitmap.h>
+
+#define MASK_SIZE 1023
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
+{
+	char buf[MASK_SIZE + 1];
+	size_t len;
+
+	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
+	buf[len] = '\0';
+	pr_debug("%p: %s mask[%zd]: %s\n", mask, tag, mask->nbits, buf);
+}
 
 size_t mmap__mmap_len(struct mmap *map)
 {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bee4e83..ef51667 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,6 +15,15 @@
 #include "event.h"
 
 struct aiocb;
+
+struct mmap_cpu_mask {
+	unsigned long *bits;
+	size_t nbits;
+};
+
+#define MMAP_CPU_MASK_BYTES(m) \
+	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
+
 /**
  * struct mmap - perf's ring buffer mmap details
  *
@@ -52,4 +61,6 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
+
 #endif /*__PERF_MMAP_H */
