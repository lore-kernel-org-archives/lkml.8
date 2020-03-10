Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9C2C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B0B24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847229;
	bh=FLADw+GKBExK9ezf3kJ+0wVCGT6MykYNqQ0rey0KKok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=emJ4NmJwBmIbWqrTedcr1Md0TWMImYLP7gWGghkeOPxVMkgo/HAPbare5QPXkDlTm
	 xlBG2Nsm1zN3urKSn/Hl7LE2U4n4JuCJM3QdaOvFHcwB0lkxZ+J1BzouA7Qv25Ldlb
	 Wq4WgNBk/S7Omw+VnwYg3EjrUT7ty44/nIbOia7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgCJNds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgCJMrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:47:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCAA924697;
        Tue, 10 Mar 2020 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844463;
        bh=FLADw+GKBExK9ezf3kJ+0wVCGT6MykYNqQ0rey0KKok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lo8HzKeZQ+9S08yEnSs+kfMa/Up0vg4QfNdYydDny+xws+oX/W6sYzAe3PnpB2aPf
         SPEqnjCwujIMM+51cMZEu0wCKYaXcopDmXfBCgyaTuTxb67eImk++/VmBXbIpC/xws
         1YtkLwgGG8jOndnI6yEi/VlA6UE8rvlPXu4bl8Ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.9 76/88] dmaengine: tegra-apb: Prevent race conditions of tasklet vs free list
Date:   Tue, 10 Mar 2020 13:39:24 +0100
Message-Id: <20200310123624.022333416@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit c33ee1301c393a241d6424e36eff1071811b1064 upstream.

The interrupt handler puts a half-completed DMA descriptor on a free list
and then schedules tasklet to process bottom half of the descriptor that
executes client's callback, this creates possibility to pick up the busy
descriptor from the free list. Thus, let's disallow descriptor's re-use
until it is fully processed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200209163356.6439-3-digetx@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/tegra20-apb-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -288,7 +288,7 @@ static struct tegra_dma_desc *tegra_dma_
 
 	/* Do not allocate if desc are waiting for ack */
 	list_for_each_entry(dma_desc, &tdc->free_dma_desc, node) {
-		if (async_tx_test_ack(&dma_desc->txd)) {
+		if (async_tx_test_ack(&dma_desc->txd) && !dma_desc->cb_count) {
 			list_del(&dma_desc->node);
 			spin_unlock_irqrestore(&tdc->lock, flags);
 			dma_desc->txd.flags = 0;


