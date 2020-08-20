Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59857C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D28C22CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916643;
	bh=H45zlV34uzWv6yFUOSzT/yKhOvpoCRwwr64AGhO37eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vdCaPv/guYq5xAvtjKvS90TL/iW2OcR9RIflAtoFQoC9uw6P6bjefknMyqYPM+ltW
	 F5byZKUBkgfxGjuoMIPCgVwDOgvIdE+kFsq9Zb2o0cxmmo3FDWzMudo2vLYCafyRba
	 PU05AhEpxro8Kpt56e3dSgCug+YeCVNNusHZgplw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgHTJoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgHTJmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C13D207DE;
        Thu, 20 Aug 2020 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916528;
        bh=H45zlV34uzWv6yFUOSzT/yKhOvpoCRwwr64AGhO37eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Jnnb5sLx+yIPGzzYLUNFanOxgekbz9EpwxMS2d45DCpCKYjf1rHJayG4YddFSLjl
         Cc71HLJIpKDAfhJgbENY2umHi0t6G+wsE+gv+1MG6L8Zps3Nh2epmF6tOkPnBcIeZc
         53PbDfbXsSLVeD5OOvFstRKGritpl++bFJld2zXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 130/204] dm rq: dont call blk_mq_queue_stopped() in dm_stop_queue()
Date:   Thu, 20 Aug 2020 11:20:27 +0200
Message-Id: <20200820091612.774929636@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit e766668c6cd49d741cfb49eaeb38998ba34d27bc ]

dm_stop_queue() only uses blk_mq_quiesce_queue() so it doesn't
formally stop the blk-mq queue; therefore there is no point making the
blk_mq_queue_stopped() check -- it will never be stopped.

In addition, even though dm_stop_queue() actually tries to quiesce hw
queues via blk_mq_quiesce_queue(), checking with blk_queue_quiesced()
to avoid unnecessary queue quiesce isn't reliable because: the
QUEUE_FLAG_QUIESCED flag is set before synchronize_rcu() and
dm_stop_queue() may be called when synchronize_rcu() from another
blk_mq_quiesce_queue() is in-progress.

Fixes: 7b17c2f7292ba ("dm: Fix a race condition related to stopping and starting queues")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-rq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 3f8577e2c13be..2bd2444ad99c6 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -70,9 +70,6 @@ void dm_start_queue(struct request_queue *q)
 
 void dm_stop_queue(struct request_queue *q)
 {
-	if (blk_mq_queue_stopped(q))
-		return;
-
 	blk_mq_quiesce_queue(q);
 }
 
-- 
2.25.1



