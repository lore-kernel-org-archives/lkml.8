Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB33C5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0C22073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480886;
	bh=TGPhnr5mY8Vj1ckf0GoDpXrsvJyl+8f5dLtUZCHvYkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rTcwOcMtOyPMgGKjM7tc7zj0BcP/o+OsZjacn6OtNKzQbgJ/aETDOBVd9mcDTfC0x
	 6o5oYvIsMTMmIWJO9YFSb6p+mwN8kklCEx6+p5CwA3ELGax0LqOxCs+FujqDu/hMnr
	 SM2dG+RNjRKpL2RWjeoOC42qUzVHDt1ehc+YkS8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCQVeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbgCQVeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:34:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D3120775;
        Tue, 17 Mar 2020 21:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480857;
        bh=TGPhnr5mY8Vj1ckf0GoDpXrsvJyl+8f5dLtUZCHvYkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpVd6AYmTkzy8bVMb6uhnZncXrcUteBsQXc3RFeH/VBKZ6mXN8nZqQMo5q/xi4XFM
         oubcRTmIWUih4YE/8FLoCLhgC9bb+xNLnD+S26Z4POVeNQWXN+KBwQyO678F3m7pOZ
         cppNXn58rCJOotogPD01LIYCcNnQcaSmUBroSPcQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/23] perf record: Fix binding of AIO user space buffers to nodes
Date:   Tue, 17 Mar 2020 18:32:55 -0300
Message-Id: <20200317213259.15494-20-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
index 3b664fa673a6..ab7108d22428 100644
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
-- 
2.21.1

