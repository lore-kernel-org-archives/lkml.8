Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6845C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF73206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgE1LWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:22:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58278 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbgE1LWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:22:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4C7001C0351; Thu, 28 May 2020 13:22:32 +0200 (CEST)
Date:   Thu, 28 May 2020 13:22:31 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Alessandrelli, Daniele" <daniele.alessandrelli@intel.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "robh@kernel.org" <robh@kernel.org>,
        "Murphy, Paul J" <paul.j.murphy@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniele.alessandrelli@linux.intel.com" 
        <daniele.alessandrelli@linux.intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Message-ID: <20200528112231.GA22054@duo.ucw.cz>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com>
 <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
 <20200524212851.GG1192@bug>
 <CAK8P3a225pqBfzQ19e6Gt0s_tYBp29xLb8EG==hhz=1wc7aVCA@mail.gmail.com>
 <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <ac0534138facc25c4cbcbbff68fc0ba3c2de87b6.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Agreed, this sounds like an incompatible extension of the boot
> > protocol
> > that we should otherwise not merge.
> >=20
> > However, there is also a lot of missing information here, and it is
> > always
> > possible they are trying to something for a good reason. As long as
> > the
> > problem that the bootloader is trying to solve is explained well
> > enough
> > in the changelog, we can discuss it to see how it should be done
> > properly.
>=20
>=20
> Apologies, I should have provided more information. Here it is :)
>=20
> Basically, at boot time U-Boot code and core memory (.text, .data,
> .bss, etc.) is protected by this Isolated Memory Region (IMR) which
> prevents any device or processing units other than the ARM CPU to
> access/modify the memory.
>=20
> This is done for security reasons, to reduce the risks that a potential
> attacker can use "hijacked" HW devices to interfere with the boot
> process (and break the secure boot flow in place).

Dunno. You disable that after boot anyway. Whether it is disabled just
before starting kernel or just after it makes very little difference.

Plus, I'm not sure if this has much security value at all. If I can
corrupt data u-boot works _with_ (such as kernel, dtb), I'll take over
the system anyway.

IOW I believe the best/simplest way is to simply disable this in
u-boot before jumping to kernel entrypoint.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXs+e9wAKCRAw5/Bqldv6
8kTnAJkBCFaIH+RgyEIJB348L5Z1U0EPAwCglTSJuvMLH/LegS0zeGTtaIRLU2s=
=U8+S
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
