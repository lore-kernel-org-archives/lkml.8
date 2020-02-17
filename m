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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6190C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D36227BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoAIqwcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBQIiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:38:08 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46487 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgBQIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:38:08 -0500
Received: by mail-wr1-f46.google.com with SMTP id z7so18505719wrl.13;
        Mon, 17 Feb 2020 00:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JwTh9MgBK1a5/EITjoip/IqcES2oRJq3oRe3+Cse3Ig=;
        b=aoAIqwcMGtVqE/eiuiQpdiI3W+N+Vtw+Qm/b+/Fa6gAevYUOW0QREkzBxzbgE4DofX
         pKSQSlTd2hfnxE+2deqHP+JeFwYgVrehyTtoLvvv1dsxfqnsK43xGukLx3upgWTBEvwT
         jhk5dsZzdNfb6K4s/e1vlp/rXen3xQINcH/O6vQcbu/Sy5mn1yJoZUV5L+StHSVXelmJ
         G4US9rU1KJ2KyDIhNfQnlFBHrjJ3wKzKzUHPo1hgaHfiRG9padZipOlgMR0TTfDHaBA4
         4bm9hpgx/9kkX73WqpV5DygRj8qHImlaLX3q8ZHvCUtX5BBiYvRWmBSOoOaa4pNyKSNV
         G70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwTh9MgBK1a5/EITjoip/IqcES2oRJq3oRe3+Cse3Ig=;
        b=c2rHPqVGWAM50mE8XKJRVsX48RCQFdY3mk+zv9FttKPJmiqRxxjSVB/BlnYoTHDSJy
         TUgSMNNHxnSCySyMzzEQ4AhtjxFgQ/8i0/2j7dVwEyAJFGiRHbwHR+Wi7ibo00NtHUcs
         KCj4XOgfBG7YIil+kITKp8YTSKlt0WHHOHaAeHWDu6FqhOK0Y0qyBQY3iasueixXHv3W
         EIUUVp0SjBarIg7NRnuv9UKT2lK0cEVI+HjUyS3SGmGH+PU+Q+fwm96Ji5/bKRGRk3qC
         LwRkHhFWiBW0gYdg/HKYrDcNYJ9kZL/xdeVEArtRcLuSmfyqJPzDEOT3ZbW4gg78Vp/T
         eysg==
X-Gm-Message-State: APjAAAUkcldeIhSrIikrRsV+Xdo6vratP187p926285pahztEaZnm4fM
        kPn/w5zMERFvkD+W931C2kE=
X-Google-Smtp-Source: APXvYqyykRoXlZxMG+bMa+Rcs05bb7cKa9RUylmRaMdwErsaxL3jHiJJtwAJilv/DutqDYeCUAd2Og==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr19969057wrw.287.1581928685455;
        Mon, 17 Feb 2020 00:38:05 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y8sm18934605wma.10.2020.02.17.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:38:04 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:38:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 09/21] usb: gadget: tegra-xudc: Remove usb-role-switch
 support
Message-ID: <20200217083803.GE1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <1581322307-11140-10-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-10-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:35PM +0530, Nagarjuna Kristam wrote:
> Padctl driver will act as a central driver to receive USB role changes via
> usb-role-switch. This is updated to corresponding host, device drivers.
> Hence remove usb-role-switch from XUDC driver.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V5:
>  - Removed select USB_ROLE_SWITCH from Kconfig.
> ---
> V4
>  - Updated device_mode variable with usb_role and remove role variable.
>  - Removed debug log related to always on.
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 58 +++++--------------------------=
------
>  2 files changed, 7 insertions(+), 52 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KUOsACgkQ3SOs138+
s6E+pxAAjij1EkuGeJ/PrsnWFIzGxqC2hx3tx1qdlArC6SLmUZDLHbjf30ywoYAy
jJekzHYN6r5lYfVE3HmvsJogBCqRowQYp3Ld7rKzOZdDzCIDVBz9v6r0IJkLYfN3
Autd3TnAI3klGZ9AW37rACQoGVAmcyydsXqdNZKotM9A/ah6/GKZ0qNCPSuZSnZq
4Nwwa3XENQquhGiMd37CbH7MeVgoH2XUsN9DBtGB0t4NNvqV44WPDmy4ExjBj+M2
XZ1chP+ul8n8AvZIWf23QV5mpR3otgCYv8+Aer3tleejbBcfRqDZfroXgahqHCA8
rE1z4ysvSvZMsnh7tl65aFvqxZOxjR5y9ew5qhVqWoqqyKVJJvhNkjteJ2A18BkM
X70TVdZANAcKldv3Az9ojFToCMWevo9oA9ESqz6aTUMQbExD22D6X7Pw2iTFL7pM
0njYV/EM/VH/dsVUg/wgfafpjwJORsmAslXpdHSBN6JbVk2W2EngP8ZHU2lZb1pR
BRwZQCbTA6ZQhwL7tJb2oNpK3/yNz4tgmIkcNCZlNYTekn7QfMWecF98JZKBONYH
ONTmlT/jdbI+UmOYV7TeJWRlhFilwki0hy58374sFpH91bhuNr7mY9yQWEaonjYc
FGearA2eaxKwp8q6OjbHFnymA5KRrU9QnAt2tP3+1DTuqKKFOTA=
=SV9f
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
