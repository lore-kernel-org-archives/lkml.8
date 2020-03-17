Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89B8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9441A20658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442597;
	bh=ETFrA/e9LYaR6+n3BQdUrrbh5mvc9XG/eiCN+ei6OAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQdnAXSuWq9CGKbrzm9U9tlbOj2zLyr6NO8GEHo7vvKmC9n7nqn6DlDLlpF+6xkoH
	 lKOBh3rrBC7AP889BoO8JCl57FPXVWOEUDQVhbB5kBgUxA9VnYKQJ4u7v2cWJPM5FM
	 hLVANpay7r+AgTYEafS8wig0Imm4TdTD1gPT9axA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCQK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgCQK4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:56:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C4B20719;
        Tue, 17 Mar 2020 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442592;
        bh=ETFrA/e9LYaR6+n3BQdUrrbh5mvc9XG/eiCN+ei6OAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBkC6qS//8D82tHJCz8OwwRPwhu02sIWuNKCN+aa6wYsmMAOvjvue9jT3cpIRs7ON
         rvUAR5+4qf3eBrXGdud4zcofM51DrLOrzfrptDeJMkTZpEc6GAAVN6qfBcNXVEAGO2
         Lrxz1Y5BOu9xGxXnqCtNgKVHSNhHntJW4GZehZ6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Remi Pommarel <repk@triplefau.lt>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/89] net: stmmac: dwmac1000: Disable ACS if enhanced descs are not used
Date:   Tue, 17 Mar 2020 11:54:25 +0100
Message-Id: <20200317103301.835538422@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit b723bd933980f4956dabc8a8d84b3e83be8d094c ]

ACS (auto PAD/FCS stripping) removes FCS off 802.3 packets (LLC) so that
there is no need to manually strip it for such packets. The enhanced DMA
descriptors allow to flag LLC packets so that the receiving callback can
use that to strip FCS manually or not. On the other hand, normal
descriptors do not support that.

Thus in order to not truncate LLC packet ACS should be disabled when
using normal DMA descriptors.

Fixes: 47dd7a540b8a0 ("net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -34,6 +34,7 @@
 static void dwmac1000_core_init(struct mac_device_info *hw,
 				struct net_device *dev)
 {
+	struct stmmac_priv *priv = netdev_priv(dev);
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value = readl(ioaddr + GMAC_CONTROL);
 	int mtu = dev->mtu;
@@ -45,7 +46,7 @@ static void dwmac1000_core_init(struct m
 	 * Broadcom tags can look like invalid LLC/SNAP packets and cause the
 	 * hardware to truncate packets on reception.
 	 */
-	if (netdev_uses_dsa(dev))
+	if (netdev_uses_dsa(dev) || !priv->plat->enh_desc)
 		value &= ~GMAC_CONTROL_ACS;
 
 	if (mtu > 1500)


