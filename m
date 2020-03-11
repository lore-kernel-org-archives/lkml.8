Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D81C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D1A20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/xX+dGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgCKOiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:38:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgCKOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:38:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so2376428wme.1;
        Wed, 11 Mar 2020 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IlF8vjliItStxT/wjkL77PBDGb3h75JlHH9lrCWsv7g=;
        b=a/xX+dGk8qG9dJT0zL2ydBvoiWjouFszn+yYzln3gWsVfTFuTOzoA/iKMUxUUQ65p1
         MkkBGNNdb40Nqbn1Ds2k2tJHD+9fgUZtfNtfVl5KDitE1UdnkybGMZs3VEjI4hyvEoD3
         aieTv9AycjqQKOai/utCiHvR4BFoBWzmZXHgq04w+UT6jbx/Omk2KdMuLxDtUMMGL7Kz
         t3jIIfycEX37PLVzKnoe3BSUGZSkVP+BmRX5385zZxGNZ0mkZZsgCPaxLAImo4Sf0hRt
         ky61nji8UhJ4rH6iysQ7Yba4zqPUYViJwljVVN4u3yJ0XfCo534DoBScWunJVYIzswoK
         6QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IlF8vjliItStxT/wjkL77PBDGb3h75JlHH9lrCWsv7g=;
        b=gK+0ud4X77DLf7U0WNcUB0xFbWAMj1mM3aG0lFkvoDV8X4oKpnQjF1v9WHu19RDdeg
         yfW0XC9MABIXpJoJYbutwHWKHFxbBvv8CiGVPHyk95npo85KqQHsFd1js8WfKM/7SfXw
         eauCHbwRlk+2uW/EqkVZQDJcL/K+T88OYbFtMxlFivtXxnFnlGshdrytdN/wMuJW6jgd
         4lSmI5m2e69QKO9bsSe8Q6fTqcpG6z71gFLFOoZ3HoQttCl0Itjs5XY1qACtsQjip8Mg
         cSzzzo8jIA3OZWT8uKPSo5HBQpYLPpvnP68JQ38FLdgoOR3dqx2jmmsmu0BEWFT4B/92
         UnJg==
X-Gm-Message-State: ANhLgQ0aHC0Q1a1Fs/pu/4+4zq/T3gh1rFx+sRswLVN+FwIb4OI/O0at
        h1n4LIG0PxpvYI//kfRWL2n7Zb/Z
X-Google-Smtp-Source: ADFU+vuCH5zFJfC/erOCWEF28PPs9YZ/845sNE9/1798jBMHK7sfbsYetQ8tFwb8XA/8esL2KHJ42Q==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr4213927wme.117.1583937475882;
        Wed, 11 Mar 2020 07:37:55 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id o16sm56960179wrj.5.2020.03.11.07.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:37:53 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:37:53 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/21] drm/tegra: remove checks for debugfs functions
 return value
Message-ID: <20200311143753.GC494173@ulmo>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-11-wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20200227120232.19413-11-wambui.karugax@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2020 at 03:02:21PM +0300, Wambui Karuga wrote:
> Since 987d65d01356 (drm: debugfs: make
> drm_debugfs_create_files() never fail) there is no need to check the
> return value of drm_debugfs_create_files(). Therefore, remove the
> return checks and error handling of the drm_debugfs_create_files()
> function from various debugfs init functions in drm/tegra and have
> them return 0 directly.
>=20
> This change also includes removing the use of drm_debugfs_create_files
> as a return value in tegra_debugfs_init() and have the function declared
> as void.
>=20
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c   | 11 +----------
>  drivers/gpu/drm/tegra/drm.c  |  8 ++++----
>  drivers/gpu/drm/tegra/dsi.c  | 11 +----------
>  drivers/gpu/drm/tegra/hdmi.c | 11 +----------
>  drivers/gpu/drm/tegra/sor.c  | 11 +----------
>  5 files changed, 8 insertions(+), 44 deletions(-)

Applied, thanks.

Thierry

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5o98AACgkQ3SOs138+
s6HZYhAAkiP6QpzzL7CdD6Z9Ope+DJuC3IiLOgXlUk62gu0rPNgHNHn8qo6QoLN9
lj+yH2lxtBKcNjdbWhbwl7Y0kPcF/NnaIwlNa0DXqeOibQ/25kwTxEUVGLjui5tr
tfuv80lAwAiTBMdkt3j/NYVFAPn593+XIuLTxpmWp1lndf6JJ4q6f7x7oWLKyH2P
4GUNrcGqLjrEvTlL0kSrcnSFt4Lj1+/E/L8S5TduQtnFMJdDX1cRVol9bsFtaYdz
NWKixSEf7MyNXVhSDqAQq6lKd6+MQtjjfA/nBrY2g0dxmlwhKklYcgdsO9RVHnK8
ChFqVsMcu4ekbblHTgZ9aUfsFlR2SsFBGdrXgjXscf95BhK1LeZtkLFHZwSho5jW
25mvVeY0BBCHDzvSdhLBt6c2ib2a3KGTwm0geLuWlEczczQEkyNLYRpESCARrNHx
FGtEQR30sVzRvnkBl+35xthXJ1/d/vzYOkbxjgAgYfBeK/H2NkJQuBxNaolkvTuv
fcQ7mqY71PLwYX/fNtVx9nGxcswa5m1FYxz4NEOykTr9bJIsjyP9gph6nb6zaGNh
mmN74mDvLdyvMZpdOUYgqLkf3bh9I43fECfrpnxkjVRrZhMDDfIVA/I1pw2ChqNQ
CaF+O8yIQIEWeNi/kyamiROf9Pzsyo7ov3RNnk+5t7W34h/+k1k=
=Kgul
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
