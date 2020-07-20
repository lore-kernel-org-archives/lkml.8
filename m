Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22414C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0E320672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261429;
	bh=ztvvJNc23Tfq8oh061M+xvD+2X0usFBKy9lq8ciHcC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dr/CcHWSYzp5hl0h9dzft4EvToCE7E9aXecopfCHzsIRqrkdjNm9YEdbFrDzetQSp
	 o7H20rPdLzhOntNj8AkfSjwgyuXcDN+8zjcLyvSOVKzyH6A1VR/JBRkmGY1Jfnbj/y
	 5g722OjmJiuG78sZvibPUcZRhqrfSwmMcpw2Cbdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgGTQK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731840AbgGTQKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 335FA2065E;
        Mon, 20 Jul 2020 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261422;
        bh=ztvvJNc23Tfq8oh061M+xvD+2X0usFBKy9lq8ciHcC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhFXzqdt8UlsfrfLlGz2CE/4i6NTvsD3IsNK2C60t3tkHi6L2dC4QMAK2NHGgsJns
         o/6rkj2zv4vIW0KJxqSaM6Igqi4Ug4MqjOWnHlVWZvK7YbIlMn9uHUYGIaZtF+R2Xa
         T/58wnqAevBltMtRBZGaaImIEfg0PWPfbdQF0xpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 080/244] dmaengine: ti: k3-udma: Use correct node to read "ti,udma-atype"
Date:   Mon, 20 Jul 2020 17:35:51 +0200
Message-Id: <20200720152829.648727707@linuxfoundation.org>
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

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 9f2f3ce3daed229eecf647acac44defbdee1f7c0 ]

The "ti,udma-atype" property is expected in the UDMA node and not in the
parent navss node.

Fixes: 0ebcf1a274c5 ("dmaengine: ti: k3-udma: Implement support for atype (for virtualization)")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200527065357.30791-1-peter.ujfalusi@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a90e154b0ae0d..baf7ab64f1d7d 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3609,7 +3609,7 @@ static int udma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(navss_node, "ti,udma-atype", &ud->atype);
+	ret = of_property_read_u32(dev->of_node, "ti,udma-atype", &ud->atype);
 	if (!ret && ud->atype > 2) {
 		dev_err(dev, "Invalid atype: %u\n", ud->atype);
 		return -EINVAL;
-- 
2.25.1



