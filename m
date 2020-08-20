Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CF4208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923793;
	bh=4OyUkUq0Yh9CrZVM8PSEZCcsieoLIBoIWas0+E+tPIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmqDItdGRJR44I3RNknpZ8Dkucj/urEPa31o8S7pakz4ddB6sI2JxTEMdp+Ip0Abj
	 XU9Aylx5Z0OMAwoomEpFQrlHR37gEjd6lHwvZ88KTSMGSltDyzSZU4tWMDabod/pET
	 MvcWRMrLdM2DvAxBqYBnRfNLWldKDHnEE+qe8mig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgHTLnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbgHTKED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:04:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C172075E;
        Thu, 20 Aug 2020 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917843;
        bh=4OyUkUq0Yh9CrZVM8PSEZCcsieoLIBoIWas0+E+tPIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EN228vdV+JACKSNqznYq5vYUjSi9N7HSP6l6zuYXgaFbfiJLqOp0hIpEbEhMzSReQ
         s/m+VOcKSWn8y+GaoV42Y9RXjT/xxtEeBDgL52BHbBGwsNTkeRr2bWCCJnbu1iZEpz
         E7uc3lzNSRbPfiIV2Ro9K3plWT0EaKF8xW5uswW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan McDowell <noodles@earth.li>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 178/212] net: stmmac: dwmac1000: provide multicast filter fallback
Date:   Thu, 20 Aug 2020 11:22:31 +0200
Message-Id: <20200820091611.380234529@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
@@ -172,6 +172,9 @@ static void dwmac1000_set_filter(struct
 		value = GMAC_FRAME_FILTER_PR;
 	} else if (dev->flags & IFF_ALLMULTI) {
 		value = GMAC_FRAME_FILTER_PM;	/* pass all multi */
+	} else if (!netdev_mc_empty(dev) && (mcbitslog2 == 0)) {
+		/* Fall back to all multicast if we've no filter */
+		value = GMAC_FRAME_FILTER_PM;
 	} else if (!netdev_mc_empty(dev)) {
 		struct netdev_hw_addr *ha;
 


