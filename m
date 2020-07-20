Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C688AC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CD1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260694;
	bh=42ZBXODhq5BpWumeFX35MNnecSl5RayteF8dGttwFtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pxsl00o8x4QRVCxz9j1iU/PtvuDFaPOmyF7KXV5+rkmKORHFGxc6OZCxPMipFew1n
	 J40vWn+qNgc6IVX+SHY/YuBAPX+70U49ov6sstD+jseyWllxYwZNTJTQg2uqD8zTqb
	 vuxnZTJDPx8lmnvmnwz9wBC60vmwWNg24SW7aBm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbgGTP6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731997AbgGTP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:58:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C978B206E9;
        Mon, 20 Jul 2020 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260689;
        bh=42ZBXODhq5BpWumeFX35MNnecSl5RayteF8dGttwFtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8y0nKnFrhuF6bFyRtKQsGJAGbRjGl3S+WsimUCUcewru2y16mfb7uvDTHl2bYzfY
         zD3v73mhBPqMTD8iBifDb4KEx55QUnfP2pQwk2n/XwFOByMxOtgAyWAjSn5VdBBUSs
         cCE9EefL5wrmQvF1oeWehV17uYzcgjXEb7rlpLqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 059/215] net: ethernet: mvneta: Do not error out in non serdes modes
Date:   Mon, 20 Jul 2020 17:35:41 +0200
Message-Id: <20200720152823.015500470@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit d3d239dcb8aae6d7b10642d292b404e57604f7ea ]

In mvneta_config_interface() the RGMII modes are catched by the default
case which is an error return. The RGMII modes are valid modes for the
driver, so instead of returning an error add a break statement to return
successfully.

This avoids this warning for non comphy SoCs which use RGMII, like
SolidRun Clearfog:

WARNING: CPU: 0 PID: 268 at drivers/net/ethernet/marvell/mvneta.c:3512 mvneta_start_dev+0x220/0x23c

Fixes: b4748553f53f ("net: ethernet: mvneta: Fix Serdes configuration for SoCs without comphy")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index ffdb7b113f172..d443cd19e8951 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3206,7 +3206,7 @@ static int mvneta_config_interface(struct mvneta_port *pp,
 				    MVNETA_HSGMII_SERDES_PROTO);
 			break;
 		default:
-			return -EINVAL;
+			break;
 		}
 	}
 
-- 
2.25.1



