Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF8C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBD9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 04:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSECu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 23:02:50 -0500
Received: from cooldavid.org ([114.33.45.68]:42708 "EHLO cooldavid.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgBSECt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:02:49 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 23:02:48 EST
Received: from cooldavid.org (localhost [127.0.0.1])
        by cooldavid.org (Postfix) with ESMTP id ED22C670DB9;
        Wed, 19 Feb 2020 11:53:48 +0800 (CST)
From:   "Guo-Fu Tseng" <cooldavid@cooldavid.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 07/13] jme: use new helper tcp_v6_gso_csum_prep
Date:   Wed, 19 Feb 2020 11:53:48 +0800
Message-Id: <20200219034801.M31679@cooldavid.org>
In-Reply-To: <f9f6897b-8dc8-2036-97d4-60e154b57356@gmail.com>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com> <f9f6897b-8dc8-2036-97d4-60e154b57356@gmail.com>
X-Mailer: OpenWebMail 2.53 
X-OriginatingIP: 2001:b011:3813:5d60:21f:bcff:fe0d:975f (cooldavid)
MIME-Version: 1.0
Content-Type: text/plain;
        charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 21:06:11 +0100, Heiner Kallweit wrote
> Use new helper tcp_v6_gso_csum_prep in additional network drivers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/jme.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index 2e4975572..de3c7ce93 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -2077,12 +2077,7 @@ jme_tx_tso(struct sk_buff *skb, __le16 *mss, u8 *flags)
>  								IPPROTO_TCP,
>  								0);
>  		} else {
> -			struct ipv6hdr *ip6h = ipv6_hdr(skb);
> -
> -			tcp_hdr(skb)->check = ~csum_ipv6_magic(&ip6h->saddr,
> -								&ip6h->daddr, 0,
> -								IPPROTO_TCP,
> -								0);
> +			tcp_v6_gso_csum_prep(skb);
>  		}
> 
>  		return 0;
> -- 
> 2.25.1
Kallweit:

Looks good to me. Thank you.

Guo-Fu Tseng

