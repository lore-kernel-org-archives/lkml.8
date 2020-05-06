Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E9C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98022080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDs0lNMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgEFRNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgEFRNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:13:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF99C061A0F;
        Wed,  6 May 2020 10:13:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r26so3622613wmh.0;
        Wed, 06 May 2020 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GNKW7Nj5sqqTflAX7xBN/lqrOeNoUdudCj9pQHf3RMg=;
        b=ZDs0lNMpexah6bbEgwbPxd4LeMcR+Qm1BK90fPCv/D0cFZxwt2Grs0fvEDM9Y5Zt/y
         /8J4uGB59bV3tf70QrxXdzJU/OFwxMaso4PzHBVPPBecQv9ouM1SYY4mROlJA4j8BE3h
         woJK0P/yuvSu4GaZhZqrnGfrQjmtaMmbxPb63jGfukM2PR+zWh/eAVW7xOTekYW+P7wn
         OiGRqrHDi5UJXBQRSL1LAiGJ7QQ6dnxkAPXUwVAb8yNHflAQxIEGumUKMj8sRymzXJyu
         yHDy/Jxn5FydMZAej+qOb6yND7AArqQWv2AVBE0cyJeVxfXdvMocKXlNQN5xnS1vMACg
         fVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GNKW7Nj5sqqTflAX7xBN/lqrOeNoUdudCj9pQHf3RMg=;
        b=TGdBaV7icU6xBlgsysgf6cPWubLBZG/DExQHbHoCnY+agXycQzmwq2la7DxcOsKdyF
         I1k9ewpyeVy81pB4giG6OADjYekgOq/u+iOP9jAcMLIm8Iy/NuQ6SOZTjlRFBdZ91h/t
         oF8VALrwy4OUew5o6LCpnUVo8kN/FesH+BNB1taA4jZaMYgBxOqVTKcD8rVH1QPd85Zl
         jebAX/QNmpukxaQCqjx/71Ujvi+H2/C2ul+jbieA9/VRbR2LdSCjia/r9uVDEsY4LX4y
         IOfHTm0/S/yoPUxzvVLQK108WognAOoe4waWFByGLK0DXjuhHMGvODB+xXBlH/egDgAf
         oKNg==
X-Gm-Message-State: AGi0PuaOnM9Vg6ITuK8ucS69Y2vG7Edg7weKpyfkcuo+uqdKt3qTmW/g
        8DkXF8VJYPArjA6k24TqJVxfRdevABU=
X-Google-Smtp-Source: APiQypIi7fdhqbB6pSzfRPoD9/lP54yHlUzEC2PyN83Nmu07s3nwp1ZMpJxcpIjOp08BCiP9Vn83LA==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr5497369wme.20.1588785232026;
        Wed, 06 May 2020 10:13:52 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id 7sm3844106wra.50.2020.05.06.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 10:13:50 -0700 (PDT)
Date:   Wed, 6 May 2020 19:13:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Fix idle suspend/resume
Message-ID: <20200506171349.GF2723987@ulmo>
References: <20200417170537.2540914-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zs/RYxT/hKAHzkfQ"
Content-Disposition: inline
In-Reply-To: <20200417170537.2540914-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zs/RYxT/hKAHzkfQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 07:05:37PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> When the XUDC device is idle (i.e. powergated), care must be taken not
> to access any registers because that would lead to a crash.
>=20
> Move the call to tegra_xudc_device_mode_off() into the same conditional
> as the tegra_xudc_powergate() call to make sure we only force device
> mode off if the XUDC is actually powered up.
>=20
> Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device m=
ode controller")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Felipe, Greg,

can you guys pick this up for v5.7, please?

Thanks,
Thierry

--Zs/RYxT/hKAHzkfQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y8E0ACgkQ3SOs138+
s6EAIQ/9Hu7iv4+5FnG2vFRCAbaCleabiFAWeWUg7kxxWd8ya0y/UvD/3YOsNqLA
M7y32t2KlQYcrVGIpryz4dyEtQtyCcibtd1uMbm2gLQWEbjU6KvxlX6siKyIk3dI
rxneQDTjUMToGhdIEuLAuJ5En1c9qs5X5STZ2kW6OdzQMoZ/oMPmItTBHwxMJ+FR
+jyiCA9sDwEwzSWYQsFqOlwEaZ2SoboTfcnSobx2nhvvJh4+MBl6rDG7iMmGt8iA
fNMl483j+2tpNDbkd+YJHlINeemTyJvuCAV6eGGlpcjPFd6yabVLY9tqyEE+X/6b
JjHoRA66q7FiyXeB7qg8ia0zJcVjKgP/Xc/YgZ+R81UdTld6f9OAkVvWqXX/MCSX
Lgq9MFEv+anqrplOyZc3TEx2108yxoxTEuAhoHu7uIZC8dMACgSlZeh/fvxJqlLy
GSciiTnnhl3McdwsWvDbCxwO4s83GsdndBTSBuPEY9P81yfqt7u2+/LWjHO0/6WH
s5LIirh8cLlomRymzszh9j64wVvaMHMxBDtUaJFg9jV13pPoWto50es9iKMJ6+Sk
uFkEMERPPWBV+6h2EpXjy9rzDgAYJ39h2iHUAgAPpsns9j+zhnXXOLlwNq9wJQ44
DzA3RptRzkZiOCXJDI8bNkAm1kQoFiO5tkmaQyzSdV1ynEl/+p4=
=qWY6
-----END PGP SIGNATURE-----

--Zs/RYxT/hKAHzkfQ--
