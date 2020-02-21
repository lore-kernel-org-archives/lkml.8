Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB5DC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F27824670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271773;
	bh=GenGKx8klKN5QOWUcat6rkevYzH+j2MnwyEAoetKWvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BmZvgwx8phEpGFjLkDfd0P5N0Qs1Co03QNrm+T9Ic1y2Gd6BcYSXdsLu2hn69GzIR
	 arl3HwS15Rs3pQshL3yUofBIyCX/1qjtMWwjFt5D85u52L3Id5wjdxsx2dxLFZW+52
	 UBEzoN/z8MnaZp4pjERWt48gPrOa4wh8Et0SsmZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgBUH4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbgBUH4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:56:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28CD124672;
        Fri, 21 Feb 2020 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271768;
        bh=GenGKx8klKN5QOWUcat6rkevYzH+j2MnwyEAoetKWvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wuypue4I6qZKWA/mvksSHqd2A2SZU4xJX1Es5tJee8F58WDF4GaH+g5lFb3S6bH3c
         MCYu3QDSAuV+dAfJttpvAG3xk2/HGWM8yCLg6QtJNvTEdN5rSM+xJD3NQi9UEgoE8z
         RbiwvXN3EmfBNfOgfgmK4wHFgFs7wyjBLYcLyv8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 292/399] enetc: Dont print from enetc_sched_speed_set when link goes down
Date:   Fri, 21 Feb 2020 08:40:17 +0100
Message-Id: <20200221072430.170548830@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 90f29f0eada4d60e1f6ae537502ddb2202b9540d ]

It is not an error to unplug a cable from the ENETC port even with TSN
offloads, so don't spam the log with link-related messages from the
tc-taprio offload subsystem, a single notification is sufficient:

[10972.351859] fsl_enetc 0000:00:00.0 eno0: Qbv PSPEED set speed link down.
[10972.360241] fsl_enetc 0000:00:00.0 eno0: Link is Down

Fixes: 2e47cb415f0a ("enetc: update TSN Qbv PSPEED set according to adjust link speed")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 9190ffc9f6b21..de52686b1d467 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -36,7 +36,6 @@ void enetc_sched_speed_set(struct net_device *ndev)
 	case SPEED_10:
 	default:
 		pspeed = ENETC_PMR_PSPEED_10M;
-		netdev_err(ndev, "Qbv PSPEED set speed link down.\n");
 	}
 
 	priv->speed = speed;
-- 
2.20.1



