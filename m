Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD11207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323197;
	bh=Y30ZBQNG3mszmrEQPnFxg46/oMSsg75n3uKrSV01Gnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=koXN8cq2urMwXRIn9fV1Q6xsskjgE2wansyYlucHcaKJCWiZ0Jb7HxI+w5Xz6s12K
	 qBeResYApI0I7EnUCEJjZv9XLWkZfiV1RhjCah0eXx83qfntM5SmIrmdmdK8K4tNnd
	 4tnf9/BIDNuydIFDcb9H4rbNR/tNmrOiSltYo6Rw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgFPPxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732447AbgFPPxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEF021532;
        Tue, 16 Jun 2020 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322794;
        bh=Y30ZBQNG3mszmrEQPnFxg46/oMSsg75n3uKrSV01Gnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThNmxeSRK5Gws0xBLOauFokFYaJ4BZcH/XV8dWHCPkWV2CQBeVgxTenaA6jchv83D
         FCx90H+qtVU67kxoBclFkzLRsz59+42JQz6XVolvnCQ4YYp/HGxdKpXD/jSaLlmclQ
         Dq/q15OTvrq5jsm0/v2+Xs/yPQQdZWZSBrftZk+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 107/161] net: mvneta: do not redirect frames during reconfiguration
Date:   Tue, 16 Jun 2020 17:34:57 +0200
Message-Id: <20200616153111.457746369@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 62a502cc91f97e3ffd312d9b42e8d01a137c63ff ]

Disable frames injection in mvneta_xdp_xmit routine during hw
re-configuration in order to avoid hardware hangs

Fixes: b0a43db9087a ("net: mvneta: add XDP_TX support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvneta.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -418,11 +418,17 @@ struct mvneta_pcpu_port {
 	u32			cause_rx_tx;
 };
 
+enum {
+	__MVNETA_DOWN,
+};
+
 struct mvneta_port {
 	u8 id;
 	struct mvneta_pcpu_port __percpu	*ports;
 	struct mvneta_pcpu_stats __percpu	*stats;
 
+	unsigned long state;
+
 	int pkt_size;
 	void __iomem *base;
 	struct mvneta_rx_queue *rxqs;
@@ -2066,6 +2072,9 @@ mvneta_xdp_xmit(struct net_device *dev,
 	int i, drops = 0;
 	u32 ret;
 
+	if (unlikely(test_bit(__MVNETA_DOWN, &pp->state)))
+		return -ENETDOWN;
+
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
 		return -EINVAL;
 
@@ -3489,12 +3498,16 @@ static void mvneta_start_dev(struct mvne
 
 	phylink_start(pp->phylink);
 	netif_tx_start_all_queues(pp->dev);
+
+	clear_bit(__MVNETA_DOWN, &pp->state);
 }
 
 static void mvneta_stop_dev(struct mvneta_port *pp)
 {
 	unsigned int cpu;
 
+	set_bit(__MVNETA_DOWN, &pp->state);
+
 	phylink_stop(pp->phylink);
 
 	if (!pp->neta_armada3700) {


