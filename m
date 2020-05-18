Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277B920872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824388;
	bh=wafRwZl9fucQ6Kdo8iS7pAL+wKFsNGDbbPPINuz48ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CdHw80Iyw9Q2UyY9Bl37KFPkueeaTZ/eQdpLRbOQwrADSElffANklptNfU/H2vL8S
	 5izcBbFg7n8F1EFAFNKbWcAMOpx8AyoQEff0iO8w9JmxIaf0yC7Z3V/jwTe61hyVit
	 yepCF+vMw7LMb5Cv+n1gHUyQzdBohTWaxowLFTAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbgERRxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbgERRxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:53:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB91420674;
        Mon, 18 May 2020 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824383;
        bh=wafRwZl9fucQ6Kdo8iS7pAL+wKFsNGDbbPPINuz48ZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=da8Fe5lHHQJaDKXPJwQbOSHBP8iBsKEf6jbXrfLhFr6yi2f5Ifh/C7GlaiFNhD26J
         zKrvPVhd1VUr56BDjCuvB1vIkQdtqexV8xNrdGKSuT+wTA70vplMhMZVW385hPZvCq
         Z5Cz6z/VZKofXsv8aRFt7yJ+uHsFzII0CbLmDoeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/80] dmaengine: pch_dma.c: Avoid data race between probe and irq handler
Date:   Mon, 18 May 2020 19:36:41 +0200
Message-Id: <20200518173455.035907064@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

[ Upstream commit 2e45676a4d33af47259fa186ea039122ce263ba9 ]

pd->dma.dev is read in irq handler pd_irq().
However, it is set to pdev->dev after request_irq().
Therefore, set pd->dma.dev to pdev->dev before request_irq() to
avoid data race between pch_dma_probe() and pd_irq().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Link: https://lore.kernel.org/r/20200416062335.29223-1-madhuparnabhowmik10@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/pch_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index afd8f27bda969..6e91584c36770 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -873,6 +873,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 	}
 
 	pci_set_master(pdev);
+	pd->dma.dev = &pdev->dev;
 
 	err = request_irq(pdev->irq, pd_irq, IRQF_SHARED, DRV_NAME, pd);
 	if (err) {
@@ -888,7 +889,6 @@ static int pch_dma_probe(struct pci_dev *pdev,
 		goto err_free_irq;
 	}
 
-	pd->dma.dev = &pdev->dev;
 
 	INIT_LIST_HEAD(&pd->dma.channels);
 
-- 
2.20.1



