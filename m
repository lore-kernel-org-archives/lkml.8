Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE0C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693E4206F0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ufGQhn3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgBAPdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 10:33:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:32808 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgBAPdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2PYSDAtXiyT57Pssinvpgs84tIcQLviMKfkN82DzBW0=; b=ufGQhn3uaLT+cXZ+p98Hcw23SG
        kcxrAsr1xGiIs+hWt4mT6AO07WLvrCdL1SXy7nX7HKaUBm0hkwgA8fZNeTgQP1Nll/dpVyUO3gIiB
        CwfYGXuW1wVvliGSAF5/14LVJ3Z8kuC4Tjd3a+3VMw74RkcDtIksw3Sl+n8ZcQ35Kv4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1ixuln-0003VR-NA; Sat, 01 Feb 2020 16:33:15 +0100
Date:   Sat, 1 Feb 2020 16:33:15 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, wahrenst@gmx.net,
        hkallweit1@gmail.com
Subject: Re: [PATCH 4/6] net: bcmgenet: Initial bcmgenet ACPI support
Message-ID: <20200201153315.GJ9639@lunn.ch>
References: <20200201074625.8698-1-jeremy.linton@arm.com>
 <20200201074625.8698-5-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201074625.8698-5-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -3595,7 +3597,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
>  	/* If this is an internal GPHY, power it on now, before UniMAC is
>  	 * brought out of reset as absolutely no UniMAC activity is allowed
>  	 */
> -	if (dn && !of_property_read_string(dn, "phy-mode", &phy_mode_str) &&
> +	if (!device_property_read_string(&pdev->dev, "phy-mode", &phy_mode_str) &&
>  	    !strcasecmp(phy_mode_str, "internal"))
>  		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);

The code you are modifying appears to be old and out of date. For a
long time there has been a helper, of_get_phy_mode(). You should look
at fwnode_get_phy_mode().

   Andrew
