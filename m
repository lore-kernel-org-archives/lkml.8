Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9652071A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592479880;
	bh=xmVKqCZO9WNjF/s1+iMwtbOzQ/ZlWpvC11qODgjb/Fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3pc4GKK67ynv4eBdckSZOhGR/sNo+8Fus/4Uwayk1NMc9sGOo8smE8yi5/kUyHUb
	 ysTgrNTxJhW4VygkVM6A8LEFiwh6+JL+OT71DxgmmJVEG04WKQqgsn677dJR/UqSk5
	 Qj8oEVeph26ouYuMlRD9WQTsYceUKajodzFrAogI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgFRLbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgFRLbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:31:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A25E206C3;
        Thu, 18 Jun 2020 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592479876;
        bh=xmVKqCZO9WNjF/s1+iMwtbOzQ/ZlWpvC11qODgjb/Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVP4Z99YcHvJ4xcy54nJ0Ixc1WAPI7Izy/o0/amvDXFN82Opxh8WrxPGFBbR8f+G7
         GDeN8EXggH2c9KxHuKiBFZ7Dq2s1To4uG1FKnZNPphdza9rUQWorreO/aYdUnBffoD
         8SZDuaMTbl/iPpakFrbxV76w9x3vikQZ5a3ZXRbk=
Date:   Thu, 18 Jun 2020 12:31:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ASoC: amd: closing specific instance.
Message-ID: <20200618113114.GG5789@sirena.org.uk>
References: <20200618072653.27103-1-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2JjAQZceEVGylhD"
Content-Disposition: inline
In-Reply-To: <20200618072653.27103-1-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2JjAQZceEVGylhD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 12:56:52PM +0530, Ravulapati Vishnu vardhan rao wro=
te:
> The steps to reproduce:
>=20
> Record from the internal mic :
> (arecord -D hw:1,2 -f dat /dev/null -V stereos)
>=20
> Record from the headphone mic:
> (arecord -D hw:1,0 -f dat /dev/null -V stereos)
>=20
> Kill the recording from internal mic.
> We can see the recording from the headphone mic is broken.
>=20
> This patch rectifies the issue reported.

The changelog should really also describe what the underlying problem
and/or fix are - this description is only at user level, it's missing a
bit for describing the change.

--w2JjAQZceEVGylhD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rUIEACgkQJNaLcl1U
h9DKfAf+L2nSYQE3s9vUUaTa2gREfXwRWFiOeS9pnxdOboz5I43vVFqJauMas8kx
PhUZRYhfwsYXiNWLikhDRpPTw/zLhqaxRhqTjV724NcZE35tZp4KjC6aSvY7n0Zs
KEN208OWaO27vbklKnwv0rXwu5lCrX1c5dJF2ax9z2u6cu1PCKWd4o2rC30JxykY
GFtcooFi04ann8+eBia8VhNHODWPIkkVBDe7moz4hGPg+Od/NGaKjtX47zpSGadF
BH+5fTO/sVjdTXLvn3WKdxf0qiNmROyhCQQNuJAPPO3Ns71xSCxHHvq3MlLCsjF9
r8eky0ARkzvxVVwhj3tAyPqcghgdeQ==
=mItw
-----END PGP SIGNATURE-----

--w2JjAQZceEVGylhD--
