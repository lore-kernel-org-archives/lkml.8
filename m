Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20FEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A6F20726
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBNWQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:16:31 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45730 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbgBNWQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:16:29 -0500
Received: from mr4.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01EMGRSE029155
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 17:16:27 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01EMGMJo017474
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 17:16:27 -0500
Received: by mail-qt1-f199.google.com with SMTP id c8so6831644qte.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=eJQfIN4vckK3hUkjct5X1Ay1QWrTD3wdbdr+ZOUlltA=;
        b=n0qRgS9TJpiVZeDAg2yNasDa/5QPqIJ1d1iImPU2U8+dLM85ojDEqinsq51njkeh/Z
         7KtXHIGQF6HD3VLX1ZzmPKZhxSDwBpX/VPr6TLK8vKuVOdQk/9x6iTneGsnRjXbQmSWH
         5VzIEoLj0xRqW7CQJWv1WebHra3/JeMlZudwB5n9NB9MZ5cqPc790zA6W6ALPaXR1pCP
         RoBEo0PWC2rAA+JAPXp9K1E1PyPFxclRtyDqk2uSqstzYIIDeKPAuHq/JxBGa4GR0ynS
         vIJfI/U6KiBWMuLp2jQLXPtDQF1ab6Ikql4N2LPR+FmJTVyoggVdib567w/N4xr3FzTg
         VWxg==
X-Gm-Message-State: APjAAAXcu/D4IdntPdpnVjL9L9eD5NSXzIcYFfkO25WIm8fkPTazzuGd
        4HsL1rHIUI7CJfGajRHgw6wdFVDBZKUsAn7nSCy69JWth265oXpdXkH5jn1envgQ6nGKEik8oJU
        0UAV97sCAKLRRSh1IFNFNqPRGyfvWC57WNDw=
X-Received: by 2002:ae9:dc85:: with SMTP id q127mr4618889qkf.460.1581718581952;
        Fri, 14 Feb 2020 14:16:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyyXhf9ySjiOcoYhCw3Npb8sBi+pCL4GfySWR4dtPZqBKpxKv5rWOUxYeNMQvsuo/hmv53Wiw==
X-Received: by 2002:ae9:dc85:: with SMTP id q127mr4618857qkf.460.1581718581514;
        Fri, 14 Feb 2020 14:16:21 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id m204sm4224406qke.35.2020.02.14.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:16:19 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20200213211847.GA1734@sasha-vm>
References: <20190829205631.uhz6jdboneej3j3c@pali> <184209.1567120696@turing-police> <20190829233506.GT5281@sasha-vm> <20190830075647.wvhrx4asnkrfkkwk@pali> <20191016140353.4hrncxa5wkx47oau@pali> <20191016143113.GS31224@sasha-vm> <20191016160349.pwghlg566hh2o7id@pali> <20191016203317.GU31224@sasha-vm> <20191017075008.2uqgdimo3hrktj3i@pali> <20200213000656.hx5wdofkcpg7aoyo@pali>
 <20200213211847.GA1734@sasha-vm>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1581718578_27211P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Feb 2020 17:16:18 -0500
Message-ID: <86151.1581718578@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1581718578_27211P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Feb 2020 16:18:47 -0500, Sasha Levin said:

> >> I was hoping that it would be possible to easily use secondary FAT t=
able
> >> (from TexFAT extension) for redundancy without need to implement ful=
l
> >> TexFAT, which could be also backward compatible with systems which d=
o
> >> not implement TexFAT extension at all. Similarly like using FAT32 di=
sk
> >> with two FAT tables is possible also on system which use first FAT
> >> table.

OK.. maybe I'm not sufficiently caffeinated, but how do you use 2 FAT tab=
les on
a physical device and expect it to work properly on a system that uses ju=
st the
first FAT table, if the device is set to =22use second table=22 when you =
mount it?
That sounds just too much like the failure modes of running fsck on a mou=
nted
filesystem....

