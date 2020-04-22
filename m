Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065EBC5518F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14BF2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552328;
	bh=EMQFBZd/o/wVk1UPIuwifXdCv5bHQAgdbB6BPa+Uwws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M98gnrsJgbRZJXCrr+g9Y/GZ4G05P9/ynKiERdL5tCTWpHSgjmoL7fVJ4snvzY77n
	 bbUYI7Gsl3OzHQoyeVuQscQ15cjFU6tdWXayIjQD2I1xOdo5UGAIZIVUsAV+QnL5iT
	 SCWws8aR/BOeiD6/NjmsXkGU9xuczvxxuH5KOiX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgDVKSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729806AbgDVKRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E376E2076B;
        Wed, 22 Apr 2020 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550630;
        bh=EMQFBZd/o/wVk1UPIuwifXdCv5bHQAgdbB6BPa+Uwws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmvfXzU+5FSQzYoUFRzPKXvhrvIq1rTbzgZ5PrtL0FpZd5Ut+a8z3FDD5jPv9bRUz
         PktFLDQilNZWqh1ipajq+OwP73jKdJWhQowpqkGeujedYQpOzVHwOqnDaLUhvltwnV
         a8/m7nmrD8P7RlwOp4lIymcPOhTQU/oq7wV19Ng8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, cki-project@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 029/118] block, bfq: turn put_queue into release_process_ref in __bfq_bic_change_cgroup
Date:   Wed, 22 Apr 2020 11:56:30 +0200
Message-Id: <20200422095036.658767293@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

commit c8997736650060594845e42c5d01d3118aec8d25 upstream.

A bfq_put_queue() may be invoked in __bfq_bic_change_cgroup(). The
goal of this put is to release a process reference to a bfq_queue. But
process-reference releases may trigger also some extra operation, and,
to this goal, are handled through bfq_release_process_ref(). So, turn
the invocation of bfq_put_queue() into an invocation of
bfq_release_process_ref().

Tested-by: cki-project@redhat.com
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bfq-cgroup.c  |    5 +----
 block/bfq-iosched.c |    2 --
 block/bfq-iosched.h |    1 +
 3 files changed, 2 insertions(+), 6 deletions(-)

--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -697,10 +697,7 @@ static struct bfq_group *__bfq_bic_chang
 
 		if (entity->sched_data != &bfqg->sched_data) {
 			bic_set_bfqq(bic, NULL, 0);
-			bfq_log_bfqq(bfqd, async_bfqq,
-				     "bic_change_group: %p %d",
-				     async_bfqq, async_bfqq->ref);
-			bfq_put_queue(async_bfqq);
+			bfq_release_process_ref(bfqd, async_bfqq);
 		}
 	}
 
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2717,8 +2717,6 @@ static void bfq_bfqq_save_state(struct b
 	}
 }
 
-
-static
 void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	/*
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -950,6 +950,7 @@ void bfq_bfqq_expire(struct bfq_data *bf
 		     bool compensate, enum bfqq_expiration reason);
 void bfq_put_queue(struct bfq_queue *bfqq);
 void bfq_end_wr_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
+void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 void bfq_schedule_dispatch(struct bfq_data *bfqd);
 void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 


