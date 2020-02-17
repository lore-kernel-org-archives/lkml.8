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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0915C761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79410206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duD1/Ief"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgBQJxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:53:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41356 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgBQJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:53:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so18877369wrw.8;
        Mon, 17 Feb 2020 01:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EI0LWC0VSHqVkZNo01uDgFnElBN1ode1tHZ9MdKxUEU=;
        b=duD1/IefDFi6QUnSoHvtGg2JA8kOy5+xP/bD9OaaE/hg7ufxztIHAkMUAV/aw0NeOO
         VS+oxCYoeybkXzt1u8ccPy0KHMQ/wJwixc+ZNtKvY/lIWWH+pJdr0CuHFPgrNMUPKinT
         vWQN/ICr+ZIrGE5yCrXT1q7yEb2hL5E8OqUJIX2+YJeKWBKRLeS6VdZCuVRcLM4vfvwS
         LGIGa/ztPPQi2T8g4EQDTYVlO8p0oKzID+nvgSkejRKO7BXP0d8fkF973nrcFBMIxb19
         wWqW2V6wC6TJXD5OB+1PzyqowX92rZPETzwE7GX3g+PC+HjsTwBFr4E2mC4FLDOKgJ8i
         OqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EI0LWC0VSHqVkZNo01uDgFnElBN1ode1tHZ9MdKxUEU=;
        b=oTffnp8aRTCxE9p8rqc56C5cavtxI0IexvsOKNpv/KFzNNd4z/RLDqQc6omcmNZvol
         FATzp48uYDvxZOVe1wiSnw0eyQ2YlmkvOkzNsUh0jgR+M7b2GjkzfCiOgeWSuPrvCQA1
         Afj1sMFoeRe34CNYpuMo99tJMM8nuFcTfK9yJYkD0KZdenbdVcZKlymIq/wGuIXXeVXu
         RmO6rBGvNJKfisCH5YT51NaIJcMoFHA8ewdcYoelxOSJ5Llo81qgEUJvbxxOKEP2QQ5R
         k6nJm1rRM0HTjoViXmjZ2LfWneyjSSI7EzMSBUeBROlUakxPNQwa/GjgUeL1+BTMkus0
         YsMQ==
X-Gm-Message-State: APjAAAVEcRIqj1rkouylVkKbU9I2Tc7Jv29bXBtS4gZob5lCQtlUsOQX
        RMFsHFJ12C0/vLbHhL4Z3Mg=
X-Google-Smtp-Source: APXvYqwDRUUMylF2W3mAi8ca1A6woe1XWe+7RIuT4lMynVU9COkibJn7kg+f6DD0sSr9neg+5GoAgA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr20181516wrx.136.1581933199531;
        Mon, 17 Feb 2020 01:53:19 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id h18sm126379wrv.78.2020.02.17.01.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:53:18 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:53:17 +0100
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
Subject: Re: [PATCH v8 18/22] ASoC: tegra: Add audio mclk parent configuration
Message-ID: <20200217095317.GB1345979@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-19-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-19-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:23PM -0800, Sowjanya Komatineni wrote:
> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
> through Tegra210 and currently Tegra clock driver does the initial parent
> configuration for audio mclk and keeps it enabled by default.
>=20
> With the move of PMC clocks from clock driver into pmc driver,
> audio clocks parent configuration can be specified through the device tree
> using assigned-clock-parents property and audio mclk control should be
> taken care by the audio driver.
>=20
> This patch has implementation for parent configuration when default parent
> configuration through assigned-clock-parents property is not specified in
> the device tree.
>=20
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Sameer Pujar <spujar@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  sound/soc/tegra/tegra_asoc_utils.c | 68 ++++++++++++++++++++++----------=
------
>  1 file changed, 40 insertions(+), 28 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KYo0ACgkQ3SOs138+
s6FPPhAAi7eQ3lWrIh/IfkN95y7YA83xL0PKdbWrernTM29uQP5zvJXQGHbJBo/0
nOS5opl055+kZw++4ZblDnPLMxjXCHz8675b44cJtgB6sHVEOsBmBAc2ZOjliUPT
UpzLOCLguBGrxUSxGZ1+WmD7uzuupFPtRrtYI5VnT+iQYhDdOi9Hxd0f7O3URrgl
bA3xCc6tshoco6AzBNulREymKSzmPqd+sMXE4FMZgRrCAl7fhXwIgkNon74tZX3T
d96Oc44uvY6BUulCS/euU3gJb1GrnUfknIzf0uOwP9aODREre9bov6z65zKZR+Vk
+a4w2gcy2i92oC6ijX7hmgWXn5KmPSnloEqQcFo24yrU57X1tMTBSIcbizXYUZu+
XkKwbdPiqJKoxMSI5evZtC7jRQYpZ6MSbfT0aDNKKn5XQ1ucjXmblwRkisr9hLj3
iyrfGc6DdnIKxAnYeJg0YZUswbixhiUoQU5Rzz8HadyYYFvo5XwTCRuv62Pw5VwL
Y1E/B2kDk306VwD91zHMRkVq9Z4nSXLiDGXjJx7KQuJe011CnEUpTpE2y1BiEuND
DSgETznHyi+ngKZY8nIWNan7uBOZE0tN7wbFHXRPlIhQlIYrLHBFgqB7S1giA4lL
O6p8sdihYgMRnvtMgBSBY5G6Ov3QlGIKh41HiqnEuOsF+mBlGsY=
=5hey
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
