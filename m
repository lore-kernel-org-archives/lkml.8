Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F92206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+W6ZtH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgEVM64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgEVM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:58:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A2FC061A0E;
        Fri, 22 May 2020 05:58:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so12917929eja.7;
        Fri, 22 May 2020 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSr4HyzjLQHJeqg4FXdVwA9taG1tAujGNpZJV/Lp2xA=;
        b=C+W6ZtH/OmhK136qz25PUTdO8T+zJkzNw6ZdekdKRaw+lWD3gdjDOE4qa3ij5Xm5C2
         5D53U63XJnTud+61Yl5K3aYr0X8XkMkTh2qnE4fDWg7f6zUgNA0x8z9fDNpDX0RHXyoc
         2NeTkVNO2BEy1XtAAzhxpd0ehdj+wdJAHi8ASiEwlPqUzJ5He7JxOAdhV2RsGpOeGJ60
         I4N2T9rlWf6O4pYEY5B/QPzbsao03F+tDdKegOk4YORJrlwK7Os6WGLEY06VaRO1nxDG
         g2USmgybGdFgG9/vnjC5pmRYLy2IQKPgLbXwp807/iGActrwuWQHOd+teANdUnQ10COv
         4xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSr4HyzjLQHJeqg4FXdVwA9taG1tAujGNpZJV/Lp2xA=;
        b=VMpy3gxufc5w6tlludx4Af/sk/3jQyqFcvp7BhKKqAoJ7MIPF1NXg4ue5nxdt55Cbu
         jr89QfvLVlkHzMhWB98DLSulum1emPwCng9JkN1bNiNl5s0LoiukRTAYfte9o67Fiai2
         dN0AeXtUkiBLfTvJk+34kW0HQQL8AlNmbLFNGvWJ8kMe4t2C/eF6aqHA9fvKOdtdG8VY
         T1KZErriaISaDoALlLKPh0UDOBPidcUkKmy/3DnBnpMEgzCGoNANBBLRSk/y8lDzHtx1
         MaoiQ85WN+eTKXMg4bv6TowMaZ/NMvZk6WKYdG8P6pvHXpySHRGszLxZ1ay7aTDs3qEN
         252A==
X-Gm-Message-State: AOAM532U3+4SY6kH2xdR3jNci9qj0AZxk1/Oz2NMpxPml7HBP8eB3O4S
        Z9UDiJi1n2Cnn3KHR/i9mQqx+imu
X-Google-Smtp-Source: ABdhPJxYxiJCIdeqCxYbxGViLXunGVZrNR70OnewxOb4bmcvtpwxRQFfJ9pUADd3zXcMegCttBuv/w==
X-Received: by 2002:a17:906:dbd6:: with SMTP id yc22mr7916730ejb.345.1590152334467;
        Fri, 22 May 2020 05:58:54 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id i4sm7743846eja.92.2020.05.22.05.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:58:53 -0700 (PDT)
Date:   Fri, 22 May 2020 14:58:52 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: Defer BPMP probe if shared memory not
 available
Message-ID: <20200522125852.GJ2163848@ulmo>
References: <20200520151206.15253-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <20200520151206.15253-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 04:12:06PM +0100, Jon Hunter wrote:
> Since commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
> adding all top level devices") was added, the probing of the Tegra
> SRAM device has occurred later in the boot sequence, after the BPMP
> has been probed. The BPMP uses sections of the SRAM for shared memory
> and if the BPMP is probed before the SRAM then it fails to probe and
> never tries again. This is causing a boot failure on Tegra186 and
> Tegra194. Fix this by allowing the probe of the BPMP to be deferred if
> the SRAM is not available yet.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/firmware/tegra/bpmp-tegra186.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7HzIwACgkQ3SOs138+
s6F7aw//cbgdSkP2Ni/r+B9R5WWnEoShgUiaq0OGHzyiQPzG93CZFHUiWuO9ZSW6
qWRXMZkRGZzd2fCra33fVNPZdalCHJ/zPMlNfDC4PKhPO6KUixIv8P3/fDFodLtp
0hI6lZKkifiqkjIPUgDqHm6T19/cnJjalGkcoAAzu0GdL6/thkdn/SO0SARRaE8M
9LOsLIcoIhahOYatM/+SMRmJOqLA8NncSKHPQf6AZoGrLJC/QuvyZxKVs4wH5Vl9
OSR18XfNqy7CSZxioLsOYXqunVu8+NXRvmcdCm3Bi/xmDG5ra8ekdE1AESQvp0FC
X0+Guo2UcNKGg0ntbe9Rw5vQ1iJBpyHPE8t/2Ij0Y5K1RNjFy52dY9fc1nCb1ZDt
7hbOCqmu+bNjP/Px9IWiAtsS1DZMukbX4ywHWDlGaBm5flHb30XXeRuUuUkFn5ZO
dJPKbneJFqmV5xXpTTE76ltZfSBLk8MdWWW6/nSO9OEzODFCJv9I5UQLofI/L6xh
7yNT64Doq2tSx62Jp7ZjUxdmJ5+ric3oq3SHfiQig8UgNgFkbK3Vf4dMyE98XYq4
Vgk2kWjkeV3C81BGDJflVwMxiUNjEx1D6w5gXNoJYRfOwSL2D6xw0RUKrnxxV8yX
dLYx0Aeq0Ys+Y4Hn4klCsk+MuNQ+aEY+qeOGoVOcVe2/2Pn2NRU=
=Yo2G
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
