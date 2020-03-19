Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C7C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85D321655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCSOKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:10:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbgCSOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:10:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsf-00020F-Ry; Thu, 19 Mar 2020 15:10:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 823501C22A3;
        Thu, 19 Mar 2020 15:10:41 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:41 -0000
From:   "tip-bot2 for Alexey Budankov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Fix binding of AIO user space buffers to nodes
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
References: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704123.28353.13994745078032026323.tip-bot2@tip-bot2>
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

Commit-ID:     44d462acc0bf3eabe1522471fd1f683d8ce612cb
Gitweb:        https://git.kernel.org/tip/44d462acc0bf3eabe1522471fd1f683d8ce612cb
Author:        Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate:    Thu, 12 Mar 2020 15:21:45 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 12 Mar 2020 11:32:46 -03:00

perf record: Fix binding of AIO user space buffers to nodes

Correct maxnode parameter value passed to mbind() syscall to be the
amount of node mask bits to analyze plus 1. Dynamically allocate node
mask memory depending on the index of node of cpu being profiled.

Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com
[ Remove leftover nr_bits + 1 comment in mbind() call ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 3b664fa..ab7108d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
 {
 	void *data;
 	size_t mmap_len;
-	unsigned long node_mask;
+	unsigned long *node_mask;
+	unsigned long node_index;
+	int err = 0;
 
 	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
 		data = map->aio.data[idx];
 		mmap_len = mmap__mmap_len(map);
-		node_mask = 1UL << cpu__get_node(cpu);
-		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
-			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
-				data, data + mmap_len, cpu__get_node(cpu));
+		node_index = cpu__get_node(cpu);
+		node_mask = bitmap_alloc(node_index + 1);
+		if (!node_mask) {
+			pr_err("Failed to allocate node mask for mbind: error %m\n");
 			return -1;
 		}
+		set_bit(node_index, node_mask);
+		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1, 0)) {
+			pr_err("Failed to bind [%p-%p] AIO buffer to node %lu: error %m\n",
+				data, data + mmap_len, node_index);
+			err = -1;
+		}
+		bitmap_free(node_mask);
 	}
 
-	return 0;
+	return err;
 }
 #else /* !HAVE_LIBNUMA_SUPPORT */
 static int perf_mmap__aio_alloc(struct mmap *map, int idx)
