Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE161C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D928208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846020;
	bh=B+1AQMH6VDQXqLliH1g7u6fiebVF899B+kyVEXJ9Rag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYO38rlqp4CZhmiQ650qgZ6dxoBV7AVyLyoGLH/vxJT/8h5DDhJLAQ7V2SUXa+ZWM
	 D74s7wxHSG3nILqAggMRMqPBws9Wf1W55et3DV5QqFoJYG4VzcVQNjjQJuaUK4Dnrc
	 Oqya4YjhXVapfykL09uNbZI7k6ct5SCkpMRTbcSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgCJNNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731721AbgCJNNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:13:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA3B2468C;
        Tue, 10 Mar 2020 13:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846015;
        bh=B+1AQMH6VDQXqLliH1g7u6fiebVF899B+kyVEXJ9Rag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBTheS0od/pE9PbqV9Ywhq+IbvYOg1fD89scI2GcbgdDR7Z/ar3Kj6E2B+Iwp5KEB
         AYJND64FF1i/cPL7e7m5P4e4yuNm9r8T4joF/5IkglNGJvaMU1XJDndrFjXMz1lT5/
         3XHZAD2S4Xts7ndU3zmRBsnK0MwemtSnUAV5HGOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 55/86] dm cache: fix a crash due to incorrect work item cancelling
Date:   Tue, 10 Mar 2020 13:45:19 +0100
Message-Id: <20200310124533.764679419@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
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
@@ -2859,8 +2859,8 @@ static void cache_postsuspend(struct dm_
 	prevent_background_work(cache);
 	BUG_ON(atomic_read(&cache->nr_io_migrations));
 
-	cancel_delayed_work(&cache->waker);
-	flush_workqueue(cache->wq);
+	cancel_delayed_work_sync(&cache->waker);
+	drain_workqueue(cache->wq);
 	WARN_ON(cache->tracker.in_flight);
 
 	/*


