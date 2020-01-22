Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAB524688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699317;
	bh=pLeF0alBcThh37xBzLw7dVki1tgMbE2L/olH00haWf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RUjKRxqKgKM7xT9s84YlluvTRETktuX5+j5HAjd0WyAK348D3LIcgEbo0xSY2zmx+
	 NfB0JsZ5aCvvb1oeFuw2WxrZeT5xI1N1+zXzEyaKm2yveIbR34gdSXHzGDbIvFi7es
	 BOnKFHiKsYn5FPCEXBFPcq4jbLb/or+c7oCJRhnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgAVNV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbgAVNVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:54 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0474C2467C;
        Wed, 22 Jan 2020 13:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699313;
        bh=pLeF0alBcThh37xBzLw7dVki1tgMbE2L/olH00haWf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4Izd10p9XjH29Rd+/EhVUavam7sJy5IHilvW84RUr/YHTTUYRhzFIib2xBZ+/eEi
         BF/77HYx0ODl4a5irPP6BNyKmknnct0inFUxQc2RpVcFVmZq04cXDPG3JRTE6mAlR3
         4weAutaEQ1rO4/R1kV35chAeioGH1JGLPaSNj6/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Wilck <mwilck@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 105/222] block: Fix the type of sts in bsg_queue_rq()
Date:   Wed, 22 Jan 2020 10:28:11 +0100
Message-Id: <20200122092841.257085936@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

commit c44a4edb20938c85b64a256661443039f5bffdea upstream.

This patch fixes the following sparse warnings:

block/bsg-lib.c:269:19: warning: incorrect type in initializer (different base types)
block/bsg-lib.c:269:19:    expected int sts
block/bsg-lib.c:269:19:    got restricted blk_status_t [usertype]
block/bsg-lib.c:286:16: warning: incorrect type in return expression (different base types)
block/bsg-lib.c:286:16:    expected restricted blk_status_t
block/bsg-lib.c:286:16:    got int [assigned] sts

Cc: Martin Wilck <mwilck@suse.com>
Fixes: d46fe2cb2dce ("block: drop device references in bsg_queue_rq()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bsg-lib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -266,7 +266,7 @@ static blk_status_t bsg_queue_rq(struct
 	struct request *req = bd->rq;
 	struct bsg_set *bset =
 		container_of(q->tag_set, struct bsg_set, tag_set);
-	int sts = BLK_STS_IOERR;
+	blk_status_t sts = BLK_STS_IOERR;
 	int ret;
 
 	blk_mq_start_request(req);


