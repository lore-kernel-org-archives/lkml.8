Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E215C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47117222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1NFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:05:36 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:57002 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:05:36 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1B58B1C0314; Fri, 28 Feb 2020 14:05:34 +0100 (CET)
Date:   Fri, 28 Feb 2020 14:05:33 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miles Chen <miles.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 60/97] lib/stackdepot: Fix outdated comments
Message-ID: <20200228130532.GA2979@duo.ucw.cz>
References: <20200227132214.553656188@linuxfoundation.org>
 <20200227132224.337663006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200227132224.337663006@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit ee050dc83bc326ad5ef8ee93bca344819371e7a5 ]
>=20
> Replace "depot_save_stack" with "stack_depot_save" in code comments becau=
se
> depot_save_stack() was replaced in commit c0cfc337264c ("lib/stackdepot:
> Provide functions which operate on plain storage arrays") and removed in
> commit 56d8f079c51a ("lib/stackdepot: Remove obsolete functions")

This is wrong.

> +++ b/lib/stackdepot.c
> @@ -96,7 +96,7 @@ static bool init_stack_slab(void **prealloc)
>  		stack_slabs[depot_index + 1] =3D *prealloc;
>  		/*
>  		 * This smp_store_release pairs with smp_load_acquire() from
> -		 * |next_slab_inited| above and in depot_save_stack().
> +		 * |next_slab_inited| above and in stack_depot_save().
>  		 */
>  		smp_store_release(&next_slab_inited, 1);
>  	}

May have been outdated for mainline, but they are actually okay for
4.19.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlkQHAAKCRAw5/Bqldv6
8tAzAJ95qqYvuO9RBFo7nXmPUkGUMFI7JwCfSMtXBblNLSW62kuhjkvzKX/LWJ0=
=p+Oh
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
