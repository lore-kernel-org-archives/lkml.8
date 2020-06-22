Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B850CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC1206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFVIxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:53:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38030 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgFVIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:53:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 74C061C0C0A; Mon, 22 Jun 2020 10:52:59 +0200 (CEST)
Date:   Mon, 22 Jun 2020 10:52:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org
Subject: v5.8-rc1 on thinkpad x220, intel graphics: interface frozen, can
 still switch to text console
Message-ID: <20200622085258.GA22686@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Linux duo 5.8.0-rc1+ #117 SMP PREEMPT Mon Jun 15 16:13:54 CEST 2020 x86_64 =
GNU/Linux

[133747.719711] [  17456]     0 17456     4166      271    65536        0  =
           0 sshd
[133747.719718] [  17466]  1000 17466     4166      289    65536        0  =
           0 sshd
[133747.719724] [  17468]  1000 17468   433587   303033  2588672        0  =
           0 unison
[133747.719730] [  18023]  1000 18023     1316       16    40960        0  =
           0 sleep
[133747.719737] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),tas=
k=3Dchromium,pid=3D27368,uid=3D1000
[133747.719795] Out of memory: Killed process 27368 (chromium) total-vm:668=
6908kB, anon-rss:647056kB, file-rss:0kB, shmem-rss:7452kB, UID:1000 pgtable=
s:5304kB oom_score_adj:300
[133747.799893] oom_reaper: reaped process 27368 (chromium), now anon-rss:0=
kB, file-rss:0kB, shmem-rss:6836kB
[136841.820558] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbe=
at on rcs0
[136841.924333] i915 0000:00:02.0: [drm] Xorg[3016] context reset due
to GPU hang

Kernel is v5.8-rc1.

Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvBxagAKCRAw5/Bqldv6
8v2DAJ92b8dghQBXzFffjNNLy6CEyC262ACfYxgoVq6bAVMZNICYquHEtA+jVrM=
=0WGl
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
