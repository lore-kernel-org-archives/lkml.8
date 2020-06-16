Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ABEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E61208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323715;
	bh=Nd5CAFcb1qbBMYToCoK0811GTdwgJBHbQfz1EiufNmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BhKkxD3UqqeSHZKgUE5plSsdMI56AkT8H11Rw3VOjQsF2LwFoEabVwYJH3EWmMkhI
	 ztleZ61Bu0APXaqgqI07e8vnhVThiu3KodrSxG+Iq10tEtxDj6uZVc31gBIFQEx5B6
	 81/eX10u0XxcF1C5lwGe2TDesc00DedXEn3wne10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbgFPQIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgFPPqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF9920776;
        Tue, 16 Jun 2020 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322371;
        bh=Nd5CAFcb1qbBMYToCoK0811GTdwgJBHbQfz1EiufNmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K461u75HZ4comF2yE/IYWr/5p2lXYfihChaHvR44XU8P/QGFPIOjMOkKmpnpMdBFc
         IVVdJC7BKAasxQ/yL4dKYENAERBuNAUv9oIxsdX+lEy9eTp8TuTBzJbqYkLuBcp2vV
         1KM0M7RNaGkws8bL+iWg2G0sogUk88arE8+irfe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 106/163] net: macb: Only disable NAPI on the actual error path
Date:   Tue, 16 Jun 2020 17:34:40 +0200
Message-Id: <20200616153111.895371384@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 939a5bf7c9b7a1ad9c5d3481c93766a522773531 ]

A recent change added a disable to NAPI into macb_open, this was
intended to only happen on the error path but accidentally applies
to all paths. This causes NAPI to be disabled on the success path, which
leads to the network to no longer functioning.

Fixes: 014406babc1f ("net: cadence: macb: disable NAPI on error")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Corentin Labbe <clabbe@baylibre.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2565,15 +2565,14 @@ static int macb_open(struct net_device *
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_init(dev);
 
+	return 0;
+
 napi_exit:
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
 		napi_disable(&queue->napi);
 pm_exit:
-	if (err) {
-		pm_runtime_put_sync(&bp->pdev->dev);
-		return err;
-	}
-	return 0;
+	pm_runtime_put_sync(&bp->pdev->dev);
+	return err;
 }
 
 static int macb_close(struct net_device *dev)


