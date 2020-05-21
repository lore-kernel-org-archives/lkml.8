Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BC7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E9B206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgEUNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:33:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52638 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729362AbgEUNdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D1B0F323A3BCFC162EF6;
        Thu, 21 May 2020 21:33:08 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 21:32:58 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Bin <huawei.libin@huawei.com>,
        "Xie XiuQi" <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH 4/4] perf util: Fix potential segment fault in put_tracepoints_path
Date:   Thu, 21 May 2020 21:32:18 +0800
Message-ID: <20200521133218.30150-5-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200521133218.30150-1-liwei391@huawei.com>
References: <20200521133218.30150-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Bin <huawei.libin@huawei.com>

This patch fix potential segment fault triggerd in put_tracepoints_path
when the address of the local variable 'path' be freed in error path
of record_saved_cmdline.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index 086e98ff42a3..0e5c4786f296 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -428,7 +428,7 @@ get_tracepoints_path(struct list_head *pattrs)
 		if (!ppath->next) {
 error:
 			pr_debug("No memory to alloc tracepoints list\n");
-			put_tracepoints_path(&path);
+			put_tracepoints_path(path.next);
 			return NULL;
 		}
 next:
-- 
2.17.1

