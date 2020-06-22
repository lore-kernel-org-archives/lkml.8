Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7E6206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFVKVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:21:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46356 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFVKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:21:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6FBE81C0C0C; Mon, 22 Jun 2020 12:21:05 +0200 (CEST)
Date:   Mon, 22 Jun 2020 12:21:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        rodrigo.vivi@intel.com
Subject: Re: [Intel-gfx] v5.8-rc1 on thinkpad x220, intel graphics: interface
 frozen, can still switch to text console
Message-ID: <20200622102105.GA6353@duo.ucw.cz>
References: <20200622085258.GA22686@duo.ucw.cz>
 <159281719363.11575.10607533427539631904@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <159281719363.11575.10607533427539631904@build.alporthouse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-06-22 10:13:13, Chris Wilson wrote:
> Quoting Pavel Machek (2020-06-22 09:52:59)
> > Hi!
> >=20
> > Linux duo 5.8.0-rc1+ #117 SMP PREEMPT Mon Jun 15 16:13:54 CEST 2020 x86=
_64 GNU/Linux
> >=20
> > [133747.719711] [  17456]     0 17456     4166      271    65536       =
 0             0 sshd
> > [133747.719718] [  17466]  1000 17466     4166      289    65536       =
 0             0 sshd
> > [133747.719724] [  17468]  1000 17468   433587   303033  2588672       =
 0             0 unison
> > [133747.719730] [  18023]  1000 18023     1316       16    40960       =
 0             0 sleep
> > [133747.719737] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null)=
,task=3Dchromium,pid=3D27368,uid=3D1000
> > [133747.719795] Out of memory: Killed process 27368 (chromium) total-vm=
:6686908kB, anon-rss:647056kB, file-rss:0kB, shmem-rss:7452kB, UID:1000 pgt=
ables:5304kB oom_score_adj:300
> > [133747.799893] oom_reaper: reaped process 27368 (chromium), now anon-r=
ss:0kB, file-rss:0kB, shmem-rss:6836kB
> > [136841.820558] i915 0000:00:02.0: [drm] Resetting chip for stopped hea=
rtbeat on rcs0
> > [136841.924333] i915 0000:00:02.0: [drm] Xorg[3016] context reset due
> > to GPU hang
>=20
> If that was the first occurrence it would have pointed to the error
> state containing more information on the cause of the hang.
> Attach /sys/class/drm/card0/error

I rebooted in the meantime (I need this machine). I updated to
5.8-rc2, let me see if it appears again.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvCGEQAKCRAw5/Bqldv6
8ra8AJ9a5MeyxXQMGOQpt14HyRy7iDoIyQCfdW8mVBpcIGK647Sn7FRe/TFKx+Y=
=6Vyy
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
