Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16BC2D0EE
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF34208E0
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgC1Qn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:29 -0400
Received: from mx.sdf.org ([205.166.94.20]:50188 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgC1QnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:20 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhDVT002162
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:13 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhDHv003972;
        Sat, 28 Mar 2020 16:43:13 GMT
Message-Id: <202003281643.02SGhDHv003972@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Mon, 18 Mar 2019 06:56:55 -0400
Subject: [RFC PATCH v1 16/50] include/net/red.h: Simplify red_random() TO BE
 VERIFIED
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Nogah Frankel <nogahf@mellanox.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Aruna-Hewapathirane <aruna.hewapathirane@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code goes to some trouble to optimize the
computation of prandom_u32()/(p->max_P/p->qth_delta).

But given that the first division is already an approximation,
there's no need for the fiddly shifting included in
reciprocal_divide().  Just compute p->qth_delta / p->max_P
and do a 32-bit multiply and 32-bit shift.

This code is subtle, so I'm not certain I didn't break
something; review definitely appreciated!

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Nogah Frankel <nogahf@mellanox.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Aruna-Hewapathirane <aruna.hewapathirane@gmail.com>
---
 include/net/red.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/red.h b/include/net/red.h
index 9665582c4687e..a357ddb227433 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -131,8 +131,7 @@ struct red_parms {
 	u32		qth_max;	/* Max avg length threshold: Wlog scaled */
 	u32		Scell_max;
 	u32		max_P;		/* probability, [0 .. 1.0] 32 scaled */
-	/* reciprocal_value(max_P / qth_delta) */
-	struct reciprocal_value	max_P_reciprocal;
+	u32		delta_max_p;	/* (qth_delta << 32) / max_P */
 	u32		qth_delta;	/* max_th - min_th */
 	u32		target_min;	/* min_th + 0.4*(max_th - min_th) */
 	u32		target_max;	/* min_th + 0.6*(max_th - min_th) */
@@ -184,7 +183,6 @@ static inline void red_set_parms(struct red_parms *p,
 				 u8 Scell_log, u8 *stab, u32 max_P)
 {
 	int delta = qth_max - qth_min;
-	u32 max_p_delta;
 
 	p->qth_min	= qth_min << Wlog;
 	p->qth_max	= qth_max << Wlog;
@@ -198,9 +196,10 @@ static inline void red_set_parms(struct red_parms *p,
 		max_P *= delta; /* max_P = (qth_max - qth_min)/2^Plog */
 	}
 	p->max_P = max_P;
-	max_p_delta = max_P / delta;
-	max_p_delta = max(max_p_delta, 1U);
-	p->max_P_reciprocal  = reciprocal_value(max_p_delta);
+	if (delta >= max_P)
+		p->delta_max_p = 0xffffffff;
+	else
+		p->delta_max_p = DIV_ROUND_CLOSEST_ULL((u64)delta << 32, max_P);
 
 	/* RED Adaptative target :
 	 * [min_th + 0.4*(min_th - max_th),
@@ -316,7 +315,7 @@ static inline unsigned long red_calc_qavg(const struct red_parms *p,
 
 static inline u32 red_random(const struct red_parms *p)
 {
-	return reciprocal_divide(prandom_u32(), p->max_P_reciprocal);
+	return reciprocal_scale(prandom_u32(), p->delta_max_p);
 }
 
 static inline int red_mark_probability(const struct red_parms *p,
@@ -397,7 +396,6 @@ static inline int red_action(const struct red_parms *p,
 static inline void red_adaptative_algo(struct red_parms *p, struct red_vars *v)
 {
 	unsigned long qavg;
-	u32 max_p_delta;
 
 	qavg = v->qavg;
 	if (red_is_idling(v))
@@ -411,8 +409,10 @@ static inline void red_adaptative_algo(struct red_parms *p, struct red_vars *v)
 	else if (qavg < p->target_min && p->max_P >= MAX_P_MIN)
 		p->max_P = (p->max_P/10)*9; /* maxp = maxp * Beta */
 
-	max_p_delta = DIV_ROUND_CLOSEST(p->max_P, p->qth_delta);
-	max_p_delta = max(max_p_delta, 1U);
-	p->max_P_reciprocal = reciprocal_value(max_p_delta);
+	if (p->qth_delta >= p->max_P)
+		p->delta_max_p = 0xffffffff;
+	else
+		p->delta_max_p = DIV_ROUND_CLOSEST_ULL((u64)p->qth_delta << 32,
+						       p->max_P);
 }
 #endif
-- 
2.26.0

