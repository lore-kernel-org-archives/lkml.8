Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D0C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28F42176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LAIeX56U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBRNju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:39:50 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:51560 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgBRNju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZvM5SJLfCygy+dxNwz0/A0b6jQXOvJ0xzPs0cBdmSKg=; b=LAIeX56UO8rWJZdbAF65v0ChM9
        9v/9mznqO6FhMXCCC8zRD03rRzca9/LhSLn8DD/hUXhshfgL8pD/Gy0jUNx5pVNDy05NqO1J0YeKK
        T28hKdeVK/xUxvAEZY1IOahF3P0wJIX7AK18Tfvtf2wG10uZ7mxaINzzZLPbVFcQg3JM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j436F-0002mI-L1; Tue, 18 Feb 2020 14:39:43 +0100
Date:   Tue, 18 Feb 2020 14:39:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH 8/8] net: ll_temac: Add ethtool support for coalesce
 parameters
Message-ID: <20200218133943.GA10541@lunn.ch>
References: <20200218082741.7710-1-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218082741.7710-1-esben@geanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esben

> +	if (ec->tx_coalesce_usecs)
> +		lp->coalesce_delay_tx =
> +			min(255U, (ec->tx_coalesce_usecs * 100) / 512);
> +
> +	pr_info("%d -> %d  %d -> %d\n",
> +		ec->rx_coalesce_usecs, lp->coalesce_delay_rx,
> +		ec->tx_coalesce_usecs, lp->coalesce_delay_tx);

I guess this is left over from debug? You don't actually want it here?

  Andrew
