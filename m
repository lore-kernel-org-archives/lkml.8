Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D778C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE9F24679
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579177625;
	bh=hRJQLOPnPVf/2ivPsnIuDnw9i76csHuBPFFx5CnsSco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MOrqLlmaNTH9yZVspX+/nx3EGdZIkYCytbsCZr5aylqVg/+y3tRqd4P8VQPSb4x1/
	 T27D0+IKzOvk/rNm6QrUKd7vD214vlWsKPGsAs8Uak7WbSorpS6DeHurszOqYMzeAr
	 rOiKqhCZCtbkt1our3ogod+hlYNGDTwZb0LXlZHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgAPM1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:27:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgAPM1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:27:03 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E2920748;
        Thu, 16 Jan 2020 12:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579177623;
        bh=hRJQLOPnPVf/2ivPsnIuDnw9i76csHuBPFFx5CnsSco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWZE+aaXhLkjD86rfTa/9opKEj0Uc9cyLFhmZff/7iMWkDj9IsHhOeXXjfbg6dg88
         1DVaZHulML9LjANNOADwJkRbPuAEeAFznfmQp1RBQEUGlvHWiW+54HkLfIeMoMQLeu
         RzoOWaKr0DWfDCJinWfilv7BYFQO+QGmsWWCYW5Y=
Date:   Thu, 16 Jan 2020 13:27:00 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: allwinner: h6: tanix-tx6: enable emmc
Message-ID: <20200116122700.2wy2wrgvmyvudj2t@gilmour.lan>
References: <20200115193441.172902-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cgkvlw4sxymxgfmc"
Content-Disposition: inline
In-Reply-To: <20200115193441.172902-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cgkvlw4sxymxgfmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jernej,

On Wed, Jan 15, 2020 at 08:34:41PM +0100, Jernej Skrabec wrote:
> Tanix TX6 has 32 GiB eMMC. Add a node for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Did you forget to send the other two patches?

Maxime

--cgkvlw4sxymxgfmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiBWlAAKCRDj7w1vZxhR
xVlGAQD3brgXo3D11jUsw56mmFTRmlfMXqWKJQmp0FrlJWAUHgEAm9wCD/aZFlvh
k3tke8kPmz0qp0TKQzSu2UBWG7KgZwI=
=zeNt
-----END PGP SIGNATURE-----

--cgkvlw4sxymxgfmc--
