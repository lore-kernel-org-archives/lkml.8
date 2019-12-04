Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77BC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F85D206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgC1Qnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:43:43 -0400
Received: from mx.sdf.org ([205.166.94.20]:50097 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbgC1Qn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:27 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGh6Cr021330
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:07 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGh6ii026355;
        Sat, 28 Mar 2020 16:43:06 GMT
Message-Id: <202003281643.02SGh6ii026355@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Wed, 4 Dec 2019 00:25:58 -0500
Subject: [RFC PATCH v1 02/50] lib/fault-inject.c: Fix off-by-one error in probability
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Anton Blanchard <anton@samba.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the combination of two fixes.  First, use prandom_u32_max() for
efficiency:
-	if (attr->probability <= prandom_u32() % 100)
+	if (attr->probability <= prandom_u32_max(100))
 		return false

And then a bug-fix:
-	if (attr->probability <= prandom_u32_max(100))
+	if (attr->probability < prandom_u32_max(100))
 		return false

Before, probability = 1 would succeed 2% of the time and 99 would
succeed 100% of the time.  (0% was caught by an earlier test.)

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Anton Blanchard <anton@samba.org>
---
 lib/fault-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index 8186ca84910bc..e20151fa5515e 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -134,7 +134,7 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 			return false;
 	}
 
-	if (attr->probability <= prandom_u32() % 100)
+	if (attr->probability < prandom_u32_max(100))
 		return false;
 
 	if (!fail_stacktrace(attr))
-- 
2.26.0

