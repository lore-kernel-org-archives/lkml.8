Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C24C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A777C2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzQ6UXfW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgD0L6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0L6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:58:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48542C0610D5;
        Mon, 27 Apr 2020 04:58:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so7357150pjb.3;
        Mon, 27 Apr 2020 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxZ+N+WEssbmNvYM0Ih4yXgwxlPsTEXMjiSj67uczQI=;
        b=kzQ6UXfWXmPDhjr5Kr6e6I7CGAQl72AJrdi96DXZAcYemHOlOt6l5MeYZlLhIziP1H
         dhQxttBUGYvW8YYFkJ8bL3wSfDmAE9hiwsLeD4dNBVP8y6HfMb7zK7sBIFi+co6zQtvi
         XotJpwYJcrN9E6eoM9+JG8Kf0irrHTosM/JqsGbVMvJW+fxLU189DOM68kmPMS7va4V1
         o5hA/mIYrcrzB2iyQVP4w420myfpLxTmZLHpOqgoRia/r32o036ck201A6OqdrTkHsaY
         av1d10Jd+KQPpNlfXdAVJxv4C2FHqmnO4jxll+R6wC7XD/T/82UMt5hMLGHJkr8znuoH
         rtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxZ+N+WEssbmNvYM0Ih4yXgwxlPsTEXMjiSj67uczQI=;
        b=FDnM5tP923QgBBwFHPHXL8kyQO1Hu86WZeqg9l8s/HDLVukXn64FlvDQN/hGNKK7Uz
         26cU0o5AszY4S2PFYcmeEyM0JpY8h0bik8sMbGM+l/+JebLYb+BNg4qmqVeTDIDqKPdD
         y84VOpEBtj3Hpza+fvmaEpcXtVf7Wj2BICdNf+xzJwNhHh14TVJEEl25/DL7Bwt3j0sq
         g01t2ZzqfmihfgZm36XBC20fMvEjDpZWN4IFBGO3eyu4Ni+t8fSsEQ405l/TcWrse+7U
         ETR4wQniXhc0gesSVT9JOoWjbpDjZjgpNFB0FMO6yMiO830Q/NCELQI8p1hgQeuA2+Q1
         U3iA==
X-Gm-Message-State: AGi0PuaJI+pqkx3UjjS0Tuc3aoUQyu+EhlsuCHQuQcpGWvaNNFRpzzgu
        LaJvWJh3dpasCo/71Yu4cUmc1KRj3dxiqQ==
X-Google-Smtp-Source: APiQypLhTM7RPmcqJ6FJZYoAq3I/OsjlHZfp2aDYHvVekpSby3Pmy6nro0GePcz2aOfAuBy7Qx2q5g==
X-Received: by 2002:a17:902:c282:: with SMTP id i2mr22629215pld.20.1587988730802;
        Mon, 27 Apr 2020 04:58:50 -0700 (PDT)
Received: from blackclown ([171.61.45.154])
        by smtp.gmail.com with ESMTPSA id x132sm4992788pfc.57.2020.04.27.04.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Apr 2020 04:58:50 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:28:27 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH v4] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200427115827.GA3214@blackclown>
References: <20200425113234.GA14492@blackclown>
 <8518467.FNpd3NTrYF@pc-42>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <8518467.FNpd3NTrYF@pc-42>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2020 at 11:50:23AM +0000, Jerome Pouiller wrote:
> On Saturday 25 April 2020 13:32:34 CEST Suraj Upadhyay wrote:
> > Break lines with length over 80 characters to
> > conform to the linux coding style and refactor
> > wherever necessary.
> >=20
> > Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
> > ---
> >=20
> > Changes in v4:
> > 	- Added a space after declaration in wfx_get_hw_rate().
> > 	- A checkpatch warning for this commit is retained at line 75,
> > 	  to maintain uniformity in function declarations. (Reviewer
> > 	  jerome suggested).
> >=20
> > Changes in v3:
> >         - Changed the temporary variable name for the memzcmp statement
> >           to is_used. (as suggested).
> >         - Added a temporary ieee80211_supported_band variable to address
> >           the problem in wfx_get_hw_rate() more efficiently. (not
> >           suggested, but still).
> >=20
> > Changes in v2:
> >         - Introduced a temporary variable for the memzcmp statement.
> >         - Addressed the checkpatch problem with wfx_get_hw_rate().
> >         - Restored the function definition of wfx_tx_get_tx_parms
> >           as suggested by the reviewer.
> >         - Added suggested changes for req->packet_id statement.
> >=20
> >  drivers/staging/wfx/data_tx.c | 40 +++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 14 deletions(-)
>=20
> This patch does not contain the suggestions from Dan. However, it is
> sufficient from my personal point of view.

Yes, I considered them but thought it would be bad to introduce a new
variable at every iteration of the for-loop.

> Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

Thanks Jerome, This was my first patch to the linux kernel.

>=20
> --=20
> J=E9r=F4me Pouiller
>=20

Regards,

Suraj Upadhyay.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl6myNsACgkQ+gRsbIfe
746u7w/+PohUp9jD+xMXnW5e8Q49hUyz1vbxWWtc0XF6GlWb8Ki/KOY1kcU6+/Um
ipSXRDD0hcN8sKalisIVY0PWOAnRerg1GUa7mQWZYw58EGNSDEK4oiiKBXBOtEd+
P+p4xXjq5tdNXN767/fK7Qy59tWDvT3Wz5yIudvV5EEq68ZTcCFwt15Q65yhQSCU
vpsqwTTz5ztnYPNLb0aBKOgnvM4W5QHNhOhtBh9QRYeh1EDHPTAMuel38EFCE3tr
B74zOcqgLCGj8nE6pDdXfHx2remYfO7AKfeDk9w9T3Uxo31wwlUEGS8JzX2VaArp
xPJfmcPdx0GIjwvSha9XzUpThD4beXGtETTk+Qmfc9mdC9Vsy9ORA6TVSMglvtCW
VZPT+sQo7M0m7PNU/DdAZiGd9z+/lonv5uP7YgmohkSUiRM/c2e8D3qXcd68tlxJ
LGSm0kHRPdib6QjzsUdmIyGgm12dV1PO1Sc4Vgfa9G/Mlpg9x0Z1Pjf1FZbZEMra
6rrftGxAiOnr7U3gjGhdBruNqfrxvHGIy3712YFqKoT7Yi5haRGg0J8SFTzb+bEy
iEqNsqaxTLn2UDMg54W9qcuXu/U/zDl5pniYoELjANVrB4JuCRUaLpb2f1vp4Gy2
dFBjsbrCAJ3r808r6AzAOSiJCTJhdg6wIsj9E4c6RVUfPY7JbMI=
=eJ/o
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
