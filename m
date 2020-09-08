Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B362C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 213422078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593238;
	bh=qGT3/ySqSqFR13Q+ieA5/jBlGs2udlquAiRUcFkiAeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eD5np4znG3vLaVOVTW/mdJ6ElTQW892LjjOVnCSaL6B40jfmFDnhmgkX1McQzGzgO
	 NdMEk4S4seGNfpr93Wa2z2Zh80X82t4P86c6ib558x4OPXZ5FeFR7Fzvsn0R4eAXSn
	 k/4H2zAls8WOYdmzUM5fC/FocCknXRHL2FwjsfLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbgIHT1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbgIHQAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:00:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9ED2404D;
        Tue,  8 Sep 2020 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579492;
        bh=qGT3/ySqSqFR13Q+ieA5/jBlGs2udlquAiRUcFkiAeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=opQPvir0AxgMCWno4AZpd1owBhpmIl+CRxgrzMEuCliHzCG77WP9xIwo76DE74C2J
         /xreb6KxZdaL+kZizMHbxtLtrESUlnWycWfPKug7B+Nydq5HEebVIp2j2mS2k7Opf8
         FjJp7nWQdRzIAHgQCZroXH/JoVKm5995g+iiUhlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 100/186] net: dp83867: Fix WoL SecureOn password
Date:   Tue,  8 Sep 2020 17:24:02 +0200
Message-Id: <20200908152246.483465624@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>

[ Upstream commit 8b4a11c67da538504d60ae917ffe5254f59b1248 ]

Fix the registers being written to as the values were being over written
when writing the same registers.

Fixes: caabee5b53f5 ("net: phy: dp83867: support Wake on LAN")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83867.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index f3c04981b8da6..cd7032628a28c 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -215,9 +215,9 @@ static int dp83867_set_wol(struct phy_device *phydev,
 		if (wol->wolopts & WAKE_MAGICSECURE) {
 			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFSOP1,
 				      (wol->sopass[1] << 8) | wol->sopass[0]);
-			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFSOP1,
+			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFSOP2,
 				      (wol->sopass[3] << 8) | wol->sopass[2]);
-			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFSOP1,
+			phy_write_mmd(phydev, DP83867_DEVADDR, DP83867_RXFSOP3,
 				      (wol->sopass[5] << 8) | wol->sopass[4]);
 
 			val_rxcfg |= DP83867_WOL_SEC_EN;
-- 
2.25.1



