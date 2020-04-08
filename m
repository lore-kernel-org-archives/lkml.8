Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B850C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22E52083E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rD6zdw/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgDHJu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:50:58 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:65199 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgDHJu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:50:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48xzzz0yYLzC4;
        Wed,  8 Apr 2020 11:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586339455; bh=iC82MKUqJkWiaKVW400x9WE+5+v7C99X1AR4Uuo7NoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rD6zdw/JReETSh1IDXhswBj9oBpxZk2oSuVQozllyCjgaGWh0EoyyG6NKOPCITO6D
         1gXX0QbxuP/5zh/zevVfjkRC392XEumzm20LqZlpH0CF2BS2FEnTwGAIzfOLCyrRy4
         /HYTT6Ahj/WjhAhBrN1jwm3sI92vuyt6u41wQOSZnD6qMiuCV1JhcQr8h+ZglNmVQ5
         zBlxjelY57CXrI7by/2nyVsirMEakWYsQAmwQHOuOiGziD30e9HDXMMLg/A/cgJBLh
         G28nYKhW8RJ9ZbFFEI41FjLrsl9chTM1/geYz93kQo0PeLLeHCkfWhVYzrvOFcfYlT
         bv2G4b/3aibxg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 8 Apr 2020 11:50:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     =?utf-8?B?5p2O5qGD?= <tao.li@vivo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sergey Organov <sorganov@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenhu.wang@vivo.com
Subject: Re: Re: [PATCH] usb: gadget: serial: Fixed KASAN null-ptr-deref in
 tty_wakeup
Message-ID: <20200408095052.GA9335@qmqm.qmqm.pl>
References: <ADsAIgAICMOkBsTG35M4NqqB.1.1586331773574.Hmail.tao.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ADsAIgAICMOkBsTG35M4NqqB.1.1586331773574.Hmail.tao.li@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:42:53PM +0800, 李桃 wrote:
> Cc:  Felipe Balbi <balbi@kernel.org>,"Michał Mirosław" <mirq-linux@rere.qmqm.pl>,Sergey Organov <sorganov@gmail.com>,linux-usb@vger.kernel.org,linux-kernel@vger.kernel.org,wenhu.wang@vivo.com
> Subject: Re: [PATCH] usb: gadget: serial: Fixed KASAN null-ptr-deref in tty_wakeup>On Wed, Mar 18, 2020 at 10:56:01AM +0800, Li Tao wrote:
> >> The port->port.tty maybe reset as NULL, If gs_close() was invoked
> >> unexpectedly during running gserial_connect().
> >> 
> >> BUG: KASAN: null-ptr-deref in tty_wakeup+0x1c/0x84
> >> Call trace:
> >> [<0000000095c3c837>] dump_backtrace+0x0/0x6d4
> >> [<0000000047726bb8>] show_stack+0x18/0x20
> >> [<00000000bedb4c1e>] --dump_stack+0x20/0x28
> >> [<00000000722f2e2a>] dump_stack+0x84/0xb0
> >> [<00000000325683d4>] kasan_report_error+0x178/0x1e4
> >> [<0000000053079998>] kasan_report_error+0x0/0x1e4
> >> [<00000000b6d33afa>] --asan_load8+0x150/0x15c
> >> [<00000000188745b8>] tty_wakeup+0x1c/0x84
> >> [<0000000064f6dd21>] gs_start_io+0xd0/0x11c
> >> [<0000000063d67b6c>] gserial_connect+0x15c/0x1b0
> >> [<00000000faf7c0f9>] dm_set_alt+0xa8/0x190
> >> [<000000008deb1909>] composite_setup+0xde4/0x1edc
> >> [<00000000792ee16d>] android_setup+0x210/0x294
> >> [<00000000ab32ef30>] dwc3_ep0_delegate_req+0x48/0x68
> >> [<0000000054e26fd2>] dwc3_ep0_interrupt+0xf2c/0x16fc
> >> [<0000000050cb2262>] dwc3_interrupt+0x464/0x1f44
> >> [<00000000fdcaa6e9>] --handle_irq_event_percpu+0x184/0x398
> >> [<000000003b24ff56>] handle_irq_event_percpu+0xa0/0x134
> >> [<00000000aedda5ee>] handle_irq_event+0x60/0xa0
> >> [<000000005f51a570>] handle_fasteoi_irq+0x23c/0x31c
> >> [<000000008db2608d>] generic_handle_irq+0x70/0xa4
> >> [<00000000098683fc>] --handle_domain_irq+0x84/0xe0
> >> [<000000008ed23b46>] gic_handle_irq+0x98/0xb8
> >> 
> >> Signed-off-by: Li Tao <tao.li@vivo.com>
> >> ---
> >>  drivers/usb/gadget/function/u_serial.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
> >> index 8167d379e115..3c109a8f9ec4 100644
> >> --- a/drivers/usb/gadget/function/u_serial.c
> >> +++ b/drivers/usb/gadget/function/u_serial.c
> >> @@ -565,7 +565,8 @@ static int gs_start_io(struct gs_port *port)
> >>  		gs_start_tx(port);
> >>  		/* Unblock any pending writes into our circular buffer, in case
> >>  		 * we didn't in gs_start_tx() */
> >> -		tty_wakeup(port->port.tty);
> >> +		if (port->port.tty)
> >> +			tty_wakeup(port->port.tty);
> >
> >What prevents port.tty from being set to NULL between the check and the
> >call to tty_wakeup?
> >
> >Shouldn't gs_close() and gserial_connect() have some sort of locking to
> >prevent this?
> >
> I encountered this issue on Samsung EXYNOS980 platform, Maybe this is platform specific issue.
> The USB interrupt handler got port_lock on CPU 0 in gserial_connect while gs_close is waiting for 
> this lock on CPU 1.  But this port_lock will unlock in gs_start_io-->gs_start_rx temporarily, This race
> condition may cause port.tty set as NULL.

Hi,

gserial_connect() indeed accesses port[] array without taking the
portmaster's mutex. This is since commit 19b10a8828a6 ("usb: gadget:
allocate & giveback serial ports instead hard code them") introduced
dynamic allocation of the port structure.

Best Regards,
Michał Mirosław
