Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF109C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8363C214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322630;
	bh=EASFF+si7Jeiw9r8N0JD86TinU8vNlBUIXAnCbib6X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xzK6I9UmP26H5amNVx4xzxSS0Msv+Qr2b84JB19RGUFOaSOldcVvYjmVQqDGqmLI9
	 afpGTAs1w6rvsJ5VSIMMxiQ6+nZa+zoBEez9Cs3JvzVab+TtLAMhBtiNh7DGvz9mkp
	 f8PnSlbv6FfNr3oNkM1GdtYKyWtAveB7QHmKagac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbgFPPu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732587AbgFPPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:50:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CDF42071A;
        Tue, 16 Jun 2020 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322611;
        bh=EASFF+si7Jeiw9r8N0JD86TinU8vNlBUIXAnCbib6X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBIyxlWW8XSiwgrXY6AC59uFyup0y0q6KvR1+lebtrKebfIXoob1g0+6AbXvrYwJu
         sIa11LL4HqcdMYBK3PWf0tx7H5FJAJuRZxUQf/Fgt74y52sHNqaWWXPX/UaUVxRT3z
         o7C5BdiFnJ+ZwXsrDnjWtXAydq9GCWVDeQVizr00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sameeh Jubran <sameehj@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 008/161] net: ena: xdp: update napi budget for DROP and ABORTED
Date:   Tue, 16 Jun 2020 17:33:18 +0200
Message-Id: <20200616153106.807834339@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 3921a81c31df6057183aeb7f7d204003bf699d6f ]

This patch fixes two issues with XDP:

1. If the XDP verdict is XDP_ABORTED we break the loop, which results in
   us handling one buffer per napi cycle instead of the total budget
   (usually 64). To overcome this simply change the xdp_verdict check to
   != XDP_PASS. When the verdict is XDP_PASS, the skb is not expected to
   be NULL.

2. Update the residual budget for XDP_DROP and XDP_ABORTED, since
   packets are handled in these cases.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1642,11 +1642,9 @@ static int ena_clean_rx_irq(struct ena_r
 					 &next_to_clean);
 
 		if (unlikely(!skb)) {
-			if (xdp_verdict == XDP_TX) {
+			if (xdp_verdict == XDP_TX)
 				ena_free_rx_page(rx_ring,
 						 &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id]);
-				res_budget--;
-			}
 			for (i = 0; i < ena_rx_ctx.descs; i++) {
 				rx_ring->free_ids[next_to_clean] =
 					rx_ring->ena_bufs[i].req_id;
@@ -1654,8 +1652,10 @@ static int ena_clean_rx_irq(struct ena_r
 					ENA_RX_RING_IDX_NEXT(next_to_clean,
 							     rx_ring->ring_size);
 			}
-			if (xdp_verdict == XDP_TX || xdp_verdict == XDP_DROP)
+			if (xdp_verdict != XDP_PASS) {
+				res_budget--;
 				continue;
+			}
 			break;
 		}
 


