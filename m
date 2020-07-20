Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF3722CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261343;
	bh=cV5vFB3/El2GAgoC0rrFO8na4il1gFH8qOCX0BK2jQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qA4BWSllxPLZSOzk5fubDvEW/y9frvCqcdiwMoJj7wwq068BZWUf86s7U+IBrLmqw
	 RzQpBxjHs8mKxIW63uwdYpW0Mf5iFT9SkVOqHX3hKsQHyVuZAd50BBUocf4q7Rd+fU
	 vgRJqXKWYw46EsKKEwLzG5L9+ilFP+cAbTYF/ryQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgGTQJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387461AbgGTQI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7959206E9;
        Mon, 20 Jul 2020 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261337;
        bh=cV5vFB3/El2GAgoC0rrFO8na4il1gFH8qOCX0BK2jQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTT0U1gpWfieJgI9FVWk2DsJecbjKTtlC/qQuJJnQJuMRN7jqOQPKQ7cLFSb+R/Md
         KNfkbB4dwXqTwQiZejD4jVA2ywQTPIu+yzlidyjZbwBZhqcsJ7BVmNl3q/PPQcizSM
         ASfTLuKauH42ZcMpZzFh0JgYnt1C8bmEkYO9tO1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 039/244] blk-mq-debugfs: update blk_queue_flag_name[] accordingly for new flags
Date:   Mon, 20 Jul 2020 17:35:10 +0200
Message-Id: <20200720152827.715756531@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit bfe373f608cf81b7626dfeb904001b0e867c5110 ]

Else there may be magic numbers in /sys/kernel/debug/block/*/state.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-debugfs.c | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992d..121f4c1e0697b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -125,6 +125,9 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
+	QUEUE_FLAG_NAME(PCI_P2PDMA),
+	QUEUE_FLAG_NAME(ZONE_RESETALL),
+	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32868fbedc9e9..02809e4dd661e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -585,6 +585,7 @@ struct request_queue {
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
+/* Keep blk_queue_flag_name[] in sync with the definitions below */
 #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
-- 
2.25.1



