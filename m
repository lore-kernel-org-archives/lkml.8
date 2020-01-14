Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2093BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CBE2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996268;
	bh=78T+bpLA7/RmBMo8dSWS9SOZnKlKwg5JEWcCQl/VvCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ckKZDqoqO4rPHZB8Xyepn1dc3K9xqa6mJwfTuoknTV0KX8Hp4ZjsBSUQVOPXYRmvK
	 MVBevlHhdcTHK5zLCmieYgt9WMWC4grFomi2B8rQL2ZzLBI7obcXprFwGEgV772oFF
	 gUq+nZueBQ6p/n2N6XfwyoNtpsFN8/3owFnDcWx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgANKE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgANKEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:04:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A23B2467D;
        Tue, 14 Jan 2020 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996264;
        bh=78T+bpLA7/RmBMo8dSWS9SOZnKlKwg5JEWcCQl/VvCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s79UoxgYbGe95gf33bicFloLfeYz0vLPw7mnznJ2G4RPIyYwHbJYcHn2SxoUKsZYX
         BWKv712mbHGFlFamVOGj3/58Q7177rg0YjnwAvEMo9tqrsZin3oWJ/bwzkU3rdECwc
         A4m6gkYjhj0WUd4BxQrmcZdPjqpqwflD7BIWTZLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Faber <faber@faberman.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.4 35/78] can: mscan: mscan_rx_poll(): fix rx path lockup when returning from polling to irq mode
Date:   Tue, 14 Jan 2020 11:01:09 +0100
Message-Id: <20200114094358.333077052@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Faber <faber@faberman.de>

commit 2d77bd61a2927be8f4e00d9478fe6996c47e8d45 upstream.

Under load, the RX side of the mscan driver can get stuck while TX still
works. Restarting the interface locks up the system. This behaviour
could be reproduced reliably on a MPC5121e based system.

The patch fixes the return value of the NAPI polling function (should be
the number of processed packets, not constant 1) and the condition under
which IRQs are enabled again after polling is finished.

With this patch, no more lockups were observed over a test period of ten
days.

Fixes: afa17a500a36 ("net/can: add driver for mscan family & mpc52xx_mscan")
Signed-off-by: Florian Faber <faber@faberman.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/mscan/mscan.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -381,13 +381,12 @@ static int mscan_rx_poll(struct napi_str
 	struct net_device *dev = napi->dev;
 	struct mscan_regs __iomem *regs = priv->reg_base;
 	struct net_device_stats *stats = &dev->stats;
-	int npackets = 0;
-	int ret = 1;
+	int work_done = 0;
 	struct sk_buff *skb;
 	struct can_frame *frame;
 	u8 canrflg;
 
-	while (npackets < quota) {
+	while (work_done < quota) {
 		canrflg = in_8(&regs->canrflg);
 		if (!(canrflg & (MSCAN_RXF | MSCAN_ERR_IF)))
 			break;
@@ -408,18 +407,18 @@ static int mscan_rx_poll(struct napi_str
 
 		stats->rx_packets++;
 		stats->rx_bytes += frame->can_dlc;
-		npackets++;
+		work_done++;
 		netif_receive_skb(skb);
 	}
 
-	if (!(in_8(&regs->canrflg) & (MSCAN_RXF | MSCAN_ERR_IF))) {
-		napi_complete(&priv->napi);
-		clear_bit(F_RX_PROGRESS, &priv->flags);
-		if (priv->can.state < CAN_STATE_BUS_OFF)
-			out_8(&regs->canrier, priv->shadow_canrier);
-		ret = 0;
+	if (work_done < quota) {
+		if (likely(napi_complete_done(&priv->napi, work_done))) {
+			clear_bit(F_RX_PROGRESS, &priv->flags);
+			if (priv->can.state < CAN_STATE_BUS_OFF)
+				out_8(&regs->canrier, priv->shadow_canrier);
+		}
 	}
-	return ret;
+	return work_done;
 }
 
 static irqreturn_t mscan_isr(int irq, void *dev_id)


