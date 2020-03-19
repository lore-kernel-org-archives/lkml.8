Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60533C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D68214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623440;
	bh=0LqicDmr77Al2eNygVgMYr2Fnd3p52bjdgDexKNOop8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ib/HNHZu7wKNSNXTvft7kjVDRtNKLsb/VTtCiwWAlAqZGxIh82ElsiAZaMLHum9sv
	 z4V2BSaYySBwQ1LxPfGFbmTskCYwHfJvqJ/KqHqI2cb0+gSINBicBexCQFOJyDhVOv
	 QfakpXBV2RFmGeKUSs0i4ffQzo3gfewEv76fps6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgCSNKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgCSNKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:10:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66BC214D8;
        Thu, 19 Mar 2020 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623435;
        bh=0LqicDmr77Al2eNygVgMYr2Fnd3p52bjdgDexKNOop8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYs1ZOQKuAEnZqHXu+68+WI3i6rCaI6Ishv8PHkg2KSebNuJXEOdjfxSZIqncNTiy
         zCZkk8HX0OtTFJGa+7CN5TJ6Lh3Ak81/aU2KldqQ+Rofhiwa5iL4jDkYsGxOAPyHgb
         RVYhlJF1YnNK5uECtyA1h12E6x10phoXBlU8K8z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 26/90] net: fec: validate the new settings in fec_enet_set_coalesce()
Date:   Thu, 19 Mar 2020 13:59:48 +0100
Message-Id: <20200319123936.553181277@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ab14961d10d02d20767612c78ce148f6eb85bd58 ]

fec_enet_set_coalesce() validates the previously set params
and if they are within range proceeds to apply the new ones.
The new ones, however, are not validated. This seems backwards,
probably a copy-paste error?

Compile tested only.

Fixes: d851b47b22fc ("net: fec: add interrupt coalescence feature support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2470,15 +2470,15 @@ fec_enet_set_coalesce(struct net_device
 		return -EINVAL;
 	}
 
-	cycle = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->rx_coalesce_usecs);
 	if (cycle > 0xFFFF) {
 		pr_err("Rx coalesced usec exceed hardware limitation\n");
 		return -EINVAL;
 	}
 
-	cycle = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
+	cycle = fec_enet_us_to_itr_clock(ndev, ec->tx_coalesce_usecs);
 	if (cycle > 0xFFFF) {
-		pr_err("Rx coalesced usec exceed hardware limitation\n");
+		pr_err("Tx coalesced usec exceed hardware limitation\n");
 		return -EINVAL;
 	}
 


