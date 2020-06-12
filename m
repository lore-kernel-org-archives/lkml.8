Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF91206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLXFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:05:55 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58802 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:05:55 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DCF521C0C0A; Sat, 13 Jun 2020 01:05:53 +0200 (CEST)
Date:   Sat, 13 Jun 2020 01:05:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, mhocko@suse.cz,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 5.7-rc0: kswapd eats cpu during a disk test?!
Message-ID: <20200612230552.GA3593@amd>
References: <20200531103431.GA28429@amd>
 <e3afe444-4541-b420-0888-575cae8aa46d@suse.cz>
 <20200612224532.GA24103@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200612224532.GA24103@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +CC linux-mm
> >=20
> > On 5/31/20 12:34 PM, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > This is simple cat /dev/sda > /dev/zero... on thinkpad x60 (x86-32),
> > > with spinning rust.
> > >=20
> > >   PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+  =
COMMAND
> > >    1000 root      20   0       0      0      0 R  53.3  0.0  57:34.93=
  kswapd0
> > >   27897 root      20   0    6976    580    536 R  44.5  0.0   1:44.53=
  cat
> > >=20
> > > It keeps both CPUs busy... and I don't think that's right.
> >=20
> > Does an older kernel behave differently here?
>=20
> Let me try on x220 (x86-64, first):
>=20
>   737 root      20   0    5404    744    680 R  31.2   0.0   0:09.98 cat =
      =20
>  1024 root      20   0       0      0      0 S  21.4   0.0 165:22.68 kswa=
pd0   =20
>=20
> That was with ssd, result with spinning rust is similar:
>=20
>   859 root      20   0    5404    740    672 D  21.1   0.0   0:03.33 cat =
      =20
>  1024 root      20   0       0      0      0 R  11.8   0.0 165:33.07 kswa=
pd0   =20
>=20
> 5.7-rc1+ kernel.
>=20
> Performance of spinning rust is down, too, on x60:
>=20
> pavel@amd:~/misc/hw/hdd1t$ sudo ddrescue --force /dev/sda1 /dev/null
> GNU ddrescue 1.19
> Press Ctrl-C to interrupt
> rescued:     2147 MB,  errsize:       0 B,  current rate:    3080 kB/s
>    ipos:     2147 MB,   errors:       0,    average rate:    5382 kB/s
>       opos:     2147 MB, run time:    6.65 m,  successful read:
>       0 s ago
>       Finished
> pavel@amd:~/misc/hw/hdd1t$ uname -a
> Linux amd 5.7.0-next-20200611+ #123 SMP PREEMPT Thu Jun 11
>  15:41:22 CEST 2020 i686 GNU/Linux
>=20
> And there's something clearly wrong here:
>=20
>   966 root      20   0       0      0      0 R  94.4  0.0   8:18.82   ksw=
apd0
>   23933 root      20   0    4612   1112   1028 D  80.6  0.0   0:26.40   d=
drescue
>  =20

Same x60 under older kernel:

pavel@amd:/data/fast/pavel$ sudo ddrescue --force /dev/sda4 /dev/null
GNU ddrescue 1.19
Press Ctrl-C to interrupt
rescued:     6593 MB,  errsize:       0 B,  current rate:   60424 kB/s
   ipos:     6593 MB,   errors:       0,    average rate:   95563 kB/s

 3539 root      20   0    4616   1136   1048 D  21.4  0.0   0:15.63 ddrescue
   865 root      20   0       0      0      0 S   6.9  0.0   0:04.91  kswap=
d0

Linux amd 4.6.0+ #172 SMP Sun Aug 14 11:25:34 CEST 2016 i686 GNU/Linux

These are more reasonable numbers.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7kClAACgkQMOfwapXb+vL9CwCfYbc2+YM+k2PuNUEa5voPfTrS
LIAAn1vwrCTCwORMMFy3I7mp2ALQxe3r
=7s82
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
