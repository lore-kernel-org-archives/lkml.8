Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA0CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841AF23134
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073936;
	bh=xn6WjHRNun+91wxlEFjur4mhWmoemTK089x9wa+Bzf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cSN4I4cCDC+emuxqQRo47FPneR5SlxqU3MvgtizQfNzIJC940wcehUAet8q4SselS
	 dUJq7yZadCmH0ZKrUmR9bA+b0yKUuHGUEgOO7pKhMxl1kcpPrRdRYlAyFxhn8D8Q0W
	 BpGTvO3+1s/KzfaN8TT+UmODKNgH+sioi+bSRBkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgHJPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgHJPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:25:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC912078E;
        Mon, 10 Aug 2020 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073128;
        bh=xn6WjHRNun+91wxlEFjur4mhWmoemTK089x9wa+Bzf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2qSytlaKGmRp5+Ij7GWvhGFGKiRlChUjxNSy6nW7LQv/abq3nqvuPRMpCpsFSIC/E
         7/wL12Kf16Ee6fOnohGOTmWrEkuiGX1ZGQf9pIUtaVcTyrB9DnAW6FgnvhBiUC1ZIz
         A9g5wybZhQ6QaMPiudH9RJpYt9a2VAj1UJR8gQLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 69/79] net: mvpp2: fix memory leak in mvpp2_rx
Date:   Mon, 10 Aug 2020 17:21:28 +0200
Message-Id: <20200810151815.638917711@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151812.114485777@linuxfoundation.org>
References: <20200810151812.114485777@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit d6526926de7397a97308780911565e31a6b67b59 ]

Release skb memory in mvpp2_rx() if mvpp2_rx_refill routine fails

Fixes: b5015854674b ("net: mvpp2: fix refilling BM pools in RX path")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Acked-by: Matteo Croce <mcroce@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -2981,6 +2981,7 @@ static int mvpp2_rx(struct mvpp2_port *p
 		err = mvpp2_rx_refill(port, bm_pool, pool);
 		if (err) {
 			netdev_err(port->dev, "failed to refill BM pools\n");
+			dev_kfree_skb_any(skb);
 			goto err_drop_frame;
 		}
 


