Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28251C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FE620732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgFVO77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:59:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbgFVO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:59:56 -0400
Received: from desktop ([188.192.134.246]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5VTm-1ilzVH1REo-016zBv; Mon, 22 Jun 2020 16:59:33 +0200
From:   <mail@adrianschmutzler.de>
To:     "'David Woodhouse'" <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc:     "'kexec'" <kexec@lists.infradead.org>,
        "'openwrt-devel'" <openwrt-devel@lists.openwrt.org>,
        <linux-mtd@lists.infradead.org>,
        "'linux-arm-kernel'" <linux-arm-kernel@lists.infradead.org>,
        "'openconnect-devel'" <openconnect-devel@lists.infradead.org>
References: <5277ad6f4147325a921678367b4501d87217e95c.camel@infradead.org>
In-Reply-To: <5277ad6f4147325a921678367b4501d87217e95c.camel@infradead.org>
Subject: RE: lists.infradead.org restored from backup, git.infradead.org down.
Date:   Mon, 22 Jun 2020 16:59:32 +0200
Message-ID: <001e01d648a5$bd1ee2d0$375ca870$@adrianschmutzler.de>
X-Mailer: Microsoft Outlook 15.0
MIME-Version: 1.0
Thread-Index: AQG5hV8pLw0uSvkNbgUKrUeSyIoqiqkeQGlQ
Content-Language: de
Content-Type: multipart/signed;
        micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="=-=XMvxVdaVBbhA+p=-="
X-Provags-ID: V03:K1:WJk5W5PG4j7/5TJ/HBZSoGxsduLFv8ECFfIo31dmkCy9/2aWeOJ
 5f4fCbbnGBOffxKcwVAZTc7BPU7kp4PqdN7QxmzOvAp4RtTkkBzVV5G6RKugkyuwY0GTBkB
 xoSQcRBiY7IuV8lWi/9hTKNy4S6V0eIcoMqOkyCcb9K33gsupvVI3Gr9LyZJcgF9pshtz6D
 gmHmDZK0dXm+LVv6dai+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ToHgZf6XnjE=:k1cmNqwWpx0vUkjYHY6T/t
 evS0DyVoCNnAdtZFyXI6X24vw4tGnefcnyOmGlnhUzb+HrvpPhYPcwZws+nA9sxGm09YnL/I2
 0wrjzehpzjA8+ZMGJP3WxbjKFyEikX2ThHHB0GbfZgsdGFSAzJUJYYAWYRU9wKM0wFPQHz3Ol
 KGNMh8ps3YMRsu44p0PDdi6qBHIrbM1Kx5dybOxIVmsdic8ufkyQ16zOxV/34Ht5pPL14Ff/q
 PtEvdKO2QsXFqFlWO3lnGyNZl4FqML3yd5wgBHETqwC2z8ug/6NDFsdZgZSwPRLtwfHFlgvMm
 JrlsQLRHnMeFiKCpbQJ6IuhoAfCdwzM3tG4Pql7iqjJFRhUey9q4m0q8N6iN/ldhlaoyszgOa
 qHm+8aksg2/KVBoSxys9kMXmIV3s8IoV9SEWzvc7v+m3MxPTNeeUcODPv1PSwdyz0L+HMZZAc
 GASPbFlWFD4oicMw2Xuhxf1ByGjHCDLwsjYvtYTMelj6P8OxamM67hLh+ygCfJnwfyInLwTKi
 hkVBqYVK4HvSNDqW8fOz3u+WgT2nvVYAFkW3nW8wQ0p6p/GuN3Ehen76uowpyGmtFn6SYVetd
 lqTXBEnvH1cBQtXinCK9NecLNztTI74kxjmgNvbRlPpgKF3z8lfP4thhfyhWtSENfYryUtxUt
 L22Q0BeBWTl1/vjTA+x1AgyL2un3oo3Kz+3ckOjFA/9A+RABvJ8rfitbosonmSyjiYov8I0lO
 eIl9su221YRmjRpHbsKJq3cDZbmQYhwCHUYXQdY9uAlErePwLRiU6ZLXPu5477Zx1GmFAWpAf
 GWYrFkMxp92Nw7ZvWRF/CN9ygYECRXq+XnuwHDhjA/LgcbHShYPMyy6FxdEAyR5srsOMq5+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

--=-=XMvxVdaVBbhA+p=-=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Original Message-----
> From: openwrt-devel [mailto:openwrt-devel-bounces@lists.openwrt.org]
> On Behalf Of David Woodhouse
> Sent: Montag, 22. Juni 2020 14:52
> To: linux-kernel@vger.kernel.org
> Cc: kexec <kexec@lists.infradead.org>; openwrt-devel <openwrt-
> devel@lists.openwrt.org>; linux-mtd@lists.infradead.org; linux-arm-kernel
> <linux-arm-kernel@lists.infradead.org>; openconnect-devel <openconnect-
> devel@lists.infradead.org>
> Subject: lists.infradead.org restored from backup, git.infradead.org down.
>=20
> The machine hosting lists.infradead.org and git.infradead.org suffered a
> complete disk failure over the weekend; sadly the last backup of the
> mailman config was fairly old (May 2018) so the subscriber lists and arch=
ives
> have been reset to that date, but the lists should be running again.
>=20
> I've recreated the new lists which had been created since then.
>=20
> The lists should be up and running again on a new host; we can recreate
> archives if anyone can provide the mailboxes.

There is this page:
https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/

Don't know whether they provide a sufficient interface though or will respo=
nd and help if asked nicely ...

Best

Adrian

>=20
> Users will have to resubscribe (and in some cases, unsubscribe again).
> Apologies for the inconvenience.
>=20
> If you had personal email hosted on, or going through,
> bombadil.infradead.org then please let me know and we can move you to
> another box.
>=20
> The dead box was also git.infradead.org; I'll be fixing that next... if y=
ou had an
> account and want it reinstated then please let me know.

--=-=XMvxVdaVBbhA+p=-=
Content-Type: application/pgp-signature;
	name="openpgp-digital-signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESgN6p2H3WoMOAf81oNyKO7qxAnAFAl7wx0gACgkQoNyKO7qx
AnCxgg/+LUncYyqX/WHSsM8AxoC8qVdMxLvcW0jjo/Sf1suYv2qBJJaTMjrAHRkk
nGgf8pJ4WNyke1yCYJ4rk3MHJTqBNeXd589pzivShmpW7vLXiZo/0dITBRzk7lMk
Zic6H3yrNws13ssM+z1xX8LJLi9UKmDwLtEp3GxXFRtjmuldSKsrZJfY0Mnj1Aj/
as7OrOZckoLTM3FAzz1PbDYXDoRKJczliFpnj05MJeWbgsG5gZZehgJ9LozqArCn
tyZC+MElMM6JujPdAO4wzcMo43fDzs0QWNvNGkd2SDU23H5VSx+5KGEww5lSyAbf
Y5stkGfd51PDHvZWZfVvU9XT8ZhDq2+1Id3Ef72E+oEuXfCKywxKpb4EkQoXBbhQ
lOPtGPVmqdg6cHZpsV/N2z2kWelbLbElA0iMWbHqC804sHs5E+hutKyaD/ep2igC
I0D4VbhxSaagt5I7EqcB4HW3wTJ59yi133d7Ws8hFdCAn2Wkp1KuoxVs4Py3DFWJ
k/PPKj3b3YeGiyppp/6Nxnw5rmSV/TQu8s1SRh2l2G3rIBpifPCvlO/7nwh8ASGo
9c70bDTAHpR0cMzqcmu6obuTHvOWmp/qyJBUS2yEYeS32UOgceD7abICagTLHs0X
O92cZ/+o+T5iMQl6dUko6GgNwMp0iWjuijXB7Xfa9PJFHwYZsMc=
=dbBk
-----END PGP SIGNATURE-----


--=-=XMvxVdaVBbhA+p=-=--

