Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3DDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0CD21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587043627;
	bh=oj+XMYejkYfYV1Q101OcM0l/io3atrU26NDGuzee03E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIxdqQvHrqFdMBaBDFqZiM4a1iYSnUz9B8c+dS35+keQjv7/GDZdHD4+7XuAMh4DM
	 626gfomwxYtjqpB9rOCCQ1Jt1eJFOVgYzJHXUl33kNtJn1mYzBuhuJnKoBdPxUNRDf
	 WIZDNNif9Q0QeokM76XseYUAhhxuIpW+k20AvpXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895341AbgDPN1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895261AbgDPN0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:26:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F48A21D82;
        Thu, 16 Apr 2020 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043579;
        bh=oj+XMYejkYfYV1Q101OcM0l/io3atrU26NDGuzee03E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQaZLXbirB8QTTptARSWFhMT8KNHbL5/7YNGdhou5Jf0TKrhcFpcUf873xWZ34QKU
         Kk/z2wh3OHzZ5uZlULH5JelTDdbiJKS5Leq9uN9QPj4H8jaoEQ1A78SZh0Jk4G/PRc
         mETYyur+cT6TzrETu4iT3hdLQ3rw2DFeTL03qR6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Alexey Dobriyan (SK hynix)" <adobriyan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 015/146] null_blk: fix spurious IO errors after failed past-wp access
Date:   Thu, 16 Apr 2020 15:22:36 +0200
Message-Id: <20200416131244.597812857@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit ff77042296d0a54535ddf74412c5ae92cb4ec76a ]

Steps to reproduce:

	BLKRESETZONE zone 0

	// force EIO
	pwrite(fd, buf, 4096, 4096);

	[issue more IO including zone ioctls]

It will start failing randomly including IO to unrelated zones because of
->error "reuse". Trigger can be partition detection as well if test is not
run immediately which is even more entertaining.

The fix is of course to clear ->error where necessary.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 78355a0e61db6..d2d7dc9cd58d2 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -571,6 +571,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	if (tag != -1U) {
 		cmd = &nq->cmds[tag];
 		cmd->tag = tag;
+		cmd->error = BLK_STS_OK;
 		cmd->nq = nq;
 		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
 			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
@@ -1433,6 +1434,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->timer.function = null_cmd_timer_expired;
 	}
 	cmd->rq = bd->rq;
+	cmd->error = BLK_STS_OK;
 	cmd->nq = nq;
 
 	blk_mq_start_request(bd->rq);
-- 
2.20.1



