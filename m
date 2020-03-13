Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F3C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD48E20674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VZNpBmBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCMSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:11:05 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34188 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMSLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W9a+0fAfmG82n7GJfhOGZ1nPwnwMa9XduCIBZsnFc4w=; b=VZNpBmBl5ZDoTsrw2KG7/2ePeo
        rrMX3dnNGMHXy4ZbZf385u23KVedALl8eCkeIyeRUI+rFglkBfZBJh/BI41sIcZAbj05KU48ihh9a
        IYcYP5VhpedG8cV73sM6yY9PlBh+ZcICtocOUkNvx9x2127drCFT9mW8GNZbKF6lHB0Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jCols-0007vu-Mk; Fri, 13 Mar 2020 19:10:56 +0100
Date:   Fri, 13 Mar 2020 19:10:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Marek Vasut <marex@denx.de>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: net: phy: Add support for NXP TJA11xx
Message-ID: <20200313181056.GA29732@lunn.ch>
References: <20200313052252.25389-1-o.rempel@pengutronix.de>
 <20200313052252.25389-2-o.rempel@pengutronix.de>
 <545d5e46-644a-51fb-0d67-881dfe23e9d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545d5e46-644a-51fb-0d67-881dfe23e9d8@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> > new file mode 100644
> > index 000000000000..42be0255512b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/nxp,tja11xx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP TJA11xx PHY
> > +
> > +maintainers:
> > +  - Andrew Lunn <andrew@lunn.ch>
> > +  - Florian Fainelli <f.fainelli@gmail.com>
> > +  - Heiner Kallweit <hkallweit1@gmail.com>
> > +
> > +description:
> > +  Bindings for NXP TJA11xx automotive PHYs
> > +
> > +allOf:
> > +  - $ref: ethernet-phy.yaml#
> > +
> > +patternProperties:
> > +  "^ethernet-phy@[0-9a-f]+$":
> > +    type: object
> > +    description: |
> > +      Some packages have multiple PHYs. Secondary PHY should be defines as
> > +      subnode of the first (parent) PHY.
> 
> 
> There are QSGMII PHYs which have 4 PHYs embedded and AFAICT they are
> defined as 4 separate Ethernet PHY nodes and this would not be quite a
> big stretch to represent them that way compared to how they are.
> 
> I would recommend doing the same thing and not bend the MDIO framework
> to support the registration of "nested" Ethernet PHY nodes.

Hi Florian

The issue here is the missing PHY ID in the secondary PHY. Because of
that, the secondary does not probe in the normal way. We need the
primary to be involved to some degree. It needs to register it. What
i'm not so clear on is if it just needs to register it, or if these
sub nodes are actually needed, given the current code.

    Andrew
