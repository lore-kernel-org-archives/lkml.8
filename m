Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0D7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A32220729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGTWFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:05:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45770 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTWFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:05:10 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BBF4F1C0BE2; Tue, 21 Jul 2020 00:05:07 +0200 (CEST)
Date:   Tue, 21 Jul 2020 00:05:06 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Theodore Tso <tytso@mit.edu>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 130/133] printk: queue wake_up_klogd irq_work only
 if per-CPU areas are ready
Message-ID: <20200720220506.GB11552@amd>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152810.011879475@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20200720152810.011879475@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>=20
> commit ab6f762f0f53162d41497708b33c9a3236d3609e upstream.
>=20
> printk_deferred(), similarly to printk_safe/printk_nmi, does not
> immediately attempt to print a new message on the consoles, avoiding
> calls into non-reentrant kernel paths, e.g. scheduler or timekeeping,
> which potentially can deadlock the system.
>=20
> Those printk() flavors, instead, rely on per-CPU flush irq_work to print
> messages from safer contexts.  For same reasons (recursive scheduler or
> timekeeping calls) printk() uses per-CPU irq_work in order to wake up
> user space syslog/kmsg readers.
>=20
> However, only printk_safe/printk_nmi do make sure that per-CPU areas
> have been initialised and that it's safe to modify per-CPU irq_work.
> This means that, for instance, should printk_deferred() be invoked "too
> early", that is before per-CPU areas are initialised, printk_deferred()
> will perform illegal per-CPU access.
>=20
> Lech Perczak [0] reports that after commit 1b710b1b10ef ("char/random:
> silence a lockdep splat with printk()") user-space syslog/kmsg readers
> are not able to read new kernel messages.

Is this still needed in 4.19? 1b710b1b10ef was reverted in 4.19, so
there should not be any user-visible problems...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8WFRIACgkQMOfwapXb+vLKhgCfV9OfDawaGXAxOK460y5BjrhE
G4YAn1xYwFJm2Kc0ESgqD4+gVnhnw1C/
=H6fx
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
