Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED8C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AF0206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgEEMJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:09:59 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39056 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgEEMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:09:59 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3ABF11C022C; Tue,  5 May 2020 14:09:57 +0200 (CEST)
Date:   Tue, 5 May 2020 14:09:56 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4.19 11/37] PM: hibernate: Freeze kernel threads in
 software_resume()
Message-ID: <20200505120956.GA28722@amd>
References: <20200504165448.264746645@linuxfoundation.org>
 <20200504165449.741334238@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20200504165449.741334238@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 2351f8d295ed63393190e39c2f7c1fee1a80578f upstream.
>=20
> Currently the kernel threads are not frozen in software_resume(), so
> between dpm_suspend_start(PMSG_QUIESCE) and resume_target_kernel(),
> system_freezable_power_efficient_wq can still try to submit SCSI
> commands and this can cause a panic since the low level SCSI driver
> (e.g. hv_storvsc) has quiesced the SCSI adapter and can not accept
> any SCSI commands: https://lkml.org/lkml/2020/4/10/47
>=20
> At first I posted a fix (https://lkml.org/lkml/2020/4/21/1318) trying
> to resolve the issue from hv_storvsc, but with the help of
> Bart Van Assche, I realized it's better to fix software_resume(),
> since this looks like a generic issue, not only pertaining to SCSI.

I believe it is too soon to merge this into stable. It is rather big
hammer. Yes, it is right thing to do. But I'd wait for 5.7 to be
released before merging it to stable.

It needs some testing and it did not get any.

Best regards,
							Pavel

> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> ---
>  kernel/power/hibernate.c |    7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -901,6 +901,13 @@ static int software_resume(void)
>  	error =3D freeze_processes();
>  	if (error)
>  		goto Close_Finish;
> +
> +	error =3D freeze_kernel_threads();
> +	if (error) {
> +		thaw_processes();
> +		goto Close_Finish;
> +	}
> +
>  	error =3D load_image_and_restore();
>  	thaw_processes();
>   Finish:
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6xV5QACgkQMOfwapXb+vLdngCfWXiRv6+x3tG+LpFhumaMbyZq
ek4An1F4jv81BEgOsgETKkkyu5eN7pM9
=FCx7
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
