Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589B5214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257843;
	bh=F3ivNuwb2LcIvLbEQXXlXKZSuU63yBE1w7IKeh6wsNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uaf5eUHHr4ClzMpnS2XpMMBhYiooddlQqjzwKb3rlLLV0+nrmPsgRdJS4tew3gOs7
	 RJm0OGe0TsSEZooi5ybtyvmmPfLhgqjjgAlXKOrviCNVZcEkXbbchlurRPILFAfHuw
	 pWXKfdA6rSRCDaGbQxZVKPnIJY4+CqPpOgB16ubs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbgCCRul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730026AbgCCRue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:50:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCB920870;
        Tue,  3 Mar 2020 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257833;
        bh=F3ivNuwb2LcIvLbEQXXlXKZSuU63yBE1w7IKeh6wsNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rd/FAera/sU4D4FM4nzRTj38Nr1gAGXBPbJnuXPPg/hVHwPJew5Fa8A0UnjjmZ9y/
         lXjSKcnS4Ncg8/eJ/17lqWU4HzxqEzPyP9y0X7KuhdlVgIys5lamBKuoux4A2ZuIev
         gSkPvJV5PXr09Y5Vjf7CBCeGIBtZBMbiciZTRSLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 147/176] drivers: net: xgene: Fix the order of the arguments of alloc_etherdev_mqs()
Date:   Tue,  3 Mar 2020 18:43:31 +0100
Message-Id: <20200303174321.727416287@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 5a44c71ccda60a50073c5d7fe3f694cdfa3ab0c2 upstream.

'alloc_etherdev_mqs()' expects first 'tx', then 'rx'. The semantic here
looks reversed.

Reorder the arguments passed to 'alloc_etherdev_mqs()' in order to keep
the correct semantic.

In fact, this is a no-op because both XGENE_NUM_[RT]X_RING are 8.

Fixes: 107dec2749fe ("drivers: net: xgene: Add support for multiple queues")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2020,7 +2020,7 @@ static int xgene_enet_probe(struct platf
 	int ret;
 
 	ndev = alloc_etherdev_mqs(sizeof(struct xgene_enet_pdata),
-				  XGENE_NUM_RX_RING, XGENE_NUM_TX_RING);
+				  XGENE_NUM_TX_RING, XGENE_NUM_RX_RING);
 	if (!ndev)
 		return -ENOMEM;
 


