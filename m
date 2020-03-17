Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2507C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91B206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443276;
	bh=OQtESyWE2X0qpSPCtJSY9euznuXqETpwsjPb898PWr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vn9RSauDk8dnUvdhFEkkcq6/XMKLWs8Q/jYcSCslrm6qo8AaB8fkxmks8yTE+xkqf
	 LaWe28OAMNkb9wKCsBIhrPMjNs/cuqZKQVwE6/VXR6pmFhWPSP6PSiWkMTuxRxOQ0h
	 YJ80svPdeQXeYF1dVa7y2Tw+Q+3TZCTKqt46OCmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCQLHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgCQLHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:07:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA6F20658;
        Tue, 17 Mar 2020 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443269;
        bh=OQtESyWE2X0qpSPCtJSY9euznuXqETpwsjPb898PWr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BW0skR7fGahAFvBxrF1U/Eyk3oQTjyQ+P3sPU/wX1cqEqt2ZRhq09ldYRYmD8Z2Dv
         HcP0jsimCfX3QOvX3c2hjrefcAMmi4dCXuvFYr6nqTJ0WRUhNAnJ+4MGJDPbVgdd9Q
         Wcv0Jnns1iCJy1R0tgv3nsLsCFdo+ndYoGjAhoXU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Derek Shute <Derek.Shute@stratus.com>,
        Edward Cree <ecree@solarflare.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 030/151] sfc: detach from cb_page in efx_copy_channel()
Date:   Tue, 17 Mar 2020 11:54:00 +0100
Message-Id: <20200317103328.825627532@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Cree <ecree@solarflare.com>

[ Upstream commit 4b1bd9db078f7d5332c8601a2f5bd43cf0458fd4 ]

It's a resource, not a parameter, so we can't copy it into the new
 channel's TX queues, otherwise aliasing will lead to resource-
 management bugs if the channel is subsequently torn down without
 being initialised.

Before the Fixes:-tagged commit there was a similar bug with
 tsoh_page, but I'm not sure it's worth doing another fix for such
 old kernels.

Fixes: e9117e5099ea ("sfc: Firmware-Assisted TSO version 2")
Suggested-by: Derek Shute <Derek.Shute@stratus.com>
Signed-off-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sfc/efx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -525,6 +525,7 @@ efx_copy_channel(const struct efx_channe
 		if (tx_queue->channel)
 			tx_queue->channel = channel;
 		tx_queue->buffer = NULL;
+		tx_queue->cb_page = NULL;
 		memset(&tx_queue->txd, 0, sizeof(tx_queue->txd));
 	}
 


