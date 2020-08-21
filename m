Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF47EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40372078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHULeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:34:03 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:56481 "EHLO
        5.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHULdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:33:42 -0400
Received: from player735.ha.ovh.net (unknown [10.110.208.83])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 08A71176644
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 13:25:32 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player735.ha.ovh.net (Postfix) with ESMTPSA id 7B4F8152CABB2;
        Fri, 21 Aug 2020 11:25:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R005a6cdfe79-642f-4464-9630-78fb3fb6c30d,
                    20EB7F6BE0168D07063FB82D5C23839419BBC220) smtp.auth=steve@sk2.org
Date:   Fri, 21 Aug 2020 13:25:23 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Beniamin Bia <beniamin.bia@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/hwmon/adm1177.c: use simple i2c probe
Message-ID: <20200821132456.0c9a7b54@heffalump.sk2.org>
In-Reply-To: <20200814151358.GA256451@roeck-us.net>
References: <20200813160958.1506536-1-steve@sk2.org>
        <20200814151358.GA256451@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/T8vEHXh221/e0deqj8_/PKm"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 12622463856318827790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudduvddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevledvueefvdeivefftdeugeekveethefftdffteelheejkeejjeduffeiudetkeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T8vEHXh221/e0deqj8_/PKm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Aug 2020 08:13:58 -0700, Guenter Roeck <linux@roeck-us.net> wrot=
e:
> On Thu, Aug 13, 2020 at 06:09:58PM +0200, Stephen Kitt wrote:
> > This driver doesn't use the id information provided by the old i2c
> > probe function, so it can trivially be converted to the simple
> > ("probe_new") form.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> I'll apply the entire series, but please don't use entire path names
> as tag in the future but follow bubsystem rules.

Sorry about that, I=E2=80=99ll bear that in mind for the remaining hwmon pa=
tches (and
more generally).

Regards,

Stephen

--Sig_/T8vEHXh221/e0deqj8_/PKm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl8/ryMACgkQgNMC9Yht
g5yQ6w/+KE+YETNP307h4d2A3H1iZlOMtOGg0JP62siyM6zkrFjJV373y22q9kQd
7jF6rlPMPv/B0aFNuR/Abarlyc7kn/FDlPz6mpVomwnQVjpREIMYHgFYhrjq+u0Q
raY5+1PN0/VF9SS1qSqs5F37yUn7MGPqoQVnntH3bqo8+UGDP8A4slGJQU+wFHd/
7L9HwsiM5ufuVeRqLY0OssyC+0oPh+g5cdSACpZqzzyyOmMm1ojWk26fwWK9nQVQ
UO/CILGfHyBhc7Ng5iaH0ycKRbJKyEFVfgA1Vy4uN7MkiGnCtfuvkHXgGz/L9LV/
D7sJsxixhvs2oasO70RxCnKLMC7LVQ5bmxQ1mpuLEmnuvcgmzDpRO5eShG02yoLY
6L0TE+SjdmAWWUigcZcUhFztALccGhCjNcuM+BMniiaHgPacT4ocNooF/e/+v7aP
oyODufQppaSZXp7+n0wHejvV8RyumVW1kl9INDrURWUN7stPjAcNaeIXkpg+BP45
dXyqQgY906kYyyafEr5AF886tpMOPTjaPhSVIyg7wpLxW8hdJoKzDeEDT8H6lp4Y
5ENdR8cAw8yrb6rL6JXgFIJIMybzTiPsl6hzAvlE+wOIUOgWCCpfUFMzkEd3yBNg
jwzzbPYAbDjgapSHjXyjaoJrc3zxq4H2ivvcRFuJQZ1j5TCnkSI=
=9UWE
-----END PGP SIGNATURE-----

--Sig_/T8vEHXh221/e0deqj8_/PKm--
