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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB74207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT6orcQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgFDN6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgFDN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:58:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A577C08C5C0;
        Thu,  4 Jun 2020 06:58:50 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o26so4819804edq.0;
        Thu, 04 Jun 2020 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qC5bBE2TNzOj1a5qZ4ztpSJPzwogmBB/9SPnd42iqo=;
        b=iT6orcQpn/Zi9wQ2jD0Zv6Ejjxgz46upF6pdzB8ylmJX5eM/yc1F7rzfJ77zsa3h6+
         9+gSoxRgJ88r5eHycx4vpD6wv5Kgk68jXO2c679Qn11EMfJw9PsEkNMI88NBPV002slG
         uJR2RVM0GH1wDx5EiO7DjUBGJWaKHdhAAlE7GDE31zlEd6eXFqqP/30ikBJ1/MvZMmrC
         qwV5HOS2W8BbBaK8f1z7zHZVVw2c/RxCbQ6yBKiYrnEBIeSTZXooB5JWsM++eT6hxwFl
         /la/P/dLY9kocRmiWWtTjD0k8qk8GsRG9b/BplEUVihPlWXZ19MIb9HK3YdAGoAXjaF9
         jXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qC5bBE2TNzOj1a5qZ4ztpSJPzwogmBB/9SPnd42iqo=;
        b=frUUtv0XWPxN0RCeTYRXgDfjtxB4l+z1v4tm9Q3n3XTBDAmEY5m+/yTxBV4zkVYBCo
         yPoFGpwUk3iC5qdnosyGTEQVIB9y/DNOZgTeOd/irLcbA4IHakQ+gvlhmZhEENq3nxFq
         pNLMXF9fSCNgPAYGcGAsflZ6+6ctIXuKb8IlkLNyFkpsXbjcU35j5X2XqCEvHIuWqr6E
         pj57ZWucjYCQnsG5JufcC6ob+BmsjC151bRlsjKT3zuSYcrhfUp1Lbg8FdGxMuyZYPcr
         6glWfBBfn2+uRcz+rtbMmUSpG4CQ2DYq/iktL6y7r6TpeCpcoQYJSKr4NNBlXikPRhSH
         DhNg==
X-Gm-Message-State: AOAM530pkynx6vf+jmHuLsA8oR3hTjKNHGTIkyeIrhUGgfnLYB947ZJR
        SH5QJHEl53GSFOKtH3i0aQ8=
X-Google-Smtp-Source: ABdhPJznfDDx1LlyjwF9qSl9ZNsDXsrN8tt512tci2tZybQ3b4FkTErmLxkpVRFdHyfSZnNaDP1Oag==
X-Received: by 2002:a05:6402:149:: with SMTP id s9mr4288851edu.375.1591279128550;
        Thu, 04 Jun 2020 06:58:48 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id kt10sm2221923ejb.54.2020.06.04.06.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:58:47 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:58:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Nagarjuna Kristam <nkristam@nvidia.com>, balbi@kernel.org,
        gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/8] phy: tegra: xusb: Add soc ops API to enable UTMI
 PAD protection
Message-ID: <20200604135846.GD1138399@ulmo>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <1589437363-16727-6-git-send-email-nkristam@nvidia.com>
 <db698a53-c5f6-d03f-edf0-f4fb38963e1f@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline
In-Reply-To: <db698a53-c5f6-d03f-edf0-f4fb38963e1f@ti.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 05:54:03PM +0530, Kishon Vijay Abraham I wrote:
> Thierry,
>=20
> On 5/14/2020 11:52 AM, Nagarjuna Kristam wrote:
> > When USB charger is enabled, UTMI PAD needs to be protected according
> > to the direction and current level. Add support for the same on Tegra210
> > and Tegra186.
> >=20
> > Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>=20
> Can you give your Acked by for pending patches in this series?

I went through these patches one more time and I think they're all good
now. I've acked the ones that didn't have my Acked-by yet.

Thierry

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Y/hYACgkQ3SOs138+
s6HnyA/9Fj2LLU1HqZfshnRjI3aQgaPbxFFuL1xOjZMMWSLk0qZ9BkE+knzQ9/c2
G0EfbsP+Z0tp3HFRK37yT6YL2xNwciVYEQow+y0TMzwVCQdBY+ChdcL4M7Da/iNp
VjJsEsmp7kWn2AApkN3CqZsrtYp+rzWTFoh7DPZfJr1Ny21gKaa7CHI72b/PXYoS
sNnJvHwYBYZ9KofaSKteV+LyueAMuOxvQHA8CTWP9qgG5rpPb9n3lbv0D6BGOjSP
xbt2Q1I5mxrTOVkpUpTjXDpVKglC3TCwUC9FLkDHOrfzjoF3pJFG1x97EuU2aH5Y
E2xbIA7kSniYH+ZtxlL6f+iYmWqFyNsm6H6dWF3m/j5sryhLzwoa3KYSCdH2QSoc
L/sW43agd+HcUKsHKk0mH1K1cVgGO2grnTQdSwbNRn8tlhchy0gikuCM1Ecs3Ehc
bfSRDHVsV75gQtOxavNEdKfIwz9ExOKGolDsazpgLJ32c57lwGLHHGxPTmI5PmTo
NgwrE40zXoC5fG3XuWg/Iel3zXvUZSHn/rfk+d41wZXN2CpDjESOkK+RTiSeherg
UHYPTk5jGBFw9WVZFImkI+791yWp8cWpJej73wKj3bhoCcFpIXgFvV7R+iKvPxkp
WqFTPpsaCZVq1WB2vzCxKhiYe1U6IuN+uhvNaoCCKFtZiq1NI1g=
=91er
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
