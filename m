Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FA3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617432078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hfK0M7gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgFMWtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:49:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:55633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFMWtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592088505;
        bh=ZQoSmYn5DR4f1XEtFIcs/HRDaC0pyj6G16R31BFM678=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hfK0M7gdeuiMA5rh9qdqXHKZWA2eJYeYSQ902fhWmPtTKR06kQNloa32KAnsT9/eF
         fXV67CyXDaFHj9apv5G9aj+qN8XZYSRlsLVgotW+BU/BN+kaJ/PaNBiOPxRCp6zfly
         1XVPP/B+bYhC5IJ2tsGR9C7Ke0NmwJU2PIGY8FxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.151.203]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1jJX0z3g7V-00QjnM; Sun, 14
 Jun 2020 00:48:24 +0200
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
To:     Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200425054659.814774-1-masahiroy@kernel.org>
 <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com>
 <11e05a6d-e4bd-e381-7015-2d52e8fdef39@gmx.de>
 <2867805.ELcs8R50RY@daneel.sf-tec.de>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <73a996ae-92b3-32fa-e796-23b049266631@gmx.de>
Date:   Sun, 14 Jun 2020 00:48:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2867805.ELcs8R50RY@daneel.sf-tec.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="11JXvv6rkxWNxO4WV6HQ3YFb37GdS0QD5"
X-Provags-ID: V03:K1:23q5nT0BkvdlSEGaWXcBY1d2CHCmIoL2XVZmLhkLaf2F8QdnAwe
 hHysZupNM7EZ6mjSbz5r3irxCqqDnLTeQ5DB8/f80FQ++uK8ofiDyLiaSBy4/7SnaNYcyiN
 nOTgKWYPnO8AmwT37BBxlb6Ki5xsI5rMRPXEkZsZ4cMc4IuLTW/4bzrDjWZZCGFfWs0cXcy
 feHKJA7LD89DpPpyid0hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2qcEw6tCsUg=:/CfT5PC3EMtSv5L1kicFjn
 Oi1vKGF9iwNRuF9jz5ndsuqXzAl2kDYvs2N0mF0NRX0gFlRxb8OUUDsrlnsZy2YXsDBtEyonP
 MxP1Dsoh4HP36UoBcQLHmX0W9RUPyt34xX3B9DxC6mRNLRzXwJW9yX8rl3zA+FO0CYclZTnvc
 aaZx+duUdAeeKG9ThKhpqva6Qwn8glz/mpvYg2+GBZuBOwOnJ8nDaY7Y+huWkKkBVC4VcCAh4
 qulZSGtcCiensakOHN4eBRh4ea+Bi380pyDF+4h28gOaiOy3ZfZ6PUtz8KGCp1fZTTVFCWGn1
 5q+UCVPGnw4iXhEndOKaqfM+RFD+lz3RwrxJJMckAU/7+DyIDs83Vmx/UfopPp6g11R+juRVS
 UxEMV4C0cNRaI/cBKuQ3HFPmWc7sfKi2YOtyo9RLdg8MHUqEzf9eON+FHSF7r5d9sOLET8tUs
 8gYsr5ApuyjmsmbrMh9x188AnMvuSE+5rVG3YYxF94mDZgwMdArPfkhyFOnl4y2SMoiwNhf1c
 4uFPUcaSvSdVCSUTr9UfJ9iq3Yb2zN33DH7iEpzuSfIgMUv7dF4UE0NDyQDrXnRLP1nWim5lR
 v+HGKezUDSO1GxVWwZakwaCw1Gx8msMQxvr2sNoUVi4dfEdpyfRD1vkpPrNe+m2R2h1ucrnrR
 zNQ3Qt+WCvN1uLvZEv4IDcSyPfjPf8eUeLJjyasdpn8ogiqvrpHZ/sYz+mwa4s8gKcDYdEfib
 U7uDs7CZvXTDe593xst9pN5Wk/CBbmjlm3cYygg1lgFqtP3NW2QEh1A4VryqoWmw3s2aqWy6W
 d5NliFedGarK9sWfkjnaJtpV9paTzwt9EsKdwnhOq+H6cXcOitdklA0EZ6ahIsWipWxBcVp10
 bJFhSCQeAcKLRM/cTMnOhPVLOWHcu0/uPYvLV2BGE0K7KChK01mqEKKtUU6OYYiFqxBe+bPtc
 +dFXZXWliVvX1dgvKl8YGl3mf+pNww5Cskugoks0pUsunpFhYW6uFyaF/GvrbIhbvBtG8e05e
 vin+ez59rPoXaA89oXlyP5FtMBrnDnpuKRJ77F+YEAwWroE064fi3beOFCkvFsOvt/iHWmeCN
 11SZGnc4HPueRbm+hT+2ec1VzlH8MvmhjolpjyVtCGLqNGklIZ+qctSAQ1fh8JwNwkadAWRLK
 ckZarF7/bzZQIs1O88iI2iJoW6SJDwd34M2TsrigKlwrw4vtOiYyzIlaueTWd9G4xwf08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--11JXvv6rkxWNxO4WV6HQ3YFb37GdS0QD5
Content-Type: multipart/mixed; boundary="CBJDS3axAHGQm4wgtPcq3oqNTCodU6XTb"

--CBJDS3axAHGQm4wgtPcq3oqNTCodU6XTb
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.20 21:36, Rolf Eike Beer wrote:
> Helge Deller wrote:
>> On 10.05.20 03:19, Masahiro Yamada wrote:
>>> Hi Helge,
>>>
>>> On Sun, May 10, 2020 at 2:39 AM Helge Deller <deller@gmx.de> wrote:
>=20
>>> I will drop this patch from my kbuild tree,
>>> then you will apply what you think is best
>>> to your tree.
>>>
>>> What do you think?
>>
>> Sure, I'll take it through the parisc tree.
>=20
> Is this already in 5.7.2?=20

No, because it went into 5.8 kernel and not backwards into 5.7.x:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D0d341e0ddb1a3444716420ad9151949c02adbe4e

Helge

> I get these:
>=20
> pioneer /usr/src/linux-5.7.1-gentoo #  make distclean
> gcc: error: missing argument to '-Wframe-larger-than=3D'
> gcc: error: missing argument to '-Wframe-larger-than=3D'
>   CLEAN   arch/parisc/kernel
> gcc: error: missing argument to '-Wframe-larger-than=3D'
> gcc: error: missing argument to '-Wframe-larger-than=3D'


--CBJDS3axAHGQm4wgtPcq3oqNTCodU6XTb--

--11JXvv6rkxWNxO4WV6HQ3YFb37GdS0QD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS86RI+GtKfB8BJu973ErUQojoPXwUCXuVXtgAKCRD3ErUQojoP
XwmoAP9iWsPIrz2JQZbJpWsF5ASKBKTtD+a8Ne1TF16e33xUqwEAykdgqIpn6/Oj
RcKqZkj4xt8A3K3mo4qqpVrWxnTDbQA=
=Crz2
-----END PGP SIGNATURE-----

--11JXvv6rkxWNxO4WV6HQ3YFb37GdS0QD5--
