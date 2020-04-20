Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5A5206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P1Np4Olo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgDTT7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:59:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51904 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgDTT7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=T3mQKlhtFGHs08GyVcsfNUPTltwQz0CSj49TT0aYLW8=; b=P1Np4OloDgFFs80Ll4OLOvuvSC
        VSqwuxEmQpE2ZXTUWXpxyh8L6nYVRvzuZallxuqbat1Eoc0d/mR3KoWt+Ocn3vJjvPqi+d+2AQli3
        3rgHr08EN7Y5vTSwLc8qaMoQY6zBDHV6ToLAmz8c05ZW/TQC1kUUTdIeTzB3ER+Xx5vs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jQcZF-003tRE-Pl; Mon, 20 Apr 2020 21:58:57 +0200
Date:   Mon, 20 Apr 2020 21:58:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: net: Correct description of
 'broken-turn-around'
Message-ID: <20200420195857.GI917792@lunn.ch>
References: <20200420180723.27936-1-f.fainelli@gmail.com>
 <20200420180723.27936-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420180723.27936-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:07:21AM -0700, Florian Fainelli wrote:
> The turn around bytes (2) are placed between the control phase of the
> MDIO transaction and the data phase, correct the wording to be more
> exact.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
