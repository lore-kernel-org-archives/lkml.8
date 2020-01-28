Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8740FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AE22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnImthP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgA1Rly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:41:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39624 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1Rly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:41:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so3513916wme.4;
        Tue, 28 Jan 2020 09:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iS/CGYsUuq2LbHaMd6R2ad+3itHZhgE21jnTyoHb+Zo=;
        b=UnImthP+L/q0uWa7EyUm7P9KMZN8Tl4VJvuspRZeLQNWDjgVovtY6MB1jdauJiEWhi
         V/N53RdIDtxdflyxHnbAmWxbWxqMcbhaokEaQl3KQdSRlwelTNCheBGCCmErDltRm+hl
         wuHHy2DdlIiqW35eLci35WpY6NUxYJkbOl6U9GKmZmYw7TLeOR4CePA5WbuQnrrKfeug
         QsFb/xvfQQQGRa6KDVWSG44Os9awgCdFLMlk8fJLkQ2+GWhHSsISjGoijHgY3+Mzq9wj
         DJ5vef25stxvpVhymh6PyUnv4qtdI8VK3SnM2k0JYZIJUbEu1ss+iZgeA2GHsjkmuDdR
         5N1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS/CGYsUuq2LbHaMd6R2ad+3itHZhgE21jnTyoHb+Zo=;
        b=A4Mlvk1NrdjVUIK2OFSbpuN+4781UttSsrX6Na8Fk4uV+7pNR/xOJpf5qtMx9lpX1d
         SiQ7ImutYbmR6XtLEQaNc15hb/2KB8gVWOsZjz3l2gP5f9vuisGIfyUgQ5r4KSA1cCTy
         w+qusQ233qUwfggE/kWZ2CW4yRcnzKuQEMWtpRGjZKqpC/LxI1IKU4j8/x9VPuaxNFA2
         IECpEcuQoG/RuARqN7yh7RX4XlOpvF7ElQPZy2fyL19NGGPrOqi8sbWraAcVPDVLe9o2
         w9ZHIPB3+/4mtcSn9+EqF8iEAEz0SDBq36XhYb1kAKnk6p4DrLAzIYvsvsLn+ER06UVw
         xHqA==
X-Gm-Message-State: APjAAAXouK1XUTd6aZAt3yC+KPcVyZGSlSOV5puXt0FLAS9SSLUkXDSH
        it0azVpKI+uOMlufol3gR5Y=
X-Google-Smtp-Source: APXvYqw/7CsfcTWV6CDMWX8q3FKbGO2fpdvTe33+eNMrNvrZouGCO28i2ItZlK5EpC6tYnSaQDbgug==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr6273720wme.186.1580233311940;
        Tue, 28 Jan 2020 09:41:51 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id i204sm4126181wma.44.2020.01.28.09.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:41:50 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:41:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch V3 06/18] phy: tegra: xusb: Add set_mode support for USB
 2 phy on Tegra210
Message-ID: <20200128174149.GD2293590@ulmo>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-7-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <1577704195-2535-7-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 04:39:43PM +0530, Nagarjuna Kristam wrote:
> Add support for set_mode on USB 2 phy. This allow XUSB host/device mode
> drivers to configure the hardware to corresponding modes.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2-V3:
>  - No changes in this version
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 126 ++++++++++++++++++++++++++++++--=
------
>  1 file changed, 99 insertions(+), 27 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4wcl0ACgkQ3SOs138+
s6Gzdw//T0TzStcx4Ls9rs7glP6lCDnKHC7MT3T3R3bCcl+5lfRhw57519KSLJ08
tnZN7R5VikD552BdU4rx7Az5Xc2WyMD75FC46BlJaYB5J2+EBep405gs3chsT5c6
a0BLT1tibvdeO1iE2Bkf4EaP3k2Mh4vkZ+mDeHaxMtsYARi80asTTnFZ9S43YUh9
EmVZXguUi+Nc9qbPpCGabyCxzBUDU+uvi2itwVL8pk+STjiLmfV0LAlIxycBmw77
CEaRP7xEy4f9QjibvRs45UmgkVFZybvQoOi3M2Rs3Katzdsl1vgXlQP1yIvhaT6P
r/eUNQSx2Jt1e8FIjDEdK7LPmJvfRV2sqbPTYK1o281dvSi8ip8bQm28WT02fdnz
OvSG/cub4k7mk4XIP3MQliz3pIsT31AUPWCJ3Cx4pU2+Duu65oy2JfKQ2Le0qI+l
oYYS/oO7cxBlVVaFnFPKXWNd8HbRyjbmlMWPTXgXWluxaDqDEDBDy+Q7Eqr/nxOV
1qAEFwFlPve6s6Vz/HW2wiOiaBUS206WsqodwH+ymGD197bwagDpAKy4a4mpNJUS
4Dg7xkVHpLePFMTSRsM2OcJ2y7zEdNajimnwtrcPtTUc4PhG0uijp4Ple52t1moT
WWRSMfNRkUDBrb4V7ftmJg7/HTuCCge154ywzlzeFPQrWeDZjvE=
=CMq6
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
