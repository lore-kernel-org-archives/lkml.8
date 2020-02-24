Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD83C38BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD3F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXT6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:58:45 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:48022 "EHLO
        9.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBXT6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:58:44 -0500
Received: from player698.ha.ovh.net (unknown [10.110.115.188])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1030415AA38
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 20:58:42 +0100 (CET)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player698.ha.ovh.net (Postfix) with ESMTPSA id 3A332FB0C78D;
        Mon, 24 Feb 2020 19:58:34 +0000 (UTC)
Date:   Mon, 24 Feb 2020 20:58:33 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document acpi_video_flags
Message-ID: <20200224205833.3016789f@heffalump.sk2.org>
In-Reply-To: <20200221165502.31770-1-steve@sk2.org>
References: <20200221165502.31770-1-steve@sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/m24mW9PsjW.9ELm8gJu.TnZ"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3094254422545550725
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m24mW9PsjW.9ELm8gJu.TnZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 17:55:02 +0100, Stephen Kitt <steve@sk2.org> wrote:
> Based on the implementation in arch/x86/kernel/acpi/sleep.c, in
> particular the acpi_sleep_setup() function.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst
> b/Documentation/admin-guide/sysctl/kernel.rst index
> 534781ba3eac..1c48ab4bfe30 100644 ---
> a/Documentation/admin-guide/sysctl/kernel.rst +++
> b/Documentation/admin-guide/sysctl/kernel.rst @@ -54,8 +54,15 @@ free spa=
ce
> valid for 30 seconds. acpi_video_flags
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -See Documentation/kernel/power/video.txt, it allows mode of video boot
> -to be set during run time.
> +See :doc:`/power/video`. This allows the video resume mode to be set,
> +in a similar fashion to the ``acpi_sleep`` kernel parameter, by
> +combining the following values:
> +
> +=3D =3D=3D=3D=3D=3D=3D=3D
> +1 s3_bios
> +2 s3_mode
> +4 s3_beep
> +=3D =3D=3D=3D=3D=3D=3D=3D
> =20
> =20
>  auto_msgmni
> --=20
> 2.20.1
>=20

I forgot to include the base commit information; this is against 8f21f54b8a=
95
in docs-next.

Regards,

Stephen

--Sig_/m24mW9PsjW.9ELm8gJu.TnZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl5UKukACgkQgNMC9Yht
g5ykHw//dc4KmvEg8tU/J/gP9UfZFugohw/U4tRXGpht45fnHCnDg+ldFiMAewKA
29VYEKg5M/KlEKz0yVTvTh+/XTa41TN/Iz3GQpBLPCZaJs/ZfTncX1rpmzjQVLev
nOIuM8wHkGiQ7SPkn2OE4tZAr+4p15204+0GlQESvyiRBFH4Z4CSyAPWwlQxGol4
dG4j5yRq3FWp9dTGn3BjtykOJmnyy506d32CQLB4lCjOGK57DV8fdK6kCwDXzi+4
/0nO4Sx8xQQ8sWAh/VUOoSlaNUfMLExHXQY26lXGJ4ozxohegZQkhxM+mAz7V3AQ
oWIOMRNnBZA+sSp7d+lCmnVxNt2NkC/7A9foqTzKLe2CjXMhfvJ6o3KLvBuS5H1r
IixsZ8f6GjJuIG7PHqTyB/A2d6OwUGw20pEuFFCrUVwF2Gdiz+FIpMFCfJ4mAbTS
qhO7PZG42HC7rrajkysI44/+HOEve7XT55euYDIZOorsj7P6Anh+yUwgWPgiU+zF
gath9A8FCEq6VqvvjVNot9KAM/rhzGkfTEd2ZAJVntl3bAA/use291hpTCvqapVH
NvJsHFeLku1rWfHWN0a233Qx0ENho8FZdbyj8uENwBmyBxTzR2J8ngbVr89qYjV5
8RfTZUe+GckQOHrikkI2EbojMrCRf4iyA6dfJv93GzZG0YOq5s8=
=m/8w
-----END PGP SIGNATURE-----

--Sig_/m24mW9PsjW.9ELm8gJu.TnZ--
