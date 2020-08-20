Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769BE2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918969;
	bh=jCWSzzWsnZtuQtsA6NucjMeHiaQf7lh9jvPojgITP9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AzXDMAdjWdiQayUlqaZY5id0i5iBnjIyLgGIuZrUGFHYsfrCYYLfQd/VeZz+juBJc
	 IZxLODvg2TDF13rjf6tsc9kf+PpDcMWxRv2zS+hTQZLATlVBc0TxisZ22Gxsi7jDkA
	 ZHSUG1eyLdxkNamvIFhfzrpNyXUy9U2wVMh0UQhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbgHTKWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731622AbgHTKW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:22:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA40C20658;
        Thu, 20 Aug 2020 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918947;
        bh=jCWSzzWsnZtuQtsA6NucjMeHiaQf7lh9jvPojgITP9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpg7ZyCYPvGcIYk8RstI0luI2dhDzpU2agIns3grTEUMTg3xMWFgJ6wDNLxmUuqfz
         Twh1J0kwjnMHlj2Eo8KNP+Ix9w8AWDkd9GlIonm1mCEvMzJOV2GI2x1P8BC1F09Bgg
         lk7XG4vJ2dUhg1YFVWoKlx92J/uu6spzoPxg9nEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan McDowell <noodles@earth.li>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 125/149] net: stmmac: dwmac1000: provide multicast filter fallback
Date:   Thu, 20 Aug 2020 11:23:22 +0200
Message-Id: <20200820092131.761492554@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>

commit 592d751c1e174df5ff219946908b005eb48934b3 upstream.

If we don't have a hardware multicast filter available then instead of
silently failing to listen for the requested ethernet broadcast
addresses fall back to receiving all multicast packets, in a similar
fashion to other drivers with no multicast filter.

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -146,6 +146,9 @@ static void dwmac1000_set_filter(struct
 		value = GMAC_FRAME_FILTER_PR;
 	} else if (dev->flags & IFF_ALLMULTI) {
 		value = GMAC_FRAME_FILTER_PM;	/* pass all multi */
+	} else if (!netdev_mc_empty(dev) && (mcbitslog2 == 0)) {
+		/* Fall back to all multicast if we've no filter */
+		value = GMAC_FRAME_FILTER_PM;
 	} else if (!netdev_mc_empty(dev)) {
 		struct netdev_hw_addr *ha;
 


