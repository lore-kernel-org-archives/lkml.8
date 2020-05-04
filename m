Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50577C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D28C206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVUedMQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEDVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDVAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:00:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9314EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:00:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r4so390751pgg.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I6H13M7NC/pnWpn3HyPGpJ1fI/ZFJ77tiVfWu3eCvzg=;
        b=sVUedMQbwmk2viz3tYh78sUuEQ0vMwUPfMeeFNXoe3DvCmTfUEyv5KPfIaVP0OhhIt
         8Rc1H9lxgdKWWd7aWK9Eete49hK4i7QyKh5gzZ/rbW1YImwFuT1AVNbv+Ksr7V5Lp0Wx
         9grTa2yVXoTy3P4tckywaQ08ncy6/macZRay5KPvGHLIDX/8rFaIgJm2tgbZzQJ7n4oQ
         dSyTyG+zF+MvvZyXCirA9sGrMvZ7c/Uc5La3jIWeD0eBMLbRowub9iR9EJXrTq+rjd7w
         luUrQbdNBw3icVUs/3tsn5eGqLk9k2oxAc0XOwbKL1u2EEV6kddOsa4H9qE5HAjHpfBU
         /ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6H13M7NC/pnWpn3HyPGpJ1fI/ZFJ77tiVfWu3eCvzg=;
        b=kD3iF0tStOGp61tEqFMQlcMiP78a6Xl92nge7BBgJbz1xeFuM1gP+IpH1At5BHTqiN
         6K65U4oQb0X1KeNE84WlcI04UpOH+XbV/KQk041aOw8tIVD6M1Ndupt7kH1uPSKdMnRj
         +QDGRrDuxK04tNsq4WS8IECTicnmLpi6FOrJV7UTcUPTNdY+KbmkBHi7aJmtWOvkjNjb
         Cf/vFUIeplzXt3j3uRwfmEbH/0+P2k0kMFqT5jFS3LLVWHMtJLuVzsWIMiQbRZjBjE6D
         X4wdUEPnBZzo8xsdwZNt6uWdx/+VJbR0Y29e2OQGAlZglUCL/I+ZxFxfy7fbHFg62Zdb
         jQGw==
X-Gm-Message-State: AGi0PuZvF1ILebk68echKwp+q8uf/nmLrpke9c/81LZUHT9McBI6q/yq
        WYpcshJuMaM8WZCzVD/MhG/w8w==
X-Google-Smtp-Source: APiQypKIwMQ2cmCq2OatFGRT7S/CRUodXEKhVRvliUqq7cRyvTNjBw4OnuCgpUpsCA0tIrs6zGLvSQ==
X-Received: by 2002:a65:498f:: with SMTP id r15mr94129pgs.345.1588626010476;
        Mon, 04 May 2020 14:00:10 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id a7sm9718272pfg.157.2020.05.04.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:00:09 -0700 (PDT)
Date:   Mon, 4 May 2020 14:00:04 -0700
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_usbpd_logger: Add __printf
 annotation to append_str()
Message-ID: <20200504210004.GB102727@google.com>
References: <20200414201239.1506922-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20200414201239.1506922-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Enric,

On Tue, Apr 14, 2020 at 10:12:39PM +0200, Enric Balletbo i Serra wrote:
> This allows the compiler to verify the format strings vs the types of
> the arguments. Also, silence the warning (triggered by W=3D1):
>=20
>   cros_usbpd_logger.c:55:2: warning: function =E2=80=98append_str=E2=80=
=99 might be a
>   candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wsuggest-=
attribute=3Dformat]
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for chrome-platform-5.8. You'll find it in the for-kernelci branch
very shortly.

Benson
> ---
>=20
>  drivers/platform/chrome/cros_usbpd_logger.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platfo=
rm/chrome/cros_usbpd_logger.c
> index 7de3ea75ef46..d16931203d82 100644
> --- a/drivers/platform/chrome/cros_usbpd_logger.c
> +++ b/drivers/platform/chrome/cros_usbpd_logger.c
> @@ -46,6 +46,7 @@ static const char * const fault_names[] =3D {
>  	"---", "OCP", "fast OCP", "OVP", "Discharge"
>  };
> =20
> +__printf(3, 4)
>  static int append_str(char *buf, int pos, const char *fmt, ...)
>  {
>  	va_list args;
> --=20
> 2.25.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXrCCVAAKCRBzbaomhzOw
wvFAAQDpxP+AJwzAJyQ93hm+19rLTbF39gjmJiWOssobatSetwD+IbIlGF9F2F68
VZsBbrCHv98+t9VaK+eTihVeTEPpQww=
=pIYl
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
