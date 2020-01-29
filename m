Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54904C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A91820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h90n3iun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgA2J1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:27:33 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37968 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgA2J1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:27:33 -0500
Received: by mail-wm1-f43.google.com with SMTP id a9so5597275wmj.3;
        Wed, 29 Jan 2020 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZo/V+gV36C6pLlSdL5oMb9o324Cuj0Yjq9W/IVgMQA=;
        b=h90n3iunMCL1A9Xcv8WhCfTlfB+2T8q6qVgPETdqrdO42CGLgYv0J2sCLSAfrV85S2
         hsGfua5uw1rxZ8XoCpT1zHQtJPsM2eqBbqKFJUnPvNlVSNIFf97mo2Fy4YoyNbrPX2Vo
         bfe616dtJxHFH2vERzeJdnDmnWBKozytqFfwZ0cjh8RHR9e3jY6LiuWFq2jIDEoYQ+XK
         zkbLNtSNJTV5GFtPjKNhgMI7gIlKfMnSpzz3LFEy4ZPZPBVTbG8QMAtwqL81q8OvT1Up
         lUVgxbJUdkWBJoZXNtvoZaek/XNfiekKktF6/agZJS+snTKSoin+qVEX/VZCyTBBD8oq
         oMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZo/V+gV36C6pLlSdL5oMb9o324Cuj0Yjq9W/IVgMQA=;
        b=Hd/iESYMctT1kAlh4dhlTJTrNDINZnbKwAMDPYPxXWGBYDVihQ4A2DZfh3mrP22oqa
         TnSwBdYMCn3hyXREBdRyso9qA09KXCn5qrbyh3n2f6WnTY9nugRxI1a7Bl6a5eo0bCkz
         M2PfLm9WTqWocEppIptI6+IOSiCuFNiMg1+v3iqKoDBerTWfWrTiGvBcH5UlQgoYqNsn
         O/797ih1iu0UZxAPIBJYAAc9gQ+LEWfeSHSI8Ir0SwxP22QYHwVy3r3iUDSfFjRmNeWk
         1R9UmFID+SNWQJt3n3vjr4mVx4JbfnqigfrA1BJPcBChWkPvQFjMpy4hR1cP6ROvNl7n
         SPKw==
X-Gm-Message-State: APjAAAVXD5GgWOi9epygIW/s/L8aOxeL+nj94+GMMBGOQC/UYOsBEBgy
        gjiCddeN6MMLD8IpmDMnAH0=
X-Google-Smtp-Source: APXvYqyVtA/WKM8S71ZyV2OT6fbZIlWQNU42S2bVFlhrVDp19ETZw+RMJGq5yBbncaNzuNiN/qyHVQ==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr11041027wma.177.1580290050708;
        Wed, 29 Jan 2020 01:27:30 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id z3sm2054801wrs.94.2020.01.29.01.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 01:27:29 -0800 (PST)
Date:   Wed, 29 Jan 2020 10:27:28 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 12/18] usb: gadget: tegra-xudc: support multiple
 device modes
Message-ID: <20200129092728.GB2479935@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-13-git-send-email-nkristam@nvidia.com>
 <20200128181020.GJ2293590@ulmo>
 <7478f53a-c236-5442-8abb-7531edb89b29@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <7478f53a-c236-5442-8abb-7531edb89b29@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 12:20:09PM +0530, Nagarjuna Kristam wrote:
>=20
>=20
> On 28-01-2020 23:40, Thierry Reding wrote:
> > >   	struct tegra_xudc_save_regs saved_regs;
> > >   	bool suspended;
> > >   	bool powergated;
> > > -	struct usb_phy *usbphy;
> > > +	struct usb_phy **usbphy;
> > > +	int current_phy_index;
> > Can be unsigned int. It's also very long. It might be better to choose a
> > shorter name so that when you use it, the lines don't get excessively
> > long. Alternatively you could keep this field name and instead declare
> > local variables to reference the current PHY to make lines shorter.
> >=20
> > Actually, looking at this a bit more, I don't see current_phy_index ever
> > used by itself (other than the assignment and one check to see if a PHY
> > has been selected). So why not just store a pointer to the current PHY
> > and avoid all the dereferencing?
> >=20
> > Thierry
>=20
> current_phy_index main purpose is to quickly get which index for USB 2 an=
d 3
> phy's to be used. This is used at mulitple functions. Based on your comme=
nt
> above, I believe its good to use 2 pointers for UTMI and USB 3 phy's, whi=
ch
> are points to current phy index. This ensures to keep line length as less=
 as
> possible.

Yes, I think in general it's preferable to use the objects directly
rather than an index into an array to find the objects.

Thierry

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4xUAAACgkQ3SOs138+
s6Hu5g/8C6/Ok0YQVG4K+SUpBeDRFOEhJdFXvbx8GY1l2VGOb2zwbXpyBvoBIlg5
208voSlRwDaYhJAeIYL8czDUJlPuxe24896v5zmuxBNDauiMzTMJF8wkrjFupf3w
TobSBAJTsPPhdTxxz2AmOPVUi4AVn9oyymZG1KEQrzxFdoktA3SPm6lqrGh5CxoO
c3nTfgPGqqiZrhP5xxquYqdVrod0x0KDyrtYwyt9AO+5291H2JxyFb9e9sJvQ4Tx
qesj5dLAfet2CfgZUYn7bwtDmo8bMEFvKOO6Qh2T+mZpFuK05hPvSSbT2JZTTGmK
VCXSmauItknL/WUjwUS2ugEMCccGiyzAD3XMX7DhWF+du3iXdeQAyEaL98YLMbXH
mWEMjNMx8fMWX9Z9nsRfaIEP22ZGsfxPt1IcNWlGI+D0r4VY7EX9rKqSAEmLfCIZ
RZXv2oqah0T2DJNed0wjStwXDo03uzoFS0NwGkUyf5/erFZSykXkSRMySj1QJvCT
YG5Eyo92i+XB3ibLCVW0wdK0Fkx2XzbutPtGW2MIA4R3agSi8AWl9axdOlPyQIOu
wFHUB5bSQr/2h3CdnMfh5DQ6auZUTAmSSr+bY5oi7Zmkezkm17Jp6PxbBv0e1Q//
gaaDwV1HF2pyFyMlqkYBsyLyTGz0r2xjp7+M+iRd5WYeOB6SdF0=
=QD3x
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
