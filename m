Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC6DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6E62073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="do98fXC1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e02smifr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgGFLbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGFLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:31:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39BC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 04:31:16 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594035075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIjr59zT/ebHtB1OersU4qLeRIoOyUYlrI9yu0DaPO0=;
        b=do98fXC1FGkK0E7Fn2LbBXk/QTKlQVhmeQuF59Ki8hZOR3/Ci2hDkKEInuRYu5T4SfPnFo
        J88n+fIcn00/3PpiBGZZbNrHPijv/rgTceVxJY/YAB1Jm8lf166G3JMmgWv455lYsu3gXe
        WahJjVbkyC1xdBxf6GuWmhBqZ1TYHIB3pyNX/L4/u4MZi2psXMt3bsezSJKcrVwIrCirLT
        hJcVivYW5KtOAcSKhDiuRBBp14wLE2FmQmmEJZRIzxSltROcVyR2ylGAweopVuJufdxxDV
        wfVhxy3sSLsBXicEujJpVtJGsiJE1gLVn8LmfS7Xi/TRg95sJ9iIquRhauBPiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594035075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zIjr59zT/ebHtB1OersU4qLeRIoOyUYlrI9yu0DaPO0=;
        b=e02smifr93XZX3Wn5TwGUzMVRAp6tsngVXmHDmLZlWgIZTFIQmyRpjSfiB1rfv8E7Jr4CE
        uSd53rEr/P2jc5BQ==
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Petr Mladek <pmladek@suse.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "S\, Shirish" <Shirish.S@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock
In-Reply-To: <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com> <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com> <20200630035816.GA21591@jagdpanzerIV.localdomain> <20200630102141.GA11587@alley> <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley> <20200630130534.GB145027@jagdpanzerIV.localdomain> <20200630180255.GD37466@atomide.com> <20200702051213.GB3450@jagdpanzerIV.localdomain> <20200702160514.GK37466@atomide.com> <20200703103241.GB182102@jagdpanzerIV.localdomain> <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com>
Date:   Mon, 06 Jul 2020 13:31:01 +0200
Message-ID: <877dvg6ft6.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi,

On Sat Jul 04 2020, Andy Shevchenko wrote:
> On Fri, Jul 3, 2020 at 1:32 PM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
>>
>> On (20/07/02 09:05), Tony Lindgren wrote:
>> > * Sergey Senozhatsky <sergey.senozhatsky@gmail.com> [200702 05:13]:
>> > > On (20/06/30 11:02), Tony Lindgren wrote:
>> > > > This conditional disable for irq_shared does not look nice to me
>> > > > from the other device point of view :)
>> > > >
>> > > > Would it be possible to just set up te dummy interrupt handler
>> > > > for the startup, then change it back afterwards? See for example
>> > > > omap8250_no_handle_irq().
>> > >
>> > > I think we can do it. serial8250_do_startup() and irq handler take
>> > > port->lock, so they should be synchronized.
>> > >
>> > > Something like this then?
>> >
>> > Yeah thanks this should work better for shared irq.
>>
>> This is, basically, an equivalent of
>>
>> ---
>>  drivers/tty/serial/8250/8250_port.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index d64ca77d9cfa..dba7747d2ddd 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *port)
>>
>>         if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>>                 unsigned char iir1;
>> +
>>                 /*
>>                  * Test for UARTs that do not reassert THRE when the
>>                  * transmitter is idle and the interrupt has already
>> @@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *port)
>>                  * allow register changes to become visible.
>>                  */
>>                 spin_lock_irqsave(&port->lock, flags);
>> -               if (up->port.irqflags & IRQF_SHARED)
>> -                       disable_irq_nosync(port->irq);
>>
>>                 wait_for_xmitr(up, UART_LSR_THRE);
>>                 serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>> @@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *port)
>>                 iir = serial_port_in(port, UART_IIR);
>>                 serial_port_out(port, UART_IER, 0);
>>
>> -               if (port->irqflags & IRQF_SHARED)
>> -                       enable_irq(port->irq);
>>                 spin_unlock_irqrestore(&port->lock, flags);
>>
>>                 /*
>
> ...which effectively is a revert of
>
> 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and
> RT kernels")

Please, don't revert that commit. I've faced the same issue as described
in the commit log. There is hardware available with shared UART
interrupt lines.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl8DC3UACgkQeSpbgcuY
8KaatQ/+I3uMpcHFLxQZhMYRh5GqeaLa/qLoonGoPgq5vSZihPv1qQHC5CIPHs9u
b1kud/9/p1yItg1tFM/xbUCBB5m8Ghp1kq3auEA39q1vz80PD39K9g+Jcw1Eh4xU
v06gSdvac3rNNAFk27iMKf55wITenBJWEZvttrSDI44KH3Mr0Zftl9y2azHh3gg1
iFpk7RsdoVziAHAwufC4SPghWatmB6NgZrbn2XZO+nqdg+E9457bjbLOHEUaDBqg
l7jXGOnRH0J/y+H5Nj+K9MGpzov855RbARwOUvnc9F9WY3mMPaRGkj+hTeueyU3K
ymwNPWotPsVQVEMTLzOgnR2lnxmUgahL+JO3MF+/wu1Vt1INZedHhawwGGXNMC9T
rPXs3CeDsdInR9GhEsuOjehrYpW577ZH/NQnmNZr1dPTViCJI1vryDhgV3toClnl
67XKp0m4XIUgbGPrRP7OAc/mePjSaHhPvfh3dlrNPyRCTq8ViLN3PgTLfZcyhexz
wvhBQFxp2d0wbI96J2VzOoVNccPr4n0pepXXYGwrzEe1IehwMI6PjN7GfB2ugO8o
lpklK0KHm2YrKsLKFg8ncCNEfq1NpDFISSaK3eLnMdhoGCuEPNvXMCgN9AaRVnKE
jZXuk/iOekD5ua4K3H+zcck76ECCNbPlXV/5uqSaYzyug/kCHFM=
=tqSP
-----END PGP SIGNATURE-----
--=-=-=--
