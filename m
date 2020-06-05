Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD62A20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591367017;
	bh=KX0wPoZfWnP4R5JzHVE4rOgaZ7FssBpsYKHdzxcphs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zUCWfbugaRZeh7ZAKw/1KxmQjYXbA65A5PoMR6itZEjx9ddh5RXH7v50LKb1TRSLq
	 fE8QuCG14VuGbUdtN5YPQ/bVZNDxwcPmMlud8iiMnFt4R+fJvwCOS5ciJSG81OJ5rg
	 BvibQyd1w7IbgYFKhUCBPIJwo4ea3vOdW8iBf7EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgFEOXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728615AbgFEOSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4A62086A;
        Fri,  5 Jun 2020 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366689;
        bh=KX0wPoZfWnP4R5JzHVE4rOgaZ7FssBpsYKHdzxcphs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbuYbC6PE8w8M7RA2FSx+0fOD2+Lb1Jb0DOIyvu4wAWF2q7Wbdl+cWgyjkvH8zbvQ
         fYaGMlE9Sc7nXWF1ydhpoTK7VHMaS6NrcNcbmM2j/nwHvtANesR4zaJrINefCTQwFU
         SimZSzxWkAw9vnZGRGK144A72rBlDexZf3ZADE2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hu Jiahui <kirin.say@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Eric Dumazet <edumazet@google.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 14/38] airo: Fix read overflows sending packets
Date:   Fri,  5 Jun 2020 16:14:57 +0200
Message-Id: <20200605140253.426961596@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 11e7a91994c29da96d847f676be023da6a2c1359 upstream.

The problem is that we always copy a minimum of ETH_ZLEN (60) bytes from
skb->data even when skb->len is less than ETH_ZLEN so it leads to a read
overflow.

The fix is to pad skb->data to at least ETH_ZLEN bytes.

Cc: <stable@vger.kernel.org>
Reported-by: Hu Jiahui <kirin.say@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200527184830.GA1164846@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/cisco/airo.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -1925,6 +1925,10 @@ static netdev_tx_t mpi_start_xmit(struct
 		airo_print_err(dev->name, "%s: skb == NULL!",__func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 	npacks = skb_queue_len (&ai->txq);
 
 	if (npacks >= MAXTXQ - 1) {
@@ -2127,6 +2131,10 @@ static netdev_tx_t airo_start_xmit(struc
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = 0; i < MAX_FIDS / 2 && (fids[i] & 0xffff0000); i++ );
@@ -2201,6 +2209,10 @@ static netdev_tx_t airo_start_xmit11(str
 		airo_print_err(dev->name, "%s: skb == NULL!", __func__);
 		return NETDEV_TX_OK;
 	}
+	if (skb_padto(skb, ETH_ZLEN)) {
+		dev->stats.tx_dropped++;
+		return NETDEV_TX_OK;
+	}
 
 	/* Find a vacant FID */
 	for( i = MAX_FIDS / 2; i < MAX_FIDS && (fids[i] & 0xffff0000); i++ );


