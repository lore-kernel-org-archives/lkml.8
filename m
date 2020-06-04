Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAE020772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1f2NHBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgFDNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgFDNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:55:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2187C08C5C0;
        Thu,  4 Jun 2020 06:55:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so6192015eja.7;
        Thu, 04 Jun 2020 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+TkUabSV+OTqQPmnaL9a3ExZBKm+F57OQveb5MBEJk=;
        b=n1f2NHBDfOoCTWz5xazgoAelhZcz8WqQgan0vJaQhdpGXIncr67Q2O67CIuWwDlcEU
         De63teMiapr5RmJJV7ThJU4OBudjpG1waF80cZGDK0mTW2vupN3AyqEy/JyZI47xxAgl
         4uNy6ex5Fl4usTzw359W1lWYZv298CNpeFRhLAW8QtbsTAfFf1ITud1sr3RXuEk6U/eE
         MIlk0SzyriBsYeEYSZRkJeoP/KZpTr62uiP58y7OhTmbbW3Y7OwDC6PCQBe1qkTH/7c5
         KTrFGmaL+Vk5E0OZEFRuoXViYYdFt4B45cv8l5x86OvIS7LUAxOSc17Fcy96CfnuiIfI
         fnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+TkUabSV+OTqQPmnaL9a3ExZBKm+F57OQveb5MBEJk=;
        b=TpJMxfEt7trjLV6zI8tmjJZwxu6qFvbCHRiLDKXR/PD0bctCyCb0VHZ1qmXMTN5JO4
         /p5QS//Ayl+vsWxW4V2jBR9CYjyG8mLXXgbZ2xROUonwoz/bcpiGDpKJ3sMN/xi0J3GI
         M3MIoXUO0oaAjbfbb6LkjzFmH2qLlv3gk0PWJO8Jc6pUjDfRhN7RWXPDM8WhB1znwGZp
         5njm0xMnvqUcvVwZW4YQaByzhHdOZgWLoRSTAjmTVACKtpwfLYmjTSTYtE/9R2cb+NW0
         XTe/1s6+22RQxzmSdbaMTTVYWxBbuOpBGQDEVpxa7H9ucSLmGFVazrZRWRigdRJDODTs
         TMGw==
X-Gm-Message-State: AOAM5327uDBmOPPEP6CVqpDiAVQFeju4DG9owv7LbuLzzQg0F10l2z8+
        xxW2fftI+lC1cEUQ8DS6W4c=
X-Google-Smtp-Source: ABdhPJyGB3nhFNS0MjYNM3IuTC0eXcw7EzsX6Vv4WXlx4zaZ98U44I+4hGmciSv12vlatuCrC7Tstg==
X-Received: by 2002:a17:906:da02:: with SMTP id fi2mr4175184ejb.41.1591278912367;
        Thu, 04 Jun 2020 06:55:12 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id r16sm2320163edv.95.2020.06.04.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:55:10 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:55:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/8] phy: tegra: xusb: Add soc ops API to enable UTMI
 PAD protection
Message-ID: <20200604135510.GB1138399@ulmo>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <1589437363-16727-6-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <1589437363-16727-6-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 11:52:40AM +0530, Nagarjuna Kristam wrote:
> When USB charger is enabled, UTMI PAD needs to be protected according
> to the direction and current level. Add support for the same on Tegra210
> and Tegra186.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - Alligned function and its arguments.
>  - Fixed other comments from Thierry.
> ---
> V2:
>  - Commit message coorected.
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 40 +++++++++++++++++++++++++++++++++=
++++++
>  drivers/phy/tegra/xusb-tegra210.c | 32 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.h          | 13 +++++++++++++
>  3 files changed, 85 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Y/T0ACgkQ3SOs138+
s6ERBhAArocXmu9OV1jFSPMvJ9BFTXleQEoD8VMOD38H5LloSKgUbsj1YPVxsBQx
Q80FpNgM/LUI1+wffo+qpNM/OjUsdiRgT8ObsFq8G4LK4pQA0ng8VYLgX/CR6cfz
+B1GXGWdPIr5wSDOrMToC6jJjl9PSnetzJPfcG2d4iqm16dpw+jaQu6tP2utFJfs
GpWZs/pDjKiVnhvpPWnfWxS397Eo1iiWQA6aXMKYWu+YKuwd59ZTf6Cw0myWEIof
F5trIHYIHA1YU9cQqusNFmMvbYYvV1yesz8wb8AVSf+dPqSIoQ3J3h6bSnJfZFnr
xvhFjvvouALGYnqH8qwQXfGMUROPrD8CGQyCkR/VnOmwPRBnGOoS49xTreoU/92V
Bb/Xt0qeUVAA4l77MTc9ZstTJ36XdVQfknl9Wcv7K7BO0Bw6ly7H7RUfGNQMfRyJ
SxXXcNKDGii2hpM6H7f8Q5z6c11H4mrMGqcrDUz3m4q+K8BycVkoK7GtJcuHH9mJ
8wKSNy9m9rBFiqahOsuR8O4YN7bO1Qk6v7Z8o1XdkK6wCCQgsXmV1mezi1RpWw2M
ExUhv+6q7H/emj4U25ffB8yBNcz3WPFaE5uHDPacgnFJ29b1fgeivPu+E1pQlzny
YpQBzTdfsquRTqDPBJtpTSiIb2sksPUwnSkd8P2nVndg0pmWNMI=
=9yVG
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
