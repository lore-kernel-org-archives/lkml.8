Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E522C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F462078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCYb+erS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbgEVM7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgEVM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:59:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC25C061A0E;
        Fri, 22 May 2020 05:59:17 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so12932418ejq.5;
        Fri, 22 May 2020 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZW5lGmB6LapbscwV/BtBehKVwRSoVgdjATk0hkmmT0o=;
        b=pCYb+erS0ga5JAdH3+v7xJEGa80jYFbQf/IjxC70Wz9WnXm4mbKkPQ5pWCvnpu0eJk
         ZpYd3BY+Kc5pLF9NWfnxhHn6Pt5BtznZwGbXUIS9+X5M1+kPfG1b47zQ5gbSytrEyaab
         fIr48P7BVgAGbkHrHWzwh2eezAV+XDyb5ooSgsY9m12ZT1mstCpMs/43LGPnwGBilx5l
         qw3Fzz+amJYBjH4p2RgSJMZ1iXlrgi4gDMSegzHjliRKrhvPoqKh5WWnN6K2WN21XqoO
         9SEBQs6vpgR7AfDvA+mVwUi18utSB+PyyACqGGQHQ8yoTbPLTfIyFCyAPHXXVQvrZo9C
         wAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZW5lGmB6LapbscwV/BtBehKVwRSoVgdjATk0hkmmT0o=;
        b=uTWnTve9nDyOGcjOIX9oMX9Wh6PO7fb1jIeClMf6kcZm0hFOEnvbYWCP39gGaVs3wn
         926+9GRDSBJhYF9a+8AcXmRMKzNXLU0n+tcocDN9HFGkDothk+aOJb9N9eYs/mzOXGFC
         LLx56OMXWx/noUGABcFfPg8sxlAFhyKdS5xEjg/V5MebA5ZXG8BGX1qEUnHmLlq7lpDm
         ++K0jGFOuh9KjQzbyp6o7gttnk+sb/F4iY/FW27Lc0XoI/9+fanR0EFc6ofcnCTMA4lR
         zv+GJsvoVYg0TyEFXzMj9/uHSWNvOiiQmMFP2i3h9lI6lYowo1xcRHCQb38ydAfTXwLY
         VKNg==
X-Gm-Message-State: AOAM530At0NOyzMS8zup0OP+r32SxmBF0PaJBtHIPsCgNeoWUS/KN+jg
        A7rMBXbq6NbQC5O4IqI6fmU=
X-Google-Smtp-Source: ABdhPJzbVOQxgtkfX5DSe5uy+Y4yhs9DBCwwJvPjdCZVLa9SRWBLMBVIiYqLk4QkteajZIvbjKZHCA==
X-Received: by 2002:a17:906:64c:: with SMTP id t12mr7852404ejb.524.1590152355994;
        Fri, 22 May 2020 05:59:15 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id a15sm8008320ejj.104.2020.05.22.05.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:59:14 -0700 (PDT)
Date:   Fri, 22 May 2020 14:59:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: hub: Do not enable orphaned window group
Message-ID: <20200522125913.GK2163848@ulmo>
References: <20200519090301.32689-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <20200519090301.32689-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 02:03:01AM -0700, Nicolin Chen wrote:
> Though the unconditional enable/disable code is not a final solution,
> we don't want to run into a NULL pointer situation when window group
> doesn't link to its DC parent if the DC is disabled in Device Tree.
>=20
> So this patch simply adds a check to make sure that window group has
> a valid parent before running into tegra_windowgroup_enable/disable.
>=20
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/gpu/drm/tegra/hub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HzKEACgkQ3SOs138+
s6H7NxAAlocR8/osRzgQ4vml66I6m+TJuF9k2Ow7YvMDRZYSDXW/Vsl2rqwUZrwZ
A6wx5r9OxEq/eXjSpNHvF2nOqPRetvKHqJKBFFXOixDdD0UtIvlAKdIEZ8Ch3Gx0
fu+OHajYhSQwEUxgNToQy5lqRJz4nZKTmXJgirAHD1BBqxjc3FqZaXBnwkE2bmMx
rwJGkoylRBaw3TSxzSHx+CalaDf2yxfLHwcXa9/zcfFKJ8oEOBgREnL5PxbZhH5J
LOhqHzDR7TpQgGJjA3XAHYwt+nS04lfbQpiy+gYWwVQ+n5S0I5nThGUEXbNSKivR
REjA95NXLQLBziROaxWuUlH8iWggdfhnAP8PfM5pG/TR26/r3f//4VDaR3RZoqzA
dkaPwAg14VPir9OOOOkFxYp9hBw9fh91FbzwSMguAbG9bE4Dt9ENCH6+2EVYi3qo
14NESubshj9GpokX6gjs2Ksz6GDzvXsCygYC+gcmTRSYZq30D5LFgvWqLtElw2/P
j8w0Wq/yg9KSCf5/4YMGynGeZ6NLWbch+jolHGeothCJ1DbZqiZYbqO+UECEJtCh
+m0PRjJMLvCRsjGwyG8vGY9QoOtsoUT8nCKSy1bRaNcK+OGwOUpzAp0bZUyJKkgs
5ci/nJu96j3qB+W/5fKnjT9JMMiUxInzQyU91aeurJWtPIAH+Oo=
=G02C
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
