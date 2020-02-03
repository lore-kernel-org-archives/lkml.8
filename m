Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2623C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547620679
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XCcsIbra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBCBRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:17:37 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:33544 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgBCBRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Pg3gkrEgnoEJZvScerIJAe8qFqPzR9YYna0FwRjFm7o=; b=XCcsIbraVVxu09hQ48MivZvB0t
        UfJy4x1mw9yDLP+x8cZ+XbGcFpTZUiDqyRoue72qfI581UN5Jykk2p1hEzYKxDqeLBbgk314swsyB
        ape3NVBZ5LfqKd9/r36MIY1wunNIB2XtQlliGPOMr3VWdjfNDvj+QYXHNsgC7YcN91qs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1iyQMm-0007wh-5O; Mon, 03 Feb 2020 02:17:32 +0100
Date:   Mon, 3 Feb 2020 02:17:32 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, netdev@vger.kernel.org,
        opendmb@gmail.com, davem@davemloft.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net,
        hkallweit1@gmail.com
Subject: Re: [PATCH 2/6] net: bcmgenet: refactor phy mode configuration
Message-ID: <20200203011732.GB30319@lunn.ch>
References: <20200201074625.8698-1-jeremy.linton@arm.com>
 <20200201074625.8698-3-jeremy.linton@arm.com>
 <b2d45990-af71-60c3-a210-b23dabb9ba32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d45990-af71-60c3-a210-b23dabb9ba32@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 08:24:14AM -0800, Florian Fainelli wrote:
> 
> 
> On 1/31/2020 11:46 PM, Jeremy Linton wrote:
> > The DT phy mode is similar to what we want for ACPI
> > lets factor it out of the of path, and change the
> > of_ call to device_. Further if the phy-mode property
> > cannot be found instead of failing the driver load lets
> > just default it to RGMII.
> 
> Humm no please do not provide a fallback, if we cannot find a valid
> 'phy-mode' property we error out. This controller can be used with a
> variety of configurations (internal EPHY/GPHY, MoCA, external
> MII/Reverse MII/RGMII) and from a support perspective it is much easier
> for us if the driver errors out if one of those essential properties are
> omitted.

Hi Florian

Does any of the silicon variants have two or more MACs sharing one
MDIO bus? I'm thinking about the next patch in the series.

     Thanks
	Andrew
