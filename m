Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B32C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385C1206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD1Iww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:52:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbgD1Iww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:52:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CB51EBCED245C65FC3FC;
        Tue, 28 Apr 2020 16:52:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 16:52:43 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] perf c2c: Remove unneeded semicolon
Date:   Tue, 28 Apr 2020 16:58:56 +0800
Message-ID: <1588064336-70456-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warnings:

 tools/perf/builtin-c2c.c:1712:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:1928:2-3: Unneeded semicolon
 tools/perf/builtin-c2c.c:2962:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 tools/perf/builtin-c2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0d544c4..0e14c18 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1709,7 +1709,7 @@ static struct c2c_dimension *get_dimension(const char *name)
 
 		if (!strcmp(dim->name, name))
 			return dim;
-	};
+	}
 
 	return NULL;
 }
@@ -1925,7 +1925,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		FILTER_HITM(tot_hitm);
 	default:
 		break;
-	};
+	}
 
 #undef FILTER_HITM
 
@@ -2959,7 +2959,7 @@ static int perf_c2c__record(int argc, const char **argv)
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = perf_mem_events__name(j);
-	};
+	}
 
 	if (all_user)
 		rec_argv[i++] = "--all-user";
-- 
2.6.2

