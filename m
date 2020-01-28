Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA72C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9750624686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNLNmYcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgA1Rk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:40:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:40:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so17052214wrh.5;
        Tue, 28 Jan 2020 09:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+5kU/FDPz57dXxiPi0dfPSLPlmcbLh7YSuFBWhdfiKA=;
        b=RNLNmYcn4qBHQJnmp07riCjU9LF5/SAYzBftYEovbiNmgGU00WFZkhP9w3Pir5ifKO
         8JDuJjDD1hfaCSuIENKHdy5oxDALbeQLUnWKKjcfBzhwout5sH/OqDRGuYLUwh+kbsd/
         CR7wputyd3lra9ZnmeyYI5IqrMROcAlBFu0s9ya4w/llmdlTU4YkGY1uAgz+ZDsommm3
         5ICYqD76aMrw1Rd8jB4NBOQytz3WdhKZUQYmSbHdafOGG6DuuKFUN17eItSTCWaBOb92
         ONsl9ELTVQ4RH36Lahw4Taq2UQpAEEwwFLz8uW4Btka+xiMHjl21mLK3SBAVWyj2641h
         owzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+5kU/FDPz57dXxiPi0dfPSLPlmcbLh7YSuFBWhdfiKA=;
        b=qqXwAxikjpfT7dAYxWzyHXJvLnS5XyzbdijEFb6e1MOiuiHViipmFjHEGHZAWX/3J0
         yOwUO77E5EedHDZmlII21EZ6FhnfbB5a/kGU6a325tDAuiuRR8nuF6jZ1vd1ft8IaYb2
         AmjjHCsYViTfEzGk/1M/cJ2b7WdqZtWJ0smMimzn5sTwJDgL0WM7WLYwPWacsjcQPFtJ
         8R+sNnsxA0lEk5rbSFpkfEWe6kF8gIgyueIQfyr+KA2v1J/nxUoSkqLKYEcyRYba0vCX
         /mqfEE9ICI1kUxWWNA0uHMgVToFIuXinJ6lJvVXZkCew41ifg+4oftr7LYQn6LwkKFkN
         I9AQ==
X-Gm-Message-State: APjAAAVJL3Pauot5yET6JF423KGqhdZ5UGJyoAewWniXkRhi7AL29Sy8
        4F4QMUDiSmT3MeQYh6BM9dQ=
X-Google-Smtp-Source: APXvYqxQUy0CblFTR2ar53ETf9BOWZ5G+z91zjcEUpsSSPXbTnzQTLPY8cqewV6j7eTA+iQdcrkmaA==
X-Received: by 2002:adf:f98c:: with SMTP id f12mr27977668wrr.138.1580233253589;
        Tue, 28 Jan 2020 09:40:53 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id p5sm25904002wrt.79.2020.01.28.09.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:40:52 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:40:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 05/18] phy: tegra: xusb: Add support to get companion
 USB 3 port
Message-ID: <20200128174051.GC2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-6-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-6-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:42PM +0530, Nagarjuna Kristam wrote:
> Tegra XUSB host, device mode driver requires the USB 3 companion port
> number for corresponding USB 2 port. Add API to retrieve the same.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Reviewed-by: JC Kuo <jckuo@nvidia.com>
> ---
> V3:
>  - Added Reviewed-by updates to commit message.
> ---
> V2:
>  - Added -ENODEV as return instead of -1, to sync other errors.
> ---
>  drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
>  include/linux/phy/tegra/xusb.h |  2 ++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 536b2fc..80dbc57 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1274,6 +1274,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
> =20
> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padct=
l,
> +				    unsigned int port)
> +{
> +	struct tegra_xusb_usb2_port *usb2 =3D tegra_xusb_find_usb2_port(padctl,
> +								      port);

Nit: may be better to move the initialization of the variable to below,
right before the line that checks the validity of the pointer.

Other than that, looks good:

Acked-by: Thierry Reding <treding@nvidia.com>

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wciMACgkQ3SOs138+
s6FkZA/9FHtGkDhpfIWIFxolCiSJnOiP9ZEL76PdXvDTBl0QMD7W+HEEOP7y320y
kLMJ+0tVLMwO2G2ArlIxEL2n+/yqzgmekiF5tG2ERDjqss0xK7Kekw0CeGC2yRof
rx0Nf1y3AMXt92Gsc8W+bGFDIu/3LuUHpfLMBa/wktTW53C87znLtFfdHIz5Jkk8
+0B2eLoPqoRB9B0AN0d4R6rHX4RplD7teD8N4a1BNhLIgt1nQRCDUdmkp51AAnfU
wAUAeAUtHJfLAusc4W7Xy1hVyW2IwX2C2AvCdA8nM6DJozNBnjPy9OsP4Tv7i3Rs
sSXSckeEDFVB7G2XUivcD96oKpE2CRrv4sD7Ru/94S9X6TotMlboUl/0LE3pM0Dr
naPJ8xSBeWPhtKwd3rm3AQ0ajUx8KEXs3otfm8lIG0aTQ34PYXapbIo58xumM/zh
p6IHHFWBuc0B7jv08+7XxUs3agcjRVlaDlmGv48Ku91rZkUZXHHEc5QRJfnl7FEQ
Z6Jgozux8EQXFuGm5O8xOusG0G+NuQXrljCEnf9PTTfNfQeZ0bpqeuvXT/3uByM/
+3pDDCaMjsy0CYPCpKsca3dWaoxsm4+mzcaECFXZWFqbPLxdzNYB3nVhcC3COlXe
ARlhLHHOdiNSqhveiPdYLffPNnqbdfmNGpdtbb1k0fEtXCbYGBs=
=yeBp
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
