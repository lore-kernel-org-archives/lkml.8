Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1909FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95C7206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGYV2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 17:28:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59556 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbgGYV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 17:28:09 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jzRi5-0003wV-Fu; Sat, 25 Jul 2020 22:28:01 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jzRi5-001HP4-2h; Sat, 25 Jul 2020 22:28:01 +0100
Message-ID: <6898a5af75e165fb9524558804fca9f46f98b633.camel@decadent.org.uk>
Subject: Re: process '/usr/bin/rsync' started with executable stack
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Kees Cook <keescook@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
Date:   Sat, 25 Jul 2020 22:27:56 +0100
In-Reply-To: <202006251253.2893D4F67@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
         <20200624165148.GD31008@kadam> <202006241238.E9CB1CE85B@keescook>
         <20200625100429.GB2571@kadam> <202006251253.2893D4F67@keescook>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-9s2wXGQEeGkArEPHaR7g"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9s2wXGQEeGkArEPHaR7g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-25 at 13:20 -0700, Kees Cook wrote:
> On Thu, Jun 25, 2020 at 01:04:29PM +0300, Dan Carpenter wrote:
> > On Wed, Jun 24, 2020 at 12:39:24PM -0700, Kees Cook wrote:
> > > On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
> > > > In Debian testing the initrd triggers the warning.
> > > >=20
> > > > [   34.529809] process '/usr/bin/fstype' started with executable st=
ack
> > >=20
> > > Where does fstype come from there? I am going to guess it is either
> > > busybox or linked against klibc?
> > >=20
> > > klibc has known problems with executable stacks due to its trampoline
> > > implementation:
> > > https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks
> >=20
> > Yeah.  It comes from klibc-utils.
>=20
> This is exactly what I was worried about back in Feb:
> https://lore.kernel.org/lkml/202002251341.48BC06E@keescook/
>=20
> This warning, combined with klibc-based initrds, makes the whole thing
> pointless because it will always warn once on boot for the klibc stack,
> and then not warn about anything else after that.
>=20
> It looks like upstream klibc hasn't been touched in about 4 years, and
> it's been up to Ben to keep it alive in Debian.
>=20
> A couple ideas, in order of my preference:
>=20
> 1) stop using klibc-utils[1]. initramfs-tools-core is the only thing with=
 a
>    dependency on klibc-utils. Only a few things are missing from busybox.
>=20
> 2) make the warning rate-limited instead?
>=20
> 3) fix the use of trampolines in klibc

It only uses trampolines on alpha, m68k, parisc, s390, and sparc32.  As
of today, the master branch should correctly enable executable stacks
on these and only these architecture.

I have a development branch that sets sa_restorer and disables
executable stacks on alpha, s390, and sparc32:

https://git.kernel.org/pub/scm/libs/klibc/klibc.git/log/?h=3Dexecstack-fixe=
s

But I haven't yet tested those changes other than on qemu-user.

The m68k and parisc kernel ports still don't support any alternatives
to trampolines for signal return, or they didn't when I reviewed this
a few months ago.

Ben.

> Thoughts?
>=20
> -Kees
>=20
>=20
> [1] Ben appears well aware of this idea, as he suggested it in 2018. :)
>     https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D887159
>=20
--=20
Ben Hutchings
Anthony's Law of Force: Don't force it, get a larger hammer.


--=-9s2wXGQEeGkArEPHaR7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl8co9wACgkQ57/I7JWG
EQkXsA/9Gbdsr1lUAsnm01IzmA+B2l2ioKNZ5fpmjADK5cEXPyvVsJn+5DPWdHxs
O9j032ExQvM816R3dWpzO23DdqO05AYL+VdqTOpgIdwx8CZTCFc9Pv1ua1PhiaKY
vJsNpPSu+nRfAcTStXZUjbMvMtJnev2wSv+zT3+eUX73/b5+BbKGnn1Zdkq8P4/R
4Zdv6q17QXYTe37SFLxRPfAXIURZIoIJwdym/PlxxkfdKXl0W+zYJmQhbBCc17Et
dBx5i3HyhtxowCv3vElKLqtzU2cFqVQGowdlcuw2sg3yWKIpopGH1Da6cnaCAmCp
iTpkn26+lyHVuavirUGcRRhm4ROW5YSPEgpQhXL6hpuQwbUf/Nm+Egaxe+p0yQI3
u5Es7vnjC9xCuHvA6apd+mDnmTsqV8IXPVrng+P07M47LS3r71Pb2lYWoKgpzoZv
8mvYESVPS+95d3zsvy72+AwBAmgoEHgYiDoBcrZwqjsaAu0lQzCKjxw7e3aQUo9Y
1srn2zFuTfqWdOt8iU3w8Ld/mNHgplCRtNVP9sM3AsV1ilZZqD4QKzrGHGbd0VaW
ZcuOa89NIIo+MYS0E7U22z+qI/L9KipKP4jPhG9U9UGn2VMBGR7qbeXikgd91T9F
XV6pNmjNn1NrU2PjegtogkxwaLdC1dZPVulJkpzT71eNpmQa0GA=
=sL/U
-----END PGP SIGNATURE-----

--=-9s2wXGQEeGkArEPHaR7g--
