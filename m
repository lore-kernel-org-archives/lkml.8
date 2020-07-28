Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D53C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4515820825
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595956285;
	bh=Wtdd2aggXUG2SrwcZacfye57yI4AkP3hAjgBPEBSse4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6OQKZeS0ZAe3wHlgQeGR6jwx/jF/PcmLxpoRquc1eaMSYincd1HsELVomKSwzl9Z
	 BZLgx9Trj0dDfclcPJwtlAJtlWBNjNxFWa0g6i5MBbDraC3glvuUodi9gIj46CWe2Q
	 zTKDqRapHPeVFZt+T3iUW76RPSbVaNJqOrwwTMYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgG1RLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731962AbgG1RLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:11:21 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B29207F5;
        Tue, 28 Jul 2020 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956280;
        bh=Wtdd2aggXUG2SrwcZacfye57yI4AkP3hAjgBPEBSse4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xnu1j6Gqw6ndNDJkvhznFHT9epfk5i65xB7LnGD8Lf4mZGStFxEIgnCnu/H1n0nGt
         8LTO4ZU5CG6vltPbiI5QrlJIhEh/KCIjQF7ww16WG1nM3qNn3bPlQHZINPV06xJ7Xm
         UJQUcrsS6VVxK3TV0xMs320uW7K4fybWda/rYQVU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/4] mm: mmu_notifier: Fix and extend kerneldoc
Date:   Tue, 28 Jul 2020 19:11:09 +0200
Message-Id: <20200728171109.28687-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728171109.28687-1-krzk@kernel.org>
References: <20200728171109.28687-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    mm/mmu_notifier.c:187: warning: Function parameter or member 'interval_sub' not described in 'mmu_interval_read_bgin'
    mm/mmu_notifier.c:708: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_registr'
    mm/mmu_notifier.c:708: warning: Excess function parameter 'mn' description in 'mmu_notifier_register'
    mm/mmu_notifier.c:880: warning: Function parameter or member 'subscription' not described in 'mmu_notifier_put'
    mm/mmu_notifier.c:880: warning: Excess function parameter 'mn' description in 'mmu_notifier_put'
    mm/mmu_notifier.c:982: warning: Function parameter or member 'ops' not described in 'mmu_interval_notifier_insert'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 mm/mmu_notifier.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 352bb9f3ecc0..4fc918163dd3 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -166,7 +166,7 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 /**
  * mmu_interval_read_begin - Begin a read side critical section against a VA
  *                           range
- * interval_sub: The interval subscription
+ * @interval_sub: The interval subscription
  *
  * mmu_iterval_read_begin()/mmu_iterval_read_retry() implement a
  * collision-retry scheme similar to seqcount for the VA range under
@@ -686,7 +686,7 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_register);
 
 /**
  * mmu_notifier_register - Register a notifier on a mm
- * @mn: The notifier to attach
+ * @subscription: The notifier to attach
  * @mm: The mm to attach the notifier to
  *
  * Must not hold mmap_lock nor any other VM related lock when calling
@@ -856,7 +856,7 @@ static void mmu_notifier_free_rcu(struct rcu_head *rcu)
 
 /**
  * mmu_notifier_put - Release the reference on the notifier
- * @mn: The notifier to act on
+ * @subscription: The notifier to act on
  *
  * This function must be paired with each mmu_notifier_get(), it releases the
  * reference obtained by the get. If this is the last reference then process
@@ -965,7 +965,8 @@ static int __mmu_interval_notifier_insert(
  * @interval_sub: Interval subscription to register
  * @start: Starting virtual address to monitor
  * @length: Length of the range to monitor
- * @mm : mm_struct to attach to
+ * @mm: mm_struct to attach to
+ * @ops: Interval notifier operations to be called on matching events
  *
  * This function subscribes the interval notifier for notifications from the
  * mm.  Upon return the ops related to mmu_interval_notifier will be called
-- 
2.17.1

