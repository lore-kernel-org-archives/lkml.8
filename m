Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91EC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1D20732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBXM1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:27:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54844 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgBXM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:27:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 00068293775
Date:   Mon, 24 Feb 2020 07:27:05 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] drm/panfrost: Don't try to map on error faults
Message-ID: <20200224122705.GA3363@kevin>
References: <20200212202236.13095-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200212202236.13095-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Acked-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

On Wed, Feb 12, 2020 at 02:22:36PM -0600, Rob Herring wrote:
> From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>=20
> If the exception type isn't a translation fault, don't try to map and
> instead go straight to a terminal fault.
>=20
> Otherwise, we can get flooded by kernel warnings and further faults.
>=20
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I rewrote this some simplifying the code and somewhat following Steven's=
=20
> suggested. Still not using defines though. No defines here was good=20
> enough before IMO.
>=20
> Only compile tested.
>=20
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 44 +++++++++++--------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/pa=
nfrost/panfrost_mmu.c
> index 763cfca886a7..4f2836bd9215 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -596,33 +596,27 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(=
int irq, void *data)
>  		source_id =3D (fault_status >> 16);
> =20
>  		/* Page fault only */
> -		if ((status & mask) =3D=3D BIT(i)) {
> -			WARN_ON(exception_type < 0xC1 || exception_type > 0xC4);
> -
> +		ret =3D -1;
> +		if ((status & mask) =3D=3D BIT(i) && (exception_type & 0xF8) =3D=3D 0x=
C0)
>  			ret =3D panfrost_mmu_map_fault_addr(pfdev, i, addr);
> -			if (!ret) {
> -				mmu_write(pfdev, MMU_INT_CLEAR, BIT(i));
> -				status &=3D ~mask;
> -				continue;
> -			}
> -		}
> =20
> -		/* terminal fault, print info about the fault */
> -		dev_err(pfdev->dev,
> -			"Unhandled Page fault in AS%d at VA 0x%016llX\n"
> -			"Reason: %s\n"
> -			"raw fault status: 0x%X\n"
> -			"decoded fault status: %s\n"
> -			"exception type 0x%X: %s\n"
> -			"access type 0x%X: %s\n"
> -			"source id 0x%X\n",
> -			i, addr,
> -			"TODO",
> -			fault_status,
> -			(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> -			exception_type, panfrost_exception_name(pfdev, exception_type),
> -			access_type, access_type_name(pfdev, fault_status),
> -			source_id);
> +		if (ret)
> +			/* terminal fault, print info about the fault */
> +			dev_err(pfdev->dev,
> +				"Unhandled Page fault in AS%d at VA 0x%016llX\n"
> +				"Reason: %s\n"
> +				"raw fault status: 0x%X\n"
> +				"decoded fault status: %s\n"
> +				"exception type 0x%X: %s\n"
> +				"access type 0x%X: %s\n"
> +				"source id 0x%X\n",
> +				i, addr,
> +				"TODO",
> +				fault_status,
> +				(fault_status & (1 << 10) ? "DECODER FAULT" : "SLAVE FAULT"),
> +				exception_type, panfrost_exception_name(pfdev, exception_type),
> +				access_type, access_type_name(pfdev, fault_status),
> +				source_id);
> =20
>  		mmu_write(pfdev, MMU_INT_CLEAR, mask);
> =20
> --=20
> 2.20.1
>=20

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl5TwRQACgkQ/v5QWgr1
WA1Hog//TrLApFg1MbWFYQX8Y/weTKYo4RLc+VHaQ///TZ4caRYQ9fJ1JCjuW7Jh
ud8LA79XswB+sdgvVxhMsWWfQcQGT5jfeSl2QXQNRXtIyXyf3R8rPBht3OQ/FyCo
fhrwdfQDEBDZA2/rsvAmZ/UUZVGA4Dp2ph6F/6gORK6Y5fCi81INGj3SGMZQCt/A
HO9OksOe+uV03bXo5KFnULw7Q25oPp80sMCZUFxOq0eHMZObTzMZqA13HxEYnrnb
uCfV58MAB8fIqd2M5M0fIpgmCNfOGm/2Gkg+Kof9RLOLjPUeQqRj5ss8QunDWw1L
EATJFXeaWQiLaoPBJx/Q4i3uuVKQ0c/QkbqLN4otFHLTaLrdsAqhkVeASFUSOdJL
CpmEISk5pCX27hHCwcWyj22SGuzE8zDhFvQNMYquKgVqhLEZdH1CHQf1jQazyxsz
xLr/4e74IjkwpBB6gWZduLRHAqEhsooDLGoz94W5LDvOpOR0FT5pTgxgiU2MhFf7
aPu/nZQ7Fb/L0oqAGyyholv8KpLoTNI80LEqXdm1ntSceCQyvfTr8nMDJvC0uMiC
xYlu9yMDwY6vvQXt4bVuFr3WoToFlvlmgD3piTKXUYShUdDN9gs7UDdCvhiB0aXo
leDlW9VjcKbl76HNXbAOw7amcQqeTkcOSLw4kt859VeQnwVhtJE=
=GEiC
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
