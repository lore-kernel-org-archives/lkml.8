Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E167C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1700E20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsyLT00T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgIDMUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIDMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:20:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C02C061245;
        Fri,  4 Sep 2020 05:20:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z22so8304518ejl.7;
        Fri, 04 Sep 2020 05:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7q5C8/jLUItkAZStR962PGtWTqQiplBbNCOmTg7hWgU=;
        b=WsyLT00TMZEoq+18wWgtxZ1dcOZ+WYbmhd12eCiwQIPbsIzoA9LAqSSVgHk2c6dLde
         0sPSQtlnM2rPjCHE02qSk2zcWwuGXekTynYfz0VD6H+7ahI/yZsjlQMJ/FlCIE0+QkU/
         DP/FnaaYvwDOlGgNUBRUFfxMhOa/YyGoIqJK75lmh7uuQo2fFB+OufWTbInVrO15xOr3
         GesFjYn1bPlCkl+amWCCKKKr3/aXeAvOsineO8kpUC3p9iX8C9bZb7odv33uGmc4XVRA
         LdtHrCQ3cMilURSGlYOdVtbAM+FItXdab+DNIHUqjoIf6yr7/m6KwLRvNHLQXU+6sFpB
         08kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7q5C8/jLUItkAZStR962PGtWTqQiplBbNCOmTg7hWgU=;
        b=Zhc2obYzRLS1+pK9Fyc49tJdJkPLl40T8gbe4HrkZct7LBDupvtLGGzIp9kzsfZd8g
         15EI0GzQTejK7IB2MMA1op+GGQ1PEzOnq5sbAIiN1T4S3ebnTB/y3mx73sAKvLMW20kd
         82Dh2k4kTAhBArBvywEjHHbZoFw6xRNAM7zgvef803aMyLt/0sUJclLvvS+C0GQLkzmI
         UUyAJf8kLLs8lR8aCAGaiIuSjAlaJWdmZ+GyKklCgbiJOYm0uIM71fXV5lxkoRO3q0no
         OB9JKDp+4R/7jxHV3YqRij6Li+Nrwgc0f6uIbnPPk0QHjeWtCH32u7yVchinBeE5h034
         nOYg==
X-Gm-Message-State: AOAM531RFl3eU/+cSSTSWu1Ut6YayBpYmQ2leI5E1RDlSfpwp7j+Pn6h
        WUVdpWfIn+QWZfgQuRvx6vQ=
X-Google-Smtp-Source: ABdhPJzCVpPb1VtJYTDT+SzrKaKMRmuVzIH723SPCX/zt4OLYxw7srtxI5Tvd9U9KDpFbFR8P0rpcg==
X-Received: by 2002:a17:906:4e4a:: with SMTP id g10mr6837157ejw.274.1599222045587;
        Fri, 04 Sep 2020 05:20:45 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id gh21sm5973012ejb.32.2020.09.04.05.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:20:44 -0700 (PDT)
Date:   Fri, 4 Sep 2020 14:20:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
Message-ID: <20200904122042.GB570531@ulmo>
References: <20200814162252.31965-1-digetx@gmail.com>
 <20200904090519.GF6714@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20200904090519.GF6714@8bytes.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 11:05:19AM +0200, Joerg Roedel wrote:
> On Fri, Aug 14, 2020 at 07:22:52PM +0300, Dmitry Osipenko wrote:
> > The mapping operations of the Tegra SMMU driver are subjected to a race
> > condition issues because SMMU Address Space isn't allocated and freed
> > atomically, while it should be. This patch makes the mapping operations
> > atomic, it fixes an accidentally released Host1x Address Space problem
> > which happens while running multiple graphics tests in parallel on
> > Tegra30, i.e. by having multiple threads racing with each other in the
> > Host1x's submission and completion code paths, performing IOVA mappings
> > and unmappings in parallel.
> >=20
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>=20
> Thierry, does this change look good to you?

As Dmitry said, there's a new patch for this which is better. I've
replied with an Acked-by and Tested-by to v5.

Thierry

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9SMRoACgkQ3SOs138+
s6GhTg//UlLbZDthSu1hLjh23HngDKBjooAZZJ7K88xkccpzohDGR4lmRSk9RlNk
oBPS01vo9mJh3nZEP3lw8Td/ObOUV9f1cW8ghnvYsxWvPoIjyL9Xr48D0EulHXpY
89ESymAMx9H8EDVwo7b1KfYCZ7/ls6L94PmUYaLIS++2AFKNkUZS7pzk+ISN5sFZ
IdXGUqKc0jbQntzCzcBBGoa76SxNIdXknIiwaAZDfi50CNOisX/H8I7RVoLjfz0n
ssi5eQix/oaPUvsaLF9azDqmOl8+7llhP17Plytso+ZGnUvidawjFepRjpAt+E0n
Borw8eNrjnAYYv7nvfkBA3l62Q1ngghq8Qbr1Psi6ZG7TRahr9PNTTOjKI3vCjJK
DaR+OhIKBAoejiRAXCJy0X0dnEzLianKD0DoazeVYJajo5CmGGx+rbHzOKxqSMUg
qVIxd6h3Wp956BSHwWxIQAXETmCCkRk0joO7bvkrr2soIpigm9mz2/tDGErMs3rU
e76A84X5ysKuhM2+2rAaNaYKRlQw2ljGnVfLjZbLBqz7bZTkwWJ+GIUq92zF2wWD
r/qdWUpmX64sRPL/Z1R5jIqzBEwwdh25EhQHpvlrY6PEIbUtdg+/QpVdAEXmVyLt
ifBgIbg6NC2rdxsaSU4HUDV15YTf7Ux3NnLaXBXliytG8cOy/r0=
=BRoz
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
