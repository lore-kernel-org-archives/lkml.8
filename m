Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0336BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D827A2074F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgC1QnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:22 -0400
Received: from mx.sdf.org ([205.166.94.20]:50209 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgC1QnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:20 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhDDT006033
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:13 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhDXl006621;
        Sat, 28 Mar 2020 16:43:13 GMT
Message-Id: <202003281643.02SGhDXl006621@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 17:44:31 -0500
Subject: [RFC PATCH v1 17/50] net/802/{garp,mrp}.c: Use prandom_u32_max
 instead of manual equivalent
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Aruna-Hewapathirane <aruna.hewapathirane@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous code was carefully written for efficiency, which is
good, but the helper function is more legible.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Aruna-Hewapathirane <aruna.hewapathirane@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
---
 net/802/garp.c | 2 +-
 net/802/mrp.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/802/garp.c b/net/802/garp.c
index 400bd857e5f57..84a82d1b9ed59 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -394,7 +394,7 @@ static void garp_join_timer_arm(struct garp_applicant *app)
 {
 	unsigned long delay;
 
-	delay = (u64)msecs_to_jiffies(garp_join_time) * prandom_u32() >> 32;
+	delay = prandom_u32_max(msecs_to_jiffies(garp_join_time));
 	mod_timer(&app->join_timer, jiffies + delay);
 }
 
diff --git a/net/802/mrp.c b/net/802/mrp.c
index bea6e43d45a0d..bed550772aeb5 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -579,7 +579,7 @@ static void mrp_join_timer_arm(struct mrp_applicant *app)
 {
 	unsigned long delay;
 
-	delay = (u64)msecs_to_jiffies(mrp_join_time) * prandom_u32() >> 32;
+	delay = prandom_u32_max(msecs_to_jiffies(mrp_join_time));
 	mod_timer(&app->join_timer, jiffies + delay);
 }
 
-- 
2.26.0

