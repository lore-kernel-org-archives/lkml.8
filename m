Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62FC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D562083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgG2Adp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbgG2Adp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:33:45 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3376BC061794;
        Tue, 28 Jul 2020 17:33:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EDC0128D3F7E;
        Tue, 28 Jul 2020 17:16:58 -0700 (PDT)
Date:   Tue, 28 Jul 2020 17:33:41 -0700 (PDT)
Message-Id: <20200728.173341.1412402860749304096.davem@davemloft.net>
To:     bkkarthik@pesu.pes.edu
Cc:     herbert@gondor.apana.org.au, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfounation.org
Subject: Re: [PATCH] net: ipv6: fix slab-out-of-bounds Read in
 __xfrm6_tunnel_spi_check
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200725133031.a5uxkpikopntgu4c@pesu.pes.edu>
References: <20200725133031.a5uxkpikopntgu4c@pesu.pes.edu>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Jul 2020 17:16:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: B K Karthik <bkkarthik@pesu.pes.edu>
Date: Sat, 25 Jul 2020 19:00:31 +0530

> use spi_byaddr instead of spi_byspi
 ...
> diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> index 25b7ebda2fab..cab7693ccfe3 100644
> --- a/net/ipv6/xfrm6_tunnel.c
> +++ b/net/ipv6/xfrm6_tunnel.c
> @@ -103,10 +103,10 @@ static int __xfrm6_tunnel_spi_check(struct net *net, u32 spi)
>  {
>  	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
>  	struct xfrm6_tunnel_spi *x6spi;
> -	int index = xfrm6_tunnel_spi_hash_byspi(spi);
> +	int index = xfrm6_tunnel_spi_hash_byaddr(spi);

You are passing a u32 integer into a function that expects a pointer as an
argument.

This change isn't even compile tested properly, let alone run tested.

Please stop making such careless submissions, this takes up valuable
developer patch review resources.

Thank you.


