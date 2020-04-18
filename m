Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5465C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52662070B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JoYHbgnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgDROfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:35:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46466 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDROfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AZ/RMhwSUwQdo6J0IUbGcZIvgJfSETQ2FQQOLcJdtl4=; b=JoYHbgnQKNg8ELfaeVny9/OIK4
        /aBwVhAONEQbN7jZtN6XnTXuSLlkLV4qe1CJdpyDqSdhvi+k4xyxPGwzbG8a59i2WjFKDhffnxMkX
        mv2sAovqYEYe2TkU3ztt2F//DgZc/iqRZQlC4U8kwUpCxe74l7RDqPBreAm+yBfnSMUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jPoYp-003TBM-5f; Sat, 18 Apr 2020 16:35:11 +0200
Date:   Sat, 18 Apr 2020 16:35:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] dt-bindings: net: mdio: Document common
 properties
Message-ID: <20200418143511.GE804711@lunn.ch>
References: <20200418005126.15305-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418005126.15305-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 05:51:26PM -0700, Florian Fainelli wrote:
> Some of the properties pertaining to the broken turn around or resets
> were only documented in ethernet-phy.yaml while they are applicable
> across all MDIO devices and not Ethernet PHYs specifically which are a
> superset.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/net/mdio.yaml         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
> index 50c3397a82bc..58d486db5651 100644
> --- a/Documentation/devicetree/bindings/net/mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/mdio.yaml
> @@ -50,6 +50,33 @@ patternProperties:
>          description:
>            The ID number for the PHY.
>  
> +      broken-turn-around:
> +        $ref: /schemas/types.yaml#definitions/flag
> +        description:
> +          If set, indicates the PHY device does not correctly release
> +          the turn around line low at the end of a MDIO transaction.

Hi Florian

Since this is a generic property, maybe this should be "the MDIO
device"? Probably the whole document needs s/PHY/MDIO/g ?

	 Andrew
