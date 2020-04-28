Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037AC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFE8206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 10:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8P0NejM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgD1KRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgD1KRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:17:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD365C03C1A9;
        Tue, 28 Apr 2020 03:17:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so22347872wrx.3;
        Tue, 28 Apr 2020 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PaOE7EKh8O20/7Yms9xkw0YwXarsNSTkVwVY/irSTwI=;
        b=R8P0NejMyV1PDqJHKa2KbMse3xkmH8lrC5aVCpQIQfbYimB6ByrYkdvxXRPTIF1hhf
         3UWs96bgNm4OJwe1RQIRSSkCRvzUJ8GQfJ2CwFrMcDkUHqJBmOm438on6tQv9Wl1KT4d
         21niGjPBlWfcXdcJuvCcTMhypz4LjeUMEh6f14IxZvgLBvX53lAOqQ5RJDV5ywmsTrme
         fqxe+B6MCXAz4QUXEsT/u7ontkqWn/rBV5jQOmoxDjeLv0Sh9YiqdxCm36XEUxwhPJzd
         zHIUONuOD7Xh4DuF49pJHmaUnohR0PSFwVHqq5pfBL3aJ+bg5unzDI8vkb9S63KN6QZk
         gDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PaOE7EKh8O20/7Yms9xkw0YwXarsNSTkVwVY/irSTwI=;
        b=MMw3022hnZjwJShO0KvGBEU35cEMjowze+7bexzv9li5v3fxNTjZHwXPYcy1QJWcZi
         l9CLamrYcSeiQf24VSzxSPeeqKyzt/hym5k0TBWAJ7JRnlm1HBmckkea7ljBV2yADTJS
         LhAs2jH4WZgop0rWSMoHj3hxoww6wmGVzqNpyxpcKdc5cUcUm8+JPd0RjzdAnrsBjSS6
         m8NJjZmHwlqfwftx9TroBi+0YTFJR+0Rq86dpe3oGKKle36pMqbZXD+oobu9J6GYO5LV
         dTV6glElMoTa/AeiRoMPEA2w5iZwqlG3r2slurT825dM4OD1aocrk7ig4VMnr3ERIxTA
         PfKA==
X-Gm-Message-State: AGi0PuZeLCbfn0GywMn9FD7rZEnDImcXnzr3RlIGeh9pMBfRuY44UHtg
        K7Auirg6wQi0sfw8DkAXeagXZmj/
X-Google-Smtp-Source: APiQypLxLZtVaWlIaYwOkXS3QvuWCKzZ7uVHba7bLh7gUGi0QAF6deX5ljtvnpRZxHDbTtXx/9wAQg==
X-Received: by 2002:adf:fe51:: with SMTP id m17mr32016729wrs.414.1588069062479;
        Tue, 28 Apr 2020 03:17:42 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id m15sm2626066wmc.35.2020.04.28.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:17:41 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:17:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/8] phy: tegra: xusb: Add USB2 pad power control
 support for Tegra210
Message-ID: <20200428101740.GG3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-5-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-5-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:04PM +0530, Nagarjuna Kristam wrote:
> Add USB2 pad power on and off API's for TEgra210 and provide its control
> via soc ops. It can be used by operations like charger detect to power on
> and off USB2 pad if needed.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra210.c | 190 ++++++++++++++++++++++++++------=
------
>  1 file changed, 133 insertions(+), 57 deletions(-)

Ignore that previous comment, I was making wrong assumptions:

Acked-by: Thierry Reding <treding@nvidia.com>

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6oAsQACgkQ3SOs138+
s6HgRRAAkKBpdIifr13ah+O4pd7JwhNKw9JYwDfzVCGukWCrfD8Y/gZovptA53ww
MtcogouhBKZgyH9D0qRFPhDJGOBSgSn+MwQRfIXzsYVXrllvCACvhD7iFs1ACJ+L
wFGllBYVRByCUnXrGB6fZAe2my9D2+gzOtDjDjC7fZZE20jYewyVwG1TL3F1fMCd
arkdvSki+qOmwEgjaYfOypgZmj9Lgn0ty9q/XCYg48oStgFOutFDEL/au6ncBfv6
L+/bOwwJ63o+Fa6P8p70Sx+dPjjWkHAgqrD09BAHCG9Xi9qosL/T7XHTw8odQoPA
FRFnHnh/TEexCInco3nBGE77opKnsl/Jrdnd7YgK2F+O31vcrQ4LKYPefTKwR7se
oxvHjodo6PIS2hKzn4pKqUX7D6KGVZXwXEGipvdWRTZcx7zewOMmcUF6dPbMuzvk
6J/YRh2zcbidu/FmExilZK7RSehzORSSTcvvlRHN4aoH07tWCMzFOYBCmbwDjEYj
syMOBDw83hPdwbYHAQae1sKiKGciRQmHyORwjwT2RR6fNq0Zr3ssq+q6ZVZybjGT
Bu+O/i670oGR9Nn7OKi/LKM+v4dJS17KrJNn66j/mqVTgRGO5blIFySlSqYPNN5t
hkA8fz67jresVycjbbWe0qUHiYp7N9hn4eEntxMih7YgSf1gvtI=
=76s1
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
