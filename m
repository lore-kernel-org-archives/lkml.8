Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82DC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6FA208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umE8GfA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEGT1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGT1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:27:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EDFC05BD43;
        Thu,  7 May 2020 12:27:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so7796270wrt.1;
        Thu, 07 May 2020 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=juyJ9lwzr2janjOSEHzVoFlAFrc9APYn5GdZLAkVqVc=;
        b=umE8GfA+bHenXOWvcmjiP+45bDgfaYbTvHQ/hacGGjWxmK3hRlnoqycD0UKK8jGCko
         iak/Jv50S+X4+ZAowstqq4ZYxe+Sb85eqR/7LYk+6gczJv6Cw7RVzJIGRwjyOX792eWb
         H2hzes4pJSXnXI4G/r099kpqo8cmEvLbpHeXDKWXnQO6R6N1lrP0w6Ki2blPG7Fd/JQV
         HQ+j1Sxs07V71UwwHqbHwX7gfPZq4LgA1JXbbES1asXVyMd4bz60Zn3YR515FeR8+k/Q
         I0NvNscwlFH4PENJZoRJny3fQqYODqROOzsGUjbZfyCTBCUO6E3onx5hZnPiEsj1Ovpk
         T52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=juyJ9lwzr2janjOSEHzVoFlAFrc9APYn5GdZLAkVqVc=;
        b=eSak8UyTxcacLXEJWxL/np5AFcW/1IcdRW6Z+QkSY9k/RhrGui4APEOSWERcLeBK2s
         qYmWpw7LqkRQgcCOa5OqqKhoXyDo9e0mVNDsItOhJGIpMP3olwqwKxANT40AjMObxR0y
         MmqW1QPopoBQWZ15AKTAmn1plIg7XKhkEZUzNjSo7T61m3jQjTFssnqO9uvk6fN+TH7A
         T6TFuiUC35nBbQ92XSk/FiLEM1eHmOC3TtZ4koBpRBLubwTZt0QX3AO5QKv84RPGcu9G
         DHMw9HTwYaWg40mnQ9tJyfsh7mE2Z6JhiDvWC3abcv9eQjJrszicD9SUN5wX2UprIlDT
         uKmQ==
X-Gm-Message-State: AGi0PuZJ9M/vDi7Aasf/HEsbaWuSzZqI4ATVL3QV7k0oGsI6WKGt0+5b
        QQp0DANUl5tQjO+GSq3ZxIY=
X-Google-Smtp-Source: APiQypJOZABF8JKClO8579wnGqVXB4heq+mJNVis4yMmBNkvzyrxD3cHqfWEUirjY8quYem3/WrGeg==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr17076474wrh.295.1588879640019;
        Thu, 07 May 2020 12:27:20 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id w11sm9184361wmi.32.2020.05.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:27:18 -0700 (PDT)
Date:   Thu, 7 May 2020 21:27:17 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Fix an error handling path in
 'tegra186_emc_probe()'
Message-ID: <20200507192717.GA2905961@ulmo>
References: <20200506200907.195502-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20200506200907.195502-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 10:09:07PM +0200, Christophe JAILLET wrote:
> The call to 'tegra_bpmp_get()' must be balanced by a call to
> 'tegra_bpmp_put()' in case of error, as already done in the remove
> function.
>=20
> Add an error handling path and corresponding goto.
>=20
> Fixes: 52d15dd23f0b ("memory: tegra: Support DVFS on Tegra186 and later")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/memory/tegra/tegra186-emc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied to for-5.8/memory, thanks.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl60YRIACgkQ3SOs138+
s6E0uhAArwnuPlgr7H/3NTv0vER3Av5CqoabBWqcHkdalDEoowrpcAIKG7Y+J3yp
teJ8yCVlGPVPQp5P3peK+ABdZCVVtLx6FnRfuiIlEFih8xJwfLmUukabewO3+sC6
TE0QZtJl7q4R9aXRHHvi2lv/Wl2X4j7A3ucZEVYcB4fEHI7GCWJaGluR6/B6QRS6
D7ad5FQOPbDKWr7vg8ePm+mfypMs8Fes739f8JDnBCnS9Ol3s6Z83xnBc7BTlcUl
hxqY8YRBbyiyWIjTbo5jjg1UGYdKdt0c42YIvmnMpRfxMpwlyyIYDZDirLGo+cF9
ZjJ4p9cVyTTgL9J3CR4LUA2Klxsa6iaLC2lzZ/bUq4zLzxBtWVQinN2z/j8Lav24
54dW1UqhW7VLFxOWqZNa8X7vHTI7LF/gxiaop6J6o/+vYVpIkwHIftEyJz7Na2VO
rfS5Njj9WgYAlNYP4mq1kZigXZOpW5s8ahOpoVA6q0Qbcas11eR8oU8QvwiYQ4c3
v/tDrG/IqehyIpEdvmz7Xr63j45QQmxWH0hYDd1gBRWCzWfB/dM1e41LQe0sOTes
HhWd0qmmj9Ld0XvnYEZvwRTA0nQkuPAH9pr5PdHedUyB/EpKtOnZYM+VQZ/8JAEA
/5X/ZuRMs5hrKgT8XsVTrtnVo+dMxclmYN7CtSizt4LjMumBIH8=
=jPaV
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
