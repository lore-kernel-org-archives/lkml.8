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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F32C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F22B22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWYfWF6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgA1SK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:10:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45596 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgA1SKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:10:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so2556080wrx.12;
        Tue, 28 Jan 2020 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THXIcxAQ+jRZ9p0oqCi3Nel8bF5n2Oj6LcOlDPsztjs=;
        b=AWYfWF6oKD17pcdtJ5MPRnS4jNaFxgWz+hrGuMK8EveAfoNAkLX3ICr7Azw79XCVPO
         G77K5lfouDTtVlRpWTG9Yx1ZYCSUNCU4dqeVlLsgriStyOEP1KzaG/Op3HEZskuEzoQd
         7Eqy+B86FPY+cq/BrQ5NBc8iYm+UcQi9WLS/FW1DcBFM0lQrOQhuT6PSsNbZX3RhWXlR
         RnLj5HoL9EN01j1aFVcJLzr5jF97WkJO2c3CUTML1ldStKQgJ4yNOiPkgsYt7bEBM/Rq
         km2yigkmrASSnebhXhH5/HvkARTQsWKjRZ33OPPzRz7dgjbzemmX/SZj7GYssp9k8Vpg
         UD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=THXIcxAQ+jRZ9p0oqCi3Nel8bF5n2Oj6LcOlDPsztjs=;
        b=fC2bjBpTvcmncLQATKC3IPV9pnGKam1enJ04LDmbgxsh65TT/pj9kjeJcL3qDbuXFw
         wijT9bGpusP3ULwNLs4vNA06M2UUbR3EG6MpR94RReecUDE0h4LHCgeyxPWHd5Sb9dED
         vHU42PS9GbVPKtdU5StQ0kGso5S1EPMrm2QFb1TF2Cvj3q/k980tmhKXi9/c7OLOGA3t
         CF5KhCfW6ZzCEl7614BVWqu3UQOwylIZboYJ9H6gTq0iN2oCOBa93flYlOAHiMNIefo7
         8fjRx8nLidBJAIJVRYDSXhcjwZe/aNE+IfSXIonEXtH1m4qictBqCd7kPss7IkZ3jVfk
         OCcw==
X-Gm-Message-State: APjAAAWpXFOiNoNBgM5uDawCOVOcalBqWeYQVZ0/JCgyGlG+bE4Ai896
        0WWD6KNU259uWZiJ2F2H4os=
X-Google-Smtp-Source: APXvYqxKqo1EPLOMRvFiZxIKnf+uw/hGtB+hSgdZoNS0pddIbQOsu66CPHcFIrm4EC3y5yr/lDD8Lg==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr30628170wrp.54.1580235022924;
        Tue, 28 Jan 2020 10:10:22 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id b67sm4206059wmc.38.2020.01.28.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:10:21 -0800 (PST)
Date:   Tue, 28 Jan 2020 19:10:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 12/18] usb: gadget: tegra-xudc: support multiple
 device modes
Message-ID: <20200128181020.GJ2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-13-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-13-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:49PM +0530, Nagarjuna Kristam wrote:
> This change supports limited multiple device modes by:
> - At most 4 ports contains OTG/Device capability.
> - One port run as device mode at a time.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V3:
>  - No changes in this version
> ---
> V2:
>  - Updated err variable on failure to get usbphy.
>  - Corrected identation after tegra_xudc_phy_get API call in tegra_xudc_p=
robe.
> ---
>  drivers/usb/gadget/udc/tegra-xudc.c | 228 ++++++++++++++++++++++++++----=
------
>  1 file changed, 167 insertions(+), 61 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc=
/tegra-xudc.c
> index 283c320..bf80fae 100644
> --- a/drivers/usb/gadget/udc/tegra-xudc.c
> +++ b/drivers/usb/gadget/udc/tegra-xudc.c
> @@ -483,14 +483,15 @@ struct tegra_xudc {
>  	bool device_mode;
>  	struct work_struct usb_role_sw_work;
> =20
> -	struct phy *usb3_phy;
> -	struct phy *utmi_phy;
> +	struct phy **usb3_phy;
> +	struct phy **utmi_phy;
> =20
>  	struct tegra_xudc_save_regs saved_regs;
>  	bool suspended;
>  	bool powergated;
> =20
> -	struct usb_phy *usbphy;
> +	struct usb_phy **usbphy;
> +	int current_phy_index;

Can be unsigned int. It's also very long. It might be better to choose a
shorter name so that when you use it, the lines don't get excessively
long. Alternatively you could keep this field name and instead declare
local variables to reference the current PHY to make lines shorter.

Actually, looking at this a bit more, I don't see current_phy_index ever
used by itself (other than the assignment and one check to see if a PHY
has been selected). So why not just store a pointer to the current PHY
and avoid all the dereferencing?

Thierry

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4weQwACgkQ3SOs138+
s6FiDw/9FkKjqK/pE5MWAXa2YCYVvNyJ+tKDD6xQh1/co/QYHOLWNSNyrJL/ECmZ
GRJpJYS/BTn+9WPnbOYWEiDVXhoQ+3evAEYFiir3DF23endG5IN5ZA58pLRP7vQD
T0Z6z5JcltLVESbX3hitWHdJkPKfqJHLFqQYZXHQTUWmpUAVgOt2lNtiaew5bEmE
yYOb/CPUHOeJfzespeepeCiJh9aNkVhW6bTX8vsmmdgnmAA7WJeNlZiR5tVXKumJ
nCOk7bOUti9v3FGUJotCCYe1pB/YdVw9wQU3dHh12LBiOP7hUHfhQql6UqEkfkBj
su0GpKqOo15/c6vXVlW5+JaJGSPdpQ52KrsAhh8ckfa5hJbkYkKn60CucJ+0X09k
APKUjF4ZyTgx6aKTsWK8NfOUaaGUmpbtivtIhQJLobss5pA5Vd2KBPXn9BsU+X7o
jQrgBhauACy3YceIosSYm7furIYwE87/zG0p6bGoKcq1TOvRmNXjsvB9AQywsbCQ
UHXFM+PBi3n7w8hUldDvoLhCZgwKN/ivosMBfva/VOlWBKI15BBdv4Q6biu/ULGh
Y+WpJPap/Rb2uhjQOccr2j7ERlQJw/0iT+lJUGRNgDxccmLTrRbCjhKPhbVNN/69
+O7NOHvGHW9zu+aNHKFCKy7GLVVhNTBPocoOCSuk4gIaQeukQow=
=nZc6
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
