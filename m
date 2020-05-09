Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A10C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF342184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589055871;
	bh=hJUWP29cYuX3Xi3cAjjlLU0uoC2+SMXGfHqNZqHVaxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Kh/7RU/RImkwZemWD6bZi9P2qM6usLVBMXk0FxejZqsXm289tvESmFbznY3H9crGX
	 yEUiT4q5mZ0bHiKNzT9I0aNohDcFZs8VYo4Fk3jUrhSjXgQJ2wE0gmVuhydTTbrIuN
	 fiEkE/4Fi/oTR8azwwabTZDysSWUCFLPBWlLT/qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgEIUYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 16:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgEIUYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:24:30 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7255720A8B;
        Sat,  9 May 2020 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589055869;
        bh=hJUWP29cYuX3Xi3cAjjlLU0uoC2+SMXGfHqNZqHVaxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dkXfCj+Wefxi4yE0M84fSKGXdQalIEyHmG5bZ8+PmJ5RNaDzlD1UVcUDvCoTyZnPE
         iIaUncrfotfIAcegEz/jo+1kIS7MxQarsagOHWKqcTQSG7RmQuFay8djD1iQtqwT2q
         Ap5ngFEaehcYX8mBOSniUSsBImsko+R16W8wWmnM=
Date:   Sat, 9 May 2020 13:24:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] net: freescale: select CONFIG_FIXED_PHY where needed
Message-ID: <20200509132427.3d2979d8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200509120505.109218-1-arnd@arndb.de>
References: <20200509120505.109218-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 May 2020 14:04:52 +0200 Arnd Bergmann wrote:
> I ran into a randconfig build failure with CONFIG_FIXED_PHY=m
> and CONFIG_GIANFAR=y:
> 
> x86_64-linux-ld: drivers/net/ethernet/freescale/gianfar.o:(.rodata+0x418): undefined reference to `fixed_phy_change_carrier'
> 
> It seems the same thing can happen with dpaa and ucc_geth, so change
> all three to do an explicit 'select FIXED_PHY'.
> 
> The fixed-phy driver actually has an alternative stub function that
> theoretically allows building network drivers when fixed-phy is
> disabled, but I don't see how that would help here, as the drivers
> presumably would not work then.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> +	select FIXED_PHY

I think FIXED_PHY needs to be optional, depends on what the board has
connected to the MAC it may not be needed, right PHY folks? We probably
need the

    depends on FIXED_PHY || !FIXED_PHY

dance.
