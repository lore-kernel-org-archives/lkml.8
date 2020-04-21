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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0998C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B79B206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl4K58Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDUWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDUWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:15:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B8C0610D5;
        Tue, 21 Apr 2020 15:15:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so58749wrg.11;
        Tue, 21 Apr 2020 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KCN4A8zZyT0LS+NTrRH68PthgzM+18/EfBL40whNNw=;
        b=Cl4K58IwCsuU8N1zvBwYQVbRECNrDKY7nQVOP8b4qIhI6fsPDF5yJvr0ZuawdmtZlf
         mhk2pdHWKZKGuCsr/FWEN0Kvf8piFzRdiVede1uYKd3/PI8aKpF6j10Cq3JPQl2NEEJq
         X9aZpXFSxAvXFO2e/5Fcf9FFPnyp4OoKBi2NVvfUgxjwnNE2c16IzfyTeJmvmvbI/k0s
         D1xsXMTy77NoPRDi7ftWiCSjotouKF5h9M0vORMh3DQFKCaa0tud1x6qXXBYG4pDo3aH
         NVx83+t8iegXK81HtEPdhShyO3iVzu2zjGZYPILEORUzFjNc4PCoSKmvVGBUdDhWkjMB
         686g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KCN4A8zZyT0LS+NTrRH68PthgzM+18/EfBL40whNNw=;
        b=KF/F8M+6lx2zKasd7v73D652ifCkHAn80++xFDv/fYsHzfj1ozZvSLfjYIMrBtQRsE
         hZ1fmnaKQchz4LqBG5HOLoRBM3zS+HXLBg4X1tt/JD1aWiJOi/p2y+L7R3OeJvDiuRvp
         soD353577Cbhhdd8zsXykqLjsxYkN7KXogM3TXCjxuWHeOaZUTS+HZr9eFLRfXuYuWo1
         D34HNDFy94LtJMLR5EzWqO4eJMQIg2LelTOPYjG/igRDWjjfoWHuvkMf+pZZYOyGBYkB
         9I/c35g1uFTCyhkTo0mN8s4LfrvyqYw2MlLYMgJIZ9jz9vEO/0E59Ut8acq8cUvib+zh
         VZzQ==
X-Gm-Message-State: AGi0PuYPxHbb+RhvtAvPrUFs6hfI6fEMx+02Cx4DnZef0jphEPK7udew
        sT6+Dcpu4IrNSwoajY7hkGclhoar
X-Google-Smtp-Source: APiQypKoJ3M7zSK6XcPhI6+YDybMMiSh7YznfYwe8V6Es+2R+LEARlYSHXr0k3wOFMzY0Ec9vh+CIw==
X-Received: by 2002:adf:df82:: with SMTP id z2mr28402325wrl.58.1587507353580;
        Tue, 21 Apr 2020 15:15:53 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id t17sm5485764wro.2.2020.04.21.15.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:15:52 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:15:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] soc/tegra: fuse: Trivial clean-up of
 tegra_init_revision()
Message-ID: <20200421221551.GC3445172@ulmo>
References: <20200417123949.26288-1-jonathanh@nvidia.com>
 <20200417123949.26288-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20200417123949.26288-2-jonathanh@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 01:39:49PM +0100, Jon Hunter wrote:
> Clean-up the tegra_init_revision() function by removing the 'rev'
> variable which is not needed and use the newly added helper function
> tegra_get_minor_rev() to get the minor revision.
>=20
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> Changes since V2:
> - None
>=20
> Changes since V1:
> - Added this change in V2 of the series
>=20
>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)

Applied, thanks.

Thierry

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6fcJcACgkQ3SOs138+
s6Hrew//YSdlL1YIcOWe/mXFbhH6pSu3wJv7nhAtBxWfzbSXsj9iE0VCOoAIe+u2
cBqWWuxWvYN5iO208BCpLp/M3hHHb9FzNg5ymkTWZkKzNebliIdvPH2OzUUgg179
uox5R5ucfNNxs9iVKOpJqLcdjbfjpsllXTQeO5xs6hB5wn4Bh4xzvG6J+/Hv/pGL
6b7fMNsB5N7zSU3F+/fky62hvGZwKVaKptKB00QgA6R4XgcthIi5s8qS6UEss9w4
IJpzJifpyOmBa43/3KPjk/y+BGVqCp/AJuugqzcDdu2ygBMeB1vpPvs21BSxVhg2
I8wdu5IKvPVLLIjdhU9e5rTiZaO1jZGXFxKqhtfJxe6ySSXVDejsu9XEi/TzZNZG
sMa+iLYrrjVdKOZhuLGr29XCuF4cf6gjrPMhpEyS54TUQWZS9uyInGU3WC1xj0tx
8DX9v8Gon43AnJtydm0Io2eoqS7+SPxv/arR3LPSXiMUA/r2BLWevb6HxxlSVZmz
A1fTHx//nkGdN0unTmZWAThg+zqpBOnJ3wFFj+jfW46jmtQripdo5mAMMAoHYuT4
ZzI4ePcS04C86kYTYDgw+rW595hgdJzA9Tkbdrmhmk7q3f4FTwXgQ+aRFkUDpSTd
mwBjDdy03BG6khW7XoG+nzKnG14mOqJ3shuFX5IlL8phEWhBXvc=
=Iitk
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
