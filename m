Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4244C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE22C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846750;
	bh=Ne+Rbl+wF0k1lMl/aPemFvLHXKkrkdgmlb5C+qtk2yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sA/zbpaYITR8i2zvxh9Sik4yCyvi5BCOaWrXPVKQW5BfkYdy0MGODT1LveQFlDS99
	 zTfviMyTLsNM2ePdASBUcq+AAIXHTP87LCWcMhENiqC8hvPABLswKVxT1gkbNJLz1u
	 OC4dYyCaVFgMt3rCe4aAhGz/LQop0VBSL9OPJ0Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCJM45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbgCJM4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:56:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 654C02468D;
        Tue, 10 Mar 2020 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845011;
        bh=Ne+Rbl+wF0k1lMl/aPemFvLHXKkrkdgmlb5C+qtk2yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AMD+S7040woPqoFipSLqMTwVDBxs9nPw51gg+w2kZJc75DwK5mLisDhTUfJFNedO0
         vcGlUbD+Iqn45uBiMmqIpJdc+nqYPEM8aaqXOr1hbAq2OvMtOF7WMNvi6bDMc3KJsO
         QuyHm5wfA1fpPoaj4RZKuwVXF5f5B/jvkfd3jkj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Evich <cevich@redhat.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 003/189] block, bfq: get extra ref to prevent a queue from being freed during a group move
Date:   Tue, 10 Mar 2020 13:37:20 +0100
Message-Id: <20200310123639.929399082@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit ecedd3d7e19911ab8fe42f17b77c0a30fe7f4db3 ]

In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
may happen to be deactivated in the scheduling data structures of the
source group (and then activated in the destination group). If Q is
referred only by the data structures in the source group when the
deactivation happens, then Q is freed upon the deactivation.

This commit addresses this issue by getting an extra reference before
the possible deactivation, and releasing this extra reference after Q
has been moved.

Tested-by: Chris Evich <cevich@redhat.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e7919e76a27c2..db2a14215aeea 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
+	/*
+	 * get extra reference to prevent bfqq from being freed in
+	 * next possible deactivate
+	 */
+	bfqq->ref++;
+
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
@@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
+	/* release extra ref taken above */
+	bfq_put_queue(bfqq);
 }
 
 /**
-- 
2.20.1



