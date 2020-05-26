Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE73C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0FE208A7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519870;
	bh=14eDN6iWkvLygluEYtdkN4nLLdQl8xArd15UGUNLXjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MV/RyF3sLgycvfFvVujhloK6QGThUFa+4BuC7dWOajKJr/1f789vwHSe/Y2rVX1U3
	 Uri2oWNrKgQv2K7KNQUKPGqcGAzDYDtuOFL04MKcJjgj27Kyf6Hk0ahTXaeaZ97gz3
	 RttmYeKP+eYy1F9FLEmBRrUv9Gna8TBGymfzAw1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbgEZTE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389427AbgEZTEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:04:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A0620849;
        Tue, 26 May 2020 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519865;
        bh=14eDN6iWkvLygluEYtdkN4nLLdQl8xArd15UGUNLXjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpJCz9zjKivoTIThrn/4hQrTJJuSoNJNH2eWILPA6XAut+DvLdmNMhy1dYphPa6bB
         pRHJMrtVvsd+HK6HkaUU+t23rneBgFHTn6LxLTYEQj2i3/C7bOvn06qFZu68NcpEWW
         uAw1HrrS0gSYWU8rdjgKh7W+6ZHLUMfPLrVsbEk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.19 46/81] dmaengine: tegra210-adma: Fix an error handling path in tegra_adma_probe()
Date:   Tue, 26 May 2020 20:53:21 +0200
Message-Id: <20200526183932.153406200@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 3a5fd0dbd87853f8bd2ea275a5b3b41d6686e761 upstream.

Commit b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
has moved some code in the probe function and reordered the error handling
path accordingly.
However, a goto has been missed.

Fix it and goto the right label if 'dma_async_device_register()' fails, so
that all resources are released.

Fixes: b53611fb1ce9 ("dmaengine: tegra210-adma: Fix crash during probe")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20200516214205.276266-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/tegra210-adma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/tegra210-adma.c
+++ b/drivers/dma/tegra210-adma.c
@@ -793,7 +793,7 @@ static int tegra_adma_probe(struct platf
 	ret = dma_async_device_register(&tdma->dma_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
-		goto irq_dispose;
+		goto rpm_put;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,


