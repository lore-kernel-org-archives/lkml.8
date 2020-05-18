Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3518E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826638;
	bh=tBs33K+uNGXDzZgMYrAIoeato9mMKDEaIncgrf6We24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ofBIPOgr9mikvMSr4ZbqTw170HVp9Si6KSy5FPwZAbwdtKvJ5NG7XwNiUKWWW9ocS
	 rUUyDaLP8skjX2fStey+7zmJtG1mdvoMdWhB+Gu13fuZaVq96hln1zBVbaE5IAw8of
	 mOK174GMENzgnBta4fDPl7kCQBXlpC0pcVa8QMt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgERSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgERRkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E193020657;
        Mon, 18 May 2020 17:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823645;
        bh=tBs33K+uNGXDzZgMYrAIoeato9mMKDEaIncgrf6We24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2GVlOLAyy383m3BIlrg/LnEiRLL6weAFmMb1BPopgoEkZv2fofhU5S98HGlBeTq/
         sbMN6iOlWpHZDkFhars24fVhV+/5IPpEvVCKYtRkxt58wxxUFgNnh/dB0jqeTvcSNC
         uGw+l4EY5zGymPFinUFFLHO0ucAp8Q6F4phaidhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Giuliano Procida <gprocida@google.com>
Subject: [PATCH 4.4 66/86] blk-mq: Allow blocking queue tag iter callbacks
Date:   Mon, 18 May 2020 19:36:37 +0200
Message-Id: <20200518173503.689982128@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

commit 530ca2c9bd6949c72c9b5cfc330cb3dbccaa3f5b upstream.

A recent commit runs tag iterator callbacks under the rcu read lock,
but existing callbacks do not satisfy the non-blocking requirement.
The commit intended to prevent an iterator from accessing a queue that's
being modified. This patch fixes the original issue by taking a queue
reference instead of reading it, which allows callbacks to make blocking
calls.

Fixes: f5bbbbe4d6357 ("blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter")
Acked-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Giuliano Procida <gprocida@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq-tag.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -484,11 +484,8 @@ void blk_mq_queue_tag_busy_iter(struct r
 	/*
 	 * Avoid potential races with things like queue removal.
 	 */
-	rcu_read_lock();
-	if (percpu_ref_is_zero(&q->q_usage_counter)) {
-		rcu_read_unlock();
+	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
-	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
@@ -505,7 +502,7 @@ void blk_mq_queue_tag_busy_iter(struct r
 		bt_for_each(hctx, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
 		      false);
 	}
-	rcu_read_unlock();
+	blk_queue_exit(q);
 }
 
 static unsigned int bt_unused_tags(struct blk_mq_bitmap_tags *bt)


