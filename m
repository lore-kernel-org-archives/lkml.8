Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849B42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823585;
	bh=R2+G2g70Z5guBITJdADg/p7YFldTOiznc75Jb28esL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7n4sXZdC8yQVEbRUisEy1Ho3lNLPjnGcXhOrtF+Xy7FvlTdms5EwBMrn1XyHVbFt
	 Cn8P3PBqgv/EbpYByrSYSSqnvZfYcn/UeOgrwlK5MfcIPSgJ2GQpMM3UKBIg8sG+aF
	 2ToBQzuuX3PdfyARF+lhmw5vXGaAnDsLcAyt85qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgERRjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgERRjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:39:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB21207C4;
        Mon, 18 May 2020 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823576;
        bh=R2+G2g70Z5guBITJdADg/p7YFldTOiznc75Jb28esL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IF0KFhKTt6ACQJXTnc+TuktuYW2IIFZQFJZfc3I3pYffj0ILyLcZbGDIzssLbWcEX
         B6Cj7rieXybq9sJXJZFAzWEx61P0atKT7hlGp4P1mzgSHA+tw4PfqZEffyZh/DDIQ2
         SRpCCtJ5BMMcPlpwHoXfIYdc252VN0UQPx42ZhjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/86] net: moxa: Fix a potential double free_irq()
Date:   Mon, 18 May 2020 19:36:08 +0200
Message-Id: <20200518173457.982415582@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ee8d2267f0e39a1bfd95532da3a6405004114b27 ]

Should an irq requested with 'devm_request_irq' be released explicitly,
it should be done by 'devm_free_irq()', not 'free_irq()'.

Fixes: 6c821bd9edc9 ("net: Add MOXA ART SoCs ethernet driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/moxa/moxart_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index f1dde59c9fa6c..374e691b11da6 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -541,7 +541,7 @@ static int moxart_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	unregister_netdev(ndev);
-	free_irq(ndev->irq, ndev);
+	devm_free_irq(&pdev->dev, ndev->irq, ndev);
 	moxart_mac_free_memory(ndev);
 	free_netdev(ndev);
 
-- 
2.20.1



