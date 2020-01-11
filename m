Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934AC33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5408A20678
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738836;
	bh=v3mttVPp1GerNJolr6lWCMYoGvxolo6C6ng1zXOq1eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cCymmsB1lzblKXUNooaM7zgGzkihMH76+Tye8S6WFfJnr5BouXukre4iRxg3ClJCg
	 aJzP0I1ueJH/jsEgbx3z4YCKObw07nOfkn1FXVdevxvX5NLWXYjfwQA2aBr3xTC3qP
	 bfmp2jimK3F+MBg21Keef9ODR34cSXMZWMz/lKv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgAKKdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731148AbgAKKdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:33:49 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D1D20678;
        Sat, 11 Jan 2020 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738829;
        bh=v3mttVPp1GerNJolr6lWCMYoGvxolo6C6ng1zXOq1eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKEv0Nk+bKcXKpotDNz0uXs19w4qXdmrcwz7fndt7d93SMTw3G9Kx7BOb4yFlExqy
         fmlQ74E2Ms4jm5dImh/P79VjenBHbcekXHaaWxxvYPDo899/z0Kp1RFv5whkiWtAQs
         3KTCjTaRTryN06B7WIlwDbyQ3T9aUl8GuZIiUCDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Sriram Dash <Sriram.dash@samsung.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 144/165] net: stmmac: Fixed link does not need MDIO Bus
Date:   Sat, 11 Jan 2020 10:51:03 +0100
Message-Id: <20200111094939.030296312@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit da29f2d84bd10234df570b7f07cbd0166e738230 ]

When using fixed link we don't need the MDIO bus support.

Reported-by: Heiko Stuebner <heiko@sntech.de>
Reported-by: kernelci.org bot <bot@kernelci.org>
Fixes: d3e014ec7d5e ("net: stmmac: platform: Fix MDIO init for platforms without PHY")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Acked-by: Sriram Dash <Sriram.dash@samsung.com>
Tested-by: Patrice Chotard <patrice.chotard@st.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail> # Lamobo R1 (fixed-link + MDIO sub node for roboswitch).
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -320,7 +320,7 @@ out:
 static int stmmac_dt_phy(struct plat_stmmacenet_data *plat,
 			 struct device_node *np, struct device *dev)
 {
-	bool mdio = false;
+	bool mdio = !of_phy_is_fixed_link(np);
 	static const struct of_device_id need_mdio_ids[] = {
 		{ .compatible = "snps,dwc-qos-ethernet-4.10" },
 		{},


