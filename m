Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2775C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7710D206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326865;
	bh=2+qcIOCOkKHZNw4l4h7nefYzKid9thmlUS+TXFtvQ5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sfiUXGQFIdpqBffY4/T+cRnn2gz0LPBaAtedfCD87yzyY2U61A/OM/wWfkasmtiTM
	 7pvO7vGjwooWl1g8smR1tQqhLAIklN2Nk1v6glMQBJEoshuMZerXWLWWKHwBjnF7bA
	 bnJy0JWYXjmp3rq04eQ75mjq06PvMTNPc0eIvaT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgCPCro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:47:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729348AbgCPCro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:47:44 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EA02051A;
        Mon, 16 Mar 2020 02:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326863;
        bh=2+qcIOCOkKHZNw4l4h7nefYzKid9thmlUS+TXFtvQ5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uLczIeoOq59Jz02rRHZvUWao/SCC5s6iUN2NnBAjGYYCV7VwdGlLthl9Ic3mzsjQz
         az36797F0eejGPaBJCqYq9bcpO14f+epnG48RGUYPMLFjlg4RFnjbR589tn0ftHtcV
         4J2+YDwm1eZD+RDXWivRF0MWbgvp6U9H5N4Ns8jI=
Date:   Mon, 16 Mar 2020 10:47:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 0/2] properly define some of PHYs
Message-ID: <20200316024735.GB17221@dragon>
References: <20200313102534.5438-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313102534.5438-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:25:32AM +0100, Oleksij Rempel wrote:
> changes v3:
> - add phy-handle on the marsboard
> 
> changes v2:
> - remove spaces
> 
> Oleksij Rempel (2):
>   ARM: dts: imx6dl-riotboard: properly define rgmii PHY
>   ARM: dts: imx6q-marsboard: properly define rgmii PHY

Applied both, thanks.
