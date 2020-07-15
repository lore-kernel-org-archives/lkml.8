Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E69C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA9420674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGODV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:21:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7314 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgGODV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:21:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8EE9E172D7C581CD3E7;
        Wed, 15 Jul 2020 11:21:26 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 11:21:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <chris@chris-wilson.co.uk>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/i915: Remove unused inline function drain_delayed_work()
Date:   Wed, 15 Jul 2020 11:21:04 +0800
Message-ID: <20200715032104.32052-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not used since commit 058179e72e09 ("drm/i915/gt: Replace
hangcheck by heartbeats")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index b1c5955a52e1..54773371e6bd 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -266,19 +266,6 @@ static inline int list_is_last_rcu(const struct list_head *list,
 	return READ_ONCE(list->next) == head;
 }
 
-/*
- * Wait until the work is finally complete, even if it tries to postpone
- * by requeueing itself. Note, that if the worker never cancels itself,
- * we will spin forever.
- */
-static inline void drain_delayed_work(struct delayed_work *dw)
-{
-	do {
-		while (flush_delayed_work(dw))
-			;
-	} while (delayed_work_pending(dw));
-}
-
 static inline unsigned long msecs_to_jiffies_timeout(const unsigned int m)
 {
 	unsigned long j = msecs_to_jiffies(m);
-- 
2.17.1


