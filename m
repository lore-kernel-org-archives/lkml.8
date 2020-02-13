Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4DBC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F620675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609280;
	bh=xSKy0VUYvuRtdZfsXdTP62/aEzxuc94wctJhZJ9qRQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hD6ZrJbxZtH9W4d62wl44DZfTvA2CJIIKy4x16Uj6me4RRo4R8prL0Zon7/hZhvoz
	 +KQxNkvZG314WoIGSzAOTB+EfDGhBLi5YgnxipIf0WTSztGvGwBxk/SkLbDpF5LA8m
	 /vgQ6/vL2Dcy4R3ssloCOudAapwgdwBE2TY0TmBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgBMPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgBMPZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:51 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6032120848;
        Thu, 13 Feb 2020 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607551;
        bh=xSKy0VUYvuRtdZfsXdTP62/aEzxuc94wctJhZJ9qRQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzQXbjMA7eMfvjRTuVOjL5CPGGmoSz8Trsey/v+B9FOIcrOmcwIr5cJFmnx/srXbC
         T7Ec3ouvCqnAj/lwesf3cErgxPCpthLXfb4u8qQPWXJz10Ji5dyruDEtS9f5cup2cK
         0UjOF4FNt9d6664zmWZnQnk88XnEZnGfpZln1Sis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 116/173] net: macb: Limit maximum GEM TX length in TSO
Date:   Thu, 13 Feb 2020 07:20:19 -0800
Message-Id: <20200213152001.702224885@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit f822e9c4ffa511a5c681cf866287d9383a3b6f1b ]

GEM_MAX_TX_LEN currently resolves to 0x3FF8 for any IP version supporting
TSO with full 14bits of length field in payload descriptor. But an IP
errata causes false amba_error (bit 6 of ISR) when length in payload
descriptors is specified above 16387. The error occurs because the DMA
falsely concludes that there is not enough space in SRAM for incoming
payload. These errors were observed continuously under stress of large
packets using iperf on a version where SRAM was 16K for each queue. This
errata will be documented shortly and affects all versions since TSO
functionality was added. Hence limit the max length to 0x3FC0 (rounded).

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -66,7 +66,11 @@
 /* Max length of transmit frame must be a multiple of 8 bytes */
 #define MACB_TX_LEN_ALIGN	8
 #define MACB_MAX_TX_LEN		((unsigned int)((1 << MACB_TX_FRMLEN_SIZE) - 1) & ~((unsigned int)(MACB_TX_LEN_ALIGN - 1)))
-#define GEM_MAX_TX_LEN		((unsigned int)((1 << GEM_TX_FRMLEN_SIZE) - 1) & ~((unsigned int)(MACB_TX_LEN_ALIGN - 1)))
+/* Limit maximum TX length as per Cadence TSO errata. This is to avoid a
+ * false amba_error in TX path from the DMA assuming there is not enough
+ * space in the SRAM (16KB) even when there is.
+ */
+#define GEM_MAX_TX_LEN		(unsigned int)(0x3FC0)
 
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
 #define MACB_NETIF_LSO		NETIF_F_TSO


