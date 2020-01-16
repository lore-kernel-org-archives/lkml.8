Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFE8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579162017;
	bh=kmovhnOdTNZF+05ykgKH5WX6MCS0s6lAPI/WYzZejfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SxWIHNlhhIzbwyRPRQ1nvQacTMtJVR1dGkj9rvZvll4Fy9HTUgHHpsvJgoSXtYCR6
	 jjRdMrdCw0OXcdtQdrf74QPnFkzfyulHlAL7GGo0EFc4rXEAwKVMoFVcBJYC4ZgguF
	 H+gX4MqMnyh50Db8eLet78R3Fk8S6re/ee6cqoLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgAPIG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgAPIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:06:56 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D1E2077B;
        Thu, 16 Jan 2020 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579162015;
        bh=kmovhnOdTNZF+05ykgKH5WX6MCS0s6lAPI/WYzZejfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCEXiojqof9qt7912bwlCFqbdFjcEVrnU04HWRVU8DZuzR9+zWv2GufSGeRf3NNPY
         wLsrUqw3CbnAn/rbF4fNE2C2VdgWy9FzamqLtF6I1PXrfNa6W8q8wSefQyQcBgRtsH
         fRvonWTSB+5Vz+tdIZOcvJuglJZgx5bwdOapkMek=
Date:   Thu, 16 Jan 2020 09:06:52 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Use internal
 oscillator
Message-ID: <20200116080652.mp5z7dtrtj3nyhpq@gilmour.lan>
References: <20200113180720.77461-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3pzc2q6hpze4pego"
Content-Disposition: inline
In-Reply-To: <20200113180720.77461-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3pzc2q6hpze4pego
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jernej,

On Mon, Jan 13, 2020 at 07:07:20PM +0100, Jernej Skrabec wrote:
> Tanix TX6 doesn't have external 32 kHz oscillator, so switch RTC clock
> to internal one.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>
> While this patch gives one possible solution, I mainly want to start
> discussion why Allwinner SoC dtsi reference external 32 kHz crystal
> although some boards don't have it. My proposal would be to make clock
> property optional, based on the fact if external crystal is present or
> not. However, I'm not sure if that is possible at this point or not.

It's probably a bit of a dumb question but.. are you sure the crystal
is missing?

The H6 datasheet mentions that the 32kHz crystal needs to be there,
and it's part of the power sequence, so I'd expect all boards to have
it.

> Driver also considers missing clock property as deprecated (old DT) [1],
> so this might complicate things even further.
>
> What do you think?

I'm pretty sure (but that would need to be checked) that we never got
a node without the clocks property on the H6. If that's the case, then
we can add a check on the compatible.

> Best regards,
> Jernej
>
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/rtc/rtc-sun6i.c#L263
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index 83e6cb0e59ce..af3aebda47bb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -91,6 +91,12 @@ &r_ir {
>  	status = "okay";
>  };
>
> +/* This board doesn't have external 32 kHz crystal. */
> +&rtc {
> +	assigned-clocks = <&rtc 0>;
> +	assigned-clock-parents = <&rtc 2>;
> +};
> +

This should be dealt with in the driver however.

Maxime

--3pzc2q6hpze4pego
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiAZnAAKCRDj7w1vZxhR
xfp9AQCqNNEBQxQevPB260RWbeeZq1fZKNeOc5q4PJQniM8vxQD/T0iCbunuJWB3
Af65fnaGfBRmzV4wO0oHexIh7gFK6g4=
=C6EU
-----END PGP SIGNATURE-----

--3pzc2q6hpze4pego--
