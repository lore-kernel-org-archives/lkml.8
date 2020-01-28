Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0A4C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF11E24699
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ALls1Hha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xQCuMAW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgA1MGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:06:08 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34503 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgA1MGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:06:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 26C568001;
        Tue, 28 Jan 2020 07:06:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Jan 2020 07:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=C7BP0Zni9pKQ6yYB1hCeGZ1I8NU
        lPigOIZFHlEK44jg=; b=ALls1HhagVexqLTH/h6HfQDmb56kWRV3I2CWddueYyp
        zcoHkuQocJfc3iJD64htrx9UVO03xUON3tzcfq2iZvR3v+sjX4rcevVgt3EKNqSO
        SY+XDJtBR0zuliU1m93mZW5D9C8X3YM5Ih4zKqsr+C6Hyf5vcpKGUOu8pFI3WoYP
        8NPR2977Bg/W3z2tJi4T7uz3oju0mVcypU14Em2qM53+Fco6SQYzxtitvotctNQH
        cHDhIe76gWf+ObHCvyiGAX510l/8CJXUxo2gzJFKks2+OBqZhU2VpIIo5DXISjG2
        /ZOEyXSZdpDqsW3XneCgkMM+/KCyRxelw3KryCdaLSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C7BP0Z
        ni9pKQ6yYB1hCeGZ1I8NUlPigOIZFHlEK44jg=; b=xQCuMAW0jfCmQEQunw8ckc
        gdQOD7TaUzimD2QZmoSE2J8mMZDngHwkFi/QZdOOS5se5YfkcS3kMKvRtmS7ZxtP
        YLKZNZXSGQjNnbK+IhbFO5zQCUoRir2bHI9LaW/+tt8OhdID4tsdn5SsS7+BktPI
        Y9ZyvuDKA5OtRuZjfcPCU6AvFPowN5FflZwMjsR/nICvHKIUHHjI62ODis1vFsdA
        XXuo3dmib2gMDa26Ccio6x2/KAEceLpTJ4L9xyC8QIE1UpLIWr9BKXsHhpHPdBDa
        ZtVEMbhLkJxTZ10y9IE18jsbvrwRDyzKAemU1LQQynwRCE3bHOTzZTQjv193yJiQ
        ==
X-ME-Sender: <xms:qiMwXjz4XFjhNuzZIlFMMXXas_QkCht5qVWi1dvzwypJoCFkYYzkTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qiMwXnZpF_sOX1hrns5RV2xfBvHmpj8vam49Sd80LHfMyPCFZ7ArSA>
    <xmx:qiMwXjTjxhmPWPtyucRLlIoVwEEsXatcNZb8BpdO-c171B_mKqvmMg>
    <xmx:qiMwXq2RVZj3swcotL-KDtfy-AxtgxApnCbVyogSW44bSWpYEccXhw>
    <xmx:rCMwXlLbckjvPmc6vxiUVBC3jMhpTn_n7BUh9PG94jaLIHH_dTYubw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5D0F73280059;
        Tue, 28 Jan 2020 07:06:02 -0500 (EST)
Date:   Tue, 28 Jan 2020 13:06:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        philippe.cornu@st.com, pierre-yves.mordret@st.com
Subject: Re: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Message-ID: <20200128120600.oagnindklixjyieo@gilmour.lan>
References: <20200128082013.15951-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vfnmhiqen3omgibi"
Content-Disposition: inline
In-Reply-To: <20200128082013.15951-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vfnmhiqen3omgibi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Benjamin,

On Tue, Jan 28, 2020 at 09:20:13AM +0100, Benjamin Gaignard wrote:
> Convert etnaviv bindings to yaml format.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/display/etnaviv/etnaviv-drm.txt       | 36 -----------
>  .../devicetree/bindings/gpu/vivante,gc.yaml        | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
>  create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt b/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> deleted file mode 100644
> index 8def11b16a24..000000000000
> --- a/Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Vivante GPU core devices
> -========================
> -
> -Required properties:
> -- compatible: Should be "vivante,gc"
> -  A more specific compatible is not needed, as the cores contain chip
> -  identification registers at fixed locations, which provide all the
> -  necessary information to the driver.
> -- reg: should be register base and length as documented in the
> -  datasheet
> -- interrupts: Should contain the cores interrupt line
> -- clocks: should contain one clock for entry in clock-names
> -  see Documentation/devicetree/bindings/clock/clock-bindings.txt
> -- clock-names:
> -   - "bus":    AXI/master interface clock
> -   - "reg":    AHB/slave interface clock
> -               (only required if GPU can gate slave interface independently)
> -   - "core":   GPU core clock
> -   - "shader": Shader clock (only required if GPU has feature PIPE_3D)
> -
> -Optional properties:
> -- power-domains: a power domain consumer specifier according to
> -  Documentation/devicetree/bindings/power/power_domain.txt
> -
> -example:
> -
> -gpu_3d: gpu@130000 {
> -	compatible = "vivante,gc";
> -	reg = <0x00130000 0x4000>;
> -	interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
> -	clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
> -	         <&clks IMX6QDL_CLK_GPU3D_CORE>,
> -	         <&clks IMX6QDL_CLK_GPU3D_SHADER>;
> -	clock-names = "bus", "core", "shader";
> -	power-domains = <&gpc 1>;
> -};
> diff --git a/Documentation/devicetree/bindings/gpu/vivante,gc.yaml b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> new file mode 100644
> index 000000000000..c4f549c0d750
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/vivante,gc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Vivante GPU Bindings
> +
> +description: Vivante GPU core devices
> +
> +maintainers:
> +  -  Lucas Stach <l.stach@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    const: vivante,gc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: AXI/master interface clock
> +      - description: GPU core clock
> +      - description: Shader clock (only required if GPU has feature PIPE_3D)
> +      - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)

Can you have an AHB slave interface clock without a shader clock?

> +    minItems: 2
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: core
> +      - const: shader
> +      - const: reg
> +    minItems: 2
> +    maxItems: 4

If so, that check will fail, since it would expect a clock named
shader on the 3rd item.

It looks good otherwise, thanks!
Maxime

--vfnmhiqen3omgibi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXjAjowAKCRDj7w1vZxhR
xS1pAP9nJlkJxokUnmjQfMA6kE2uPIq7zZYoUdYbHV7tme0HaAD+OTNnxQ/8usOY
eEVLroHRRxQBaSRsdwgCM0WebKkj3AQ=
=Hfql
-----END PGP SIGNATURE-----

--vfnmhiqen3omgibi--
