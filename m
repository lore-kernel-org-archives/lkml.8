Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E81C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5350320674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHRRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:43:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59580 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgHRRnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:43:04 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1k85dU-009wsH-DX; Tue, 18 Aug 2020 19:43:00 +0200
Date:   Tue, 18 Aug 2020 19:43:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: loop: Return VLAN table size through
 devlink
Message-ID: <20200818174300.GI2330298@lunn.ch>
References: <20200818040354.44736-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818040354.44736-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:03:54PM -0700, Florian Fainelli wrote:
> We return the VLAN table size through devlink as a simple parameter, we
> do not support altering it at runtime:
> 
> devlink resource show mdio_bus/fixed-0:1f
> mdio_bus/fixed-0:1f:
>   name VTU size 4096 occ 4096 unit entry dpipe_tables none

Hi Florian

The occ 4096 looks wrong. It is supposed to show the occupancy, how
many are in use. 

> +static u64 dsa_loop_devlink_vtu_get(void *priv)
> +{
> +	struct dsa_loop_priv *ps = priv;
> +
> +	return ARRAY_SIZE(ps->vlans);
> +}

So this should probably be looping over all vlan IDs and counting those
with members?

	Andrew
