Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABFC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9552067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgBQI0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:26:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:52550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgBQI0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:26:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 72D1AAC92;
        Mon, 17 Feb 2020 08:26:48 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] Dual licence some files in GPL-2.0 and MIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, noralf@tronnes.org, sam@ravnborg.org,
        chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200215180911.18299-1-manu@FreeBSD.org>
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
Message-ID: <48540535-6a17-72a7-d00f-954dbc8d5468@suse.de>
Date:   Mon, 17 Feb 2020 09:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215180911.18299-1-manu@FreeBSD.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AGLP8GzyM8YJrGNqifHoieaqtrt81ZEGD"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AGLP8GzyM8YJrGNqifHoieaqtrt81ZEGD
Content-Type: multipart/mixed; boundary="999aCkxFeB5Pzqt1gH7s7mGGbVchJfzyp";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Emmanuel Vadot <manu@FreeBSD.org>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
 jani.nikula@intel.com, efremov@linux.com, noralf@tronnes.org,
 sam@ravnborg.org, chris@chris-wilson.co.uk, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <48540535-6a17-72a7-d00f-954dbc8d5468@suse.de>
Subject: Re: [PATCH v2 0/2] Dual licence some files in GPL-2.0 and MIT
References: <20200215180911.18299-1-manu@FreeBSD.org>
In-Reply-To: <20200215180911.18299-1-manu@FreeBSD.org>

--999aCkxFeB5Pzqt1gH7s7mGGbVchJfzyp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 15.02.20 um 19:09 schrieb Emmanuel Vadot:
> Hello all,
>=20
> We had a discussion a while back with Noralf where he said that he woul=
dn't
> mind dual licence his work under GPL-2 and MIT.
> Those files are a problem with BSDs as we cannot include them.
> For drm_client.c the main contributors are Noralf Tr=C3=B8nnes and Thom=
as
> Zimmermann, the other commits are just catch ups from changes elsewhere=

> (return values, struct member names, function renames etc ...).
> For drm_format_helper the main contributors are Noralf Tr=C3=B8nnes and=

> Gerd Hoffmann. Same comment as for drm_client.c for the other commits.
>=20
> Emmanuel Vadot (2):
>   drm/client: Dual licence the file in GPL-2 and MIT
>   drm/format_helper: Dual licence the file in GPL 2 and MIT
>=20
>  drivers/gpu/drm/drm_client.c        | 2 +-
>  drivers/gpu/drm/drm_format_helper.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20

For the patches I contributed:

  Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--999aCkxFeB5Pzqt1gH7s7mGGbVchJfzyp--

--AGLP8GzyM8YJrGNqifHoieaqtrt81ZEGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5KTkYACgkQaA3BHVML
eiOHvQf/UIyF+K7nNPftG1l0eDfeIEwHnu2VsRRcSYIc0TYk/OBjIX6prRpftQk0
y9XVnznnI67ZUpWLuRKoVm7miPyJ73Ss8ELLMZUxF4B4kc+avteThWCqtY4CrpCk
k4ipU1YX4vzq3nlAF3/wA7W5iCB+m0/5Q6jHaVXbqP2QUDOnCJr7bOS9GLq+UOz1
YYa+M6F51YCU+jzOZM0j5w8wv3uf+U+HZk+XuyqxBdhWSdiMCJ2Z4Cot2j+B0Drh
tvBHk1WaxP+GMYEKuupHO0qeiVpPo/3WhSjZXe1oBBYMzRyL3kUDy/wfVxUyTR7l
Onu7KmkG3cKfxVdrjXyWGmz8r0L3XA==
=ShEd
-----END PGP SIGNATURE-----

--AGLP8GzyM8YJrGNqifHoieaqtrt81ZEGD--
