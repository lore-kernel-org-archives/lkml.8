Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC147C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B3B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584526365;
	bh=6Qp/xUEdfDHiwOlzFgHXZUcDvRvQ4RUplGy2llBeWXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FULCliY3jGTr6wjBHydpxmSDDB4XUemhpTQ7zfP4JgsvEIxA8Ek7O6KAyJJy0ctOB
	 VCR9uqF0axUepj4goM/JJSM8Pns7v1PawHwOLaIQgLZcVkyynhBy3to1aRyiZZVZQ8
	 tqgLzsB4Tuz9mL/ZWY18xjPzr+hP0cvoRu0wwTzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCRKMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRKMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:12:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4663B20768;
        Wed, 18 Mar 2020 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584526363;
        bh=6Qp/xUEdfDHiwOlzFgHXZUcDvRvQ4RUplGy2llBeWXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZHE5tlEzKgLpX+C7exwsPfM44nFiUWegCKqbBq8fYIx3Nr0wNC65Me80ZLTadDNo
         Ettdk6W3Z89nMnYoDSlz0B+Lw01hyCo/vC8D1n+pdbS2yWLHarWZjOgGHUGAAhVwhK
         cec0eWw3w3MA0yChNt1HntUFpLLiW15NzPAGLbC8=
Date:   Wed, 18 Mar 2020 11:12:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Tao <tao.li@vivo.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenhu.wang@vivo.com
Subject: Re: [PATCH] usb: gadget: serial: Fixed KASAN null-ptr-deref in
 tty_wakeup
Message-ID: <20200318101240.GA2067041@kroah.com>
References: <20200318025606.2058-1-tao.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318025606.2058-1-tao.li@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:56:01AM +0800, Li Tao wrote:
> The port->port.tty maybe reset as NULL, If gs_close() was invoked
> unexpectedly during running gserial_connect().
> 
> BUG: KASAN: null-ptr-deref in tty_wakeup+0x1c/0x84
> Call trace:
> [<0000000095c3c837>] dump_backtrace+0x0/0x6d4
> [<0000000047726bb8>] show_stack+0x18/0x20
> [<00000000bedb4c1e>] --dump_stack+0x20/0x28
> [<00000000722f2e2a>] dump_stack+0x84/0xb0
> [<00000000325683d4>] kasan_report_error+0x178/0x1e4
> [<0000000053079998>] kasan_report_error+0x0/0x1e4
> [<00000000b6d33afa>] --asan_load8+0x150/0x15c
> [<00000000188745b8>] tty_wakeup+0x1c/0x84
> [<0000000064f6dd21>] gs_start_io+0xd0/0x11c
> [<0000000063d67b6c>] gserial_connect+0x15c/0x1b0
> [<00000000faf7c0f9>] dm_set_alt+0xa8/0x190
> [<000000008deb1909>] composite_setup+0xde4/0x1edc
> [<00000000792ee16d>] android_setup+0x210/0x294
> [<00000000ab32ef30>] dwc3_ep0_delegate_req+0x48/0x68
> [<0000000054e26fd2>] dwc3_ep0_interrupt+0xf2c/0x16fc
> [<0000000050cb2262>] dwc3_interrupt+0x464/0x1f44
> [<00000000fdcaa6e9>] --handle_irq_event_percpu+0x184/0x398
> [<000000003b24ff56>] handle_irq_event_percpu+0xa0/0x134
> [<00000000aedda5ee>] handle_irq_event+0x60/0xa0
> [<000000005f51a570>] handle_fasteoi_irq+0x23c/0x31c
> [<000000008db2608d>] generic_handle_irq+0x70/0xa4
> [<00000000098683fc>] --handle_domain_irq+0x84/0xe0
> [<000000008ed23b46>] gic_handle_irq+0x98/0xb8
> 
> Signed-off-by: Li Tao <tao.li@vivo.com>
> ---
>  drivers/usb/gadget/function/u_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> index 8167d379e115..3c109a8f9ec4 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -565,7 +565,8 @@ static int gs_start_io(struct gs_port *port)
>  		gs_start_tx(port);
>  		/* Unblock any pending writes into our circular buffer, in case
>  		 * we didn't in gs_start_tx() */
> -		tty_wakeup(port->port.tty);
> +		if (port->port.tty)
> +			tty_wakeup(port->port.tty);

What prevents port.tty from being set to NULL between the check and the
call to tty_wakeup?

Shouldn't gs_close() and gserial_connect() have some sort of locking to
prevent this?

thanks,

greg k-h
