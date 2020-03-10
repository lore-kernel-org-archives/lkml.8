Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7ABC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875F02071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgCJWdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:33:36 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37540 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgCJWdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:33:36 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 890D81C0317; Tue, 10 Mar 2020 23:33:34 +0100 (CET)
Date:   Tue, 10 Mar 2020 23:33:33 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 07/86] ALSA: hda: do not override bus codec_mask in
 link_get()
Message-ID: <20200310223333.GA7285@duo.ucw.cz>
References: <20200310124530.808338541@linuxfoundation.org>
 <20200310124531.200272158@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20200310124531.200272158@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>=20
> [ Upstream commit 43bcb1c0507858cdc95e425017dcc33f8105df39 ]
>=20
> snd_hdac_ext_bus_link_get() does not work correctly in case
> there are multiple codecs on the bus. It unconditionally
> resets the bus->codec_mask value. As per documentation in
> hdaudio.h and existing use in client code, this field should
> be used to store bit flag of detected codecs on the bus.
>=20
> By overwriting value of the codec_mask, information on all
> detected codecs is lost. No current user of hdac is impacted,
> but use of bus->codec_mask is planned in future patches
> for SOF.

Given that no users are impacted, is this stable material?

Best regards,
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmgVvQAKCRAw5/Bqldv6
8oWFAJ92qQ1c7YfWPVxvOZkRZmzWz5OU1wCgjYBrJxV9v3BI8hXk5QYYPkgzwes=
=qvAj
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
