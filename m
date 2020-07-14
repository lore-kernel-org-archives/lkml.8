Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A71C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08B422507
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGNOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:16:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:6915 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725803AbgGNOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:16:17 -0400
X-IronPort-AV: E=Sophos;i="5.75,350,1589234400"; 
   d="scan'208";a="459696777"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 16:16:15 +0200
Date:   Tue, 14 Jul 2020 16:16:15 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Suraj Upadhyay <usuraj35@gmail.com>
cc:     davem@davemloft.net, kuba@kernel.org,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] decnet: dn_dev: Remove an unnecessary label.
In-Reply-To: <20200714141309.GA3184@blackclown>
Message-ID: <alpine.DEB.2.22.394.2007141615490.2355@hadrien>
References: <20200714141309.GA3184@blackclown>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Jul 2020, Suraj Upadhyay wrote:

> Remove the unnecessary label from dn_dev_ioctl() and make its error
> handling simpler to read.
>
> Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> ---
>  net/decnet/dn_dev.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
> index 65abcf1b3210..64901bb9f314 100644
> --- a/net/decnet/dn_dev.c
> +++ b/net/decnet/dn_dev.c
> @@ -462,7 +462,9 @@ int dn_dev_ioctl(unsigned int cmd, void __user *arg)
>  	switch (cmd) {
>  	case SIOCGIFADDR:
>  		*((__le16 *)sdn->sdn_nodeaddr) = ifa->ifa_local;
> -		goto rarok;
> +		if (copy_to_user(arg, ifr, DN_IFREQ_SIZE))
> +			ret = -EFAULT;
> +			break;

The indentation on break does not look correct.

julia

>
>  	case SIOCSIFADDR:
>  		if (!ifa) {
> @@ -485,10 +487,6 @@ int dn_dev_ioctl(unsigned int cmd, void __user *arg)
>  	rtnl_unlock();
>
>  	return ret;
> -rarok:
> -	if (copy_to_user(arg, ifr, DN_IFREQ_SIZE))
> -		ret = -EFAULT;
> -	goto done;
>  }
>
>  struct net_device *dn_dev_get_default(void)
> --
> 2.17.1
>
>
