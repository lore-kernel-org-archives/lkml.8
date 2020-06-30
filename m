Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5113EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E1292065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgF3Vhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:37:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52816 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgF3Vhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:37:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D52471C0C0F; Tue, 30 Jun 2020 23:37:38 +0200 (CEST)
Date:   Tue, 30 Jun 2020 23:37:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        chris@chris-wilson.co.uk, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Subject: 5.8-rc2: X hangs due to drm problem (on thinkpad x220)
Message-ID: <20200630213738.GA6288@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


[221198.058766] oom-kill:constraint=3DCONSTRAINT_NONE,nodemask=3D(null),tas=
k=3Dchromium,pid=3D3612,uid=3D1000
[221198.058804] Out of memory: Killed process 3612 (chromium) total-vm:2677=
236kB, anon-rss:95868kB, file-rss:0kB, shmem-rss:1390212kB, UID:1000 pgtabl=
es:4104kB oom_score_adj:200
[221198.123441] oom_reaper: reaped process 3612 (chromium), now anon-rss:16=
kB, file-rss:0kB, shmem-rss:1380368kB
[223149.407523] perf: interrupt took too long (10405 > 10375), lowering ker=
nel.perf_event_max_sample_rate to 19000
[223351.853087] perf: interrupt took too long (13074 > 13006), lowering ker=
nel.perf_event_max_sample_rate to 15250
[223652.320162] perf: interrupt took too long (16350 > 16342), lowering ker=
nel.perf_event_max_sample_rate to 12000
[223998.558829] perf: interrupt took too long (20625 > 20437), lowering ker=
nel.perf_event_max_sample_rate to 9500
[224119.659585] Adding 1681428k swap on /dev/sda1.  Priority:-2 extents:1 a=
cross:1681428k=20
[224452.285193] perf: interrupt took too long (25999 > 25781), lowering ker=
nel.perf_event_max_sample_rate to 7500
[225248.349100] i915 0000:00:02.0: [drm] Resetting chip for stopped heartbe=
at on rcs0
[225248.452665] i915 0000:00:02.0: [drm] chromium[719] context reset due to=
 GPU hang

Ok, so... cat drm/card0/error, they said? Well... no. It says "can not
allocate memory". Swap is unused and there are 3.5G free AFAICT.

pavel@duo:~$ sudo cat /sys/devices/pci0000:00/0000:00:02.0/drm/card0/error
cat: '/sys/devices/pci0000:00/0000:00:02.0/drm/card0/error': Cannot allocat=
e memory

pavel@duo:~$ free
              total        used        free      shared  buff/cache   avail=
able
Mem:        5973704     1802036      987008      430904     3184660     365=
4380
Swap:       1681428           8     1681420

(And yes, this is same machine from [Intel-gfx] v5.8-rc1 on thinkpad
x220, intel graphics: interface frozen, can still switch to text
console thread, and hang looks very similar).

Any ideas?

Is it possible that there's some kind of memory leak in graphics
subsystem? I suspected leak in chromium, but this time I restarted
chromium, and did swapoff / swapon, and machine was ... still pretty
unusable, culminating with hang of graphics. Text console still works.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvuwogAKCRAw5/Bqldv6
8vh8AJ4scbz0dhJv1T0im0HIMLjhltwH+QCfY8flqZQMd46etkq2GXhhfdtx/hE=
=q1QL
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
