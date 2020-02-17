Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D01C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493B72064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eyw7R/Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgBQJYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:24:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36193 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgBQJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:24:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so18777053wru.3;
        Mon, 17 Feb 2020 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1jbU4TlJlEpdoMWmG20EO03uGvQBbQQBpmr5/axN8pQ=;
        b=Eyw7R/ZtTaHAGBZNWK6oJ6nShrV/sKIR9KMGv/dAVs5q0yZKK0aYAWB/T5qD5TW7Ve
         3U5wx7yZpAVFh1WhsqvCkyuzVrIMGcITnjwmtE490kLnQEegzc2z4fBn+U/Nivhy1KnF
         LnhVlvgtrfzvTdEn9P2v3+3oaIs2iTbBOGFzV4/ZoYJTjRFTTpOmUm3L6126ZLXuwOXC
         Nw1KgN+HD/MCl7uriKDiZGVlDujku7S6JgTOtDBzwMRdiU4f1tswxWNobLoA32O44J/8
         /p3/ZvmiW0kyztyIbXQktjhV+4hnPPk1sNuumOCjrj+qEEXvoLoWbr6e5yJDOKwC5+L2
         ee+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1jbU4TlJlEpdoMWmG20EO03uGvQBbQQBpmr5/axN8pQ=;
        b=lyOCGID5i2balkIQy3j27qBekLlvHFc8kdImqgRxsbUSj+S97QLbx1Y+Kfyw+0vsMu
         2YnhY8Zgc4/0YWHC34gIsE7W3MJEz1tTlstfsOhrORAj1kLKPIIgwmgVaYzoxjOn7nyZ
         b5xJ3Z0Z9b3fP1X1qtNCQlxv87XGu3/00iOoUPh6GJ27QjGHvjPoe+9g9Qg0LHleUXdB
         HRZp94Goxll+OAmZDB+OFo2kZrjVKNbnUKvFacPhSpu7gQAGsq83lY4bFXI6DjqOyH76
         ppiIWYGYyV4m4ZJe+R5ePAVKNNo1wsNaU4ETvxjV16ri1io1uGPE5Vs0lb3nIfmvGc4l
         CBnA==
X-Gm-Message-State: APjAAAUs9y4nUZeyYaEF+cNqgDebUz8e4bRYw+0g7uBCe65R/+NgfCcr
        7CrYBCQPAHrgh5hkbYrVSTA=
X-Google-Smtp-Source: APXvYqxHC3wzpIrAycvagZ9MJQLXYisuao7zJ2nHWSOBrxr7L5QWx319+nibcU2MpAGz6ijfEZv2kA==
X-Received: by 2002:adf:fa43:: with SMTP id y3mr20785507wrr.65.1581931466884;
        Mon, 17 Feb 2020 01:24:26 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id y7sm53442wrr.56.2020.02.17.01.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:24:25 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:24:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jonathanh@nvidia.com, tglx@linutronix.de,
        gregkh@linuxfoundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: Fix a typo in Kconfig
Message-ID: <20200217092425.GK1339021@ulmo>
References: <20200216161748.21894-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline
In-Reply-To: <20200216161748.21894-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2020 at 05:17:48PM +0100, Christophe JAILLET wrote:
> A 'n' is mising in 'commuication'
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/firmware/tegra/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-5.7/firmware, thanks.

Thierry

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KW8UACgkQ3SOs138+
s6FbnhAAmQgt8qy8o0BICDHNatpwIIywn9ZdnXsUKIgec9XPCnPCZ1LUEkDKm6ks
ooXRmYaYTkLDZ4KeRsrBYgD9ngK+hcEcnTOsHywrI3GiiV2m7/nnyA6ASgOd9QEH
Pn7xrftP5U9b8FqUYxt9t6WYw6BWOaOe6Hpq6Cau6y7Msr5OCO0/SxYrfd5deWHy
gFAQfIBYy8xmjkwUf77ghSs56jiSrsCajH2ltrSwQZjLSEstSfLlomVugrc4Vsf8
qTeGGXGQE8ApG6NcuqnLcpYCtP5pvLgQ7R2xaOKtmDXedau8V4BPXQQKvXTCJfcc
Ly/yvseuCMfH42Q/S2PI6iaVyf0U1gGNix/HkCO/N0RD6Jve4gDs1+qR5LfDKEII
u8GjZPb8AlgpKR+tXIaPViM7TPYXPLpHamSERsgA0KOMj4mineT+Eji0/e/cWc2o
pXF10HzD/as6r9MxOnqgr3dZhxlACu6ZRklmzkQvbQ3GDdTvR2EIXxWeosXJZRHo
9VdHFcjUdhGf1EDekc/0FTOYBNzxh5h+O3ceQZF6BdlM1IEiK1UeV7kYAjGDpEEL
aFrKSCkcEpdOEYXy/kNhQyrKTFHOGtIKQf8wSyXoqm+tRCagNRu7hqIc8CGOBh+z
IyDtGKn1Rhb/SD3mmz9EmTL+mtWniOw6Ukq97v/UxGpCY8zUdNs=
=fk0G
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--
