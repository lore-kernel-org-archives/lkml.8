Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A0920A8B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgC3RyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:54:09 -0400
Received: from smtprelay0250.hostedemail.com ([216.40.44.250]:47660 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgC3RyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:54:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A38C018034F5F;
        Mon, 30 Mar 2020 17:54:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: snail18_7ae2b0153554f
X-Filterd-Recvd-Size: 1863
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Mar 2020 17:54:04 +0000 (UTC)
Message-ID: <bfc2cff78325ad2845ef0c7ec2d7ba719fd4f1a1.camel@perches.com>
Subject: Re: [PATCH][next] net: ethernet: ti: fix spelling mistake "rundom"
 -> "random"
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Mar 2020 10:52:09 -0700
In-Reply-To: <20200330101639.161268-1-colin.king@canonical.com>
References: <20200330101639.161268-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 11:16 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
[]
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
[]
> @@ -1627,7 +1627,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
>  							   port->slave.mac_addr) ||
>  			   !is_valid_ether_addr(port->slave.mac_addr)) {
>  			random_ether_addr(port->slave.mac_addr);
> -			dev_err(dev, "Use rundom MAC address\n");
> +			dev_err(dev, "Use random MAC address\n");

This continues without returning an error value.
Is this actually an error?

It might be useful to describe the slave and
random ethernet address too.

Perhaps:

			dev_notice(dev, "%pOF slave[%d] using random MAC address %pM\n",
				   port_np, port_id, port->slave.mac_addr);

or maybe dev_info


