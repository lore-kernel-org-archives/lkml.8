Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31424C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4B22082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 01:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jSaH2Q4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0BEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:04:24 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60746 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgC0BEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 21:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3UcsOfX95DPSSaRET+CgSDn9fXS+kEsbVaRueLTLwDc=; b=jSaH2Q4xc69YOR8DPSFLChL9Ko
        CpahMLlTgUwyCaZWQgavyyYqe0jjGxL+gdHBwke4N4vaVuZRgRPWhVtQjLvFaGhQ9JWt916qRY78w
        ff8a2OWQYBRkXdaAAz+B/SzMcLcxNWRhPA1q7EG3hMj2IRbJqnIeoaER1OBBgB+73lPM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jHdPv-0005JK-KJ; Fri, 27 Mar 2020 02:04:11 +0100
Date:   Fri, 27 Mar 2020 02:04:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] dt-bindings: net: add backplane dt bindings
Message-ID: <20200327010411.GM3819@lunn.ch>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
 <1585230682-24417-3-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585230682-24417-3-git-send-email-florinel.iordache@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 03:51:15PM +0200, Florinel Iordache wrote:
> Add ethernet backplane device tree bindings

> +  - |
> +    /* Backplane configurations for specific setup */
> +    &mdio9 {
> +        bpphy6: ethernet-phy@0 {
> +            compatible = "ethernet-phy-ieee802.3-c45";
> +            reg = <0x0>;
> +            lane-handle = <&lane_d>; /* use lane D */
> +            eq-algorithm = "bee";
> +            /* 10G Short cables setup: up to 30 cm cable */
> +            eq-init = <0x2 0x5 0x29>;
> +            eq-params = <0>;
> +        };
> +    };

So you are modelling this as just another PHY? Does the driver get
loaded based on the PHY ID in registers 2 and 3? Does the standard
define these IDs or are they vendor specific?

Thanks
	Andrew
