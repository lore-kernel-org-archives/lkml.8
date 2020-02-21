Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7FCC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C581020679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgBUOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:39:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:53164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbgBUOjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:39:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2D5D6AD61;
        Fri, 21 Feb 2020 14:39:37 +0000 (UTC)
Subject: Re: [RESEND2][PATCH] drm/bridge: analogix-anx6345: Fix drm_dp_link
 helper removal
To:     Torsten Duwe <duwe@lst.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
References: <20200221140455.8713068BFE@verein.lst.de>
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
Message-ID: <b30435c7-95c5-e21e-ea05-cd3ada20d150@suse.de>
Date:   Fri, 21 Feb 2020 15:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221140455.8713068BFE@verein.lst.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iNL8dBvkdSfxzpFwLTSyJG72RlD3VPuZF"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iNL8dBvkdSfxzpFwLTSyJG72RlD3VPuZF
Content-Type: multipart/mixed; boundary="j0E8z9krGoeKb5OwbMm0uVkVcgF5buyIV";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Torsten Duwe <duwe@lst.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Thierry Reding <treding@nvidia.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Jonas Karlman
 <jonas@kwiboo.se>, David Airlie <airlied@linux.ie>,
 Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maxime Ripard <maxime@cerno.tech>
Message-ID: <b30435c7-95c5-e21e-ea05-cd3ada20d150@suse.de>
Subject: Re: [RESEND2][PATCH] drm/bridge: analogix-anx6345: Fix drm_dp_link
 helper removal
References: <20200221140455.8713068BFE@verein.lst.de>
In-Reply-To: <20200221140455.8713068BFE@verein.lst.de>

--j0E8z9krGoeKb5OwbMm0uVkVcgF5buyIV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Torsten

Am 21.02.20 um 15:04 schrieb Torsten Duwe:
> drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide b=
y
> and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd=
[0]
> and the multiply+divide alltogether.
>=20
> fixes: e1cff82c1097bda2478 ("fix anx6345 compilation for v5.5")

You have to create the fixes tag and related cc tags with 'dim fixes',
available at [1]. For this patch, the output is

Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
Cc: Torsten Duwe <duwe@suse.de>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Torsten Duwe <duwe@lst.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

> Signed-off-by: Torsten Duwe <duwe@suse.de>

You signed off with your SUSE email address, but sent the mail from
lst.de. I don't know if it's strictly not allowed, but that's at least
confusing to the tools.

Best regards
Thomas

[1] https://gitlab.freedesktop.org/drm/maintainer-tools/

> ---
> https://patchwork.freedesktop.org/patch/343004/
> https://lists.freedesktop.org/archives/dri-devel/2020-January/253535.ht=
ml
>=20
> Can someone please review this? It's equivalent to commit
> 3e138a63d6674a4567a018a31 which just made it into drm-tip.
>=20
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -210,10 +210,9 @@ static int anx6345_dp_link_training(struct anx6345=
 *anx6345)
>  	if (err)
>  		return err;
> =20
> -	dpcd[0] =3D drm_dp_max_link_rate(anx6345->dpcd);
> -	dpcd[0] =3D drm_dp_link_rate_to_bw_code(dpcd[0]);
>  	err =3D regmap_write(anx6345->map[I2C_IDX_DPTX],
> -			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
> +			   SP_DP_MAIN_LINK_BW_SET_REG,
> +			   anx6345->dpcd[DP_MAX_LINK_RATE]);
>  	if (err)
>  		return err;
> =20
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


--j0E8z9krGoeKb5OwbMm0uVkVcgF5buyIV--

--iNL8dBvkdSfxzpFwLTSyJG72RlD3VPuZF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAl5P66QACgkQaA3BHVML
eiMJJgf/Q4Q71uHAIhlTLKYMa70/rddH1fptpa8TRjfq5TXpLQLXwQieUEior3nu
xUA6pVai/8rbiHOOjsdGjgqGW5KBHxL6v5B+Rri4vULVmOnV1/KK7XxuLgTCaIra
n3ygHgI5fovbu9vcZUuxHLh267XOQqPO8/ad88PIcvvu9SI2dRgySwE+vxraLDK5
TxmEAwvDcchriSTCJMLKYXDqvZbhYMGjbWt1JceJ0h3w7xBHOuqtyvrZyToborWE
p1vdTyC+wHwy5Htil4dIGGHW9Jymmta/2ZaI7hudWMJ5sfQSbzN6vFiDiugE6Gle
WOJSsznZ8sMwPFb+hmqs4lPcPYxlyg==
=Qr+b
-----END PGP SIGNATURE-----

--iNL8dBvkdSfxzpFwLTSyJG72RlD3VPuZF--
