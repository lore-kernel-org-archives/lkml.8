Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF04C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D0A21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="T0YorMCf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lA/EzX47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBYIe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:34:59 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48853 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgBYIe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:34:59 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3B8DE853;
        Tue, 25 Feb 2020 03:34:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 03:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9kSU8w3jBGIrw5Q053Vxj9KY2Y+
        nKYIvGD2PhfyOey4=; b=T0YorMCf0+rEEa934N7nzZBdWBY0o/SVFDZ+XhifHgr
        WgLeGOeD4yV8pcCJBSjhwDhfnUNdb+uLRDYSQ9lnsHuQFD8rOSr4r4dC7y/j3E3a
        JtXiCAFIw7N6ewGenf/5JzlkYGpbDPeIMJW8C7fc/ePaszsZrVfKmN8T8YTcIMQ4
        m4JCeqP2PM3+FwuFK4lmlxCBo9rQrOmeTKM3HIQqvfou+baH5kA/BOMstDsLXaqa
        j0F3tzzj892+CKAsnwOeCXKYazYf0fwiPshsJL3EkXhhmFZjYAkAwEf+lvtM9AXn
        UqsvpyQC4owftpUe6H3pCpuuPz35qTkvx4lTgC6R14w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9kSU8w
        3jBGIrw5Q053Vxj9KY2Y+nKYIvGD2PhfyOey4=; b=lA/EzX47ZBx2aQdDy2KC4a
        AdyZm/wlaYQlEObqpB91w+5eR69bZWfc00djRaFamhSCaMLpKqrD9UhWjj+ZYj+c
        ovIe7GiSkfUfwZnN2gtqjyqQrqIWevWCipGjdjdN/edj4rcUAf6Ko38wbVK6zCpV
        HXxbOQ0jPsIHYjP0EX0mSnIlkpycTR9UJ2kNslKyFwL9gQVwfIZRgbJ0rNCmV9L+
        9O66fQSZ0dcUU6VgH6aYx6Wc9QIbYFnf1yrpZjY8V2oMk9A4z/E3Im4BKSKYIDHq
        AkoL4SapeiVR0lp6+geO88IqFTkaTlVjmpAqW0Z7wdAQiKyxcAlfAjWNM3DPaxKA
        ==
X-ME-Sender: <xms:K9xUXrTQWHvyUtmDUxF7eyqK4j3o9FDdueedOd8v1wBsVIwpp1Pssg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledugdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:K9xUXtjyGMnPTuA0UZsF1FgUemWAiOaXjjJKPoTTsN71B-UunWMaow>
    <xmx:K9xUXkq14szlvdvqLPJ3dUbO0Ifslgh_Ej04b7Le-2EIIQDG36sdgw>
    <xmx:K9xUXslauZGdPj6MDsRVbk4CVQ4da7oqdN_UHSxFhiiyIvPB7E5OZg>
    <xmx:MNxUXvFnhCewy2L7KIuYi2X0NBlYPEoURX5_jpKCGGffgvJI6LwMyQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C15AE3280059;
        Tue, 25 Feb 2020 03:34:50 -0500 (EST)
Date:   Tue, 25 Feb 2020 09:34:48 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] drm/sun4i: de2: Don't return de2_fmt_info struct
Message-ID: <20200225083448.6upblnctjjrbarje@gilmour.lan>
References: <20200224173901.174016-1-jernej.skrabec@siol.net>
 <20200224173901.174016-7-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="57z5sn3fwlsnyvo7"
Content-Disposition: inline
In-Reply-To: <20200224173901.174016-7-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--57z5sn3fwlsnyvo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Feb 24, 2020 at 06:39:00PM +0100, Jernej Skrabec wrote:
> Now that de2_fmt_info contains only DRM <-> HW format mapping, it
> doesn't make sense to return pointer to structure when searching by DRM
> format. Rework that to return only HW format instead.
>
> This doesn't make any functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 15 +++++++++++----
>  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  7 +------
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 10 +++++-----
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 12 ++++++------
>  4 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index e078ec96de2d..56cc037fd312 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -27,6 +27,11 @@
>  #include "sun8i_vi_layer.h"
>  #include "sunxi_engine.h"
>
> +struct de2_fmt_info {
> +	u32	drm_fmt;
> +	u32	de2_fmt;
> +};
> +
>  static const struct de2_fmt_info de2_formats[] = {
>  	{
>  		.drm_fmt = DRM_FORMAT_ARGB8888,
> @@ -230,15 +235,17 @@ static const struct de2_fmt_info de2_formats[] = {
>  	},
>  };
>
> -const struct de2_fmt_info *sun8i_mixer_format_info(u32 format)
> +int sun8i_mixer_drm_format_to_hw(u32 format, u32 *hw_format)
>  {
>  	unsigned int i;
>
>  	for (i = 0; i < ARRAY_SIZE(de2_formats); ++i)
> -		if (de2_formats[i].drm_fmt == format)
> -			return &de2_formats[i];
> +		if (de2_formats[i].drm_fmt == format) {
> +			*hw_format = de2_formats[i].de2_fmt;
> +			return 0;
> +		}
>
> -	return NULL;
> +	return -EINVAL;
>  }

I'm not too sure about that one. It breaks the consistency with the
other functions, and I don't really see a particular benefit to it?

The rest of the series is
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--57z5sn3fwlsnyvo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlTcKAAKCRDj7w1vZxhR
xbG/AQCdfXPdzBwfYeiileC/tgUBlbw25nOpOnTqJMZ6pUn9BAD+LjaVwxmeURaM
km8XKQrZgLqfHMwMSCXbyzvGpMgUegU=
=YHGI
-----END PGP SIGNATURE-----

--57z5sn3fwlsnyvo7--
