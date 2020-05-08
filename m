Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A8DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D604F2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW2aHJLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEHLPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:15:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ADDC05BD43;
        Fri,  8 May 2020 04:15:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g13so1392015wrb.8;
        Fri, 08 May 2020 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYVKyLBoNazrldB00m19zXIkILYKVcaKghSKl2P2ohk=;
        b=XW2aHJLA6Mx+PiVTSct4Xp3IlQ0EtB/u43rWDJ9lX7/I5B0bPPdp0s1Lx3tJ9p3zOD
         5xJy8jDID8S1mZb+joNkFZhRrYepAd9ak3YTc3fKx4Mh/PUGGwdhD/Z0yA45iycYNHsJ
         wE2trO0TyuA2EqvESOWjNI2leIv9EhuIvWFdZaeZF3fbj9ZEnOfZr93fqTIV0Gs6LGqo
         /qzEn1PmaiZWXb1bacZQhqHR9hojXlV6slthspVatXKk/SAj6FaiUWZNsLTHeFWtknES
         xGS2dpCoa2iyZco/HzDzqh4gKqU8D+CB6E8d2sNdcrTP//p6jlx6OT5Qdk7ERUdBMPoU
         VAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYVKyLBoNazrldB00m19zXIkILYKVcaKghSKl2P2ohk=;
        b=m2a667IQgXLd1vvB1k7KyF0WbHi7MMuXnjOTG/qRpxcerZE95AliIDm3Tv98Yss79g
         CKlPuT5EoNMSSRV3UM9yLCCBdNEOKpSbAw6TWXRe5a3z6/Wok3nfp6q3oxwa+kw20MaL
         ARdqsVguuThCuwoEk/9WpHlvnLPoax+jhhFyBPNaFvDXIVNUrxo/BYxHixDWUASEG3Bw
         9zB3Y+R8mDLcxziE5dnwmWL4Il4nuY+qYpS7QiE5bWTNBAwygSnPNreSvHRo+xRUo7tL
         JjPmJl6ijHPZO6Ll/4o7Lz9ebj+sKcXfJiG6J1Ymh+t4q3vFLBx2kXYFzQxu6BZj2Kn1
         TlpQ==
X-Gm-Message-State: AGi0PuZHyHWLXeQ7Rm7pGdv/ZvO1wCR+fAuL8AyOml2/mJukUidBxSx/
        kw8RRZDrXWX8nwA7A/o95Rk=
X-Google-Smtp-Source: APiQypIpsDAj8HfWoRBDBp1VG1Dv4CQ4hSbll1vTO2j1vgMnnhkGXrmVoOXfzOZzSbK7QkjjBt0e1w==
X-Received: by 2002:a5d:4b4d:: with SMTP id w13mr2528537wrs.178.1588936516876;
        Fri, 08 May 2020 04:15:16 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id k5sm2308675wrx.16.2020.05.08.04.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 04:15:15 -0700 (PDT)
Date:   Fri, 8 May 2020 13:15:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: max77620: Use single-byte writes on MAX77620
Message-ID: <20200508111514.GA3034899@ulmo>
References: <20200417170913.2552327-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200417170913.2552327-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 07:09:13PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The MAX77620 doesn't support bulk writes, so make sure the regmap code
> breaks bulk writes into multiple single-byte writes.
>=20
> Note that this is mostly cosmetic because currently only the RTC sub-
> driver uses bulk writes and the RTC driver ends up using a different
> regmap on the MAX77620 anyway. However, it seems like a good idea to
> make this change now in order to avoid running into issues if bulk
> writes are ever used by other sub-drivers sometime down the road.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mfd/max77620.c | 1 +
>  1 file changed, 1 insertion(+)

Hi Lee,

did you have a chance to look at this patch?

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl61Pz8ACgkQ3SOs138+
s6E+7A//a03m70gtgZGEknOoNZ0CgU5RIPvSY0ARoSLPdVfn3U7lymln4Qozoqpd
fG1juRJx4/a1rW2kKjNrXAGtp02I5UMyNH3gQ++Hv+dHKOzQwS2daqpFYBNstg52
MxfQXZGeCY6itzefnnQOV39wGkRLnPnDWdyi+KvPj+AxTM0snKT2CplhcRLNrFIO
08IF7EQgO1I8pQxqggbZD/PYyFVEMql07N4ngnNw+ffdvwKa8tBrE5XN6fkkOXZY
YbNGJuR7CznCYwwgEbG7lg232hKHuTW41e9M3NBvkWknIeLCHcWdyUNYQYqYQ4yC
Olbv/CbVrS1UxDgOQHT/v80MI4rIYgMBDqu9uTZP8kp5uG2kc67RiQopaA1y1trP
9zXIBR5m9aA8KcMQtl5QXXbFMqqSgeuBPsKAmIFknufJjCOiJYD0nv/f4ZEEKcBL
eW48OH5LbAsmU82kBEO+UvL6mcH/Y0a5q2cNhmWvCx5bWJUfOfkjgRAcdIQzUW8X
b4qPznmtylujpafCIT110QwyThH6sOXocJwJkvybAWcD8JJh6Lux6kH73IDWbH13
uDOODx1CxRzhJWf0Qy75sVEnwZKSlhneb/AcjVD1AxvHfN5sKJGIHqR8mrOGddJF
qQtRSBX8eBXMIqp3E+hOq3ZZy7YYDXUDJhrSw7Icgu7Ews6N9vQ=
=2rKA
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
