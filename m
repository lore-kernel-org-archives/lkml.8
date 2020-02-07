Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668EDC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406CB21775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGMGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:06:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:50698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgBGMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:06:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA01FB19A;
        Fri,  7 Feb 2020 12:06:04 +0000 (UTC)
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
References: <20200207115744.4559-1-kraxel@redhat.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
Date:   Fri, 7 Feb 2020 13:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207115744.4559-1-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="foLTu5q3eMQh5VHpADh7fpioUUpykH1jb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb
Content-Type: multipart/mixed; boundary="s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: marmarek@invisiblethingslab.com, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>
Message-ID: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
References: <20200207115744.4559-1-kraxel@redhat.com>
In-Reply-To: <20200207115744.4559-1-kraxel@redhat.com>

--s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 07.02.20 um 12:57 schrieb Gerd Hoffmann:
> Shutdown of firmware framebuffer has a bunch of problems.  Because
> of this the framebuffer region might still be reserved even after
> drm_fb_helper_remove_conflicting_pci_framebuffers() returned.

Out of curiosity: what's going wrong here?

Best regards
Thomas

>=20
> Don't consider pci_request_region() failure for the framebuffer
> region as fatal error to workaround this issue.
>=20
> Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_hw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/b=
ochs_hw.c
> index b615b7dfdd9d..a387efa9e559 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -157,8 +157,7 @@ int bochs_hw_init(struct drm_device *dev)
>  	}
> =20
>  	if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0) {
> -		DRM_ERROR("Cannot request framebuffer\n");
> -		return -EBUSY;
> +		DRM_WARN("Cannot request framebuffer, boot framebuffer still active?=
\n");
>  	}
> =20
>  	bochs->fb_map =3D ioremap(addr, size);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--s3z0rAySyYq5LD1IVBxm1VB0rgaYv9rkq--

--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl49UqkACgkQaA3BHVML
eiO04wf/dIsiLt9szHzZl+XV/01hNiujAAhN5F6zS8nASQnLENXF588S6Bk0ROvY
Bmv+EN6CL5mi3SjNl2qSAw2F5SmeRmbQptJjuBmSLbep0N5HUhk4lR0qyGDg7cT9
F9l7FJcZI1SCQXWICWqRNL/ziokpLbgAO+DDtYIlC0CcahdqE9yHt4kJZDmy5A08
q7qaPaC2z8BbOhRR1bNw++BY3vmZQrq0AevYBwuNMvfR1p/cY8jZzuAqvw9EyRZ0
JrpG9lbTPCMy79iEinfQTYe5mBz0nOJLeKyGfzi+TbRHDBJt1oih21ybv59S/lAP
I/vTF+HchjvBzuLvhk0aTDM28C+LLw==
=fkeZ
-----END PGP SIGNATURE-----

--foLTu5q3eMQh5VHpADh7fpioUUpykH1jb--
