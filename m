Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B69FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA63E2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="oOn0/+f1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgE1ISX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:18:23 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:46215 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE1ISW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:18:22 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F301223E40;
        Thu, 28 May 2020 10:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590653900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HdBYkATTc//+jNMYSOCSa3ZZwhXDoB0+st0QSPzxGZ0=;
        b=oOn0/+f1TNm8FGMmDaeBQk5OjsSNGaOfDDzN/gWc7Vx2ZYAGVgZt1HLU0fQheq83QY2Fvc
        3nIBiIAU/2jIEyriF/xycIxcvoHswY1EP3BOgm19NdjRdcCgfTfbfPTzQ4cNKT3qPcUO6O
        kDeQG1aqOGlRdY9XiPmBsADtO1XQzHo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 28 May 2020 10:18:19 +0200
From:   Michael Walle <michael@walle.cc>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v3 0/3] net: enetc: remove bootloader dependency
In-Reply-To: <20200528063847.27704-1-michael@walle.cc>
References: <20200528063847.27704-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <0130cb1878a47efc23f23cf239d0380f@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-05-28 08:38, schrieb Michael Walle:
> These patches were picked from the following series:
> https://lore.kernel.org/netdev/1567779344-30965-1-git-send-email-claudiu.manoil@nxp.com/
> They have never been resent. I've picked them up, addressed Andrews
> comments, fixed some more bugs and asked Claudiu if I can keep their 
> SOB
> tags; he agreed. I've tested this on our board which happens to have a
> bootloader which doesn't do the enetc setup in all cases. Though, only
> SGMII mode was tested.
> 
> changes since v2:
>  - removed SOBs from "net: enetc: Initialize SerDes for SGMII and 
> USXGMII
>    protocols" because almost everything has changed.
>  - get a phy_device for the internal PCS PHY so we can use the phy_
>    functions instead of raw mdiobus writes

mhh after reading,
https://lore.kernel.org/netdev/CA+h21hoq2qkmxDFEb2QgLfrbC0PYRBHsca=0cDcGOr3txy9hsg@mail.gmail.com/
this seems to be the wrong way of doing it.

-michael
