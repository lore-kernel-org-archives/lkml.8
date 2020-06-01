Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E90C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3274B2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035388;
	bh=k1KSta/3vdw5qQ+w7fTNyHhxxnXLrfa1sMq23MSUG0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7ux5ch3YPPPwWIedHjAFQ0laOZ0+5qHo0ZcpsrxwWw5sr7cwTbficHWeHtu1b/tt
	 PvjAXhPTReeTjuwFaVmWMfsdxFCfMVVy5+HSpHwpNoWIVhTodkhyME47ZwsAgCmh9N
	 COYODTztRil3Bu6KjGPDh7PLBUDUCSeDSd7ZjjTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgFASQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731696AbgFASQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:16:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7535D2065C;
        Mon,  1 Jun 2020 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035383;
        bh=k1KSta/3vdw5qQ+w7fTNyHhxxnXLrfa1sMq23MSUG0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X96IITNplZvPQjHAQmcugIbcjQH6vgvcoABEpRc18K2BM/ikokKSs399XedBn4jbB
         qzmRdqsuXteTiznb9vYa3Z+89HZ6s6Xtoe8D6PvwjlFUgynXlDjraPLm05Ty6ilrmH
         Ypk514BGrPbylFZ6hjpwcJXWeEtu3kYdHnHA9ap8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 136/177] Revert "block: end bio with BLK_STS_AGAIN in case of non-mq devs and REQ_NOWAIT"
Date:   Mon,  1 Jun 2020 19:54:34 +0200
Message-Id: <20200601174059.771446528@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit b0beb28097fa04177b3769f4bb7a0d0d9c4ae76e ]

This reverts commit c58c1f83436b501d45d4050fd1296d71a9760bcb.

io_uring does do the right thing for this case, and we're still returning
-EAGAIN to userspace for the cases we don't support. Revert this change
to avoid doing endless spins of resubmits.

Cc: stable@vger.kernel.org # v5.6
Reported-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 60dc9552ef8d..92232907605c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -885,14 +885,11 @@ generic_make_request_checks(struct bio *bio)
 	}
 
 	/*
-	 * Non-mq queues do not honor REQ_NOWAIT, so complete a bio
-	 * with BLK_STS_AGAIN status in order to catch -EAGAIN and
-	 * to give a chance to the caller to repeat request gracefully.
+	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
+	 * if queue is not a request based queue.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q)) {
-		status = BLK_STS_AGAIN;
-		goto end_io;
-	}
+	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
+		goto not_supported;
 
 	if (should_fail_bio(bio))
 		goto end_io;
-- 
2.25.1



