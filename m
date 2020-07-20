Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFEFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4EB20758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGTFmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:42:51 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:49593 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgGTFmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:42:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U3CmdbJ_1595223766;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3CmdbJ_1595223766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 13:42:47 +0800
Subject: Re: [PATCH] mm/vmstat: don't do count if no needs
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200720052348.428564-1-alex.shi@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1ef9baa0-9788-5917-2590-a8c3fc593b81@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 13:42:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200720052348.428564-1-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From 4cb977d34227e4bafa95b8da5e47dbd8b6141d26 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Mon, 20 Jul 2020 11:50:12 +0800
Subject: [PATCH v2] mm/vmstat: don't do count if no needs

For couple of vmstat account funcs, the caller usually doesn't check the
delta value, if delta == 0, irq or atomic operator is a waste. That's
better to be skipped, also add unlikey() since !delta is less happened.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/vmstat.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 3fb23a21f6dd..b02d99dff443 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -321,6 +321,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 	long x;
 	long t;
 
+	if (unlikely(!delta))
+		return;
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -341,6 +344,9 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 	long x;
 	long t;
 
+	if (unlikely(!delta))
+		return;
+
 	x = delta + __this_cpu_read(*p);
 
 	t = __this_cpu_read(pcp->stat_threshold);
@@ -484,6 +490,9 @@ static inline void mod_zone_state(struct zone *zone,
 	s8 __percpu *p = pcp->vm_stat_diff + item;
 	long o, n, t, z;
 
+	if (unlikely(!delta))
+		return;
+
 	do {
 		z = 0;  /* overflow to zone counters */
 
@@ -518,6 +527,9 @@ static inline void mod_zone_state(struct zone *zone,
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 			 long delta)
 {
+	if (unlikely(!delta))
+		return;
+
 	mod_zone_state(zone, item, delta, 0);
 }
 EXPORT_SYMBOL(mod_zone_page_state);
@@ -541,6 +553,9 @@ static inline void mod_node_state(struct pglist_data *pgdat,
 	s8 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
+	if (unlikely(!delta))
+		return;
+
 	do {
 		z = 0;  /* overflow to node counters */
 
@@ -604,6 +619,9 @@ void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
 {
 	unsigned long flags;
 
+	if (unlikely(!delta))
+		return;
+
 	local_irq_save(flags);
 	__mod_zone_page_state(zone, item, delta);
 	local_irq_restore(flags);
@@ -647,6 +665,9 @@ void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 {
 	unsigned long flags;
 
+	if (unlikely(!delta))
+		return;
+
 	local_irq_save(flags);
 	__mod_node_page_state(pgdat, item, delta);
 	local_irq_restore(flags);
-- 
2.18.4

