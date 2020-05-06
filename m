Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B1C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E6F2076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hy7KlVWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEFPHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:07:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45264 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgEFPHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nhr9qd9ThMfni7QzQ5SF9W0ZpuyW47KCsL9Tm7+P44g=; b=Hy7KlVWCuIvr3QKj0XXtpllydw
        UINzSvoHOwbVO4XMFtC4xzbpUQy1A+v9fbAV9wVkKCXTsQ8yiIQj5y0PYIoZCCUkT03lKIjkX9HKO
        FIdp2/ubpCX0vdavYJmOTzzfPK9EDEGWe92ijdKO888WYD4uXbggRdmvzVemksyj+jsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jWLeE-0016AI-QR; Wed, 06 May 2020 17:07:46 +0200
Date:   Wed, 6 May 2020 17:07:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: net: nxp,tja11xx: rework validation
 support
Message-ID: <20200506150746.GJ224913@lunn.ch>
References: <20200505104215.8975-1-o.rempel@pengutronix.de>
 <20200505140127.GJ208718@lunn.ch>
 <20200506051134.mrm4nuqxssw255tl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506051134.mrm4nuqxssw255tl@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Oleksij
> > 
> > reg is normally 0 to 31, since that is the address range for MDIO. 
> > Did you use 14 here because of what strapping allows?
> 
> Yes. Only BITs 1:3 are configurable. BIT(0) is always 0 for the PHY0 and 1
> for the PHY1

O.K. good.

> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#address-cells'
> > > +  - '#size-cells'
> > 
> > So we have two different meanings of 'required' here.
> > 
> > One meaning is the code requires it. compatible is not required, the
> > driver will correctly be bind to the device based on its ID registers.
> > Is reg also required by the code?
> > 
> > The second meaning is about keeping the yaml verifier happy. It seems
> > like compatible is needed for the verifier. Is reg also required? We
> > do recommend having reg, but the generic code does not require it.
> 
> reg is used by:
> tja1102_p0_probe()
>   tja1102_p1_register()
>     of_mdio_parse_addr()
> 
> But this is required for the slave PHY. I assume the reg can be
> optional for the master PHY. Should I?

It is recommended to have a reg value. So lets leave it as is for the
moment. If anybody really does need it to be optional, we can change
it later.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
