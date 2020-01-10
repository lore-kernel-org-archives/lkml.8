Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C9C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D157A2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEi0dKiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgAJOel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:34:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34889 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgAJOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:34:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so2040267wro.2;
        Fri, 10 Jan 2020 06:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZMNQJdAFaOKSoBirJdfDDp1ez5wjioL8ZApZUPhDZGA=;
        b=PEi0dKiUVGpgkbyvtn6TmoyBcrbk7DV/nGOvh2MXlE4dpi790wSCeUvat1J1ODbDVa
         1T1pfyL5N1i/0ADA7w0TEzdb/vZ0GeJhKwbCmc1xPphzWSnZvlc5yyFz+33d0z8EnHDl
         q0+1cx3xc4lsoVJY34OsuhrlPguKYeAs+UOvlvsg4YS2fp0nZhfE5hlYfSePQ5wHxups
         VgSul/x6p2+AqLu/UgnBf5Sp7oyHbebfFu3pFN+seZyMhxcWfYP0VoTKfdlotqFZY0kQ
         mMhh7s1so0SXdEcDGDRQ7zic3DEJc/K/shgxmvY22HPRfZxey2mGmt/TL4fFV6mQH3sl
         S+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZMNQJdAFaOKSoBirJdfDDp1ez5wjioL8ZApZUPhDZGA=;
        b=Trd74vrNae0xJ1hJnx1KwvjNygovQLwcs7uV9x82+XEeCJIi1luFrYHESMx2wpMNF7
         +NWOr+DoLuOV7LzjukunuBD2NG0wQDIQLbGZ2SNGGnJYc04/QsV25jlWWLvWMb5qcPn8
         yrS1AvW0N3ANvwmscot5NbjoAKcQOd2J1l91o37CnFzfYDALNvmpOZyitvDSCGbmggiZ
         SxGbB+AqIdry7qHWmzALJ7m4m/O2m6mG+Qnvv4A2d8ClBS3k9ULDs2Hj5oqcy/u9cwHV
         tFmbiNANpQ5tvsd6HgU6/nSEcxZkMopeZNbcWbU1zXYbSG1BE5GVAAiZIu2ZKlU8YL2M
         +2yQ==
X-Gm-Message-State: APjAAAXyVd1ZDNE1rwKk/UDKML/k3CNPXd9YdAe84p2yv/TXCVZdb1BM
        Orq3fmE7/cxE0w94zube9pI=
X-Google-Smtp-Source: APXvYqydmYwjuRWpEnJW7zDkNndZMMKDmmNZQ/qF/g6CupwAPvWiwlhDNfoY0qM9c/h1uUKnpFpfEA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr3821479wrn.251.1578666879258;
        Fri, 10 Jan 2020 06:34:39 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id h66sm2536850wme.41.2020.01.10.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:34:38 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:34:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     joro@8bytes.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] memory: tegra: Correct reset value of xusb_hostr
Message-ID: <20200110143437.GE2233456@ulmo>
References: <20191220002914.19043-1-nicoleotsuka@gmail.com>
 <20191220002914.19043-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <20191220002914.19043-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 04:29:11PM -0800, Nicolin Chen wrote:
> According to Tegra X1 (Tegra210) TRM, the reset value of xusb_hostr
> field (bit [7:0]) should be 0x7a. So this patch simply corrects it.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-5.6/memory, thanks.

Thierry

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4Yi30ACgkQ3SOs138+
s6HnChAAlH9Yv1ffvGQBL7EGN1kk3CBGC5ioxvxbPHjtk7tQhpESolBHMLLsAGIO
a8MT248f+xIhyJ1KIcr2KBatN7OHkpDzwbUjqEY/YkpVtaFv+OtZiTLGFOHXF/IV
r+NdozdY0wYbcNr84AGJoIjGzUP4yxreQ5k+MeZhZiUlSAwuSqGBaXgNJO3ILwP9
MkvWIWF0qdIJaFr9TnekBxusLdjkk+5+S8wWkgBT8t3VQidLDJwcrbvFeey6+zSm
G6cfuLKRPUxnh0mjrhptz+ykE0ew4mDoN1KcmYRu0pdz3Em9SAfg0bFUiuZXhz+w
gsEsc/DWhsTzG2zbSuO82oTes1u66rwSz6LzUNWX+isAbUazd3MpN8Ff4xwuSDHk
7wQYbG9514z60MXQQ8DFvoKaRikQXF2TcTESvOZRcaUxOcEqDrhIYSif+cFHiYfU
hWVv1YU6RIH6oQO4gtVbJbNPMYrNxwbifLm46fHkiylkc5VOFelXRd4roXdhNZBX
uqmSY0sa/7xUNmXaCvS7N1tOrfmVSXKWBzRB1waCZyhEkFnkreWfa1KCQh0KMxLT
GsLAw6ICzF7cgR0WWMd4hc04bEU8wG+eWgDZkysK2hVRl3sG7hyCnhahT6OugCpv
4jDTUd2qR7tScl63x4t0yM8WiWgeRia7K8S4L7GIwXpvjWjYVUU=
=PM99
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
