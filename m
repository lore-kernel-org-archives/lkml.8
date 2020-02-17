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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61EC761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867AB20726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNkycy8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgBQJwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:52:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43693 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgBQJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:52:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so18809601wrq.10;
        Mon, 17 Feb 2020 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnuBRIDmYb65bxrwzxNLtvttMtj2FBSeswQzxaJFwLU=;
        b=hNkycy8N6UuK9W4/ID73gjJfgPCizEJflJ+FyMSKOnIqkhlc4HeXKJAd5oo/4DZG61
         hHaVBZElW97+qu1Hqea6RD5MUHbOH9X79658clfJ4iCqmU2NGK+yRiy1Ggsnhm0udCxO
         lSMZ6N+Rlx3Gs2f0+AMC60AE5pHgwGiZ96mpOw5WrrbDzJDg7uTbsx6Sdgrr/wYVPLGC
         JV2r7MiORaJiw34O7nI2tD/qPWLyyM+k/eTnM2DLvkcJlb5e72FM/paOglJVIMbk3GkY
         R3gYz6Uj8Z8mB34i6FZgVyIIC/69ltNGQmeIKvGMAL+AQ+NhdmSeiWwq/XZ4yn2fpOy4
         ROwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnuBRIDmYb65bxrwzxNLtvttMtj2FBSeswQzxaJFwLU=;
        b=MNlmCupWTdOadX4UtE9X+fhoG25DLI7V3buz6RTneUjFE/j0AcszZwAXMxihneYOT3
         nrwfKLd6fMa/hR4etNntwHqQYtCRQ7waxUEF65mH5h+Pb2oxbiS/CDdL9XVxYHR6TWl3
         vJLqiUQTdkHYxFd7rY2+QmyIu7rIagkf7lu3YKvv/z/fKjMcZXn+7q3vcA7Zz6lXXOVY
         QKEr6eaw4xEDNCNX3r/zjgcIw0APt/a80EIb1cBq3YxjIpqcKDcYfBRRaSEY//Gxbx/7
         yiaX9km6a/5E22Q/WGODzy6lBOEPtsv5GvMfYgLzg2LymRNPyAjntmclfIAAjJHbbZq/
         lAMg==
X-Gm-Message-State: APjAAAXSRTAVSXeEdqVAj+Dx3PcJr45eAeUr7s/WsWbolWh3B2NTK7Ek
        xufosqrqSF7mArpwSww5eLw=
X-Google-Smtp-Source: APXvYqxRk2ZLPcQLfdvf3n0JMdmde1upiP/bi/Y+QT3nHqJaebCI639WD96R/RymIJtdQ8SG6nDIrw==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr20377228wrn.85.1581933154539;
        Mon, 17 Feb 2020 01:52:34 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id l15sm169780wrv.39.2020.02.17.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:52:33 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:52:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 17/22] ASoC: nau8825: change Tegra clk_out_2 provider
 to tegra_pmc
Message-ID: <20200217095232.GA1345979@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-18-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-18-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:22PM -0800, Sowjanya Komatineni wrote:
> Tegra clk_out_1, clk_out_2, and clk_out_3 are part of PMC block and
> these clocks are moved from clock drvier to pmc driver with pmc as
> a provider for these clocks.
>=20
> Update bindings document to use pmc as clock provider for clk_out_2 and
> change id to pmc clock id.
>=20
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/sound/nau8825.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KYmAACgkQ3SOs138+
s6GxrRAAihq+8+H0SLe9ilINgoYMiaAY6gPvuTZW61dZ2Ha2NyXs55DMCkhF25IB
d3ODCkhYdw413lhlAooJ2twqgm2zasMQ9TN781WpWghavlO+ljjNrOVUdn55nkeG
43Qd15MWCfP5F0rgNh9OC0AGjbVjLLGy+QsRV/80fx5yl10lI9PlGwUfzVsiywdk
YWYrlXvQHbiwX/SxK7SORJDHVGix3Y+L6Gxxer3UGvx05Za6Alav9LP19AlMjlh9
ZRL/DS8yysIqFgPlNCbryn3LHluNSruFhVTXboxvFiJRU6WB/1kXpnoVUWLhBOqt
jQgf13JBi+c8uiHkxdK2N4/VQW2crJGziSbsmbSkrOnRnZ78lcWTEV9lVBy0JcJw
AWZJBadrUSz+3DKefFXBsapZic3gJ48sLgt4OkwZTN57j3+BGsVP3Fn91NfJfokU
+28gibibpYcxzmXj/iM5HC7yc7Qh/lleSYrwtOkrBKeIflVL6e087WfxHm3IMgTu
RmTrtann6aWswPbUqkwT6o9Mr+IJu77onGUkkPNzIq3jijWYNpw4QZz3BYEwSKdU
xaoBR6SAFiudJ1DcKLf50S9lskHO7PL6rgflaf9JvA5TkhQB+F8TiAytUj9uRbtO
tjE9lYDWqw8NMar+d6qvpNw4Bhz1Ck/lsXxUxe4shxaAoorg16E=
=rWpZ
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
