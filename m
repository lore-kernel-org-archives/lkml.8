Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A637EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C87C206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbgAXOjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:39:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388927AbgAXOjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:39:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7C03E325B45E66E3C637;
        Fri, 24 Jan 2020 22:39:03 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Fri, 24 Jan 2020 22:38:53 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <ak@linux.intel.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 1/7] perf jevents: Add support for an extra directory level
Date:   Fri, 24 Jan 2020 22:34:59 +0800
Message-ID: <1579876505-113251-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we support upto a level 2 directory, and level 2 would be in the
form vendor/platform.

Add support for a further level, to hold specific categories of events for
when we want to segregate them for matching purposes.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/pmu-events/jevents.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 079c77b6a2fd..8af05b94a37d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -960,15 +960,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 	int level   = ftwbuf->level;
 	int err = 0;
 
-	if (level == 2 && is_dir) {
+	if (level >= 2 && is_dir) {
+		int count = 0;
 		/*
 		 * For level 2 directory, bname will include parent name,
 		 * like vendor/platform. So search back from platform dir
 		 * to find this.
+		 * Something similar for level 3 directory, but we're a PMU
+		 * category folder, like vendor/platform/cpu.
 		 */
 		bname = (char *) fpath + ftwbuf->base - 2;
 		for (;;) {
 			if (*bname == '/')
+				count++;
+			if (count == level - 1)
 				break;
 			bname--;
 		}
@@ -981,13 +986,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
 		 level, sb->st_size, bname, fpath);
 
 	/* base dir or too deep */
-	if (level == 0 || level > 3)
+	if (level == 0 || level > 4)
 		return 0;
 
 
 	/* model directory, reset topic */
 	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
-	    (level == 2 && is_dir)) {
+	    (level >= 2 && is_dir && is_leaf_dir(fpath))) {
 		if (close_table)
 			print_events_table_suffix(eventsfp);
 
-- 
2.17.1

