Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A4C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76002074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIEIlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:41:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgIEIle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:41:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B7758CCBF1CF98C35C5;
        Sat,  5 Sep 2020 16:41:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 5 Sep 2020
 16:41:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: vmstat: Use helper macro abs()
Date:   Sat, 5 Sep 2020 04:40:08 -0400
Message-ID: <20200905084008.15748-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro abs() to simplify the "x > t || x < -t" cmp.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/vmstat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 06fd13ebc2b8..648c2d6ddce2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -329,7 +329,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 
 	t = __this_cpu_read(pcp->stat_threshold);
 
-	if (unlikely(x > t || x < -t)) {
+	if (unlikely(abs(x) > t)) {
 		zone_page_state_add(x, zone, item);
 		x = 0;
 	}
@@ -354,7 +354,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 
 	t = __this_cpu_read(pcp->stat_threshold);
 
-	if (unlikely(x > t || x < -t)) {
+	if (unlikely(abs(x) > t)) {
 		node_page_state_add(x, pgdat, item);
 		x = 0;
 	}
@@ -515,7 +515,7 @@ static inline void mod_zone_state(struct zone *zone,
 		o = this_cpu_read(*p);
 		n = delta + o;
 
-		if (n > t || n < -t) {
+		if (abs(n) > t) {
 			int os = overstep_mode * (t >> 1) ;
 
 			/* Overflow must be added to zone counters */
@@ -577,7 +577,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 		o = this_cpu_read(*p);
 		n = delta + o;
 
-		if (n > t || n < -t) {
+		if (abs(n) > t) {
 			int os = overstep_mode * (t >> 1) ;
 
 			/* Overflow must be added to node counters */
-- 
2.19.1

