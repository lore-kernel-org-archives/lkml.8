Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC86C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BC24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579597544;
	bh=ufmPxr7m2ZOAh3XqdfXTa6EO7d2PMRSM/BuzEtFjTC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XG9/6MJL3OgfMUFQxVbpvGsL56cn6bM5WhFf4LMB0K0mldNwdDO74vZlzbJ+siUG0
	 g3UrI7VuGLtMyGYYdQ37Qhr6n4BSFP3K+tymwJ+MQwiVoizg59olg4v+5Fb7KQXErP
	 lGvg0fXo/sUzPmRCLiiVY49UE7WEx8SAV27LXcIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgAUJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgAUJFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:05:42 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F54F217F4;
        Tue, 21 Jan 2020 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579597542;
        bh=ufmPxr7m2ZOAh3XqdfXTa6EO7d2PMRSM/BuzEtFjTC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHCpKBpw2Yn+olu7wRFA8zUcrS5UN1jLjBGL/V4TfJ8LrvSOCnWGfnvjLo2Aioe4R
         yWXUDFbXIctRfT4qRw0zyiVWn+OOJHssChKbnMpBFK1QHTf4kpTcEXSi7c57s5YQOJ
         uZ/ROTre4IGgtmrLI9WV0fAUDkVGYAqBgi/gWudg=
Date:   Tue, 21 Jan 2020 10:05:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused
 AXP803 regulators
Message-ID: <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hqrw2yi3mykdac3n"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-3-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqrw2yi3mykdac3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
> The Pinebook does not use the CSI bus on the A64. In fact it does not
> use GPIO port E for anything at all. Thus the following regulators are
> not used and do not need voltages set:
>
>  - ALDO1: Connected to VCC-PE only
>  - DLDO3: Not connected
>  - ELDO3: Not connected
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index ff32ca1a495e..8e7ce6ad28dd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -202,9 +202,7 @@
>  };
>
>  &reg_aldo1 {
> -	regulator-min-microvolt = <2800000>;
> -	regulator-max-microvolt = <2800000>;
> -	regulator-name = "vcc-csi";
> +	regulator-name = "vcc-pe";
>  };

If it's connected to PE, I'd expect the voltage to be at 3.3v?

Maxime

--hqrw2yi3mykdac3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXia+4wAKCRDj7w1vZxhR
xdmqAQDHlf0hiHmdah98FWedObMJK0sLLs07gbOULXST732ubwEAiMm3wesL11VQ
sadVtj5qmCxatUr+NdthMMN8FOVk6Ac=
=uRwg
-----END PGP SIGNATURE-----

--hqrw2yi3mykdac3n--
