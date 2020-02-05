Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B930C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BD20702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgBENj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:39:29 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbgBENj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:39:28 -0500
Received: from localhost (unknown [IPv6:2001:982:756:1:57a7:3bfd:5e85:defb])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE241158E83BF;
        Wed,  5 Feb 2020 05:39:25 -0800 (PST)
Date:   Wed, 05 Feb 2020 14:39:24 +0100 (CET)
Message-Id: <20200205.143924.1875004608052019375.davem@davemloft.net>
To:     boon.leong.ong@intel.com
Cc:     netdev@vger.kernel.org, tee.min.tan@intel.com,
        weifeng.voon@intel.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, Jose.Abreu@synopsys.com,
        mcoquelin.stm32@gmail.com, Joao.Pinto@synopsys.com, arnd@arndb.de,
        alexandru.ardelean@analog.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/6] net: stmmac: Fix incorrect location to set
 real_num_rx|tx_queues
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200205085510.32353-2-boon.leong.ong@intel.com>
References: <20200205085510.32353-1-boon.leong.ong@intel.com>
        <20200205085510.32353-2-boon.leong.ong@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Feb 2020 05:39:28 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ong Boon Leong <boon.leong.ong@intel.com>
Date: Wed,  5 Feb 2020 16:55:05 +0800

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5836b21edd7e..4d9afa13eeb9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2657,6 +2657,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
>  		stmmac_enable_tbs(priv, priv->ioaddr, enable, chan);
>  	}
>  
> +	/* Configure real RX and TX queues */
> +	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
> +	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
> +
>  	/* Start the ball rolling... */
>  	stmmac_start_all_dma(priv);
>  

It is only safe to ignore the return values from
netif_set_real_num_{rx,tx}_queues() if you call them before the
network device is registered.  Because only in that case are these
functions guaranteed to succeed.

But now that you have moved these calls here, they can fail.

Therefore you must check the return value and unwind the state
completely upon failures.

Honestly, I think this change will have several undesirable side effects:

1) Lots of added new code complexity

2) A new failure mode when resuming the device, users will find this
   very hard to diagnose and recover from

What real value do you get from doing these calls after probe?

If you can't come up with a suitable answer to that question, you
should reconsider this change.

Thanks.
