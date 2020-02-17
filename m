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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B5AC7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2033020725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaI17qZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgBQIdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:33:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45816 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgBQIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:33:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so18497160wrs.12;
        Mon, 17 Feb 2020 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+7Ukio5eVRhWG5EqBR9LrQe1Ic0U22Ymzcis/tBCVZA=;
        b=KaI17qZ8CL4COFgDL4O0IvE1WTk+T0NYsed+2clavfyv+0LH9uOM+oPyCDBwAz7LQy
         4c4wUTpqzKBFr1AjWCPGfYx8O0+kd30HjutTCUV2b9lsPwNZjMJhZRm9Cy9w2yXBgLTe
         2LtxhYOBEoiYZlNn09Xf3jeV4euYbB7jF469NCHnn0C+BqAdNhfTjTqqCDdNaEiTqNQj
         SXWzMTE7NgK06DKPDopLqBgX8MiABWYr26gGayncUrCqRjDDpwaIhwdTiqImOj5Y1fz6
         GxCFI86MnWxO0llnMNeF5nKq4WPeTfL7q8pTHfKzRJPxiHjso1coguFDSLjbhyt4ZT3P
         njSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+7Ukio5eVRhWG5EqBR9LrQe1Ic0U22Ymzcis/tBCVZA=;
        b=rEPvgw2X/QubJ6OihV23pXHYW5ShU6SqtJYjqu+MVd0l/QRtaMB1mgbSPcESBPTn26
         XEwpUUOYqiVVnzkqxA9JVCo6g+cKVnk6Fie2NBYzQNseX6gnNeFsPrCb8cBJIhLll3VF
         K4JZIJqVChYcT7SiJDPCjjSA1YQ1BKj3lAUqq2aHvi484pfmZBoW+WgYRm9Z3tEsSfIq
         jKhKPf59/gitoA5uQiA/jhSqrgmP4dXeU0ZNlep1gn5gDGUia9ttMPbf01QhnVzjDVD3
         uDrkFMAPn0UHbutdUMpnA5TdrYOMX5tMTL7+CsRq6ziEPR0vtIBOqF1j1BnUkTRewyHj
         oYQg==
X-Gm-Message-State: APjAAAUUy3BwS2mc9HposqVunrwi8l6a13FhcSK3k6g9+H9mVla0zFgg
        iBDNPV2ayHh8bXIByw/+m4vkoPS5
X-Google-Smtp-Source: APXvYqxpgq4ptqYGx9gtXms7gyTq+QH8O/dTUATiLEhEah8yYQ/a9j80dJLNDDTDT8duCCgZ8CTCAQ==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr21163986wrv.148.1581928424807;
        Mon, 17 Feb 2020 00:33:44 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id s8sm20209704wrt.57.2020.02.17.00.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:33:43 -0800 (PST)
Date:   Mon, 17 Feb 2020 09:33:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v6 5/5] arm64: tegra: Enable XUSB host in P2972-0000 board
Message-ID: <20200217083343.GD1339021@ulmo>
References: <20200212061133.11665-1-jckuo@nvidia.com>
 <20200212061133.11665-6-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20200212061133.11665-6-jckuo@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 02:11:33PM +0800, JC Kuo wrote:
> This commit enables XUSB host and pad controller in Tegra194
> P2972-0000 board.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> Changes in v6:
> - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
> Changes in v5: none
> Changes in v4: none
> Changes in v3: none
> Changes in v2:
> - use capitalization of regulator names
> - fix gpio property of VDD_5V_SATA regulator
>=20
>  .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 36 ++++++++++-
>  .../boot/dts/nvidia/tegra194-p2972-0000.dts   | 63 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 1 deletion(-)

Applied to for-5.7/arm64/dt, thanks.

Thierry

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KT+YACgkQ3SOs138+
s6FzIRAAiqLSeEJ4PKGKw0C68DNsxPVFwwerYD3emjg3/ZUeSBWtzlItgiMeALkk
hnej+vs1OH1eUutF7QVw39/lvNjfDlr081ZLK9Vs8l0w+/IrsVObz+EcS4GM6nWT
941/tn5PFxahXcLnGcNxxd9m7qJjL0v9B72JKT317JrwD5B7ZH1o+t4Ij+toNi5G
6rSuhXMii1YluF133U5XfQEyTEG/4Y7s2yAoBmn+nyZUQHSCLucg4YMJpiwiojHk
U7tSxNbbALgFwLnLjWuZzAPBwIh4RMTIrpNowTnml/CgD+k5UE3m7++jp5xNVKqw
+lmpARu7XF1ev+d3E6Td/NmJPD3gO0v1Id5fJbPF+n7VZieUpWecQwAvmfM8K8w6
+CU4npgC74i4PVzzx2tEcUFxLHKrV+F9mEJpZ7YtmazCjZPWYnV7dn414mho9ZuW
8+k248qKfEHN5G0ClQqeGKC98EjoBWAu7N5R1S9fcRkQ+6EVT7KVcfqqTPvVBVaE
c2nCV5idCkDKCdSNH1G5sOX/cwFQDfSC6GNG9VS86myLaITCJYA9FCQ4Gc8ROBvP
9/84ZzT2td0XZC4N3hWf2Aa9zX05xhdEAebKRQgHs5lsFmPrpQR1u+JSHj8dV8Db
KiPrNu847WHh74lKExsu/MLAh0agMfMT0WdIE/0qunYxQc/U67U=
=1Vx9
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
