Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3036C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B820738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHSHRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:17:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgHSHRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:17:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81A48B5C4;
        Wed, 19 Aug 2020 07:18:03 +0000 (UTC)
Subject: Re: [PATCH] drm: ast: fix double __iomem sparse warning
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>
References: <a8185578-a69a-16b0-6fdf-f4e46bc4f61f@infradead.org>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <71030cba-99dd-5815-8fac-bfd5de6319f8@suse.de>
Date:   Wed, 19 Aug 2020 09:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a8185578-a69a-16b0-6fdf-f4e46bc4f61f@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kaUcTtSqfBc2VszyW3byftADwfZhXKfvs"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kaUcTtSqfBc2VszyW3byftADwfZhXKfvs
Content-Type: multipart/mixed; boundary="YEh9LdxfkK7sXNDV0JJ2rhIbvY9VHj2fy";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Randy Dunlap <rdunlap@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 Dave Airlie <airlied@redhat.com>
Message-ID: <71030cba-99dd-5815-8fac-bfd5de6319f8@suse.de>
Subject: Re: [PATCH] drm: ast: fix double __iomem sparse warning
References: <a8185578-a69a-16b0-6fdf-f4e46bc4f61f@infradead.org>
In-Reply-To: <a8185578-a69a-16b0-6fdf-f4e46bc4f61f@infradead.org>

--YEh9LdxfkK7sXNDV0JJ2rhIbvY9VHj2fy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.08.20 um 22:28 schrieb Randy Dunlap:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> sparse complains about having 2 "__iomem" attributes on the same line
> where only one is needed since the first one applies to everything
> up to the ending ';'.
> However, to make it clear(er) that both of these pointers are
> "__iomem", use separate lines for them.
>=20
> ../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: warning: duplicate [nod=
eref]
> ../drivers/gpu/drm/ast/ast_cursor.c:256:26: CK: error: multiple address=
 space given: __iomem & __iomem
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/ast/ast_cursor.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, added to drm-misc-next

Best regards
Thomas

>=20
> --- lnx-59-rc1.orig/drivers/gpu/drm/ast/ast_cursor.c
> +++ lnx-59-rc1/drivers/gpu/drm/ast/ast_cursor.c
> @@ -253,7 +253,8 @@ void ast_cursor_show(struct ast_private
>  		     unsigned int offset_x, unsigned int offset_y)
>  {
>  	u8 x_offset, y_offset;
> -	u8 __iomem *dst, __iomem *sig;
> +	u8 __iomem *dst;
> +	u8 __iomem *sig;
>  	u8 jreg;
> =20
>  	dst =3D ast->cursor.vaddr[ast->cursor.next_index];
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--YEh9LdxfkK7sXNDV0JJ2rhIbvY9VHj2fy--

--kaUcTtSqfBc2VszyW3byftADwfZhXKfvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFIBAEBCAAyFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl880g0UHHR6aW1tZXJt
YW5uQHN1c2UuZGUACgkQaA3BHVMLeiPxUQf/YdOLGIt6Sgea61/oWWBjlQ4oVDeV
0hyIFeYRzvBn1H1vPdQiBRXu+V8psESdy7QEAV5KSfMHzlRHyHtpy1e/w5y0/Rck
rvQQlPmmRAvypKQz2D1PijxF2AKrQ9Tpk3Zn4PTgAsO/vxX0exZTPq5+iYKYr38x
AiBoSY4ldW8I2W3cqaHWgmpJf5VmVF5o2CaU9C0kuO64/vWxoS4ljRcl3iDTLpQ/
F5mZBY81ETSVBEZbySNO1hkTWS99uD4yGoi7hZsQZKvkBYp8zTLJbBGqg+er/SBx
0Tq4kRdNLGk/xtgeWnQNGDzSWIg2bXE/diDZI4aitmmRKAsC5usThdF1Fg==
=5HZM
-----END PGP SIGNATURE-----

--kaUcTtSqfBc2VszyW3byftADwfZhXKfvs--