> >By the chance, is there any possibility to release TexFAT specificatio=
n?
> >Usage of more FAT tables (even for Linux) could help with data recover=
y.
>
> This would be a major pain in the arse to pull off (even more that
> releasing exFAT itself) because TexFAT is effectively dead and no one
> here cares about it. It's not even the case that there are devices whic=
h
> are now left unsupported, the whole TexFAT scheme is just dead and gone=
.
>
> Could I point you to the TexFAT patent instead
> (https://patents.google.com/patent/US7613738B2/en)? It describes well
> how TexFAT used to work.

I don't think anybody wants the full TexFAT support - but having a backup=
 copy
of the FAT would be nice in some circumstances.

Actually, that raises an question....

What the published spec says:

The File Allocation Table (FAT) region may contain up to two FATs, one in=
 the
First FAT sub-region and another in the Second FAT sub-region. The Number=
OfFats
field describes how many FATs this region contains. The valid values for =
the
NumberOfFats field are 1 and 2. Therefore, the First FAT sub-region alway=
s
contains a FAT. If the NumberOfFats field is two, then the Second FAT
sub-region also contains a FAT.

The ActiveFat field of the VolumeFlags field describes which FAT is activ=
e.
Only the VolumeFlags field in the Main Boot Sector is current. Implementa=
tions
shall treat the FAT which is not active as stale. Use of the inactive FAT=
 and
switching between FATs is implementation specific.

Sasha:  can you find out what the Windows implementation does regarding t=
hat
last sentence?  Does it actively use both FAT sub-regions and switch betw=
een
them (probably not), or does it read the ActiveFAT value and use that one=
, or
does Windows just use NumberOfFats =3D=3D 1?

I'm assuming that the fact the doc also says =22NumberOfFats =3D=3D 2 is =
only valid
for TexFAT volumes=22 possibly means =22Microsoft thinks that's hardcoded=
 at 1=22
given the death of TexFAT.  That would make adding alternate FAT support =
a
major challenge.

On the other hand, if Windows actually looks at the NumberOfFats value, f=
inds
a 2, and ActiveFAT =3D=3D1 (meaning use second table) and says =22OK, wha=
tever=22 and
just uses the second table from there on out, it becomes a lot easier.



--==_Exmh_1581718578_27211P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXkccMgdmEQWDXROgAQJrXg//bPrYDkf+/qHxzc4KiI24Rxtqdm4U7Az9
dKL7V6gOwwbrxTrr+xIZvmIKJv49976Gx1CTVDVrWaXt8TssINoO9jmJlQOHMQ4P
DzgVhXgkzZuLbiJ5mFMMrNT5JLiCnx3clSkgSTVXxKXXsfKNFFtC3N6RqExxSB8R
mh3bU2o5kyu3+iIwstusdTjHOc6pyUDSTmJ4IgptP1GCiVxUmvzpeNR3MxcPPt0Y
y8gI2si8AxK9koQHPxmQxrfviTvcBhqZ9dnR+Ap+aLgdPCea1MgXW9/zReficgj/
sUsdqKOrKvS8lyIZbninbaXqht6jUdnyHmENqvmGfKDz0b5OZjFaS62OAkd1DHPM
2rtFlgRCNMVcbu3p+pxbl1QiGb+xgakOzYiQEHjKFKQRcsXNcHUp/wstMOQsboF+
SdnxDhKdK4Vagwur9ZyPeGZfHEOk1CCM4/VCNCOqs+qZo+YBqZbxC8uhMd53/fUl
231KAF796DKrCeIsMdoGSinaGJOqXvuHzQoXTPKYcpGglnvvje35DYxhkVs33WFU
U+b0IIoofQhzNBIJeniKpqNai5AsNNHjA4Mrnpp72sb5DA/Zll36RgXIn/+CG52/
aF2BJpOWIJdCa1X3KGoae3dNdU6n95ZHdTsKqh54ZeITB+El0BwB1uNyzHhgVjhI
e9fqc6Jcr+8=
=pN4u
-----END PGP SIGNATURE-----

--==_Exmh_1581718578_27211P--
