Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37D9C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E64720735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGfG3VUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDUWPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:15:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C1C0610D5;
        Tue, 21 Apr 2020 15:15:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so101019wrq.2;
        Tue, 21 Apr 2020 15:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvv6tja4Yk+eVEILjZRBST0jDGm4v/FbXtO/ZgqjM74=;
        b=RGfG3VUURFNtWc+VoPO9NVYyWunzCVcQA22ux57ph9xyOtZCIvDPzw9sG3NnSGWdxD
         DPxCABohIZKsnwINyit+tsz4qVL9lf3GROmiBgEHtVIHUrKbEIzp7MpwzW8UzCdZGjhg
         y4W7IgEX7maGTmX3ZT/8htQG30zvyLhaa5YID/wDuygZsqAKn8tWqq1Z1wepVZ/nDrcK
         Qtpdy5n2HknWu2HOGkPt8OJm9dDEQAVruqBXFcwsEqG4HnbTZYsZTVBakz3vVsp/neKL
         arxywQi8oxwxeEbF6c0r38sd+Iw5WYhlpzMfnCqVQIa6vybC6rrQEz4h1t2qrmJzPjzv
         38og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvv6tja4Yk+eVEILjZRBST0jDGm4v/FbXtO/ZgqjM74=;
        b=Ry1gipnDDjnD364YixM1ntuSfVqzdFID00rAVh7uQk60o2WT322DiamBQKBiqmGEAC
         iURyNuHPXy3aOAeBTm59DoRUer/kuXi4FjSChUe34dNb+Spq7/6qRIhhYx8f2BBScS4z
         /XGUkTSECaLpL8Nvc9QMNH7nSvQ6c6jtZozu5Awshmjc3teVHmywgAGAagsTpZdW34r3
         LvQT0WmScr/MNRNZVjU4AYOPMKxUOIm2x44TcPHFU/bYhKUkli7fgAGjMj1Eha5p7y4D
         UVEoaLrCUABEE4Nqp+A63fZI/Yqno7QtPnKXqKvXxT5owl1A+VYGWj+/gqakr7JeuxnJ
         71mA==
X-Gm-Message-State: AGi0PubIKOtfSaBzjFAuwOmeF5W3J7QBq0VG7tbj45UYXdfqsHhD+C3f
        ZgMyFG2z5QV0iOY6251PCDvF+ue0
X-Google-Smtp-Source: APiQypI5TRVNGnBxrY9Qs5LadawigWas7BSd7e+LErX/pZCbbEu2ZW0JsegsVtN1Jl5LDmSdi6pjBA==
X-Received: by 2002:adf:df01:: with SMTP id y1mr25888894wrl.401.1587507340215;
        Tue, 21 Apr 2020 15:15:40 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id o18sm5551756wrp.23.2020.04.21.15.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:15:39 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:15:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] soc/tegra: fuse: Add custom SoC attributes
Message-ID: <20200421221538.GB3445172@ulmo>
References: <20200417123949.26288-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20200417123949.26288-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 01:39:48PM +0100, Jon Hunter wrote:
> Add a custom SoC attribute for Tegra to expose the HIDREV register
> fields to userspace via the sysfs. This register provides additional
> details about the type of device (eg, silicon, FPGA, etc) as well as
> revision. Exposing this information is useful for identifying the
> exact device revision and device type.
>=20
> For Tegra devices up until Tegra186, the majorrev and minorrev fields of
> the HIDREV register are used to determine the device revision and device
> type. For Tegra194, the majorrev and minorrev fields only determine the
> revision. Starting with Tegra194, there is an additional field,
> pre_si_platform (which occupies bits 20-23), that now determines device
> type. Therefore, for all Tegra devices, add a custom SoC attribute for
> the majorrev and minorrev fields and for Tegra194 add an additional
> attribute for the pre_si_platform field.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V2:
> - Renamed attributes
> - Fix checkpatch warnings
> - Simplified code by using DEVICE_ATTR_RO
>=20
> Changes since V1:
> - Exported individual fields of the HIDREV register
>=20
>  drivers/soc/tegra/fuse/fuse-tegra.c    | 54 ++++++++++++++++++++++++++
>  drivers/soc/tegra/fuse/fuse-tegra20.c  |  1 +
>  drivers/soc/tegra/fuse/fuse-tegra30.c  |  6 +++
>  drivers/soc/tegra/fuse/fuse.h          |  8 ++++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 10 +++++
>  5 files changed, 79 insertions(+)

Applied, thanks.

Thierry

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6fcIoACgkQ3SOs138+
s6HqSQ/8Ce2MbHuw0lLNqNQYqrIExlw4tXEFdJYralJSe4UYsJgrw6YODCCxwL7N
IyMWNAD4w0zw1dK6bIOiwRfI2hx6UzM3W1j2868X/qTvureTJ8k5fGMFqA7kLM7h
5iTNjwtT/IWpBXU0sVO8hQuHHh8PWV9PpgU1ALUWQzekbSuo8Xd8jJzwWyYcqpn9
C9zCxa71Y6+mzEVHoHby0NSBMmhHl7bLcPkGqrFxySTWNLm9XtNVxkd9XXfKd5R9
iMffnZCL0Y2seM/Ug+axHu8hdqU+VXbAHdwxHAI6gSFmzx1kVQdM6iamr8bu0kkj
7wWWf/Pjx5G+y4VKFp2peGW4GIqmOUkJpvp/g1hC7gLztCyZ5mOdCmhfWLLogpG8
hP/nuaHaHADwY6s5YbMfjNCChyuJJMYTjajcpAVcvK6WzWbf8J9A+kI9AlGyOtBn
0cT4T1DxlJc5hf0TfJzsiziEDp0JQk9UhYZvfyxDlgY2HcvfOC1dYGAGs3rkOzOr
muXUkg1MF9p4OrQxoVpxqIQqBQZ5LisbnMg0nfaWC/fMoEIovM4iOlRfzere45Ln
WNAbLB3Wpy3kXHVIbmTTbovAslOpv3+3+pZ5GgOpQkdqK4XLgW3d2F8D/5OFs8JS
lpHYnosUl0zJPdr7RelvHSovvZrl88g+MDSDtO7SZpUjpUCZNss=
=huHJ
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
