Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA49C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4856620675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608978;
	bh=F+SdouQSAWB+bQPlqsWglxn4eZE/w0y84eUsZc9kWig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYsamN0a+eK7TiktnWg0XwJLZGequV+pXCnJhpU0mI7uKxTodK9dbvd+/afLLK1Ga
	 hCS2aMphof6kolg4CFZ1ONagoKiL/RSzvzWOzhXU1wFGB/8bOehaD3Xgt29G9/KTsj
	 r8/tRUXbeLewqO5E1OIwEeOTEiDqZJGo511iqSCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgBMPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgBMP0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:26:42 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4093224685;
        Thu, 13 Feb 2020 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607600;
        bh=F+SdouQSAWB+bQPlqsWglxn4eZE/w0y84eUsZc9kWig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6HBiZqrZ2Vz00sEhZCSOVkWDJ0QiX0tR3Y3u49DvGbqGQqVldpzfaIMPrcJH01hP
         I9VXtjNI7UfiowS1ddWYhKiHCyIsmFBaYvQUCjhQqrQlxjr/uF57phsWEgn14Sg9bh
         RPq9reO/PPE+AnqPoxgyKph8w7nIPftIIpx1R7Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/52] spi: spi-mem: Fix inverted logic in op sanity check
Date:   Thu, 13 Feb 2020 07:21:00 -0800
Message-Id: <20200213151818.524000806@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151810.331796857@linuxfoundation.org>
References: <20200213151810.331796857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit aea3877e24f3acc6145094848dbb85f9ce85674a ]

On r8a7791/koelsch:

    m25p80 spi0.0: error -22 reading 9f
    m25p80: probe of spi0.0 failed with error -22

Apparently the logic in spi_mem_check_op() is wrong, rejecting the
spi-mem operation if any buswidth is valid, instead of invalid.

Fixes: 380583227c0c7f52 ("spi: spi-mem: Add extra sanity checks on the op param")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index cc3d425aae56c..62a7b80801d22 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -169,10 +169,10 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 	    (op->data.nbytes && !op->data.buswidth))
 		return -EINVAL;
 
-	if (spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->addr.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
-	    spi_mem_buswidth_is_valid(op->data.buswidth))
+	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    !spi_mem_buswidth_is_valid(op->data.buswidth))
 		return -EINVAL;
 
 	return 0;
-- 
2.20.1



