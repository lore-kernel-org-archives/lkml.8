Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5C720708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nD/2Mhlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgETN4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:56:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41284 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgETN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yW9W/HhlxheuNaE5i574WexC9r5Wyq1J3+gq8UzHE+Q=; b=nD/2Mhlv7UcVTvWEFNNokHYfcu
        uQbQ6t/mZCHTTAvEUgO8TnmDiQ3iJmGwLFsq4IqH/+G7AcXDwmcrkzBVgqE8nkuh9txLbOLNl8qQw
        KTMcEBTtxzfJi85j0acg0xofLT1SozMJE5gNJeZU0EDs8f2Qml/f52Oc8ybr6wTvRWi4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jbPCq-002oL3-GJ; Wed, 20 May 2020 15:56:24 +0200
Date:   Wed, 20 May 2020 15:56:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     f.fainelli@gmail.com, hkallweit1@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] dt-bindings: net: Add RGMII internal
 delay for DP83869
Message-ID: <20200520135624.GC652285@lunn.ch>
References: <20200520121835.31190-1-dmurphy@ti.com>
 <20200520121835.31190-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520121835.31190-4-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 07:18:34AM -0500, Dan Murphy wrote:
> Add the internal delay values into the header and update the binding
> with the internal delay properties.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/net/ti,dp83869.yaml    | 16 ++++++++++++++++
>  include/dt-bindings/net/ti-dp83869.h           | 18 ++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83869.yaml b/Documentation/devicetree/bindings/net/ti,dp83869.yaml
> index 5b69ef03bbf7..344015ab9081 100644
> --- a/Documentation/devicetree/bindings/net/ti,dp83869.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,dp83869.yaml
> @@ -64,6 +64,20 @@ properties:
>         Operational mode for the PHY.  If this is not set then the operational
>         mode is set by the straps. see dt-bindings/net/ti-dp83869.h for values
>  
> +  ti,rx-internal-delay:
> +    $ref: /schemas/types.yaml#definitions/uint32
> +    description: |
> +      RGMII Receive Clock Delay - see dt-bindings/net/ti-dp83869.h
> +      for applicable values. Required only if interface type is
> +      PHY_INTERFACE_MODE_RGMII_ID or PHY_INTERFACE_MODE_RGMII_RXID.

Hi Dan

Having it required with PHY_INTERFACE_MODE_RGMII_ID or
PHY_INTERFACE_MODE_RGMII_RXID is pretty unusual. Normally these
properties are used to fine tune the delay, if the default of 2ns does
not work.

    Andrew
