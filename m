Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC2FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C2C2224D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596809331;
	bh=K0XrycCGZNDpmN/bowny8Gm8Al+jWDrojuWO8+J3LQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=jWJgQU3FW02pTIRmQ1ljSAyYXPqBMNvqu7WzRMH8RSjG/CBvHwCS8FOuS39KdyPaN
	 XqhQkDaQI5akZqXtO4UJ63SC93EupL2yOmRyQbpNwIYOM/mL5GcMd6cQ1VdbC0t2RM
	 zIMlCes39QkT9cusWhXSJ3NqeNp++Y9lUDOWMNVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHGOIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHGN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:59:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8AC061574;
        Fri,  7 Aug 2020 06:59:18 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so2282325ljg.13;
        Fri, 07 Aug 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=LlDfM7lfRWt2Qfq665Z9z/N/zereVKNRYo5Ume41bXA=;
        b=s20HpXZ5m2YvWnbApSNg8NgVv0sZPEJWvfd0maoB2NND3WBfda2ycvvSraEX0qd1yJ
         n5+oDa+fv7Smj6bZyRF0PNKXNMG9xQEGBmkWCMUIVAv7iKDcJuwF9yey9V+TgjhHuxyJ
         RE7FqLLk6MA2AoAy5Rz6dSJtG1CB6lHaYPlQPqLLdj80L6ocSwRzC774GhAWzk5RUsov
         L1oeIp9mg4XAwfRn77Y3c78IrKmpt8OO60YL85YsLubaw+d2jINv3GjTz8S6EoXE9wTA
         Jcti3skyHnnDxfm43Edf5yIp1ph+KPqSwAehep6RzX3Z76KJxLGfJOyaJTjgBtEHFboG
         VTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=LlDfM7lfRWt2Qfq665Z9z/N/zereVKNRYo5Ume41bXA=;
        b=kiCOFFbNClZqd06+v72GUsospOp79JMgZjR7oxv62D9hhQQt9vI6QBj56i63GiDmW5
         nFfUird8iwa5RTNyOM07KtrryNIfIge2mANg7FDt7IxYgmQJcqolxHI3DIXaGVvxm0Pt
         P8kIViluvY5L6QxofKjYTh3rOtvltPvvS6qpb7mobXXW7XqRGqvY0pLGNTyy+k4YQjj9
         E6JpgjqFWhVYqiSuo/D22lOkfhkf7qsGqFsvDGY3itfU4aoAfhEhGVg1pKkpREvpGVXA
         fcYpAOrHrjbX/0orqGhZ5fv/WpLJKInQLezGgtELZ3KpOYKkV6kd+ZfLjqXMl23iEFtO
         iIUQ==
X-Gm-Message-State: AOAM532+JCRCUHLVT82EHyOuvachY20z5eOG06QNspNGa4vB1n7EdCmx
        GojC4g7DKBw30M2HbUcqcL3CtVP5FA0=
X-Google-Smtp-Source: ABdhPJwdWQcHx6yEpnG5CUGETnHGJOgZ8C5g6CzctlmkDAQV71EGHREL5KMTeOqbXnBqb8mpESfiLg==
X-Received: by 2002:a2e:988a:: with SMTP id b10mr5901350ljj.26.1596808753789;
        Fri, 07 Aug 2020 06:59:13 -0700 (PDT)
Received: from saruman ([165.231.178.18])
        by smtp.gmail.com with ESMTPSA id h23sm4264411lfk.37.2020.08.07.06.59.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 06:59:13 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 09/41] usb: gadget: s3c-hsudc: remove platform header dependency
In-Reply-To: <20200806182059.2431-9-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-9-krzk@kernel.org>
Date:   Fri, 07 Aug 2020 16:59:08 +0300
Message-ID: <87v9hupnf7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzk@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There is no real phy driver, so s3c-hsudc just pokes the registers
> itself. Improve this a little by making it a platform data callback
> like we do for gpios.
>
> There is only one board using this driver, and it's unlikely
> that another would be added, so this is a minimal workaround.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [krzk: Include regs-s3c2443-clock.h in ifdef to fixup build on s3c6400]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Include regs-s3c2443-clock.h in ifdef to fixup build on s3c640
> ---
>  .../include/mach/regs-s3c2443-clock.h         | 49 +++++++++++++++++
>  arch/arm/plat-samsung/devs.c                  |  6 ++
>  drivers/usb/gadget/udc/s3c-hsudc.c            | 55 ++-----------------
>  include/linux/platform_data/s3c-hsudc.h       |  2 +
>  4 files changed, 61 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/ar=
ch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> index 6bf924612b06..682759549e63 100644
> --- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> +++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
> @@ -10,6 +10,8 @@
>  #ifndef __ASM_ARM_REGS_S3C2443_CLOCK
>  #define __ASM_ARM_REGS_S3C2443_CLOCK
>=20=20
> +#include <linux/delay.h>
> +
>  #define S3C2443_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
>=20=20
>  #define S3C2443_PLLCON_MDIVSHIFT	16
> @@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned int b=
aseclk)
>  	return (unsigned int)fvco;
>  }
>=20=20
> +static inline void s3c_hsudc_init_phy(void)

This should, really, be a PHY driver under drivers/phy, since the goal
is to make this platform-independent, might as well take the opportunity
to introduce a proper driver, no?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8tXiwACgkQzL64meEa
mQb4cRAAtKVS+QHFTU0k03XTqRPNweYAKDUlwxtRGzKb/zcmEFFF/mPd9Eq99Nd7
Wp82AoSPiNQKeHWUNn8WCRGpcGZoK8QI5+Y569PhmK562s8NHKrMkBZKgCSUPRB6
qPNpfUEiEcD5yKG79mnyq5IbOJUtS4zxby3NIxaWHZNsrxrscottVmUd9ip+XYqP
GJbpK7mut4VZcoEZYmcNZWG8+vnrbf+eWp1vCvCyuOeWMxVhoJuUiKCMV1HhISYs
JhJNBUtFinGRHgN8Ga4DUmQf36qLeDtccriwn35PrXgFOZbWPh4YbEQifZHwnE8h
wkkE0KVVrKwURgKfDshst2J+8IAHghfEuHdG7S4IsSvqL3EmE85dzB5PCug0Uq93
s72AlL9ued+ZK716gMzlVPeMJyyfXnSYRQNeyJ5QZvMD50FW+wqhIYI+Z3D1lEBc
asL4Y76t7lqK98H8nltZ9JrHZjXqj1o1msmsIzyvNuxDtSPQTWFQEwq26ljuGtFu
k1zhPg+3qziBgdEx+b20e+J41xnCIs7qg3VU918Z7rHtAgSA+rCEEiSH3zsJJ30D
NKg3Zxr05tu4KGSF0fTUp9Eq+yTyE8k7tjh8r2XpUK1eUM2b/JwmL/E9I1sh6XGX
5+mwU9Il/2+MWkhyKPZyJLFHW90HG1RzQDhGxNS8NyYywxKZ/9g=
=Vwlr
-----END PGP SIGNATURE-----
--=-=-=--
