Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04299207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593650384;
	bh=P8fZ7wLIZb9XIEuk9wytaWAOS7o0sAtIG3fEl3xQ+UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=u1IJwZNGcQInaiGucOQBogAyflyIDfaTuFLhenomXUeLftoi3lolwr8nh1+GsVSQz
	 zcPr+Z6lPtjBqDs7tMbIx2qV3qb8bjPhDu2Td7CRlx8sJ4fVR48OWgHSvF0Nj2mJqR
	 UGyAMS7HpGMtbJX791eRxmcvIrBrTyVz3iKsHYtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgGBAjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:39:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgGBAjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:39:39 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EBF20748;
        Thu,  2 Jul 2020 00:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593650379;
        bh=P8fZ7wLIZb9XIEuk9wytaWAOS7o0sAtIG3fEl3xQ+UY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d1SwKu/dTkBR/3Le9LuFt11WHL0+10LqBBfTLaDxStfwKbGKlemVHGDtBp9sQMrMu
         z96XjcEW2qbWQe/NO1mvw/vSyWi1vwrbPL/Hn7U4c/0RHMXRQfr+6cuDD/yr/2VHKv
         PcMBF2v5q2xkfxBpdXcL6Yyg1rFZ28cgx9POVupo=
Date:   Wed, 1 Jul 2020 17:39:37 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND net-next v3 2/3] net: enetc: Initialize SerDes
 for SGMII and USXGMII protocols
Message-ID: <20200701173937.2fa5b3e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200701213433.9217-3-michael@walle.cc>
References: <20200701213433.9217-1-michael@walle.cc>
        <20200701213433.9217-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Jul 2020 23:34:32 +0200 Michael Walle wrote:
> ENETC has ethernet MACs capable of SGMII, 2500BaseX and USXGMII. But in
> order to use these protocols some SerDes configurations need to be
> performed. The SerDes is configurable via an internal PCS PHY which is
> connected to an internal MDIO bus at address 0.
> 
> This patch basically removes the dependency on bootloader regarding
> SerDes initialization.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

This does not build

../drivers/net/ethernet/freescale/enetc/enetc_pf.c:879:2: error: implicit declaration of function `devm_mdiobus_free`; did you mean `devm_mdiobus_alloc`? [-Werror=implicit-function-declaration]
  879 |  devm_mdiobus_free(dev, bus);
      |  ^~~~~~~~~~~~~~~~~
      |  devm_mdiobus_alloc
