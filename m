Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA26C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E75D207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGTFYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:24:10 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28904 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgGTFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:24:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U3BbK4T_1595222637;
Received: from localhost.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3BbK4T_1595222637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 13:23:57 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmstat: don't do count if no needs
Date:   Mon, 20 Jul 2020 13:23:48 +0800
Message-Id: <20200720052348.428564-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For couple of vmstat account funcs, the caller usually doesn't check the
delta value, if delta == 0, irq or atomic operator is a waste. That's
better to be skipped.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: linux-mm@kvack.org 
Cc: linux-kernel@vger.kernel.org 
---
 mm/vmstat.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3fb23a21f6dd..91f28146daa7 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -321,6 +321,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	if (!delta)
+		return;
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -341,6 +344,9 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	long x;
 	long t;
 
+	if (!delta)
+		return;
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -484,6 +490,9 @@ static inline void mod_zone_state(struct zone *zone,
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	long o, n, t, z;
 
+	if (!delta)
+		return;
+
 	do {
 		z = 0;  /* overflow to zone counters */
 
@@ -518,6 +527,9 @@ static inline void mod_zone_state(struct zone *zone,
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 			 long delta)
 {
+	if (!delta)
+		return;
+
 	mod_zone_state(zone, item, delta, 0);
 }
 EXPORT_SYMBOL(mod_zone_page_state);
@@ -541,6 +553,9 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 	s8 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
+	if (!delta)
+		return;
+
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -581,6 +596,9 @@ EXPORT_SYMBOL(mod_node_page_state);
 
 void inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
+	if (!delta)
+		return;
+
 	mod_node_state(pgdat, item, 1, 1);
 }
 
@@ -604,6 +622,9 @@ void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 {
 	unsigned long flags;
 
+	if (!delta)
+		return;
+
 	local_irq_save(flags);
 	__mod_zone_page_state(zone, item, delta);
 	local_irq_restore(flags);
@@ -647,6 +668,9 @@ void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 {
 	unsigned long flags;
 
+	if (!delta)
+		return;
+
 	local_irq_save(flags);
 	__mod_node_page_state(pgdat, item, delta);
 	local_irq_restore(flags);
-- 
2.18.4

