Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52390C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B07D24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844212;
	bh=DHTj3iipJvYk0j9FXVjxikfNzEUz/kACux+D0gu+MPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OfNfOVbu1eXHxywOtiDogFi5txpUsRpODJjJrrdSzjeFvQWD31kWtBm5eqe/wIgUe
	 VavsUfMbr0obiDGWfctOKV8b8yRbMrX4buLWETqGmTvaXepFDmPuuxCzuyfi4YRTs6
	 xgUFHwDmj/blAaeP8ny6vZU4DZlfWVOf9JJ/OMH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgCJMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbgCJMn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3525224695;
        Tue, 10 Mar 2020 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844207;
        bh=DHTj3iipJvYk0j9FXVjxikfNzEUz/kACux+D0gu+MPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBlm39wEeyiRJVehaF1QCQ15URBqBSxtRPU0SQN/NlNEDfea7mSufnXew6+pNtTXM
         u0Bm004vlpb89rcfDWtTQKkCD41sbzXPqSF7r/z7SaE9oppiQJiAFviUMDT136Zrui
         46jJlwKRkQI7WqmKWBZpN8dZgMIgU2elZhsTsKtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 71/72] dm cache: fix a crash due to incorrect work item cancelling
Date:   Tue, 10 Mar 2020 13:39:24 +0100
Message-Id: <20200310123619.207004558@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 7cdf6a0aae1cccf5167f3f04ecddcf648b78e289 upstream.

The crash can be reproduced by running the lvm2 testsuite test
lvconvert-thin-external-cache.sh for several minutes, e.g.:
  while :; do make check T=shell/lvconvert-thin-external-cache.sh; done

The crash happens in this call chain:
do_waker -> policy_tick -> smq_tick -> end_hotspot_period -> clear_bitset
-> memset -> __memset -- which accesses an invalid pointer in the vmalloc
area.

The work entry on the workqueue is executed even after the bitmap was
freed. The problem is that cancel_delayed_work doesn't wait for the
running work item to finish, so the work item can continue running and
re-submitting itself even after cache_postsuspend. In order to make sure
that the work item won't be running, we must use cancel_delayed_work_sync.

Also, change flush_workqueue to drain_workqueue, so that if some work item
submits itself or another work item, we are properly waiting for both of
them.

Fixes: c6b4fcbad044 ("dm: add cache target")
Cc: stable@vger.kernel.org # v3.9
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-target.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2193,8 +2193,8 @@ static void wait_for_migrations(struct c
 
 static void stop_worker(struct cache *cache)
 {
-	cancel_delayed_work(&cache->waker);
-	flush_workqueue(cache->wq);
+	cancel_delayed_work_sync(&cache->waker);
+	drain_workqueue(cache->wq);
 }
 
 static void requeue_deferred_cells(struct cache *cache)


