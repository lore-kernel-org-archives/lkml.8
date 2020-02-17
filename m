Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC3DC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46EA20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmWrK66Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgBQI3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:29:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39645 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQI3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:29:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so18494395wrt.6;
        Mon, 17 Feb 2020 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVH3CcpBNk74SC49HrGbLvP9gnbL0Tt6Cw5BpB+EFPs=;
        b=XmWrK66YbMFKTuTeTbLDTLdZUd8PN5VrSz13wZOqjkT9hAPKtNurWCc/FBdPJ9d14Z
         lLGko2a2PLviLEcxrN8WldV9FcZAilDzlgQ3OyRsVS1d3Tpu4WB0cwlI4cOz0X7gjGGF
         i35KzNrwszgFy4BdeABmp1Kka2OAWtXDi8Q8sCCr/hCOoZFNQxXczUQhoH98T5QcVUT/
         6TkI+lmEnbmtfBbV/jezH1boA24M63mCJg4lEYAXPxrlQw+oyy2yhV53pqq7Y3/aX1/u
         6a2LGWdkCjV4ITujcAX2WsNnnA1cLgR1FRVXpkN5esav9csUCt2e1ufmenNLG03peCp8
         HFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVH3CcpBNk74SC49HrGbLvP9gnbL0Tt6Cw5BpB+EFPs=;
        b=MlRn7/eENSA1dE1bfjxf9Vxi0/f2F5VfPTzdZN1tNJJMiZpUcNqdBBv04EhZTBkQXn
         VX/qLcLhzIHXDHtsnNhxCSfBWDB5wbLxlOjZG2cAyC+Xmj7uPPN5b4jozCCzOtYGd6UZ
         ucAvNXv9JNrP8M21fuUqj2dfJLnLwFKz8vOjz9d8EMFyzfW/JCc/80pjs2g0Pls/z0f5
         7cYwF4lKeUJp7lRr8eggRESyd36S4xZx37kjVIjVoZYDrxQSDOeKKd1yf6oqjBJZmtah
         8UwkZKH6Bf8g4bVpzoPPC5PRQnv3+oYRbCGd/qq73UWVc7wVcJYTFZXlTRflEiFjgtkl
         2eJQ==
X-Gm-Message-State: APjAAAXkauCMjOKoJznz6RPjANMTnUqM1uKJuESRYNBZtDAp4VygFLG2
        PBf1O4r+8AJ+3PDFU5YwCnVB7/Kj
X-Google-Smtp-Source: APXvYqxjWOyd10qRLTbYuvPH5neXLJqQ7zL5OOtjswJKDsz2jzrDe4uJGAiaVMBkj0sdRlDe0fB5BQ==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr20172559wrh.49.1581928183767;
        Mon, 17 Feb 2020 00:29:43 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id n3sm19774814wmc.27.2020.02.17.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:29:42 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:29:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v6 3/5] dt-bindings: phy: tegra: Add Tegra194 support
Message-ID: <20200217082941.GB1339021@ulmo>
References: <20200212061133.11665-1-jckuo@nvidia.com>
 <20200212061133.11665-4-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20200212061133.11665-4-jckuo@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 02:11:31PM +0800, JC Kuo wrote:
> Extend the bindings to cover the set of features found in Tegra194.
> Note that, technically, there are four more supplies connected to the
> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
> , but the power sequencing requirements of Tegra194 require these to be
> under the control of the PMIC.
>=20
> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
> is possible for some platforms have long signal trace that could not
> provide sufficient electrical environment for Gen 2 speed. This patch
> adds a "maximum-speed" property to usb3 ports which can be used to
> specify the maximum supported speed for any particular USB 3.1 port.
> For a port that is not capable of SuperSpeedPlus, "maximum-speed"
> property should carry "super-speed".
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v6: none
> Changes in v5:
> - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
> - fix a typo
>=20
>  .../phy/nvidia,tegra124-xusb-padctl.txt        | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KTvUACgkQ3SOs138+
s6EgGA/9HHQ/W5xAPjiotHh+vzcc4EPcUPP0rhHbbk+7zfuuRrZnsOClobb9t7cC
F6FO19opkXm7X0XxNGGZTxoV/1tF2icNNj0Lsmxd1sTz8LksZ+cMM6OjIE8DN4pM
ZdRTAlQAMti1dHoDZi7fF3JZgVx9LL38RsFGFe4rIq4CWEwuBfZQ+ZJzszxneOJP
rLgBM7rFiP8lc4IpAq7E2DDBzfuQa8vocvxb5BbuzXi3DIOnEG4zyM7RRHw6Y5u2
cIoO3oww3l6O8JDwPIm+ncze6K/3Pq2ZWbpRxQB0+Upnl7Pz7HYgB26QZRELJUue
EnUfAHiBloWFKcEvjWX8k3zUA+OSFM/yGXzZenOuWhF2WDp5/v7MZ+OTQfKEM8PG
+Vrfjh1T7Gp7HLyhu9ICj1EtIs2tfQZgUQACIbpnei0cmVGuIkhY51z/kYXIdZIc
/lkmT7h5ClDYmB9QeWUA7I4/2dwpSM/aZqbbpt58T/Q23bOYFwl8qLa89TY3ec7h
17KSsN8pKv5nojIdROBYHWBZNLOPI+9Tq4SXUrXYTgzaKGdiEeTy2J8U40s4Z5XB
NIDw8lwrerJ8lKoDiJrEODz05Hv40edMBwAEQgfFF8Yk1vcFUL69wUmvipu5Hlwy
ezZYiHh0CplKOS79I4/BEyFS5RPZ80nH3gmftOHu81JnhTumj/A=
=J9v7
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
