Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58847C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE0E206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xxdyjI09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgBAPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 10:37:15 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:32826 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgBAPhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kNgOX0Qvs7yrjp7ouJEeFCf6qsFUBCuurzi6ewbYR0s=; b=xxdyjI09zmU6CFeWEZTFmEjwvp
        9VOnu8m75O6cyRPtQj72ofu/SaO2aAUESkrEHMNr/ZTUJGaXBBi6yK3W7KlAS8wBALfOJa4QfpfAL
        chZvwdJAjqkceB81LBEEFASMTPGx2fXK1SzqTqh/a6tc/B9UOAgKx3IPjgkBt78JyzJo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ixupZ-0003Wq-6P; Sat, 01 Feb 2020 16:37:09 +0100
Date:   Sat, 1 Feb 2020 16:37:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net,
        hkallweit1@gmail.com
Subject: Re: [PATCH 5/6] net: bcmgenet: Fetch MAC address from the adapter
Message-ID: <20200201153709.GK9639@lunn.ch>
References: <20200201074625.8698-1-jeremy.linton@arm.com>
 <20200201074625.8698-6-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201074625.8698-6-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -3601,6 +3605,23 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  	    !strcasecmp(phy_mode_str, "internal"))
>  		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
>  
> +	if (dn)
> +		macaddr = of_get_mac_address(dn);
> +	else if (pd)
> +		macaddr = pd->mac_address;
> +
> +	if (IS_ERR_OR_NULL(macaddr) || !is_valid_ether_addr(macaddr)) {
> +		if (has_acpi_companion(&pdev->dev))
> +			bcmgenet_get_hw_addr(priv, dev->dev_addr);
> +
> +		if (!is_valid_ether_addr(dev->dev_addr)) {
> +			dev_warn(&pdev->dev, "using random Ethernet MAC\n");
> +			eth_hw_addr_random(dev);
> +		}
> +	} else {
> +		ether_addr_copy(dev->dev_addr, macaddr);
> +	}
> +

Could you also maybe put in here somewhere a call to
device_get_mac_address(), to support getting the MAC address out of
ACPI?

	Andrew
