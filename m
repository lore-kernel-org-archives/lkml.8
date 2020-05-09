Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF44BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935B52192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEIB5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 21:57:43 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34878 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEIB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 21:57:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 10A1129922;
        Fri,  8 May 2020 21:57:38 -0400 (EDT)
Date:   Sat, 9 May 2020 11:57:44 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Jakub Kicinski <kuba@kernel.org>
cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
In-Reply-To: <20200508175701.4eee970d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <alpine.LNX.2.22.394.2005091143590.8@nippy.intranet>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr> <20200508175701.4eee970d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 8 May 2020, Jakub Kicinski wrote:

> On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:
> > Only macsonic has been compile tested. I don't have the needed setup to
> > compile xtsonic
> 
> Well, we gotta do that before we apply the patch :S
> 

I've compiled xtsonic.c with this patch.

> Does the driver actually depend on some platform stuff,

xtsonic.c looks portable enough but it has some asm includes that I 
haven't looked at. It is really a question for the arch maintainers.

>  or can we do this:
> 
> diff --git a/drivers/net/ethernet/natsemi/Kconfig b/drivers/net/ethernet/natsemi/Kconfig
> @@ -58,7 +58,7 @@ config NS83820
>  
>  config XTENSA_XT2000_SONIC
>         tristate "Xtensa XT2000 onboard SONIC Ethernet support"
> -       depends on XTENSA_PLATFORM_XT2000
> +       depends on XTENSA_PLATFORM_XT2000 || COMPILE_TEST
>         ---help---
>           This is the driver for the onboard card of the Xtensa XT2000 board.
>  
> ?
> 

That's effectively what I did to compile test xtsonic.c (I removed the 
line to get the same effect).
