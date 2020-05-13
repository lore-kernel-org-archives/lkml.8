Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E4AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F35F20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QgBfCmP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbgEMPuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:50:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58248 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgEMPuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CAERETo3HmCt4cbe7skcUAdSIJs8TS922Vv3SvzLnWo=; b=QgBfCmP3WmKmpu6AFL6yVYiciq
        tlhwOShfjy+y8zbLvLsZLYnwvCB1KcWONL3FUxrPaFR3vIeC+gQ4pi0I4Mc6H6AJlZlllJnesOh5J
        ae7LL5bwGY6eLSJVHQrzBaHrWegML8A7ADQWcrJRRxhLwEF82ck04tel3r4y0b1IkzAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jYtdp-002B9b-U1; Wed, 13 May 2020 17:49:53 +0200
Date:   Wed, 13 May 2020 17:49:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: at803x: add cable test support
Message-ID: <20200513154953.GI499265@lunn.ch>
References: <20200513120648.14415-1-o.rempel@pengutronix.de>
 <0c80397b-58b8-0807-0b98-695db8068e25@gmail.com>
 <20200513154544.gwcccvbicpvrj6vm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513154544.gwcccvbicpvrj6vm@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Uff.. i missed this. Then I'll need only to add some changes on top of
> his patch.

I've been chatting with mwalle on IRC today. There should be a repost
of the patches soon.

   Andrew
