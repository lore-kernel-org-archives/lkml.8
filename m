Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4518CC761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0122070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txsXBkx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBQJk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:40:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40760 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgBQJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:40:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so17625765wmi.5;
        Mon, 17 Feb 2020 01:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jk2U3A+UdC2j/40UYflxTvu2jRzfOgnsui2N5ti3cA=;
        b=txsXBkx9hagw1F8lGYDCyBjPM0l9cIEXq3vJZdoXDWVa7V6rLnVgervweHeiiOvV6R
         6z7kZ4U/riwXg7649B2BcoSZ2ZJYy2PCWG3nbcyI9RkQr9Z7oMR0EdqQ80vRDvr+1+8e
         368YliYQzTMw4J9byCRqWGnB+eUYvNc4qUg7ZpTm+qH+Sb4LzuK3GP5b/m38nfRjUK/+
         S+H8S2t23qTJRBXKyEnC5rzvC4ex3dtsQsPX+ZMHxbc4gKZOLcipUCdw08+AsJHAs94E
         d6BrSGUDRY2P8RPoO+wv7yKOA5bRMD2DPq/MXGN6NIvGM6CsBVvrC9BFS4icR7oo6hOB
         aVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jk2U3A+UdC2j/40UYflxTvu2jRzfOgnsui2N5ti3cA=;
        b=YZcBASfJzStJwaP6nqpTiGKkBYRUCreCT90x8Zw6uJrjNjEoJY1GD/RLre9ipVL8lQ
         uJaVYw9VT4IVbbocULOoxfnlYchrnbKx8pKD2ef3w4qGyI8YYqPDEn61P04ZwxGTeXwX
         XUuj/x+COpSag1DCTDbikm+9vabvISg9JKNhyXW8NDCG4SxXD6nx+jKUGxRpmsSU1lUr
         kMS6K5v2qreHx1hXp+EtKuRMnChVXJCyGW9MiejRGVPy6X9ulo4/RWC2up8KZLPdfLOn
         8BxAO8oJRscGrPnzDCJxGLlrdYiowf7ZLYjgmv4P6/XMrB4nKXX5XSvyNtES1Tqq1vh/
         Oiww==
X-Gm-Message-State: APjAAAVUnD50UnKMpB+G8hCX4vrqZZFp92Kfkcn3E0NfkDOKcEeA597Y
        YQrfvQR5j6JIw//Ad8XyRpY=
X-Google-Smtp-Source: APXvYqwh4pc/7fN+8AgnYCes5SZY0fQ3oNF71KqEeMZq6eHUpYNp67Xs4LeLpryg/d8kcG1Jw3JOBg==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr21894082wma.134.1581932422701;
        Mon, 17 Feb 2020 01:40:22 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id d4sm140834wra.14.2020.02.17.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:40:21 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:40:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/22] ASoC: tegra: Add fallback implementation for
 audio mclk
Message-ID: <20200217094020.GM1339021@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="egxrhndXibJAPJ54"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-12-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--egxrhndXibJAPJ54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:16PM -0800, Sowjanya Komatineni wrote:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
>=20
> New device tree uses clk_out_1 from pmc clock provider as audio mclk.
>=20
> So, this patch adds implementation for mclk fallback to extern1 when
> retrieving mclk returns -ENOENT to be backward compatible of new device
> tree with older kernels.
>=20
> Fixes: 110147c8c513 ("ASoC: tegra: always use clk_get() in utility code")
>=20
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

There's some inconsistent spelling of PMC in the above, but other than
that:

Acked-by: Thierry Reding <treding@nvidia.com>

--egxrhndXibJAPJ54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KX4EACgkQ3SOs138+
s6Fv6RAAuWcedNtxcpf1Te+X5nra3uQEEKd0TuNszot0ysatU9RzdUyV2WgKYaNM
waUPM+ScmUboRJSGBgFEuXcIFs3eYo9JV0ODdkkONJfJqWAVR05lcn/CzpWyLYBt
9KbqTnNPDMGZ/55wkn6+7VWl0skvgUrNtYsIFIXxAbPFQJle0X2Fv57a/b9XWTc4
oJw4eEM16pHXkrl60WtbvMvt3Fwjj7juBa8bS707DnVOeMufR/SCJ5R9D2R0kJeI
YIDbYuyLKzAjdrWc1cnWwYmfJmyAV2TNAH6QFxDPY6gxXErjvuY7xNSxxwlq/QDX
8HW8FDKJQ7GREF5rAO+AbKfE1iF9jrmkGCKZwDdms3BvVEm2nYx+ZG9L86+kk6NN
nn03DpAmNXNC3eiNNVgtTpDGokbKvDgjr/84dMdha1MHjqlaE9sovhfQpCpbcIEl
gvHMRDmdIHhxF8zYn8wmqPSGI2xpvqLWt4gzkQNv79Bq+Q9qhGRRTbVJBg0SawRb
TooYWT4EpiKvA8RV4rsM3gvCCtqQAD0ekFRSEb39r3Sn65zUmvCttPKyzAZ0ePk9
/2TjbCQEtPPPjXV3DZYtmCGAODV+kEI/TPiz7t66TCV16oVSWmTFBSvIsrV3FmX1
+/pfxQbsWJlWHjjsCDQ634jKLFUtefD6kaSrTMq+CbAnfspQTdw=
=/mBF
-----END PGP SIGNATURE-----

--egxrhndXibJAPJ54--
