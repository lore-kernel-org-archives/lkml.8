Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E510C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77508206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBiajpPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgD1KEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727107AbgD1KEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:04:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D96C03C1A9;
        Tue, 28 Apr 2020 03:04:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so2159539wmc.5;
        Tue, 28 Apr 2020 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FZWj3Lysed22PL4Y078VhelfrwEFYvUTFp241hLfoxQ=;
        b=dBiajpPtLsQdpwuDEw2bnf6HyJiOTwuaLSXbOYVaUbpwkKu3Imwdjtc4iYE5+qpkGh
         zAnmxl0G1wsBUSo1dx9v9KzgRSjcDS72Qicr/WaEinXnnr06KHR2nUfsgpzggQjl5tu6
         BWyTQo41EtcGqkr+DgF6Gf0xhcxEqlyBAZtLoWnDUvCcS2k+12+oODug5TBofSMXxLzW
         CIczvcddiqecK06/eo/lqPCgzmOPpdWhaPxSfmtb6KaipQoXn7vCTxqRDG/actw8k3eR
         BGOu5Ecf6efLZsFoGySM0BBwAxrTJMWGwsP84kWF39w8ODeQqg0OghQemu0d7HR37CUZ
         771Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FZWj3Lysed22PL4Y078VhelfrwEFYvUTFp241hLfoxQ=;
        b=F32QDDNB0gxx44mUJpcpAF3AShmmCU7MmqlJiDZrzRzUj9qrgzMVh42qUC43yP3bEq
         zMWcbAZS+3MuqGMKLzfbkrfloF7gWmSvwdrBN8slwo2kbjti6F89Zd0BPIh4fbvPTfzV
         Ven/ipR22aRKQCNYFbKpcQ32fYptjMc74gmQ/wTGcD6HG4kDDD2Ptxsq5IWPYfV73TkS
         etxfpglU9Jtku13zEsH1vUQBHpohtrCqH/xdUH+GxdtQaWs9j0TJFUUTBBAgePL14xz2
         dcEF9VBM+WM6RPnZe/h2l3U758ULcSTEG8zO+aQT7qwuh4vmXlwbR+2udnlVpOIuCXQQ
         hCPw==
X-Gm-Message-State: AGi0PuabHCQf9wJMgQNq2LpzQzwQw/N4QiiNq68KykM7FAtt/F+2d19r
        0UKRnTZpROFyZKXlyeP/ZzI=
X-Google-Smtp-Source: APiQypKOqaTwnSgVcZuq9zDy5UEUMjaevZemWQiNQyqv4++XNHvfQ3PT0Ok6td7Ld0TvJb/lC/PXdA==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr3621379wma.24.1588068293697;
        Tue, 28 Apr 2020 03:04:53 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id p7sm26117997wrf.31.2020.04.28.03.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:04:52 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:04:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/8] phy: tegra: xusb: Add support for UTMI pad power
 control
Message-ID: <20200428100451.GC3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-4-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-4-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:03PM +0530, Nagarjuna Kristam wrote:
> Add support for UTMI pad power on and off API's via soc ops. These API
> can be used by operations like charger detect to power on and off UTMI
> pad if needed. Update powered_on flag in the pad power control API's.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 51 ++++++++++++++++++---------------=
------
>  drivers/phy/tegra/xusb.h          |  2 ++
>  2 files changed, 26 insertions(+), 27 deletions(-)

Can we not simply pass another reference to the UTMI PHY to the charger
detect code so that we can avoid this custom API?

Thierry

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6n/8MACgkQ3SOs138+
s6FYKRAAqpXiamm0RvGR2izSuYbKEcEOvzxc1iQ6OjqGlTkQY8qiW0sUQob8c54J
2+weCIjkd6HhULC4XGi6qdP1MgNBXQiniGmsj1+9cRING/Qg2Ad3sd6mOCfjBmYw
rkd0erSue+hecchK9PlIdEQc1HRhFMRTKAWAPfFyXjE4y0gUKnTyFYmHmYYd3aJs
FlNE6tOnNBvGkTndMyYX/ikByJECinH0dyonLcGrrCuGDhVF+qu8YZRJNCAFQ/H8
HJn2zp3qm4BNs89UF05rs/OB6V7jGk3eAV34YBWw7aMt4TjC8l/AB05m6YAs19yB
T+wcqzTHFpUm86zcAM5jDBwRGou9C6Gr7CQUDiEVBMo7P0wRlHoj7dQ5CCA9iO17
ELSvO7svvJaNqqumcB1bOTsD2Oy/XNIeCnoA/PCO2ZmuDjSr2p8onshOpoZbyFvg
IW8pzi/9QkPcnA1WproUoXOfmUuiTui83/6nv1k167OjyfD2RcjHxxsflEbfn9zP
u/Hk31VMscbKS4oA+QE5b1OkGYzLGD/YxwuOtnLwMhcEInMEqJrS9SKua6Zyn4jL
HNKPNcd7sxPbccbWG0+YQhWGTVMdfqppSilUJNQK7jtYsr/2tikA0/zYOoiWVof9
biMSeF+0rVjSd9UBsbx12onY7p9wUM8EWoAePAB/A1ScEEKWl/I=
=27Yf
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
