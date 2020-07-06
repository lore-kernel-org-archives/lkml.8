Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29259C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0355A206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgGFUHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:07:47 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49832 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGFUHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:07:47 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1jsXOw-003uVe-Gw; Mon, 06 Jul 2020 22:07:42 +0200
Date:   Mon, 6 Jul 2020 22:07:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Healy <cphealy@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sfp: Unique GPIO interrupt names
Message-ID: <20200706200742.GB893522@lunn.ch>
References: <CAFXsbZp5A7FHoXPA6Rg8XqZPD9NXmSeZZb-RsEGXnktbo04GOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFXsbZp5A7FHoXPA6Rg8XqZPD9NXmSeZZb-RsEGXnktbo04GOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 12:38:37PM -0700, Chris Healy wrote:
> Dynamically generate a unique GPIO interrupt name, based on the
> device name and the GPIO name.  For example:
> 
> 103:          0   sx1503q  12 Edge      sff2-los
> 104:          0   sx1503q  13 Edge      sff3-los
> 
> The sffX indicates the SFP the loss of signal GPIO is associated with.

Hi Chris

For netdev, please put inside the [PATCH] part of the subject, which
tree this is for, i.e. net-next.

> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
>  drivers/net/phy/sfp.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 73c2969f11a4..9b03c7229320 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -220,6 +220,7 @@ struct sfp {
>      struct phy_device *mod_phy;
>      const struct sff_data *type;
>      u32 max_power_mW;
> +    char sfp_irq_name[32];
> 
>      unsigned int (*get_state)(struct sfp *);
>      void (*set_state)(struct sfp *, unsigned int);
> @@ -2349,12 +2350,15 @@ static int sfp_probe(struct platform_device *pdev)
>              continue;
>          }
> 
> +        snprintf(sfp->sfp_irq_name, sizeof(sfp->sfp_irq_name),
> +             "%s-%s", dev_name(sfp->dev), gpio_of_names[i]);
> +

This is perfectly O.K, but you could consider using
devm_kasprintf(). That will allocate as much memory as needed for the
string, and hence avoid truncation issues, which we have seen before
with other interrupt names.

     Andrew
