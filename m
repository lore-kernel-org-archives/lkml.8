Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F68C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C77207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgFRM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:56:49 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:46614 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgFRM4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:56:44 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jlu5w-00179d-QR; Thu, 18 Jun 2020 14:56:40 +0200
Date:   Thu, 18 Jun 2020 14:56:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: bcm_sf2: Fix node reference count
Message-ID: <20200618125640.GL249144@lunn.ch>
References: <20200618034245.29928-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618034245.29928-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 08:42:44PM -0700, Florian Fainelli wrote:
> of_find_node_by_name() will do an of_node_put() on the "from" argument.

> Fixes: afa3b592953b ("net: dsa: bcm_sf2: Ensure correct sub-node is parsed")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/net/dsa/bcm_sf2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
> index c1bd21e4b15c..9f62ba3e4345 100644
> --- a/drivers/net/dsa/bcm_sf2.c
> +++ b/drivers/net/dsa/bcm_sf2.c
> @@ -1154,6 +1154,8 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
>  	set_bit(0, priv->cfp.used);
>  	set_bit(0, priv->cfp.unique);
>  
> +	/* Balance of_node_put() done by of_find_node_by_name() */
> +	of_node_get(dn);
>  	ports = of_find_node_by_name(dn, "ports");

That if_find_node_by_name() does a put is not very intuitive.
Maybe document that as well in the kerneldocs?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
