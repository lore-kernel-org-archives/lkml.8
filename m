Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD42C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB8120716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597144641;
	bh=xJBqLG+s8HgG35QAutrjsfzZx63gQyfWw2+EJ8gZfGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rw80NZ/+Ayae8fl/0CetpkbgY/dhdPS+QmOjRvAwMe3Q6eWF1sx0ex/G+qIMvtUDX
	 VEceGjQobSI3YAu2dfRykOvo8U+qeBNnrItZQcH2glVqHMW2v4+OMYUFyvtuGaBYBv
	 QKAJMH7iaCQmuBK/xruOUcqON0whj6VSsrqPPRCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHKLRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgHKLRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:17:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F284420716;
        Tue, 11 Aug 2020 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597144638;
        bh=xJBqLG+s8HgG35QAutrjsfzZx63gQyfWw2+EJ8gZfGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCfZ5e9x8+yULjtJSP/dEV/zOu2rVdRZ9nNa9NgPOVpb9I4a1tlr5i7itGO2IWc8B
         wgYP0Byeb0eWLz1jF5XrkJCZckYqbu4Ez107PLs7Gw4DroGOxwdlBuEdbA8gUqSONc
         1Qe/B6DDLWp4R68YWcF0ylL6oS90PNJViKf3GA3A=
Date:   Tue, 11 Aug 2020 12:17:13 +0100
From:   Will Deacon <will@kernel.org>
To:     peterz@infradead.org
Cc:     linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep splat ("possible circular locking dependency detected")
 with PL011 on 5.8
Message-ID: <20200811111713.GA7203@willie-the-truck>
References: <20200811101313.GA6970@willie-the-truck>
 <20200811103841.GC2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811103841.GC2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:38:41PM +0200, peterz@infradead.org wrote:
> On Tue, Aug 11, 2020 at 11:13:13AM +0100, Will Deacon wrote:
> > Using magic-sysrq via a keyboard interrupt over the serial console results in
> > the following lockdep splat with the PL011 UART driver on v5.8. I can reproduce
> > the issue under QEMU with arm64 defconfig + PROVE_LOCKING.
> > 
> > Any chance somebody could take a look, please? It's a little annoying,
> > because it means when I uses magic-sysrq to increase the loglevel prior
> > to testing something else, lockdep gets disabled as a result.
> > 
> 
> Going by msm_serial, the thing to do is something like this:
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 8efd7c2a34fe..1717790ece2b 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -308,8 +308,9 @@ static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
>   */
>  static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  {
> -	u16 status;
>  	unsigned int ch, flag, fifotaken;
> +	int sysrq;
> +	u16 status;
>  
>  	for (fifotaken = 0; fifotaken != 256; fifotaken++) {
>  		status = pl011_read(uap, REG_FR);
> @@ -344,10 +345,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
>  				flag = TTY_FRAME;
>  		}
>  
> -		if (uart_handle_sysrq_char(&uap->port, ch & 255))
> -			continue;
> +		spin_unlock(&uap->port.lock);
> +		sysrq = uart_handle_sysrq_char(&uap->port, ch & 255);
> +		spin_lock(&uap->port.lock);
>  
> -		uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
> +		if (!sysrq)
> +			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
>  	}
>  
>  	return fifotaken;

Cheers, that seems to do the trick:

Tested-by: Will Deacon <will@kernel.org>

but what I don't understand is why I haven't run into this before, and why
nobody else seems to be reporting it!

I'll try some older kernels to see if it ever worked.

Will
