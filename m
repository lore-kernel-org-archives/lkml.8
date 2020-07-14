Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D87C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEB822202
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594722948;
	bh=3/kOijZ2Jqvx9fV509wbaqAHppjbu3yqiHK4P0pxR9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q45ymEaDqHZMx2t33IRYIn4Mh80iczEYVAJbsxXL/tEN3sQRDX2io43mkPDrrB4IR
	 VMrou/RT3xgyTlk3Ok4DLvHloKoEvZJB0tU2nn1SQsBe2os1400rV0lOGakpIU4ElD
	 9i/nMo1MFneb9+2YaByHmxshu1uRCaHgmRN9Tpnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGNKfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNKfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:35:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FE622206;
        Tue, 14 Jul 2020 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594722945;
        bh=3/kOijZ2Jqvx9fV509wbaqAHppjbu3yqiHK4P0pxR9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjY7E3V0aZv5d0i3fKoYwYgQvjmUZbyEsIzYHmUq5g14ANKoqVoX++pY66mGoIIUJ
         qwVw/Ls9ErxPp2BfWk5o7i5uEDzud+LydFzgGusYIheTZtJvHqESSAn44tOWSiIkr8
         OfL3jLVRUDbrvwVY6WgKIlFeRs5I5yKR5zbIyxmo=
Date:   Tue, 14 Jul 2020 11:35:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     qiao mnlife <mnlife.qiao@gmail.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        open list <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        =?utf-8?B?5LmU5pif?= <mnlife@foxmail.com>
Subject: Re: [PATCH] soc jack: When snd_soc_card_jack_new is not called or
 the call fails, calling this function causes a null pointer access
Message-ID: <20200714103536.GC4900@sirena.org.uk>
References: <5f087f1b.1c69fb81.2a42.d99fSMTPIN_ADDED_MISSING@mx.google.com>
 <DM6PR12MB4122CBAFE14C28D7302272E3F9650@DM6PR12MB4122.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB4122CBAFE14C28D7302272E3F9650@DM6PR12MB4122.namprd12.prod.outlook.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 02:56:03PM +0000, qiao mnlife wrote:
> ________________________________
> From: mnlife <mnlife@foxmail.com>
> Sent: Friday, July 10, 2020 10:45:42 PM
> To: mnlife.qiao@gmail.com <mnlife.qiao@gmail.com>
> Cc: mnlife <mnlife@foxmail.com>
> Subject: [PATCH] When snd_soc_card_jack_new is not called or the call fai=
ls, calling this function causes a null pointer access
>=20
> Signed-off-by: mnlife <mnlife@foxmail.com>

This looks good but it's a bit mangled in submission - can you please
try to resend using something closer to the format in
submitting-patches.rst?  The changelog should be in the body of the mail
and there should be a patch subject in a similar format to to the other
patches in git.

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NingACgkQJNaLcl1U
h9BIMQf/Yem6Wc8n49m8Tf5PlTiHnGyVemElmr6g1eJO0rZT66Dm+8tiK6ep0MHa
OWFTmZPF0oec1a2jQgLEgDw9WwMXlNvYoBp6UFPEkS0hJafnRl5Xq0F19CyrSHTr
H9yLrzFlAoiCfv0jiOQFiCIyCFdOapUQpe0T81jlG8cXh/UIXGs2AKRdbNAmVUFX
zVPVtFzfK0XHMpoVZv9qS4EvyaAzd7KKAjzGJsri7OrbBAxbjTETz3wKdKwMGnCe
jRM0DkTEOYPD0ZeOFqquloDz/q3u3gs1VcKaWaxwWoW1Vjg/aOi4v2XHqTZfmysO
a1PNiLk+AjAGnIx6YMAqzjXHp9MVBg==
=+aKm
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
