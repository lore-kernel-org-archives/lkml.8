Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA46720727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgEOAw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726046AbgEOAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:52:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9CC061A0C;
        Thu, 14 May 2020 17:52:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F71814DB4EA4;
        Thu, 14 May 2020 17:52:28 -0700 (PDT)
Date:   Thu, 14 May 2020 17:52:27 -0700 (PDT)
Message-Id: <20200514.175227.2037292271312428281.davem@davemloft.net>
To:     hch@lst.de
Cc:     kuba@kernel.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ipv4,appletalk: move SIOCADDRT and SIOCDELRT
 handling into ->compat_ioctl
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200514144535.3000410-5-hch@lst.de>
References: <20200514144535.3000410-1-hch@lst.de>
        <20200514144535.3000410-5-hch@lst.de>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 May 2020 17:52:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Thu, 14 May 2020 16:45:35 +0200

>  #ifdef CONFIG_COMPAT
> +static int atalk_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
> +		struct compat_rtentry __user *ur)
> +{
> +	struct rtentry rt;
> +	compat_uptr_t rtdev;
> +

Reverse christmas tree please.

>  static int atalk_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  {
> +	struct sock *sk = sock->sk;
> +	void __user *argp = compat_ptr(arg);

Likewise.

> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 6177c4ba00370..b99c5e36e0a8f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -968,17 +969,42 @@ int inet_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  EXPORT_SYMBOL(inet_ioctl);
>  
>  #ifdef CONFIG_COMPAT
> +static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
> +		struct compat_rtentry __user *ur)
> +{
> +	struct rtentry rt;
> +	compat_uptr_t rtdev;

Likewise.
