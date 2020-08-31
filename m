Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C45C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B281821473
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896614;
	bh=ERddwSmbW2NDx5hhDfjr7bYktdj7MbTDA/T+l3ouxuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K5QuCAyrkS1EZPpEgw48+Sf2k5yU4/9QMF9GgkMOQugUX9DwigRTaimSaMJ1LigUs
	 iHA6S5dDJAW4Mw23omTiPnWAGKw6HNoCee9XlZMxuSS4PBZTwckJ9nqnBmLzI2upYO
	 y2MOIH/U9NBJAvZfEE3qnT8PdWuR8cehCer7YZ+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHaR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgHaR4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:56:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8042064B;
        Mon, 31 Aug 2020 17:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896612;
        bh=ERddwSmbW2NDx5hhDfjr7bYktdj7MbTDA/T+l3ouxuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ed2/ahwDFtWyuYHg7VAwF7L4DHDXj3ep2TYL4IqTyA/werP9qDfP9UPDItciQdFSJ
         TZtQ+DXRAo5LNwOxxzS6GKp2uY6rO2En7+lzNV9UIB4g+OoUwcC1WZMIaxYOP20FLi
         kxHHt/EEok389WReTP+xDrG4KEb+Fa6CAjJj9DP4=
Date:   Mon, 31 Aug 2020 19:56:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     antoniprzybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: fixed two macros by adding brackets
Message-ID: <20200831175659.GA2556308@kroah.com>
References: <20200831160332.8507-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831160332.8507-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:03:32PM +0200, antoniprzybylik wrote:
> Added brackets to two macros.

That says _what_ you did, but not _why_ you did it.

Why did you do it?  What does this fix?

Does it make sense to do this?

And why these two macros?  Be specific please.

> 
> Signed-off-by: Antoni Przybylik <antoni.przybylik@wp.pl>
> ---
>  drivers/staging/gdm724x/gdm_tty.c   | 3 +--
>  drivers/staging/gdm724x/netlink_k.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 6e813693a766..5cd94347bf78 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -27,7 +27,7 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +#define GDM_TTY_READY(gdm) ((gdm) && (gdm)->tty_dev && (gdm)->port.count)
>  
>  static struct tty_driver *gdm_driver[TTY_MAX_COUNT];
>  static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
> @@ -323,4 +323,3 @@ void unregister_lte_tty_driver(void)
>  		}
>  	}
>  }
> -

You also deleted a line without saying so :(

> diff --git a/drivers/staging/gdm724x/netlink_k.c b/drivers/staging/gdm724x/netlink_k.c
> index 7902e52a699b..399b7b4b536f 100644
> --- a/drivers/staging/gdm724x/netlink_k.c
> +++ b/drivers/staging/gdm724x/netlink_k.c
> @@ -20,7 +20,7 @@ static DEFINE_MUTEX(netlink_mutex);
>  #define ND_NLMSG_DATA(nlh)	((void *)((char *)NLMSG_DATA(nlh) + \
>  						  ND_IFINDEX_LEN))
>  #define ND_NLMSG_S_LEN(len)	(len + ND_IFINDEX_LEN)
> -#define ND_NLMSG_R_LEN(nlh)	(nlh->nlmsg_len - ND_IFINDEX_LEN)
> +#define ND_NLMSG_R_LEN(nlh)	((nlh)->nlmsg_len - ND_IFINDEX_LEN)

Does that really make sense to change?

thanks,

greg k-h
