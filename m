Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B65EC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21616206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581343393;
	bh=FkTZq2eKwunhOe3/1nrWbQD/hFpsv1quvhZIUXFFgxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfkEyzCfUPLVSvZ7NLamYL4NvLTvV5k9mYDT8nXw21nZxDMMXjSX90Dr0HmisDVZW
	 UGyN7u1g5Vh2M1GzLAI1eIa4QH0lRkKhx/7AfwZG0qtlBKk4JGvI1y910055J2g7O3
	 aJgTSLL8Ged+Y53tfUbsI6/4+JPZ8awB46FYdxzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgBJODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:03:11 -0500
Received: from foss.arm.com ([217.140.110.172]:34272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgBJODL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:03:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D343F1FB;
        Mon, 10 Feb 2020 06:03:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5816E3F68E;
        Mon, 10 Feb 2020 06:03:10 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:03:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] ASoC: Use imply for SND_SOC_ALL_CODECS
Message-ID: <20200210140308.GN7685@sirena.org.uk>
References: <20200207091351.18133-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TXIPBuAs4GDcsx9K"
Content-Disposition: inline
In-Reply-To: <20200207091351.18133-1-geert@linux-m68k.org>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TXIPBuAs4GDcsx9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 10:13:51AM +0100, Geert Uytterhoeven wrote:
> Currently SND_SOC_ALL_CODECS selects the config symbols for all codec
> drivers.  As "select" bypasses dependencies, lots of "select" statements
> need explicit dependencies, which are hard to get right, and hard to
> maintain[*].
>=20
> Fix this by using "imply" instead, which is a weak version of "select",
> and which obeys dependencies of target symbols.

This is a *really* badly named feature :/

--TXIPBuAs4GDcsx9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BYpwACgkQJNaLcl1U
h9AJ6wf+JoGh6XxETeSB4TWntPU4POgBDY7UzyJaSzC/k9dxItOpbvF8sZbh3YVO
RqfpWryUL/Icpn8pUC785qgCczDrAzW3YB3tkwvAma8tNK/HA6TC4b5/pl2h0F1e
R5gValaXJ4qG0+Q9ZDNlDNmVX06fSlutz4K+UUBAP8DUgrXcQXqo4PhjIptTRix/
GKtNAePn3171ofUgEhfSpVE6I7zZHkcD0IC3CQ5Ss9ui/7YBzRls6qq5HOqEbvDD
4KvKMTM4lDu7u7f+R9ov/N0NEDS2ZtKNfoALHeQTBCplEhIbXSHZ5r0hF4LBAE9r
CI47bCrYKahz5DDreklkq0WdmyUZQw==
=MBOV
-----END PGP SIGNATURE-----

--TXIPBuAs4GDcsx9K--
