Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB46C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4F421556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgBYGoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:44:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:29696 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729025AbgBYGoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:44:10 -0500
X-IronPort-AV: E=Sophos;i="5.70,483,1574092800"; 
   d="scan'208";a="83891623"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Feb 2020 14:44:06 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 081C950A9976;
        Tue, 25 Feb 2020 14:34:20 +0800 (CST)
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Tue, 25 Feb 2020 14:44:02 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 id 14.3.439.0; Tue, 25 Feb 2020 14:44:05 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] tools/perf/util/*.c: Use "%zd" output format for size_t type
Date:   Tue, 25 Feb 2020 14:39:01 +0800
Message-ID: <20200225063901.20165-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 081C950A9976.AA05D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the following errors when building perf:
-----------------------------------------------
util/session.c: In function 'perf_session__process_compressed_event':
util/session.c:91:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
  pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
...
til/zstd.c: In function 'zstd_decompress_stream':
util/zstd.c:102:11: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t {aka unsigned int}' [-Werror=format=]
    pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
...
-----------------------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tools/perf/util/session.c | 2 +-
 tools/perf/util/zstd.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d0d7d25b23e3..5b74d606b4b7 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -88,7 +88,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 		session->decomp_last = decomp;
 	}
 
-	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
+	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
 
 	return 0;
 }
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index d2202392ffdb..48dd2b018c47 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -99,7 +99,7 @@ size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size
 	while (input.pos < input.size) {
 		ret = ZSTD_decompressStream(data->dstream, &output, &input);
 		if (ZSTD_isError(ret)) {
-			pr_err("failed to decompress (B): %ld -> %ld, dst_size %ld : %s\n",
+			pr_err("failed to decompress (B): %zd -> %zd, dst_size %zd : %s\n",
 			       src_size, output.size, dst_size, ZSTD_getErrorName(ret));
 			break;
 		}
-- 
2.21.0



