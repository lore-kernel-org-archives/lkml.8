Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE492C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00E02082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZOzYsq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgAJOqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:46:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38069 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgAJOqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:46:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so2254377wmc.3;
        Fri, 10 Jan 2020 06:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WUUgIu5Jy7CVGqSaZJ239PH8w1I0qej2hZIYHvSsa3M=;
        b=rZOzYsq8Gxh5LfdYdNYNsHlfTTx5eR1ekuFwXaI4UbMNvW6NXS9/NgWGl21syjE0dv
         mNbuwwU2A7q2rJHz1sEFTudg38DTBmjDNTbgsmh5ZI0Z7c5AC1pOeV2qimUkMmMz18gh
         X2WKLDLItEb6NH0weIb7MY+Y30tVAVlwXL6/BcXZ8yRKhrHKTiXTw0na5CB4UPmU2lgy
         obUDRl0U5NAbKzk0S43ixgbYY5kX919QnuSSqBnVaSdVnhk+wgDooq108X0Cn9gB0Cmi
         +/S6d/8WYUhAMZRU9Qc6vXvwVzmr75MeF8YIOsJwTJ/G6jwcOM4jfDLRaL8gHf5zZccs
         mfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WUUgIu5Jy7CVGqSaZJ239PH8w1I0qej2hZIYHvSsa3M=;
        b=Onjso2tak/ohJWEiAiyQc34dNi7pGcowM+JOI79PH5HIwOheiihauF6w8yZSok70ln
         v20YO8CglU+z20rsZ2nM1OhldvRugv10h37bWAKdr7EyFLKSKQLw3uAVRkjQwxcvId/5
         A3qx3xV0kLDnGr6MTtGpOzSThlkNdf+AVl8tqEu5SBqYeJFoIZiJYBDnyr9MLAp4HoTW
         kUbrLefbfbxiPGXo9/lBtfi2MjX15UTQocSNz5aksXXb5XGDji3VPiFcThJGYX8RMyZb
         ezgSFicc6hWdmGT2QGAhEENlO85CG8i0DkOD/0BIamWdnnPbtde2C6Yu/NOCJ/eVi3Za
         VR2w==
X-Gm-Message-State: APjAAAUpLINdqgimLd2TJJdN9aHHAhWngsnq2QI8qVrp3mDtTsTVhdOE
        kJrboypxBWdLQcWdFcKvz4A=
X-Google-Smtp-Source: APXvYqzwvlj9Nh3IZiyXKGGo+4g5khGsW5QHWE0obZpxr65I+5fnFGwNGy/Mself1TcAtN33ncx+xg==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr4837548wmk.1.1578667576068;
        Fri, 10 Jan 2020 06:46:16 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id c5sm2594111wmb.9.2020.01.10.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:46:14 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:46:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] NVIDIA Tegra30 EMC driver improvements
Message-ID: <20200110144614.GH2233456@ulmo>
References: <20191220020849.11175-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNpeiK4tTqhYOExY"
Content-Disposition: inline
In-Reply-To: <20191220020849.11175-1-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNpeiK4tTqhYOExY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 05:08:46AM +0300, Dmitry Osipenko wrote:
> Hello,
>=20
> I took a refreshed look at the driver's code and spotted few things that
> could be improved. No critical fixes here, just improvements. Please
> review and apply, thanks in advance!
>=20
> Changelog:
>=20
> v2: - Now using WRITE/READ_ONCE() in the "Firm up hardware programming
>       sequence" patch for interrupt handler interactions, to firm driver
>       even further.
>=20
> Dmitry Osipenko (3):
>   memory: tegra30-emc: Firm up suspend/resume sequence
>   memory: tegra30-emc: Firm up hardware programming sequence
>   memory: tegra30-emc: Correct error message for timed out auto
>     calibration
>=20
>  drivers/memory/tegra/tegra30-emc.c | 179 +++++++++++++++++------------
>  1 file changed, 104 insertions(+), 75 deletions(-)

Applied to for-5.6/memory, thanks.

Thierry

--PNpeiK4tTqhYOExY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4YjjUACgkQ3SOs138+
s6HihQ/7BoT7ElvPG4frfgK9JBo3hJ8xRh9OUfByjYrQMhMpZhkKix8HxH2JF63g
mWZ/ph/Zn28GXaGRxIBnYrcjfus/8NY5fRpdpZrvbEYFSlBVutEnUgLhlSAKffdr
q8SOmaUPSrlrbpc8to4JAMnXYnWK4XFuBPaKQywIkL9wYfonctHuLgFCbbk4QB9h
Uq0+qjuIx6F2HACK1/qEhM/otH0wR7ExIXsP58w6ZDWp0LdC8/qZ2fawRrk3lGG7
4wofzHGjgeQXNg95DinEqLeYcnfJseo6h206QSsEcZoZAVs1bCYy2B54QWw48/7j
vHihF72VhMOm9oe42EvDtP651vZrycAB/PTp85F9NMftoxZ7G+0OWQnyoSPUu+uB
j7eiw8PBQrn/1f/nzcjmNpw23cpeTMeN07w0voqEohlNcTJftcfXAC6DOljkCex4
1VloC30lvPlqOpqFShzV44BeCPUXZAgszNaCB09G9eOvOqZb8YeBRU2jnRZJ8pqF
xe6Bav0/Zo15ZtaNS4UGR5XZ36NEb9jEQxMirbT755vz0vI0nKM94vPu6PQ9PpJ+
QAJv1C9rK/RiV9LO2/+k8HyGQS59mQVaxMO2ADxhZEtdNYwrdmkVGlqjK3o4z1Bk
asArwOQlUlxrLYRnw+4+bDugu3s/SlArUCGruXhRu7a6cNYhFKQ=
=QEPV
-----END PGP SIGNATURE-----

--PNpeiK4tTqhYOExY--
