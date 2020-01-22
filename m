Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A11BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF082468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686580;
	bh=u5o4ITNKD88xH8XTMiyh2c5zZWnTUz39pEEvIJzm0WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxUqCFOmerzaI5FNl7PGFcsTymZ63msgwPCfir6w/H/FvHIEgC+IjSHtyJUN2UECl
	 0CigA8CbXYi4e1MJNB2Gc8oBuEOSwPp0Ql3rCIrAI5jP79IEaJfKe3PQaOfbJECGV9
	 pAT+Pg9l4qLxo6Nl4jfLA3o4TDCQa+nkeNliHLic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgAVJje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733215AbgAVJja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E95CD24685;
        Wed, 22 Jan 2020 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685970;
        bh=u5o4ITNKD88xH8XTMiyh2c5zZWnTUz39pEEvIJzm0WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa2wgc4puUEKBTa1kxe+NFeXYy/oJFxBD/lrI8CGphLOIDjWr/MuuJs6RiWSET32H
         F+dlVs8hCrLxj/wP5quPdl92s0A9E+pt2e8EOUJi5K2l4Qe+rp99TGjCUe0Q8qDvw2
         6dJqNrQoHFxjQ/MJqtXAy8qaSL1IBP/bN1LfS/0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 29/65] net: stmmac: 16KB buffer must be 16 byte aligned
Date:   Wed, 22 Jan 2020 10:29:14 +0100
Message-Id: <20200122092754.942703367@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 8605131747e7e1fd8f6c9f97a00287aae2b2c640 upstream.

The 16KB RX Buffer must also be 16 byte aligned. Fix it.

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/common.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -338,9 +338,8 @@ struct dma_features {
 	unsigned int rx_fifo_size;
 };
 
-/* GMAC TX FIFO is 8K, Rx FIFO is 16K */
-#define BUF_SIZE_16KiB 16384
-/* RX Buffer size must be < 8191 and multiple of 4/8/16 bytes */
+/* RX Buffer size must be multiple of 4/8/16 bytes */
+#define BUF_SIZE_16KiB 16368
 #define BUF_SIZE_8KiB 8188
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048


