Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFFC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17F7208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="dxG7rdJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgBTRTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:19:36 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21859 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgBTRTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:19:36 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582219169; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TykvQRtLa6qKlvUpanYdzcziqL4aJysJiSaEO3f43+VQQVZNXKt+NaL/h3fNlqejjxzOTw/BEpn5L1JUEN9t/jGnUgoNHpnFscjpSYnuS9i5adRJ4nOaUZmyClIK0+CeYjktaZo91DiYT5H7AmTNmp9f4CMbjDhCvVICrrtC+ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1582219169; h=Content-Type:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=z3eev3rxdU7OtsSnvVilC23PC1pkssIitHEb4D8Hojw=; 
        b=SgH5iM3wn55HVdhB4YGYZ8omjvBHsnkqMu6rX5MYSzwIOjBsl79E+Kq9guq9nEctcAUQ5uTAi41GVX+QASLAYOZK+mQ0Z1ISYYTXxEy5l1GJI+kI3bKgg4sRCwhbo+iv+8zJASiXAjRHsDCBXf1khnNMcex/i/DedPnK0z2VbX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1582219169;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=Subject:From:To:References:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
        bh=z3eev3rxdU7OtsSnvVilC23PC1pkssIitHEb4D8Hojw=;
        b=dxG7rdJcYmWHT/KkvqLHVFgOiYsAEmpT8DnTrTFMy90rAiAlAvXp4vSjJgm96reZ
        avFTQquYqJgqlBFdhY7DVhnTUjFqD0JmXP7JNtGOkSy4PKyngryqanimVf7urB6Tyl6
        iWk+gygYCf2eAotV5SNJl/Tc6NGz1zfvi0zRSn4M=
Received: from [10.137.0.45] (82.102.18.6 [82.102.18.6]) by mx.zohomail.com
        with SMTPS id 1582219167645457.9527982400665; Thu, 20 Feb 2020 09:19:27 -0800 (PST)
Subject: Re: [PATCH] nv50_disp_chan_mthd: ensure mthd is not NULL
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <dac89843-5258-5bed-ee86-7038e94e56da@qubes-os.org>
Message-ID: <c94ce223-56d5-e31a-2a2c-59defb988b28@qubes-os.org>
Date:   Thu, 20 Feb 2020 18:19:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dac89843-5258-5bed-ee86-7038e94e56da@qubes-os.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w32BqMJ8HV23tU4jg2Bb4RtNFGXOHFoba"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w32BqMJ8HV23tU4jg2Bb4RtNFGXOHFoba
Content-Type: multipart/mixed; boundary="8CHATbdN7dX0VKeJHOzRWHdG37WhI5eiD"

--8CHATbdN7dX0VKeJHOzRWHdG37WhI5eiD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,
Is anything missing here? How can I get this merged?

Best regards,
Fr=C3=A9d=C3=A9ric Pierret

On 2020-02-08 20:43, Fr=C3=A9d=C3=A9ric Pierret wrote:
> Pointer to structure array is assumed not NULL by default. It has
> the consequence to raise a kernel panic when it's not the case.
>=20
> Basically, running at least a RTX2080TI on Xen makes a bad mmio error
> which causes having 'mthd' pointer to be NULL in 'channv50.c'. From the=

> code, it's assumed to be not NULL by accessing directly 'mthd->data[0]'=

> which is the reason of the kernel panic. Simply check if the pointer
> is not NULL before continuing.
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D206299
> Cc: stable@vger.kernel.org
> Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@q=
ubes-os.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/driv=
ers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> index bcf32d92ee5a..50e3539f33d2 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
> @@ -74,6 +74,8 @@ nv50_disp_chan_mthd(struct nv50_disp_chan *chan, int =
debug)
> =20
>  	if (debug > subdev->debug)
>  		return;
> +	if (!mthd)
> +		return;
> =20
>  	for (i =3D 0; (list =3D mthd->data[i].mthd) !=3D NULL; i++) {
>  		u32 base =3D chan->head * mthd->addr;
>=20


--8CHATbdN7dX0VKeJHOzRWHdG37WhI5eiD--

--w32BqMJ8HV23tU4jg2Bb4RtNFGXOHFoba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl5Ov5wACgkQSEAQtc3F
duLSHw/+P2mgoCNKTxx7otQopMCHby1vNGeAhUhLrEBEcyH+s8HUw0PKa+sMcibJ
VBNFWivU/COlSowQWklTL3E21wTZNf7Wjw4Bn6R/G7GHYbEdHo/8o7kwcPT8+2J6
eF+AttjMc2wYlqiGea0PULs3plbDpJBtJXVzQG//5TVZXiVNF1RF+sCH0jyqfLfn
axvuE8I8kJO/yN6gstsumDzBdXA6TtgzVyJDs2KHm3P5z7OdECk9/UJDtp70Gsr7
bfBcAneBZNCPAekqB1VOl5399OYEINbRlyycb1CKtfkqW0Ydk24dsA2ymw9lairn
yi/3gOAI+cmSsuWK9xFBRgjtXmrduBhD68UtLGno5JA4qoKhYryGHyIhf5EGbQvA
aBTVrdvRQwlu9sipUvUYWeVHZ/nn7D3n3RVUXZ/lf8svoVfl4AeMqhI3+poDrG2C
cNHRiW8pwh/g6qoYbZjvCkI/A4gftqGQGZwJf+IvOGZz7+cO16d9KUA9nYQY7wRq
f7hVRbA5TgM62VI05uWLmdUGnbmNJh8T698dm2q/ghf2TIt6pbxPfCjEUtw8a0jH
Pp0u0kvclJ5pFAdOXHSqxs9tdZEbmMrdj1APXn6GhYY0cjaf59o08bJ9+AQtxFgB
OfX8vtDOrtQR7ROHp/rKpRy1qX1wB6ZIQnAIan93/vD26Dxl9lY=
=V2u5
-----END PGP SIGNATURE-----

--w32BqMJ8HV23tU4jg2Bb4RtNFGXOHFoba--
