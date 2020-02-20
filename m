Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11299C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFDF2467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="C036gvuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgBTSJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:09:29 -0500
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21807 "EHLO
        sender4-of-o58.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgBTSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:09:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582222159; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=IhZrbv3LTYkKC0B91LP6afzc/JR2dokKMlVIyk4/2XJyTI1aR2Un4DuyHL+PRgH0FxChRBC0Vw6yfZ2nPmUXclYAqpXTa7Tbc49ahLPSvX9+9BGgaiWOF6LIWOcMRWtoGjyeBgdpoH06sLPCTeJj1yZFSkDeGC6/DJ4VI+vpfeM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1582222159; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xw/sotA4oNFNJ04Z9OYEFDPVK+QMI4XGv7s7J3CTotQ=; 
        b=hc3uTlOBpX+CUrKjMVfTRdd681Z3GHnvGmQSoPPvs9WBBjEu09BbXXWGtuqlEUdaVVzYzEOCikGPcrvJrvGI0qIP09QAV+djYTdqd17mqiWerpiU8DlJh+rirzcIiOQ6P9EgQ6NvSEdxCdhp5bOW5eTPUXi1nM+KZf1e2dNUW+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1582222159;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
        bh=xw/sotA4oNFNJ04Z9OYEFDPVK+QMI4XGv7s7J3CTotQ=;
        b=C036gvuCI6PgqiMq2RqXs7sWe3NdWmzr2TqcGGnLCNMtpfROXd1zm1JDQI8Gri6A
        3xqNM5+Ytq+j5RNn1qSSPuzQNQbqb8m+iOUQNj2b+SaEn0xUoOiHleHeQZd2/hFR+J0
        Bg+bxomaJvwW25C6i0lR0Tx10qGb/TDmuuGHp4ks=
Received: from [10.137.0.45] (82.102.18.6 [82.102.18.6]) by mx.zohomail.com
        with SMTPS id 1582222157595579.3135438206202; Thu, 20 Feb 2020 10:09:17 -0800 (PST)
Subject: Re: [Nouveau] [PATCH] nv50_disp_chan_mthd: ensure mthd is not NULL
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <dac89843-5258-5bed-ee86-7038e94e56da@qubes-os.org>
 <c94ce223-56d5-e31a-2a2c-59defb988b28@qubes-os.org>
 <CAKb7Uvh8Ob592LOizH9FGZz5ag=VJ3R=dh0G5iZSg2-JzWZFMQ@mail.gmail.com>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <ea846dcd-0fc9-01a6-4bb4-dde68888d06e@qubes-os.org>
Date:   Thu, 20 Feb 2020 19:09:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKb7Uvh8Ob592LOizH9FGZz5ag=VJ3R=dh0G5iZSg2-JzWZFMQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hkI44MPNhtb0IuTBA6t4rXJyj69YDa5QI"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hkI44MPNhtb0IuTBA6t4rXJyj69YDa5QI
Content-Type: multipart/mixed; boundary="WLJy850lTfsTLeed3UAVaXbc1Hmlnodt8"

--WLJy850lTfsTLeed3UAVaXbc1Hmlnodt8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Ilia,
Well...if Ben made it's own version you mean using my patch given on comm=
ent https://bugzilla.kernel.org/show_bug.cgi?id=3D206299#c9 and then addi=
ng commit message without quoting me as reporter ok...

At least, upstream is patched.

Best,
Fr=C3=A9d=C3=A9ric

On 2020-02-20 18:32, Ilia Mirkin wrote:
> Hi Fr=C3=A9d=C3=A9ric,
>=20
> It appears Ben made his own version of this patch (probably based on
> the one you added to the kernel bz), and it's already upstream:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv5.6-rc2&id=3D0e6176c6d286316e9431b4f695940cfac4ffe6c2
>=20
> Cheers,
>=20
>   -ilia
>=20
> On Thu, Feb 20, 2020 at 12:19 PM Fr=C3=A9d=C3=A9ric Pierret
> <frederic.pierret@qubes-os.org> wrote:
>>
>> Hi,
>> Is anything missing here? How can I get this merged?
>>
>> Best regards,
>> Fr=C3=A9d=C3=A9ric Pierret
>>
>> On 2020-02-08 20:43, Fr=C3=A9d=C3=A9ric Pierret wrote:
>>> Pointer to structure array is assumed not NULL by default. It has
>>> the consequence to raise a kernel panic when it's not the case.
>>>
>>> Basically, running at least a RTX2080TI on Xen makes a bad mmio error=

>>> which causes having 'mthd' pointer to be NULL in 'channv50.c'. From t=
he
>>> code, it's assumed to be not NULL by accessing directly 'mthd->data[0=
]'
>>> which is the reason of the kernel panic. Simply check if the pointer
>>> is not NULL before continuing.
>>>
>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D206299
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret=
@qubes-os.org>
>>> ---
>>>  drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/dr=
ivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
>>> index bcf32d92ee5a..50e3539f33d2 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
>>> @@ -74,6 +74,8 @@ nv50_disp_chan_mthd(struct nv50_disp_chan *chan, in=
t debug)
>>>
>>>       if (debug > subdev->debug)
>>>               return;
>>> +     if (!mthd)
>>> +             return;
>>>
>>>       for (i =3D 0; (list =3D mthd->data[i].mthd) !=3D NULL; i++) {
>>>               u32 base =3D chan->head * mthd->addr;
>>>
>>
>> _______________________________________________
>> Nouveau mailing list
>> Nouveau@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/nouveau


--WLJy850lTfsTLeed3UAVaXbc1Hmlnodt8--

--hkI44MPNhtb0IuTBA6t4rXJyj69YDa5QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl5Oy0gACgkQSEAQtc3F
duLVXQ//UcaE2INvYMM1EVdYZv3qU9YSA1kGBFofdUewle8ME//5XfA1y9+Regdz
m/iunXPFn06NOCv13zYYTtmvs0PbHEdjWyi0GmfU5Qvmmr7Z+jsFetBDTi3y8IZu
CffSroIMUGSEP0l06JA0Bg4gWJv/fGCIOXcn5rAdL1L0kbE1jAP3Y6nxhQExTgYq
OvvSa2sxOBZ82fkuTTzN/qRKIMY+UGsHzMx+wUbGkRI4ncyxO0M6ZFqBAt4nTFA2
k+FWQc9e8+mUXxQJSQ/8d8z+o2c16ss30CektB8KHQNQX3UqvrzXaOo1+VS3LduG
3HI8kU4KnHT/K3Dy0Bf5AhyAHInS1URBETVEyANzQOMYQ3IOX6ORjdUP6pXeBiht
lGf6OgakKWAos6gAcYYcYbpRFBFZEJEhfYcjvboPmL0WjhuKnmPjwS0UZVdA9iKr
PD8BVzRZW+twgblxMvr1KNfIAyWCYckP53tpsqPq9+WbOEBBg5ub3o/S1UqLp2cH
9h2jTzZoYjY6u+Kuaxw69aL4uZGwToKDD6sD6MW+dND5QE+N4E0zuDUCiUzDmmPm
Aw7DFYVdHJIKDgbWPtdKAePZd3WVZ5OxBGgZAzslY7O26CUyvkUS8GnRqoB3UTdd
aVghJwC5dw0lEXpast9xk0nPyd1TQIoFHFVXnxbxTV38LQ3xrrQ=
=RGFd
-----END PGP SIGNATURE-----

--hkI44MPNhtb0IuTBA6t4rXJyj69YDa5QI--
