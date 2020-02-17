Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8838C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2EE2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX8J2v+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgBQIkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:40:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36025 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:40:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so18594044wru.3;
        Mon, 17 Feb 2020 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/v0eLXQaRFOkPyzeDbBlT5k4Nc19FPfE+bD4QEkyJ5w=;
        b=hX8J2v+VDaGd0azih500WaGYoZGq8FnzwfOZgjlVirjuxOrdjl/ZF1bhkeRSWPu6tV
         jdQd6f9IZG6RLmlBUOYPvfWvlL4t8Ggb4HR5ADfuCnWnbYV9Xa3035mLhkbpwPssTmiT
         imIf8NnEbl+nSPf6VBmlqb50/f/m9KPSAca/8YUUPbqVXH9fBNa2D+TLu3fDELvyWSvC
         BvxAOCfZWZ+ux6hG0ZDk4+GmiZ3ljG7HpKmWyWIph06LKYVNx0pROsrTj/zwPexI3x18
         eqBpYiSh0Mk0pkgB1FqwRLeU+jKkb3YJwESVCbVgK0aDXOW4FQNwYxu+Aep2Y/NjzwWN
         jMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/v0eLXQaRFOkPyzeDbBlT5k4Nc19FPfE+bD4QEkyJ5w=;
        b=O9ucD8ftVxui/WRpwRb18iG0aEtWAJPmKxEHXt4fg6RRpXAKKKv+Wl3Cusq/XoHgVC
         /IP6Ch+XqrpF3UVukGvrXjyG/kB0oQMQ5Ob1CZ1SpIEW9DQv3Hd2nb5qXFfQKZy0XFlO
         F1Tr+Xl5K1HRqRd/DbgVu2s4VHoqJA98hw/y10VkchW8lQYy3bHHHNEO0PvYBxCngUoT
         IbfJE8XQjyy+heetZ4/wooCS7rR3EtmtMd/VIXut18UqTI1ru+o3saJM78z4lsmQX4lw
         +YIrXU/G8vOY9Dz/lQhidCbQNc3vpMjgqJGF7qttZihZ6kkF6Vx8T4lmpcy7BUmKzYh/
         JHlA==
X-Gm-Message-State: APjAAAV4pDchiqyHrQZTGsqNp0bKb5P1ibPAdX/C4h7O+OWXajMkeXxa
        TwajxawBTbjUJkliHTH4HXs=
X-Google-Smtp-Source: APXvYqxdbj0tZ3mo//Zy3jk9QxmEr/R+/96Z4pMv5SFKio/zpLnzQD8uf9jpbzloh9zZntB/ArQc4Q==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr20752532wru.122.1581928843143;
        Mon, 17 Feb 2020 00:40:43 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id d9sm20048285wrx.94.2020.02.17.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:40:42 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:40:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V5 11/21] usb: gadget: tegra-xudc: use phy_set_mode to
 set/unset device mode
Message-ID: <20200217084041.GH1339021@ulmo>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <1581322307-11140-12-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
Content-Disposition: inline
In-Reply-To: <1581322307-11140-12-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 01:41:37PM +0530, Nagarjuna Kristam wrote:
> When device mode is set/uset, VBUS override activity is done via
> exported functions from padctl driver. Use phy_set_mode() instead.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V5:
>  - No changes.
> ---
> V4:
>  - Updated commit message as per comments from Thierry.
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KUYkACgkQ3SOs138+
s6H/sBAAg6AIq68tpGRjr+GzL0QiaW7lEnUDT60VSUtVvSIndYMVDmHMbfNzo3oz
c7LP+xipIG/cM3hlnTsCMZWLQOJfo5eKKpW4jW2RjVBlkv15XX93FD+mL+ro4G5s
x6HnqM9AyNz9dkfmJA0mXfz9DkDfkTlsGASLvXoIrtpfGIUgINlyuTzPRypyfmti
SNZQYZe1x69rCBby53zWG3KE8NvV32lseI6avplpck0QnXGhHh3zIIRnHtniOcmv
NlejZbfDByQIub9UAAHoarnt/yOG/tzh/GfQxTcHKky8YU8IuZOJt0JlxfwhNkgH
UJI/INy2b2FuYsJ8DGclTmsIbakuu/k+vwjBHjRpv60B8Kr/thDCocdeieACs4Hu
Ut7Z0yds6Eg9wZb5xpZdPiFud7y9tz90jTVbsh8YOTRGrEWftFUyj66UKCvdWmCO
YUKrap8aR76VfMiqFwi/QC91Bttqhbu7dU6dscMxTs53ztyufhGFTqqZeffP5oRg
EbQv9SFdVTIyuqGkcGL9WQFUv5bsBWZDZhLOq52iq6u3iJO+nVA+/pURNc8g3rWb
lJjF8DGh+cRNrid9nnVtFxGW+1Z2dg3ca60pdp6KmVfYjK+yetV3TKuS/cxYzoma
+rzCC/9EdkSbmfAtY6KsWQov/yafgd6Eq2cX7F54uzJWb3Jibxw=
=MyRo
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--
