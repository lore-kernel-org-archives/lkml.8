Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3266C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746CB2245C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597677772;
	bh=3youlaf6F0AG1XD7iY9/Et/KXihs076n7ArGrIQ9mB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rMK75/37p9X4wyC5J8Kn6S35XVDzbAwxhJNLGJPfHR/WtUHkPK/PXOUiwSLaWus21
	 8lILQWskmbSmgHyOsPF05lRDYqxVvDqVSGHgzrCvFcSP14iqRCJ6UmEasje9vVJ0bB
	 OP7mkboSNXMIopXZuOJBvWD3Hsc9PxG+SRvJ8+EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgHQPWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgHQPWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:22:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278F820885;
        Mon, 17 Aug 2020 15:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677719;
        bh=3youlaf6F0AG1XD7iY9/Et/KXihs076n7ArGrIQ9mB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4WOrPjfbpw+dHYo/F6tCkdn6tNKE2PKbJ7Iru//nPmK1CVrKqiE81/nXNBt2KCRA
         3a15oUYvKlMMEExUWparBcpt5KCEWWPYV9qpd4+mE6s67XqIFaEsrsdpd7fRsei04V
         IZfTNSMA2BPO4qAL12RmlUp24d5dUEwqrxgDFI2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 082/464] loop: be paranoid on exit and prevent new additions / removals
Date:   Mon, 17 Aug 2020 17:10:35 +0200
Message-Id: <20200817143837.710221680@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit 200f93377220504c5e56754823e7adfea6037f1a ]

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 475e1a738560d..776083963ee6c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2402,6 +2402,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2409,6 +2411,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1



