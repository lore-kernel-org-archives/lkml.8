Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CE6C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A9D2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgC1Qo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:56 -0400
Received: from mx.sdf.org ([205.166.94.20]:49876 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgC1Qnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:55 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhIZ2029371
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhI3G001046;
        Sat, 28 Mar 2020 16:43:18 GMT
Message-Id: <202003281643.02SGhI3G001046@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 17:10:04 -0500
Subject: [RFC PATCH v1 30/50] kernel/locking/test-ww_mutex.c: Use cheaper
 prandom_u32_max()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is test code; it doesn't need crypto-quality random numbers.

Also use the simpler initialize-while-shuffling variant of the
Fisher-Yates shuffle in get_random_order().

(It's not clear that we need the order[] array at all.
Could we just shuffle the stress->locks array directly?)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 3e82f449b4ff7..3fc54d88eb842 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -348,25 +348,18 @@ struct stress {
 
 static int *get_random_order(int count)
 {
-	int *order;
-	int n, r, tmp;
+	int n, *order;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
-	if (!order)
+	if (!order || !count)
 		return order;
 
-	for (n = 0; n < count; n++)
-		order[n] = n;
-
-	for (n = count - 1; n > 1; n--) {
-		r = get_random_int() % (n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+	order[0] = 0;
+	for (n = 1; n < count; n++) {
+		int r = prandom_u32_max(n+1);
+		order[n] = order[r];
+		order[r] = n;
 	}
-
 	return order;
 }
 
@@ -498,7 +491,7 @@ static void stress_one_work(struct work_struct *work)
 {
 	struct stress *stress = container_of(work, typeof(*stress), work);
 	const int nlocks = stress->nlocks;
-	struct ww_mutex *lock = stress->locks + (get_random_int() % nlocks);
+	struct ww_mutex *lock = stress->locks + prandom_u32_max(nlocks);
 	int err;
 
 	do {
-- 
2.26.0

