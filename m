Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F435C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E551F20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgCPMyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:54:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:36122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgCPMyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:54:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C502AB64;
        Mon, 16 Mar 2020 12:54:31 +0000 (UTC)
Message-ID: <9d8e1679b755940d85c95d5df8714d4bb3505cdc.camel@suse.de>
Subject: Re: [PATCH 86/89] drm/vc4: hdmi: Adjust HSM clock rate depending on
 pixel rate
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 16 Mar 2020 13:54:29 +0100
In-Reply-To: <abf64b907cd23488e06d2aca4991ac1be216ec8f.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <abf64b907cd23488e06d2aca4991ac1be216ec8f.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-2Nhzgdng4j8pr0d0VEie"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2Nhzgdng4j8pr0d0VEie
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,
On Mon, 2020-02-24 at 10:07 +0100, Maxime Ripard wrote:
> @@ -1460,6 +1456,7 @@ static int vc4_hdmi_dev_remove(struct platform_devi=
ce
> *pdev)
>  }
> =20
>  struct vc4_hdmi_variant bcm2835_variant =3D {
> +	.max_pixel_clock	=3D 148500000,

Just a reminder this might change in the close future:
https://www.spinics.net/lists/arm-kernel/msg793013.html

Regards,
Nicolas
j
>  	.audio_available	=3D true,
>  	.cec_available		=3D true,
>  	.registers		=3D vc4_hdmi_fields,
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdm=
i.h
> index cbb1d3ab85d7..ee9753255b68 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -38,6 +38,9 @@ struct vc4_hdmi_variant {
>  	/* Set to true when the CEC support is available */
>  	bool cec_available;
> =20
> +	/* Maximum pixel clock supported by the controller (in Hz) */
> +	unsigned long long max_pixel_clock;
> +
>  	/* List of the registers available on that variant */
>  	const struct vc4_hdmi_register *registers;
> =20


--=-2Nhzgdng4j8pr0d0VEie
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5vdwUACgkQlfZmHno8
x/5Emwf/c9TYjBffVgvOA41mykLV4Nr8lGqYlbGeCSqOkIJClpTw0XDG/Sam289n
NVS5OpnsEXJWm2HMrWgVqYqZHb3E609pjVeibMyMUhBIvounfpp5kiGI0ZUfCm68
+JarBt0WtkW+731jvBxEnmfWB5j8FpHiZrSJkU5Eo7C7OhIHEAXvU+ZH6TdPqll6
Zjic3+8SBELK0JfFzgB6qkVWFT4UBVpxQ53sokDF+NGROgOEdUkHWxivw9SGvFsg
ewD3v2fbRdUNVTXI/9htZH4I/lupf3byyRQRnx8IWrzI/1U3NzY1xiHU3qEKUW3Q
DQNY46wnSbAgfaRuOCuI0lgcGztljw==
=xZA/
-----END PGP SIGNATURE-----

--=-2Nhzgdng4j8pr0d0VEie--

