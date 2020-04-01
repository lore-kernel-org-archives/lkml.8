Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D607F20857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758195;
	bh=Fwzy4MXxBxnXPv0MQ/mbcyvD3ov/xjGsbmvfCvN9Zi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G5/qxwEZ4BrJUjACKTzox7n6tzq7K3kfj/PBNg22p607Y81rZEoS1U+E9rmcyYZMh
	 6h5KIuFsOiUQq6mCszLEh0YMTOSul665FdAnCwv+PfAdGMoDwczbW3aCWfS161oavn
	 7lXtOxM9w6k3c7QEmSF6Y5mtH3I4SPekaeZ+cJeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgDAQXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733270AbgDAQXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:23:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC8E921556;
        Wed,  1 Apr 2020 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758192;
        bh=Fwzy4MXxBxnXPv0MQ/mbcyvD3ov/xjGsbmvfCvN9Zi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAoWNCoIWLXbtz65uulEvXjNQyjBHFIrOdgT2w/kJoN25sZ8tlM302befqCYWX8GC
         b4ehBNISFnXab+307BQSgHYt3U4iDmYO4x5D1jgizvx2w0skY4s56NvKfcTVL9bW8Q
         m8VsrO8RJXh2edbgc77yT9+m5FbtGa2fSPyngyqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 013/116] net: mvneta: Fix the case where the last poll did not process all rx
Date:   Wed,  1 Apr 2020 18:16:29 +0200
Message-Id: <20200401161543.745787529@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 065fd83e1be2e1ba0d446a257fd86a3cc7bddb51 ]

For the case where the last mvneta_poll did not process all
RX packets, we need to xor the pp->cause_rx_tx or port->cause_rx_tx
before claculating the rx_queue.

Fixes: 2dcf75e2793c ("net: mvneta: Associate RX queues with each CPU")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2801,11 +2801,10 @@ static int mvneta_poll(struct napi_struc
 	/* For the case where the last mvneta_poll did not process all
 	 * RX packets
 	 */
-	rx_queue = fls(((cause_rx_tx >> 8) & 0xff));
-
 	cause_rx_tx |= pp->neta_armada3700 ? pp->cause_rx_tx :
 		port->cause_rx_tx;
 
+	rx_queue = fls(((cause_rx_tx >> 8) & 0xff));
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)


