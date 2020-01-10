Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB652072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="embQBqkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgAJOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:52:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53167 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgAJOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:52:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so2311391wmc.2;
        Fri, 10 Jan 2020 06:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oVYLl9LN72M2SWc5/npLC+GHfXW32Z75PJHHgZON1Jw=;
        b=embQBqkFQJiui3MEMODdwpfRFie5ETZTYIzBikIvHCeJhVjwtfGYt44rI2jFsSRoMs
         0MXr25v2rb9rV2KaiVGdV3y3LU/qbnAPddh02Z6rNYAMofyRQkdlGti+a3IjJKGOHbqn
         J2K6iF6n45lLeZxUzbNmLfvwRZhbWLBrVKmurs4VHKW8PuDkLb/9vNn4AO/hkpWz1b9z
         7o49spp5mx2CObSUaBLIun/9yGpdxWHIzghCA0+yCKcjZn02NqjzNYmf0HxNmgckF153
         pCPZ0ftzB5+P2L6V/6PN0VI+h+5n7psdi1CDrAYTkc/O5CFfTtE5tBjS119Oss6WvFky
         4iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVYLl9LN72M2SWc5/npLC+GHfXW32Z75PJHHgZON1Jw=;
        b=DdXTPBU35x2YQI5iVzSyy9iY4EWENqM4SotvfenculY93w1a+NCDF9yWqCkV8IC4WG
         hsPXrSP0bioG3Czl2yZqk8rZodXzpGhygjOf8xPXGt1oPJyOxENBtJj9cN5XgGy7kI65
         XPmQMqbley7QmcV7wGm6eL6kyrkZtLNMNsHhxVbb5grc7vCEAZKnAG6QUSM0HVtmUmjv
         /Fq2g+IemiVO34v26gAE/6k0Xd/LWvqYN7M2cTBwzUca5p5B81YDNjNnDn+mCApMo/Xx
         WFkPriOuGcY0+GtzG6madmWAjnriUILxFmlycNCQFw4h1wczt8V8eOaL+VyePgriPkxN
         YOxA==
X-Gm-Message-State: APjAAAVGmftK0xFlBqYgZutFHA1hjkS9qdUiuAoaF8tvYqxupe0/86cP
        +ecWHd7cRRMyIKikeGkcOwE=
X-Google-Smtp-Source: APXvYqwz+zKGoUL7Z/9WVoYbEbih305CPkdr5KQ12oBQgA3aj34A5GHgHcD06644tvAl04QLcM8nDg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr4889708wmk.59.1578667938288;
        Fri, 10 Jan 2020 06:52:18 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id m21sm2505984wmi.27.2020.01.10.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 06:52:17 -0800 (PST)
Date:   Fri, 10 Jan 2020 15:52:16 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND for 5.6 v1 1/3] clk: tegra: divider: Check UART's
 divider enable-bit state on rate's recalculation
Message-ID: <20200110145216.GI2233456@ulmo>
References: <20191218184407.25790-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <20191218184407.25790-1-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2019 at 09:44:05PM +0300, Dmitry Osipenko wrote:
> UART clock is divided using divisor values from DLM/DLL registers when
> enable-bit is unset in clk register and clk's divider configuration isn't
> taken onto account in this case. This doesn't cause any problems, but
> let's add a check for the divider's enable-bit state, for consistency.
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/clk-divider.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

All three patches applied to for-5.6/clk, thanks.

Thierry

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4Yj6AACgkQ3SOs138+
s6GxRRAAkhh+jeJ2znxH5p0u5lU7TnqfCZkhhIf9AuHOtxu8TBDgvsruRrJRS86P
hAc4z201mWg29UpR0R9fOvuQhGNGvuYAGU/m46Utq9XLQLlG5ZLNsettLgBmg/Ju
u4yX3YIrDvBde7/xgWB5GjBUhzTkDrcdn9nz12DHbE2weHao8xK5zeEosZw/LdYs
IDkKdGeuzYlFM3yo/Kro63RgHsG6srdoXid4elJt/RdcwrNY13hROSyGTuE5LXx6
6iZHUaMh/E947uCPe3/H3S+Sy2ZWR/6bu44kp3h6B6vh0ybyOUG4cfeJT2bqNXOb
YB6sqcXSwJapIpPy2jmQzx2LMUJPpsFglHF2E27IV2D1z7DEDSNdR8cGm0wy8CBR
xhKujgI0hs5y84GuJSFlqM1bTndC2/3GvAAqTW5BH0IekzmffvJt2a2NCwoi6jB4
HKji0Dxw4XzHkiWj+RE1tXfZu7IKOsz0W029+LX9G4EhiYAMJ7+KkJp3lHJ1f487
a3p2uRoBneOYSLMALSZ0OqNu9GWXqqUVd+nf+VH5WpLGCHpGqzXnfJyqIWyhpUey
XXkZfqhzFEjyawT4EAPVnkfOtwYuWjSV/Iz4v9qbGj/6GMy/yN6jZ6Y3LlV/kQ6y
pJq9/0eNDwcTjAsiD1z2+/eHLFhy3Pzks3GRi+Y8gdkjkxl+ppg=
=oKAe
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
