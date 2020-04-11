Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B0C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C021841
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607167;
	bh=du34FuSZ/93isxJl6ceSMUx6+clIj0/Chgs4FwB6Bf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02cVSaiKRK9U350P/3USRa7O8nB0hkR6JWq0jdt02BdhGCxvSEb2LHMQ5MsoXrXQ+
	 qG3z7oyH4khXSevMufqf51fdJmunXWM8JNYLQzGOEAX5tw1WZXvMksAbj1nlmZa9VH
	 hv2Dx1NKjdU8gNzd4dahoeHr6OjntaygrW6EyTEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgDKMMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgDKMMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:12:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B93216FD;
        Sat, 11 Apr 2020 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607163;
        bh=du34FuSZ/93isxJl6ceSMUx6+clIj0/Chgs4FwB6Bf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBup08jiylVsZc9KThzn2w7/3P6G8qThfKrirvyn/E/voRiJaxUU+iGjSVYpqq55h
         Kaw0nh/SfA2/+vjDTvLBp0jlufxetizMZ2fbjJJfu9gJEa2wHjAM8Ihyoc1J6Xivsp
         Ohopm0LURrwfAOjmmliilxRR+ZbAmnegRWFeHoeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.9 09/32] blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter
Date:   Sat, 11 Apr 2020 14:08:48 +0200
Message-Id: <20200411115419.710747345@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115418.455500023@linuxfoundation.org>
References: <20200411115418.455500023@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianchao Wang <jianchao.w.wang@oracle.com>

commit f5bbbbe4d63577026f908a809f22f5fd5a90ea1f upstream.

For blk-mq, part_in_flight/rw will invoke blk_mq_in_flight/rw to
account the inflight requests. It will access the queue_hw_ctx and
nr_hw_queues w/o any protection. When updating nr_hw_queues and
blk_mq_in_flight/rw occur concurrently, panic comes up.

Before update nr_hw_queues, the q will be frozen. So we could use
q_usage_counter to avoid the race. percpu_ref_is_zero is used here
so that we will not miss any in-flight request. The access to
nr_hw_queues and queue_hw_ctx in blk_mq_queue_tag_busy_iter are
under rcu critical section, __blk_mq_update_nr_hw_queues could use
synchronize_rcu to ensure the zeroed q_usage_counter to be globally
visible.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-tag.c |   14 +++++++++++++-
 block/blk-mq.c     |    4 ++++
 2 files changed, 17 insertions(+), 1 deletion(-)

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -336,6 +336,18 @@ void blk_mq_queue_tag_busy_iter(struct r
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	/*
+	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
+	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
+	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
+	 * synchronize_rcu to ensure all of the users go out of the critical
+	 * section below and see zeroed q_usage_counter.
+	 */
+	rcu_read_lock();
+	if (percpu_ref_is_zero(&q->q_usage_counter)) {
+		rcu_read_unlock();
+		return;
+	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
@@ -351,7 +363,7 @@ void blk_mq_queue_tag_busy_iter(struct r
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
-
+	rcu_read_unlock();
 }
 
 static unsigned int bt_unused_tags(const struct sbitmap_queue *bt)
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2346,6 +2346,10 @@ void blk_mq_update_nr_hw_queues(struct b
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
+	/*
+	 * Sync with blk_mq_queue_tag_busy_iter.
+	 */
+	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 


