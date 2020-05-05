Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A7C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AED52073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CZdp4URc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgEENHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:07:46 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42394 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgEENHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2Is8bCXJzjJBIxEnzQYankccEiAe7hsXMAe2SM6/h+w=; b=CZdp4URcIF0sRee75TssxEwvEU
        4bNiuzV/GSLcZjoHGOLOdDcVJCx+97ZeWhZtu7MybWWgVVVJwEbgQ/IfDbnrUI17ae/I+9GZAh1Fc
        lBJMYom+RpF3P77i74wgDa7w6xP6o7YYgL1oRtbu2ZEXiUQNxZV+HsKJixMjh09tPkzQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jVxIT-000vzH-S0; Tue, 05 May 2020 15:07:41 +0200
Date:   Tue, 5 May 2020 15:07:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC net-next] net: phy: at803x: add cable diagnostics support
Message-ID: <20200505130741.GD208718@lunn.ch>
References: <20200503181517.4538-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503181517.4538-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int at803x_cable_test_get_status(struct phy_device *phydev,
> +					bool *finished)
> +{
> +	struct at803x_priv *priv = phydev->priv;
> +	static const int ethtool_pair[] = {
> +		ETHTOOL_A_CABLE_PAIR_0, ETHTOOL_A_CABLE_PAIR_1,
> +		ETHTOOL_A_CABLE_PAIR_2, ETHTOOL_A_CABLE_PAIR_3};

If you put one per line, you will keep the reverse christmas tree, and
David will be happy.

> +	int pair, val, ret;
> +	unsigned int delay_ms;

Well, David will be happy if you move this as well.

> +	*finished = false;
> +
> +	if (priv->cdt_start) {
> +		delay_ms = AT803X_CDT_DELAY_MS;
> +		delay_ms -= jiffies_delta_to_msecs(jiffies - priv->cdt_start);
> +		if (delay_ms > 0)
> +			msleep(delay_ms);
> +	}
> +
> +	for (pair = 0; pair < 4; pair++) {
> +		ret = at803x_cdt_start(phydev, pair);
> +		if (ret)
> +			return ret;
> +
> +		ret = at803x_cdt_wait_for_completion(phydev);
> +		if (ret)
> +			return ret;
> +
> +		val = phy_read(phydev, AT803X_CDT_STATUS);
> +		if (val < 0)
> +			return val;
> +
> +		ethnl_cable_test_result(phydev, ethtool_pair[pair],
> +					at803x_cdt_test_result(val));
> +
> +		if (at803x_cdt_fault_length_valid(val))
> +			continue;

The name is not very intuitive. It return false if it is valid?

Otherwise, this looks good.

    Andrew
