Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFE208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323424;
	bh=+Mw1Hkuxle5Fl7ol3+GYHkofD6hHkT3YdniPFZuASkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8LrwGOev/991mmu5/Vb1DEGChs4J2ACFIVRbok2mwS5z0gTgkznzOz3WsbSvKRXE
	 ZwR35n3XE0KcTwPPduV5aL7trNXjnC35OdMujBnokowhUx7qZtFTxqhNuMrQxnlVmF
	 lQjqeWZGb5/SOOepeHg3ZSSV/OhuaC6mhnCGs1LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbgFPQDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732375AbgFPPuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:50:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97DFC208B8;
        Tue, 16 Jun 2020 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322609;
        bh=+Mw1Hkuxle5Fl7ol3+GYHkofD6hHkT3YdniPFZuASkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whngCUcGuXl75VTUgegcgTkz4XEAJ+Srd8BB1J6ezZxkr99DxV5g7txSBI7T9nkAZ
         JMcwDew1jsHBPPiFlQo0C6CcGLcqMMqDgvpNlebRSsDkdBuR3RWmwrXvPBKWbvd/rA
         9XVMRkIKYc3fFZP0oHjaba8SH+dF99m+ZNQW0WXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sameeh Jubran <sameehj@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 007/161] net: ena: xdp: XDP_TX: fix memory leak
Date:   Tue, 16 Jun 2020 17:33:17 +0200
Message-Id: <20200616153106.759787627@linuxfoundation.org>
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

[ Upstream commit cd07ecccba13b8bd5023ffe7be57363d07e3105f ]

When sending very high packet rate, the XDP tx queues can get full and
start dropping packets. In this case we don't free the pages which
results in ena driver draining the system memory.

Fix:
Simply free the pages when necessary.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -358,7 +358,7 @@ error_unmap_dma:
 	ena_unmap_tx_buff(xdp_ring, tx_info);
 	tx_info->xdpf = NULL;
 error_drop_packet:
-
+	__free_page(tx_info->xdp_rx_page);
 	return NETDEV_TX_OK;
 }
 


