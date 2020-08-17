Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A156F2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692725;
	bh=OICnLkXlVe5P+5n/vyf978ebwQib89u725aBI8qOb9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xoAU2GvVF/kPFVtE6zx8F5FUfC+L5FcicdZnLdZB+PnesRCrr1ysL7WUWcz3Pp9HH
	 lrqrSWaVb2NjLkKWvPcrsE4d1k7h0oh0TQB2DU9a5YAm2Y3X6uPqOeZtMIA/IEmpNX
	 kw0pvQrotDqLQhoghfr1hLndwr1Mf2ie60pBwNL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404174AbgHQTcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgHQPbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:31:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623FC20B1F;
        Mon, 17 Aug 2020 15:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678301;
        bh=OICnLkXlVe5P+5n/vyf978ebwQib89u725aBI8qOb9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwI0nMiWs8Xu5GgNHllY0l4uxMzYgRg4RfwoVbNuAhKMsSvNMNnKct1SJYZ1WI7H4
         YZKdGwfyr5pDYAEsmFR11ja9dbe7O6P102F0stsuIJjc9vrbDpZOHx1JLvba4lJGzF
         92MOmWeC/Umha5tNIxbn46KqCFpXv6PEbKUq15AA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 256/464] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Date:   Mon, 17 Aug 2020 17:13:29 +0200
Message-Id: <20200817143846.056139584@linuxfoundation.org>
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

From: Hauke Mehrtens <hauke@hauke-m.de>

[ Upstream commit ba3548cf29616b58c93bbaffc3d636898d009858 ]

The lantiq-ssc driver uses internally an own workqueue to wait till the
data is not only written out of the FIFO but really written to the wire.
This workqueue is flushed while the SPI subsystem is working in some
other system workqueue.

The system workqueue is marked as WQ_MEM_RECLAIM, but the workqueue in
the lantiq-ssc driver does not use WQ_MEM_RECLAIM for now. Add this flag
too to prevent this warning.

This fixes the following warning:
[    2.975956] WARNING: CPU: 1 PID: 17 at kernel/workqueue.c:2614 check_flush_dependency+0x168/0x184
[    2.984752] workqueue: WQ_MEM_RECLAIM kblockd:blk_mq_run_work_fn is flushing !WQ_MEM_RECLAIM 1e100800.spi:0x0

Fixes: 891b7c5fbf61 ("mtd_blkdevs: convert to blk-mq")
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Link: https://lore.kernel.org/r/20200717215648.20522-1-hauke@hauke-m.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-lantiq-ssc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 44600fb71c484..049a64451c750 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -909,7 +909,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
 				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
-	spi->wq = alloc_ordered_workqueue(dev_name(dev), 0);
+	spi->wq = alloc_ordered_workqueue(dev_name(dev), WQ_MEM_RECLAIM);
 	if (!spi->wq) {
 		err = -ENOMEM;
 		goto err_clk_put;
-- 
2.25.1



