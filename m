Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6484AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4775A206F1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgEaMQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 08:16:04 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:52482 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaMQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 08:16:03 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 219471C0BD2; Sun, 31 May 2020 14:16:02 +0200 (CEST)
Date:   Sun, 31 May 2020 14:16:01 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: next-20200515: Xorg killed due to "OOM"
Message-ID: <20200531121601.GA14196@duo.ucw.cz>
References: <20200526091054.GA12103@amd>
 <20200528090517.GA27484@dhcp22.suse.cz>
 <20200528120354.GB22054@duo.ucw.cz>
 <20200528120750.GC27484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20200528120750.GC27484@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-05-28 14:07:50, Michal Hocko wrote:
> On Thu 28-05-20 14:03:54, Pavel Machek wrote:
> > On Thu 2020-05-28 11:05:17, Michal Hocko wrote:
> > > On Tue 26-05-20 11:10:54, Pavel Machek wrote:
> > > [...]
> > > > [38617.276517] oom_reaper: reaped process 31769 (chromium), now ano=
n-rss:0kB, file-rss:0kB, shmem-rss:7968kB
> > > > [38617.277232] Xorg invoked oom-killer: gfp_mask=3D0x0(), order=3D0=
, oom_score_adj=3D0
> > > > [38617.277247] CPU: 0 PID: 2978 Comm: Xorg Not tainted 5.7.0-rc5-ne=
xt-20200515+ #117
> > > > [38617.277256] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW=
 (2.19 ) 03/31/2011
> > > > [38617.277266] Call Trace:
> > > > [38617.277286]  dump_stack+0x54/0x6e
> > > > [38617.277300]  dump_header+0x45/0x321
> > > > [38617.277313]  oom_kill_process.cold+0x9/0xe
> > > > [38617.277324]  ? out_of_memory+0x167/0x420
> > > > [38617.277336]  out_of_memory+0x1f2/0x420
> > > > [38617.277348]  pagefault_out_of_memory+0x34/0x56
> > > > [38617.277361]  mm_fault_error+0x4a/0x130
> > > > [38617.277372]  do_page_fault+0x3ce/0x416
> > >=20
> > > The reason the OOM killer has been invoked is that the page fault
> > > handler has returned VM_FAULT_OOM. So this is not a result of the page
> > > allocator struggling to allocate a memory. It would be interesting to
> > > check which code path has returned this.=20
> >=20
> > Should the core WARN_ON if that happens and there's enough memory, or
> > something like that?
>=20
> I wish it would simply go away. There shouldn't be really any reason for
> VM_FAULT_OOM to exist. The real low on memory situation is already
> handled in the page allocator.

Umm. Maybe the WARN_ON is first step in that direction? So we can see
what driver actually did that, and complain to its authors?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXtOgAQAKCRAw5/Bqldv6
8vqIAJ9QLfIJlNZo17LROBTh+AZyZqMyhgCfYgEjyQCym4Ij5QizS2fH0XntFqU=
=EbcQ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
