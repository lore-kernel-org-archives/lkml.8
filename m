Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200C8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FF920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WhewwSnE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UXxEHP+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGHHkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:40:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGHHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:40:22 -0400
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594194019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=deFGfHxYZYgFx9JerGX/g9w6hxTKxOGElkA7QsAXZ3w=;
        b=WhewwSnEfGMkGBbezfukKi28AdipCum2wKduadjzvIOk+jrBL5e8y8T/hYFJrBJ+6crdbZ
        hZhqae76KBRhQWKvIxiM8/+G45D4bahl9w/EYMDqDpkVQ2n+vxEDXK2UJXFa1omIr6NdPu
        GZKDdu4SipOERb1v/l0216WfWacWodvOFRRtEAU0kEExQuAa1Ix5fRIfNqbBLiqKWeiuT2
        Jz+EPJuMsU135R+GllJirrGDxQe+WncXbgf9TA4e3/mK2mIV/GalUazXC4deue7wiiRtbB
        jDsYrPgLMilJ7eBOR2s747Hf8EUipgTePQQFaP6K8r556E+W+a+WnWpsW6zfCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594194019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=deFGfHxYZYgFx9JerGX/g9w6hxTKxOGElkA7QsAXZ3w=;
        b=UXxEHP+lGDBaQFgs7Dq8HysuTS86gLQtlL8hTV3eNdK6Lhb0uGEaSsAfsiAqRrmv0JfK+L
        1c6panhvNY28iIAA==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Petr Mladek <pmladek@suse.com>,
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
In-Reply-To: <20200706144314.GB1485@jagdpanzerIV.localdomain>
References: <20200630102141.GA11587@alley> <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley> <20200630130534.GB145027@jagdpanzerIV.localdomain> <20200630180255.GD37466@atomide.com> <20200702051213.GB3450@jagdpanzerIV.localdomain> <20200702160514.GK37466@atomide.com> <20200703103241.GB182102@jagdpanzerIV.localdomain> <CAHp75VdvNi_LWv7QhEsm1vQikeiMpi68qmCwoVttjnp7oq0ahg@mail.gmail.com> <877dvg6ft6.fsf@kurt> <20200706144314.GB1485@jagdpanzerIV.localdomain>
Date:   Wed, 08 Jul 2020 09:40:17 +0200
Message-ID: <87o8oqa1zy.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon Jul 06 2020, Sergey Senozhatsky wrote:
> On (20/07/06 13:31), Kurt Kanzenbach wrote:
>> >> @@ -2275,6 +2275,7 @@ int serial8250_do_startup(struct uart_port *por=
t)
>> >>
>> >>         if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
>> >>                 unsigned char iir1;
>> >> +
>> >>                 /*
>> >>                  * Test for UARTs that do not reassert THRE when the
>> >>                  * transmitter is idle and the interrupt has already
>> >> @@ -2284,8 +2285,6 @@ int serial8250_do_startup(struct uart_port *por=
t)
>> >>                  * allow register changes to become visible.
>> >>                  */
>> >>                 spin_lock_irqsave(&port->lock, flags);
>> >> -               if (up->port.irqflags & IRQF_SHARED)
>> >> -                       disable_irq_nosync(port->irq);
>> >>
>> >>                 wait_for_xmitr(up, UART_LSR_THRE);
>> >>                 serial_port_out_sync(port, UART_IER, UART_IER_THRI);
>> >> @@ -2297,8 +2296,6 @@ int serial8250_do_startup(struct uart_port *por=
t)
>> >>                 iir =3D serial_port_in(port, UART_IIR);
>> >>                 serial_port_out(port, UART_IER, 0);
>> >>
>> >> -               if (port->irqflags & IRQF_SHARED)
>> >> -                       enable_irq(port->irq);
>> >>                 spin_unlock_irqrestore(&port->lock, flags);
>> >>
>> >>                 /*
>> >
>> > ...which effectively is a revert of
>> >
>> > 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and
>> > RT kernels")
>>=20
>> Please, don't revert that commit. I've faced the same issue as described
>> in the commit log. There is hardware available with shared UART
>> interrupt lines.
>
> Will this patch break that hardware?
> https://lore.kernel.org/lkml/20200702051213.GB3450@jagdpanzerIV.localdoma=
in/

I'm not sure how this patch will help with the situation. Because at the
point of that THRE test the irq handler isn't registered. It's
registered a few lines below (up->ops->setup_irq()) meaning the irq line
has to be disabled if shared. Otherwise the kernel might detect a
spurious irq and disables it. That's at least my understanding of the
problem (see commit message from 54e53b2e8081 ("tty: serial: 8250: pass
IRQ shared flag to UART ports")).

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl8FeGEACgkQeSpbgcuY
8KZFuw//cx3Oy+/kFOtj/m/GQiBhw+JVAJ4ixZ92RmC564AEcTZoGGwpqXE7an70
FIUvBNKAzmk6w5LR628Mx29Qee4e35n6YMgPcAjbaCwwDiMq5In5tpnkowPEvNwi
IY5J3dnaLR+MkQxg3NjYu5LBDArW0MugDqOnj1RefUIToqQCQgMb4wEskUlaDvFC
e7gv9NeOTXMg4etj5MFnWiTRTcdCCBV1HjzZ9NRFeLCm/mKm2Q/KR1MIkZxmM22/
dGzhrD15Ly7hDyXYoPJY9g4P2+pJsY3kqrZb5FsVrYhjR5ZlGB8DOIVHwJ/f98YV
bolld/ntOqWlzEeOwrmjYbSgVcW56lBMA+5HV4pOUbq6EcXyEAzWcVa4FaYsZdvJ
iRxMuC3JjRRve3mBOrITv2egPCktZeSeZExpAXzyuYbQpNwurvVQjjVL+RPJrkpx
2RnAikQtz5E2EcyxbZmNcS687sweUFRsGhlT/zE7dJ+cOd+pfM0kvrJSnNbdxNC5
/w//o5y75M5pV2CbNhvfpgB6I/aik/SxATHG6NMF3IojM/SO/gb7lmdFWpYLwP6f
k45gcwC9FZoTNHmyYzlitbs45kMfgqPQAnKAqYnRJAfl/CgOCnJZhO5DvjiX671K
32NlT5V0x/5bPcnkkgn1tYK1x68ivgeXDSjj244lns5a7KknF5A=
=lDDH
-----END PGP SIGNATURE-----
--=-=-=--
