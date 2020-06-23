Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E716204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgFWVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:11:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53408 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389684AbgFWVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:11:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 56CED1C0C0A; Tue, 23 Jun 2020 23:11:03 +0200 (CEST)
Date:   Tue, 23 Jun 2020 23:11:03 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 066/206] soundwire: slave: dont init debugfs on
 device registration error
Message-ID: <20200623211102.GB4401@amd>
References: <20200623195316.864547658@linuxfoundation.org>
 <20200623195320.204985936@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <20200623195320.204985936@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 8893ab5e8ee5d7c12e0fc1dca4a309475064473d ]
>=20
> The error handling flow seems incorrect, there is no reason to try and
> add debugfs support if the device registration did not
> succeed. Return on error.

> +++ b/drivers/soundwire/slave.c
> @@ -55,6 +55,8 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  		list_del(&slave->node);
>  		mutex_unlock(&bus->bus_lock);
>  		put_device(&slave->dev);
> +
> +		return ret;
>  	}
> =20
>  	return ret;

Mainline is significantly different here; this patch does not make
sense in v4.19 -- as it does not do anything.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7yb+YACgkQMOfwapXb+vIpBgCguXIYBDydvxHF/VrSJvIq1C6u
CrEAn3RXvz12D0iGQtA1lz2By4y491LE
=qSV3
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
