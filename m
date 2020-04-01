Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B85C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6833B20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759136;
	bh=9nHvcvoqUiKWJeWDOWu5BylYcXFsA0LaM6M0TJnmo6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pKzW81lJwHxjZ6QoN7bkRmklUtPiW092/ROth8Dfi6G+qFGSfglzedbLvN6Y/AHlM
	 kPvuuF3AEcagHRZWPpi45FtbP0jexdsFK7CqewUhWvPQSbu0RVHim2GxIl3MjU8VOF
	 cPM+sTPSdgZ9hvBujwcw8O29ImSx0WuOezB1Q1Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbgDAQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388445AbgDAQiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D0D20772;
        Wed,  1 Apr 2020 16:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759129;
        bh=9nHvcvoqUiKWJeWDOWu5BylYcXFsA0LaM6M0TJnmo6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzLIuv9wzN4Iax1jGxfdbjBXfVOhvmmQ/kLMaXEiheZxeHHXyQNlr8i4mUmEVBYs+
         2WRt/REIbyPzI19XoZw1BIzg1jGpiH6NQWKGXnbWisLsawhe8IkfUICZhoLR7MYu8R
         SVc76r9KFoTsPxjxNazWI6UXSAOen1NjIsAznrGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 046/102] net: mvneta: Fix the case where the last poll did not process all rx
Date:   Wed,  1 Apr 2020 18:17:49 +0200
Message-Id: <20200401161541.515027954@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
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
@@ -2690,10 +2690,9 @@ static int mvneta_poll(struct napi_struc
 	/* For the case where the last mvneta_poll did not process all
 	 * RX packets
 	 */
-	rx_queue = fls(((cause_rx_tx >> 8) & 0xff));
-
 	cause_rx_tx |= port->cause_rx_tx;
 
+	rx_queue = fls(((cause_rx_tx >> 8) & 0xff));
 	if (rx_queue) {
 		rx_queue = rx_queue - 1;
 		if (pp->bm_priv)


