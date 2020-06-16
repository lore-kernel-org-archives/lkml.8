Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B876C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F362221527
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322821;
	bh=WnTyGsaaTwpglz9AY7FVbY8tX7Y+mXaO6yC61jXM2eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4IJ1jHX2DTHX9zwAl8eAhBz16Svj8Zh1SdKs8SjxOr2YpR1aCXMHkERAWqRGai4l
	 beWIZkIOsZToRN6zF3i9j+raNw453FumnKHad3AZcpYeQXKNXPZGmIHKIu3TTzuODu
	 6X9+5wtb3PuexqkWyRpoMBXQi5HKtHYV1Dwx2qRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgFPPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgFPPxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81579208D5;
        Tue, 16 Jun 2020 15:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322810;
        bh=WnTyGsaaTwpglz9AY7FVbY8tX7Y+mXaO6yC61jXM2eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvKYFsrQ4WOaYKDMxTyvnLK7mk6LgvgnfNglGoPh3yM7c5ZaumshuS0V3sWV55GYK
         J58a06867tOsH5My262TEHNiT0Icf/Wp3VHbECO55kz1/RZFfK8Mt09MhKc9IBquNK
         rjUpHwi45nnRQ5XLyyIl72uzhO+WPZC+brkZiUlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 113/161] net: macb: Only disable NAPI on the actual error path
Date:   Tue, 16 Jun 2020 17:35:03 +0200
Message-Id: <20200616153111.738712796@linuxfoundation.org>
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
@@ -2552,15 +2552,14 @@ static int macb_open(struct net_device *
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


