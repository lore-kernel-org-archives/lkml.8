Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3577C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD10C24691
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845680;
	bh=FPVa7EgyFbqzPMP9b5UqFWfiQfjcJ/p/YEDAggvfVJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+As6A4SuYWXQNr70DHtEdd2wdaQJiRAPLhLWnKypOqi1yM4nfGuZxyhzUnVjDZf8
	 hVMtFdYa/QwFyz0/qV/QfSguNLgsLsL7ySBFJJuBDZF7rgPTW+i+gucnCYR2zym1Kk
	 DEqqr16zY+NRLbe47pIDC5HtDKQYYvT11G+WbD3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgCJNH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730750AbgCJNHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:07:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51AF2071B;
        Tue, 10 Mar 2020 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845674;
        bh=FPVa7EgyFbqzPMP9b5UqFWfiQfjcJ/p/YEDAggvfVJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3BsgMqXNY+pOg/klugjE5GULZMOqr8mR4hcU83ab6X1HGf5Mil+NUHYY/g4gpK+3
         wjKgR0s2jGJZkVmWxzPnCD75YV9te5mrZ2ap3uljkMStBh/iE488pnvR6l4ZthVzCG
         YtNlEUDYeqJ8NZ0xKTurW3rprLSYB+kgWyWrh/TU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 060/126] drivers: net: xgene: Fix the order of the arguments of alloc_etherdev_mqs()
Date:   Tue, 10 Mar 2020 13:41:21 +0100
Message-Id: <20200310124207.978067587@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
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
@@ -2034,7 +2034,7 @@ static int xgene_enet_probe(struct platf
 	int ret;
 
 	ndev = alloc_etherdev_mqs(sizeof(struct xgene_enet_pdata),
-				  XGENE_NUM_RX_RING, XGENE_NUM_TX_RING);
+				  XGENE_NUM_TX_RING, XGENE_NUM_RX_RING);
 	if (!ndev)
 		return -ENOMEM;
 


