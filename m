Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B65C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41752073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551874;
	bh=diEZJSbSIO+MnsYSZTyrg2M3dM6CyjSD/7Ket4healQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KvSrZih0c5JJH4z9PWptzdlQFgWibBigVLw9Fgtv88UvvFFSYfNaKCPFZzCAqfT6c
	 ehB7T3Zawtl14g/Vexk22dTxDKd3yaEYVRKLFNammtVpUx8uWXFqrGX9pjwC+JLAxm
	 PeTEyBi7SytGbchIltldkfVfrSk2aNAahCK5Jeo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbgDVKhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbgDVKWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:22:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E6D215A4;
        Wed, 22 Apr 2020 10:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550943;
        bh=diEZJSbSIO+MnsYSZTyrg2M3dM6CyjSD/7Ket4healQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5S7A6OjCjHt2Xt19ej47wT3qHZS+Z14XJDksI0JQa/O+f3pG1AORGqUsOH88EjZP
         vHowtEB4oLlN3kZCOc4/538jUGOYl/JM1CfWaq0ed6elIAYD0XjVkMUcfTLG5mnIyX
         ZDiuH2ZkMo37aqOAU9KZ3R5nGY0GCUtu/bJrVd2Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, cki-project@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.6 038/166] block, bfq: invoke flush_idle_tree after reparent_active_queues in pd_offline
Date:   Wed, 22 Apr 2020 11:56:05 +0200
Message-Id: <20200422095052.959030321@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

commit 4d38a87fbb77fb9ff2ff4e914162a8ae6453eff5 upstream.

In bfq_pd_offline(), the function bfq_flush_idle_tree() is invoked to
flush the rb tree that contains all idle entities belonging to the pd
(cgroup) being destroyed. In particular, bfq_flush_idle_tree() is
invoked before bfq_reparent_active_queues(). Yet the latter may happen
to add some entities to the idle tree. It happens if, in some of the
calls to bfq_bfqq_move() performed by bfq_reparent_active_queues(),
the queue to move is empty and gets expired.

This commit simply reverses the invocation order between
bfq_flush_idle_tree() and bfq_reparent_active_queues().

Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-cgroup.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -894,13 +894,6 @@ static void bfq_pd_offline(struct blkg_p
 		st = bfqg->sched_data.service_tree + i;
 
 		/*
-		 * The idle tree may still contain bfq_queues belonging
-		 * to exited task because they never migrated to a different
-		 * cgroup from the one being destroyed now.
-		 */
-		bfq_flush_idle_tree(st);
-
-		/*
 		 * It may happen that some queues are still active
 		 * (busy) upon group destruction (if the corresponding
 		 * processes have been forced to terminate). We move
@@ -913,6 +906,19 @@ static void bfq_pd_offline(struct blkg_p
 		 * scheduler has taken no reference.
 		 */
 		bfq_reparent_active_queues(bfqd, bfqg, st, i);
+
+		/*
+		 * The idle tree may still contain bfq_queues
+		 * belonging to exited task because they never
+		 * migrated to a different cgroup from the one being
+		 * destroyed now. In addition, even
+		 * bfq_reparent_active_queues() may happen to add some
+		 * entities to the idle tree. It happens if, in some
+		 * of the calls to bfq_bfqq_move() performed by
+		 * bfq_reparent_active_queues(), the queue to move is
+		 * empty and gets expired.
+		 */
+		bfq_flush_idle_tree(st);
 	}
 
 	__bfq_deactivate_entity(entity, false);


