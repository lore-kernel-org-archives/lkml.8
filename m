Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87D8C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED202070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgBJNlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:41:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47762 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJNlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:41:35 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2976C1C2228; Mon, 10 Feb 2020 14:41:34 +0100 (CET)
Date:   Mon, 10 Feb 2020 14:41:33 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        yamada.masahiro@socionext.com
Subject: 5.6-rc1: regression -- assertion failure in kallsyms
Message-ID: <20200210134133.GA32563@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm now getting this:

  MODPOST vmlinux.o
    MODINFO modules.builtin.modinfo
      GEN     modules.builtin
        LD      .tmp_vmlinux1
	  KSYM    .tmp_kallsyms1.o
	  kallsyms: malloc.c:2385: sysmalloc: Assertion `(old_top =3D=3D
    initial_top (av) && old_size =3D=3D 0) || ((unsigned long) (old_size)
    >=3D MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end &
    (pagesize - 1)) =3D=3D 0)' failed.
    Aborted (core dumped)
    /data/fast/l/k/Makefile:1077: recipe for target 'vmlinux' failed
    make[1]: *** [vmlinux] Error 134
    make[1]: Leaving directory '/data/fast/l/k/o/900'
    Makefile:179: recipe for target 'sub-make' failed
    make: *** [sub-make] Error 2
    make took 1 minutes 8 seconds
    Command returned exit status 2
    pavel@amd:/data/l/k$

=2E.and am not able to cross-compile kernel for Nokia N900. Any ideas?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5BXY0ACgkQMOfwapXb+vIKOQCdFFyEut5OJtQxuQkE3TNU6mag
sw0An0DRGQutUTy4wcEeY0g+7JmneLBa
=SXwM
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
