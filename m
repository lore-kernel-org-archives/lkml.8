Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53C8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91BA20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920626;
	bh=ZoPGPLTd1tfoBBhnHsu+QRKUDzo43J4+2465GGUq1aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpDqGuBrhHoPc0GKCJkm0CRLcM/3OadRuuUEb/2ghc5Xo3T5AEKaBaamVe63+U3z0
	 LioC2zlyiAFVCernDb/Jol3z6gl1NuGxFfoEMMN3pYVJv7plA+tyy31ncMSdf/IbAU
	 guKh33nEiEeH6SMpFQYTmg5QnTLYRSh45e17e0Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgHTKuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731248AbgHTKPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:15:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B90206DA;
        Thu, 20 Aug 2020 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918521;
        bh=ZoPGPLTd1tfoBBhnHsu+QRKUDzo43J4+2465GGUq1aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu6tVAoP18JO/+/dWy9aaEYtgUxiTQmNCfw0Fm3ee9ssVEXUQ4hmdKFRchrVhdE4/
         dFHjB7hqiaVRJF8yCpZDR/Nz6+dF5F12w4CbQlLKzJv7le+Moi3f7C/q2OLkrXEJDA
         n8ULCkVeXDwQdchPIsYeW53BVIPXfZgF8vd3OnIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 201/228] dm rq: dont call blk_mq_queue_stopped() in dm_stop_queue()
Date:   Thu, 20 Aug 2020 11:22:56 +0200
Message-Id: <20200820091617.596300473@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index eadfcfd106fff..cac8ec16e6031 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -95,9 +95,6 @@ static void dm_old_stop_queue(struct request_queue *q)
 
 static void dm_mq_stop_queue(struct request_queue *q)
 {
-	if (blk_mq_queue_stopped(q))
-		return;
-
 	blk_mq_quiesce_queue(q);
 }
 
-- 
2.25.1



