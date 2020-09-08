Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46065C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF6120678
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599582115;
	bh=bW1+2zZIvWQxURE22rAzvlWE41uFtJmY9vyudATADtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7D1ex0R5oHzcmMLciUce2ivUY1zFZk4y17aIUIqpol4ewbrWOKHIR1kvg0zDzu6r
	 lt7vU96f4z11uM8sJ4P2tYvt6ulYsXxhC9Qf80Qet9BY1oEtcgfQpmf8Nt0N4j6zno
	 +bxh93iEKxJ+OCkFDYxtpXwop79BMEYKF9r9xubE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgIHQVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:21:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731404AbgIHQKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:10:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94064247F3;
        Tue,  8 Sep 2020 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579767;
        bh=bW1+2zZIvWQxURE22rAzvlWE41uFtJmY9vyudATADtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0H/KxwNI9AXnmbZrf/d5Ae5qmLNZEhh8IOqk2MWS/bYWVlvh1vZ2nAGxesn87p1JX
         sGfD60TBVFpfBOMAYBO0SgwjJSq8njBG59z9smRG6u9vCKYg7vwCPMnfEuVwdr8PGa
         KJPi4ZQAuwZqGsR4ucXGqTxZE0qRYCrr1wIn9LmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 026/129] dmaengine: at_hdmac: check return value of of_find_device_by_node() in at_dma_xlate()
Date:   Tue,  8 Sep 2020 17:24:27 +0200
Message-Id: <20200908152230.998470857@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 0cef8e2c5a07d482ec907249dbd6687e8697677f ]

The reurn value of of_find_device_by_node() is not checked, thus null
pointer dereference will be triggered if of_find_device_by_node()
failed.

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20200817115728.1706719-2-yukuai3@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_hdmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 672c73b4a2d4f..ff366c2f58c18 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1667,6 +1667,8 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 
 	dmac_pdev = of_find_device_by_node(dma_spec->np);
+	if (!dmac_pdev)
+		return NULL;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
-- 
2.25.1



