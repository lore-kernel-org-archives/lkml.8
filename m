Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0697620716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221553;
	bh=/0hs1BMJug76hD76DDn1hUvFOfwgJOJkSsrfJoSqd8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nWLKcjxAKGDjiqI4uV6dRbKfPqJ0Om5MdivTHlRMYq2za02mPpItPflEosdBU1zPv
	 m0bc1SV+CNlfH9hJaHYQigMsGCEUO8QWjaAcvmCSGslrQILYmXoasMiizgF7L0/T3J
	 Xo75SqtEcI32BpSjSjJSHTxV8QPSJKYnbfrw9F1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgA1OZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:25:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgA1OZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:25:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B835424686;
        Tue, 28 Jan 2020 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221550;
        bh=/0hs1BMJug76hD76DDn1hUvFOfwgJOJkSsrfJoSqd8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGfCOSVWTJRs1YSwjQLvv2QVUdCsTIZ52y4kn+hbBojhYb19k5sb/whR/X1fUrr+K
         myJ8guGLhp7HssYyqsj0kYSxBU0+K96UnzR7WdZR44KyU6sxZc+dljL2l0JqsJR6r1
         8PEE6iKk7qbrcSc3NiA66OsX/JAjUf8tI18o0yEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 233/271] net: phy: Keep reporting transceiver type
Date:   Tue, 28 Jan 2020 15:06:22 +0100
Message-Id: <20200128135909.908143382@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit ceb628134a75564d7bfa8e4ef902e6e588339e11 upstream.

With commit 2d55173e71b0 ("phy: add generic function to support
ksetting support"), we lost the ability to report the transceiver type
like we used to. Now that we have added back the transceiver type to
ethtool_link_settings, we can report it back like we used to and have no
loss of information.

Fixes: 3f1ac7a700d0 ("net: ethtool: add new ETHTOOL_xLINKSETTINGS API")
Fixes: 2d55173e71b0 ("phy: add generic function to support ksetting support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/phy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -463,7 +463,8 @@ int phy_ethtool_ksettings_get(struct phy
 		cmd->base.port = PORT_BNC;
 	else
 		cmd->base.port = PORT_MII;
-
+	cmd->base.transceiver = phy_is_internal(phydev) ?
+				XCVR_INTERNAL : XCVR_EXTERNAL;
 	cmd->base.phy_address = phydev->mdio.addr;
 	cmd->base.autoneg = phydev->autoneg;
 	cmd->base.eth_tp_mdix_ctrl = phydev->mdix;


