Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D15BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B882E21744
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915854;
	bh=vUMlRPXZX8LWcxjNTSMNJN5QyXqT7sG8LtdI37FiEJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvFytSWBOAyBLInhQ3yiBkYHP4XPu1cxmlesea6YEyFXlKSVqIA3jvJPm8xl5/zqL
	 zD7bb9sKYgxq8ifbwXfSS2eRh5k1d1HRqOS9JMcEXGDr4NJGVjX7yhrR4l0hZpjTMN
	 xdqobMS7Who7wdkoMg/O+SSp/3dX0rgkBM5Ptf04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHTJau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbgHTJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1FDE20855;
        Thu, 20 Aug 2020 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915830;
        bh=vUMlRPXZX8LWcxjNTSMNJN5QyXqT7sG8LtdI37FiEJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjYlkHjqXdGJd7msDAHoN3DUSE8fAYDzdgIkBYVpjR8JdhpxQcK+I+x5nY6jXSLEB
         fwR6iCgNqMUm1aMaZc6Rhm/8UCrto3KvBCyON83H5DHvVUscJVHzSMndybc/EjgEKC
         890j0+aRWwClrCh5Yep4Kbyg4mClPolAv82EUmwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 148/232] dm rq: dont call blk_mq_queue_stopped() in dm_stop_queue()
Date:   Thu, 20 Aug 2020 11:19:59 +0200
Message-Id: <20200820091619.981973887@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
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
index 85e0daabad49c..20745e2e34b94 100644
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



