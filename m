Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C206AC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A191E20715
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="sQHewzr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbgDQTxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730590AbgDQTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:53:13 -0400
X-Greylist: delayed 1435 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Apr 2020 12:53:13 PDT
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A19C061A0C;
        Fri, 17 Apr 2020 12:53:13 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A2AB323058;
        Fri, 17 Apr 2020 21:53:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587153191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4efXAnhB0eBrEwqZaiyV3C1IZ+HvC96V0Mi0tdaoAQ=;
        b=sQHewzr0uJx9wYZWJRvdCsIA9zA1Q4KIewe4r+cPJcPXZShWC/1cLV8w5ANqGS9wNaxQGA
        QSme3MF6yH6LJqNCVY90rfWpMcHbomO+UqJml51J6Z9FbeDfPd25bkOl2zSuCQ3Uswexe4
        St94rI2wfsx/TSvuVe1bhp3rIBPzhRw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Apr 2020 21:53:11 +0200
From:   Michael Walle <michael@walle.cc>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] net: phy: bcm54140: add hwmon support
In-Reply-To: <20200417195003.GG785713@lunn.ch>
References: <20200417192858.6997-1-michael@walle.cc>
 <20200417192858.6997-3-michael@walle.cc> <20200417195003.GG785713@lunn.ch>
Message-ID: <35d00dfe1ad24b580dc247d882aa2e39@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A2AB323058
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         NEURAL_HAM(-0.00)[-0.254];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,roeck-us.net,gmail.com,armlinux.org.uk,davemloft.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-04-17 21:50, schrieb Andrew Lunn:
>> +/* Check if one PHY has already done the init of the parts common to 
>> all PHYs
>> + * in the Quad PHY package.
>> + */
>> +static bool bcm54140_is_pkg_init(struct phy_device *phydev)
>> +{
>> +	struct mdio_device **map = phydev->mdio.bus->mdio_map;
>> +	struct bcm54140_phy_priv *priv;
>> +	struct phy_device *phy;
>> +	int i, addr;
>> +
>> +	/* Quad PHY */
>> +	for (i = 0; i < 4; i++) {
>> +		priv = phydev->priv;
>> +		addr = priv->base_addr + i;
>> +
>> +		if (!map[addr])
>> +			continue;
>> +
>> +		phy = container_of(map[addr], struct phy_device, mdio);
> 
> I don't particularly like a PHY driver having knowledge of the mdio
> bus core. Please add a helper in the core to get you the phydev for a
> particular address.
> 
> There is also the question of locking. What happens if the PHY devices
> is unbound while you have an instance of its phydev? What happens if
> the base PHY is unbound? Are the three others then unusable?
> 
> I think we need to take a step back and look at how we handle quad
> PHYs in general. The VSC8584 has many of the same issues.

Correct, and this function was actually stolen from there ;) This was
actually stolen from the mscc PHY ;)

-michael
