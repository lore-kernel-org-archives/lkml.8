Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A2AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14052469C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844344;
	bh=/SdVvABjZMbhpCatfBfYl/CVRlV9dxUaLRllt1nFvB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7uybiItygUqWbK+swEd1/h+bSrbA875ByAzNWTkD7KXfdSWhy0RMtVC2Y8aVGwsY
	 WoJ01zFZE4qRCZcZ6Xnj6rfMSaXeX+sxyMAUeKT/53F/t+REDcBBmcI+j5rzV1P2VL
	 faM5OsZzK45MILe5Jz8xFqgyBjYLiYDQMkeMKt7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCJMpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbgCJMpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:45:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAB4246A3;
        Tue, 10 Mar 2020 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844340;
        bh=/SdVvABjZMbhpCatfBfYl/CVRlV9dxUaLRllt1nFvB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plL+pplXLHoyQRWAetymaErJPQKvbanKOKC8UASd0+bYWUkLUbENz+L0OYLDScmfv
         tPIFQrnpvbR160eKcVIrLhGGuqStPqQUdRndZQuLCaJg87JS75krXEj8m48+E5djb1
         ofrmceZE8QelSIRKUY97kazbPkUsh7Y6uixD9FMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 46/88] drivers: net: xgene: Fix the order of the arguments of alloc_etherdev_mqs()
Date:   Tue, 10 Mar 2020 13:38:54 +0100
Message-Id: <20200310123617.440477082@linuxfoundation.org>
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
@@ -1711,7 +1711,7 @@ static int xgene_enet_probe(struct platf
 	int ret;
 
 	ndev = alloc_etherdev_mqs(sizeof(struct xgene_enet_pdata),
-				  XGENE_NUM_RX_RING, XGENE_NUM_TX_RING);
+				  XGENE_NUM_TX_RING, XGENE_NUM_RX_RING);
 	if (!ndev)
 		return -ENOMEM;
 


