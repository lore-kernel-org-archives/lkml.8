Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F76AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C19920732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="q8ZhMVrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgFVVHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFVVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:07:31 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:07:30 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g7so8659029qvx.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S9pGkbvuJFuq7v9oNyRCTLIJnWYyvj7NgM/MKVi/H2A=;
        b=q8ZhMVrCnLpTLo9ZtCaPBS/DSVK/IToXthnATT9S8YQHNN7QMedcuM9hMuEuCQM9JW
         l2k130fehax0VznQe4XtGp7ur/JRThFnyTPU0Y/IhD22IZjvNh0iziQpaNBexeAU08e4
         p8M/KI9FGATEFHv1vka37geD0tLb63yRJRJGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S9pGkbvuJFuq7v9oNyRCTLIJnWYyvj7NgM/MKVi/H2A=;
        b=f/vy6Bz8cfxGTbts2MClTUMnUEqxi/SHfgpH/RmEzdtI39Stgujzpw3N+u6bQ+qmjX
         YdnpAJeLN7jwJSgmCar5fVEher2rKVJzb6GjWeld02S0CtiUcmuClAqsvSsTD3/V8y+D
         2501BPgA4GzngJ46YWVg+gq5e+2c6cE8vw7Tr7261FpMKLmjMT9t48uOuoH+fNOap3H9
         ziKCviq5RLNqhREWSrMRhX3r0pNo63nCpcNrjkuZ7GIxszuEj2Tg2/o3/CZhxoE32GEi
         Ct1NmrVziWGQcR5xE801XxKwGvBoMLBJJ+hRAe86IFi6qEHHegqJGAoihbgkmH5OVVtn
         bV0w==
X-Gm-Message-State: AOAM530NVfdEPGyG8uecEpcFWNYkA7GYcQsHvOa0DzABK5zg9MtaDpb3
        lSGQ5JAookMBO8MPS6C2OrGhXA==
X-Google-Smtp-Source: ABdhPJzv6IjEjKFWPgcnLCrtE/r1+otzt5WwH7ANZ48bZSseYpQKeMNfrgvQmZxYf/lF+ExrKixRYQ==
X-Received: by 2002:a05:6214:11a1:: with SMTP id u1mr23414523qvv.91.1592860050015;
        Mon, 22 Jun 2020 14:07:30 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-8080-e5dd-5747-7916-11ff.inf6.spectrum.com. [2606:a000:1401:8080:e5dd:5747:7916:11ff])
        by smtp.gmail.com with ESMTPSA id n143sm848169qkn.94.2020.06.22.14.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 14:07:29 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:07:26 -0400
From:   Tom Rini <trini@konsulko.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     ron minnich <rminnich@gmail.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] initrd: Remove erroneous comment
Message-ID: <20200622210726.GO27801@bill-the-cat>
References: <20200619143056.24538-1-trini@konsulko.com>
 <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
 <CAP6exYLd0uFbVSbn28iS1OV=jULtg2f+7t1DAn-fvGoRSd5dng@mail.gmail.com>
 <20200622210145.GM27801@bill-the-cat>
 <5d6dbaf4-26bf-d71a-595e-0b665d4ae614@zytor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ie3mu0AkGGOh6179"
Content-Disposition: inline
In-Reply-To: <5d6dbaf4-26bf-d71a-595e-0b665d4ae614@zytor.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ie3mu0AkGGOh6179
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 02:03:28PM -0700, H. Peter Anvin wrote:
> On 2020-06-22 14:01, Tom Rini wrote:
> >=20
> > I'm picky here because, well, there's a whole lot of moving parts in the
> > pre-kernel world.  In a strict sense, "UEFI" doesn't do anything with
> > the kernel but based on hpa's comments I assume that at least the
> > in-kernel UEFI stub does what Documentation/x86/booting.rst suggests to
> > do and consumes initrd=3D/file just like "initrd /file" in extlinux.con=
f,
> > etc do.  And since the EFI stub is cross-platform, it's worth noting
> > this too.
>=20
> For what it's worth, normally boot loaders don't strip this from the
> kernel command line passed to the kernel, although there might be ones
> which do so. In general this is bad practice; it is better to let the
> initrd show in /proc/cmdline.

Strongly agree.

--=20
Tom

--Ie3mu0AkGGOh6179
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl7xHY4ACgkQFHw5/5Y0
tyyOCwwAsGMRteGoyrg8spsoUqJI1aiNbKL1adRlWqmyOp6Xalv7oX8F2U+KM3Cb
kLjaWD13TO4EGEKQa9y9yNFQeHrR1BpX2Yvfu6z9zn1eH8TZaydpbZYvg69BhHcJ
18mRcUVuLMa3qgo3xvDWeVbMaW7HwyR4wb4Anc9pj8JYBiW3zw5P6uan5ZmGJUzj
CRzrWxPmgUnQF9W5nI5SgLQ0/U9JB9GxJWIZfm9HeWMWGwvSV7bceJjDqS35f3AH
d9C5Lj2O20WXeTYCr/fo8R/wVVYgyLREUnChau68P2/c4cdHjiOOqME54BRmtKTI
e+URO64xiyaw1YSfsJojo/TzGfXslRe75UAqSIToKL52gLFmGwQBHwa2Lq37vzui
N6WtKif0EBfxapnSq5AuERMklfV7nHl1as/Vjm+0AOkUiPCc9SFGhsXL7Jx+BUyG
aZY9dIVOLvgpAnR0p7goyXDQQt+WwtBlPGSotVn4pQUa59SU56Z+23N7Fd0G+Hm5
4b1Ka06w
=hee4
-----END PGP SIGNATURE-----

--Ie3mu0AkGGOh6179--
