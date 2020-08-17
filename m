Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED329C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C602E2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683602;
	bh=Wu7bjlen7VaDzAEZ30fkPJc0jKth6xZTnBln8GLVJdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nN499ftOGX5v56fQQFVtuBDtzgAOtvQ9StkHJQ2RyHml3Fk7PWcShSTiEqIvRoA94
	 tCYbsbMInqImoySN6ILuY9TyBVo9h0UK3z3CMsIbgOdfsnm8bysPMTNDGJL4cAw/lI
	 37Kdr5XE8N3RvzY1kUbYpNrZ5LxkeGl4cQAXBSWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgHQQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbgHQQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1EC20882;
        Mon, 17 Aug 2020 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680356;
        bh=Wu7bjlen7VaDzAEZ30fkPJc0jKth6xZTnBln8GLVJdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTFITjQ5lcxctN2+WB86iCUS24O3gE7LL4urIUUS01LukGYGoDLs+pvJyRXArQeGn
         MoSIde24hkKLMWfJA9JZaUW5dn3XtBV6jdoBzQ4Zw0rQdzelUp1iWNSg8P0ZdLMu0l
         kl7k0pr311G39qPA+ZIW5WSr7cEMWqZayY/IpuHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 154/270] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM
Date:   Mon, 17 Aug 2020 17:15:55 +0200
Message-Id: <20200817143803.501300258@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index 55394bdbc5a30..f9bc1705c0d4d 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -917,7 +917,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 8) |
 				     SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 
-	spi->wq = alloc_ordered_workqueue(dev_name(dev), 0);
+	spi->wq = alloc_ordered_workqueue(dev_name(dev), WQ_MEM_RECLAIM);
 	if (!spi->wq) {
 		err = -ENOMEM;
 		goto err_clk_put;
-- 
2.25.1



