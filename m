Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FA2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826476;
	bh=2K8/xX5qPz/2GkBEO4hSwzpuw4kzPYUm1BPA9HRbYuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cVFbnHphxXIiN231lK5ES+N8mFgee107bmlxFSmjgpxlq8Kq+8uK3YsNuSDoK7sel
	 j6BxjA5gebWhcPMwsqVbckT/pB7uO7jRoZECTnjLSArdkMUFriWJwpbC5YeGnPY90B
	 GpeffN0QHkBMtsyOUsM3SF2xuD1kFRVNCRuIAU1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgERRn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbgERRnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8240D20715;
        Mon, 18 May 2020 17:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823801;
        bh=2K8/xX5qPz/2GkBEO4hSwzpuw4kzPYUm1BPA9HRbYuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w05MxlmtYGWrIrPsylaqcppZgHE0L4d52K9c68KB/w4RTsCWq5yrIIPOC3LmS4ofe
         keRStfZhLJvteJa4vGkmNN9WuAJCrlHrsHorJd8ivi8BQo3IHzKTrhWCWCWQppMQ4Z
         AbK+AEvtdAMdQKEPnvg3NPSkWQmipj/cfkmZ+s9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 42/90] net/sonic: Fix a resource leak in an error handling path in jazz_sonic_probe()
Date:   Mon, 18 May 2020 19:36:20 +0200
Message-Id: <20200518173459.818938857@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 10e3cc180e64385edc9890c6855acf5ed9ca1339 ]

A call to 'dma_alloc_coherent()' is hidden in 'sonic_alloc_descriptors()',
called from 'sonic_probe1()'.

This is correctly freed in the remove function, but not in the error
handling path of the probe function.
Fix it and add the missing 'dma_free_coherent()' call.

While at it, rename a label in order to be slightly more informative.

Fixes: efcce839360f ("[PATCH] macsonic/jazzsonic network drivers update")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/natsemi/jazzsonic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index acf3f11e38cc1..68d2f31921ff8 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -247,13 +247,15 @@ static int jazz_sonic_probe(struct platform_device *pdev)
 		goto out;
 	err = register_netdev(dev);
 	if (err)
-		goto out1;
+		goto undo_probe1;
 
 	printk("%s: MAC %pM IRQ %d\n", dev->name, dev->dev_addr, dev->irq);
 
 	return 0;
 
-out1:
+undo_probe1:
+	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
+			  lp->descriptors, lp->descriptors_laddr);
 	release_mem_region(dev->base_addr, SONIC_MEM_SIZE);
 out:
 	free_netdev(dev);
-- 
2.20.1



