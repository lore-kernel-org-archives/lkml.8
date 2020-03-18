Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C4C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255020724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="q+5q+2k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCRMSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:18:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44089 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgCRMSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:18:42 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48j8G70yW8z9sQt;
        Wed, 18 Mar 2020 23:18:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1584533919;
        bh=xKauPM00syGypjbw94/KFEkZTZqlv1ME2ttiZ53fWVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q+5q+2k6Ug6F+kocM7xBXWa1PUfxczld5z/K9d4QAxyXvsz7sTzWUs0oqgYoVKXh6
         Usgqx+uW/Dw5MyQdjkv4J2Y2eMR9Z9yPp3xyy0DXrQ+SLwLiaV4Lrh2ByklEvHH9pZ
         tl1D1Apl3+cVGiJ67WMrrSmSrfIOH+IpA26nL0bO6cTwhDevv8giqORFJPhegXNOS3
         MhEqsM3VorWD46qpcY/7obyxQ3Jyve6C+gtMs0WMWVbvchNN2d1+h9mrIYx7Ph6Rbd
         3tJu9Wf4eQRhK00gEDs3cNR96QLI/XwAhKeR8FWNzAA7xDbg7/GSnk0xmadiyjTjQg
         IBhqD3+Uziw3Q==
Date:   Wed, 18 Mar 2020 23:18:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pm tree
Message-ID: <20200318231837.4041cd8f@canb.auug.org.au>
In-Reply-To: <ddc7ae33-1b82-ae48-5a7e-e78144fb2a8b@canonical.com>
References: <20200317185252.3cfeecde@canb.auug.org.au>
        <20200318224458.1980e10c@canb.auug.org.au>
        <ddc7ae33-1b82-ae48-5a7e-e78144fb2a8b@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lkteiqNJ+pRCAR+LQjfQi8Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lkteiqNJ+pRCAR+LQjfQi8Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Colin,

On Wed, 18 Mar 2020 11:52:00 +0000 Colin Ian King <colin.king@canonical.com=
> wrote:
>
> > This was fixed today (by including linux/ioh), but the latest update to
> > the pm tree has removed that include again.
> >  =20
> Hopefully it won't be reverted from linux-next?

Linux-next just contains what its constituent trees contain each day ...

--=20
Cheers,
Stephen Rothwell

--Sig_/lkteiqNJ+pRCAR+LQjfQi8Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl5yEZ0ACgkQAVBC80lX
0GySQwgAoR+5qipE5cyNLFPp8YjbVqPFWBTtPBjo6G91bxM8lqymu1iBj3Msj6BM
N2oY7F8k7wMAFO3bDiNAPb/uOpC8R2oapM7YQZj+93AJQ6RPdm1N90nlpFJ9e/E1
fm6u2dQe1YO2jfD302fkMicUIuHu/bUilvSCRBQdfPo5WvGTkxS/S6zgb74E0aRB
FR8Dau+S4d6vsby+MlT3vBbBEzi4bUscOwi9ISOU29kqTuXhz6GUDB/nYRan47Rz
jbtKdAbkD/G04VBzfPuI4vxHtByN1AE5ZtUV3nidlGVZ6KOpb6EuUKYKQAeLAGPm
K5dBbLRQ2THA14jZonwgWd3UusG3Lg==
=e5Oo
-----END PGP SIGNATURE-----

--Sig_/lkteiqNJ+pRCAR+LQjfQi8Z--
