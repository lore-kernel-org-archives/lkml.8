Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84080C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429C3206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCLMVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:21:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:22186 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCLMVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:21:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 05:21:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="235010057"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 12 Mar 2020 05:21:49 -0700
Received: from [10.125.252.216] (abudanko-mobl.ccr.corp.intel.com [10.125.252.216])
        by linux.intel.com (Postfix) with ESMTP id 1866058010D;
        Thu, 12 Mar 2020 05:21:46 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf record: fix binding of AIO user space buffers to
 nodes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Organization: Intel Corp.
Message-ID: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
Date:   Thu, 12 Mar 2020 15:21:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Correct maxnode parameter value passed to mbind() syscall to be
the amount of node mask bits to analyze plus 1. Dynamically allocate
node mask memory depending on the index of node of cpu being profiled.

Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/mmap.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 3b664fa673a6..6d604cd67a95 100644
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
+		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1/*nr_bits + 1*/, 0)) {
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
2.24.1

