Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F3C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187A02469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582905031;
	bh=J8YaD3XysmkNtxkj5J5klSCDqrtpxqc61S9xpF9emqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wTLrVq6SPwykll/Tdx3oo3LA2R7v4rd+et6T8vEhJPicYi6S3mB9+gk4mLm77eZln
	 rfv/XiIgnw6sYiOn+fuW2RxRF05Zdhwb+fHZgZovEy7yBJxuo6dkPNB79CuOd1vqOS
	 4tY4Pl3D0gYfdnoSixMI7Zd5ltQnla4VK8wZETMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB1Pu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:50:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39299 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgB1Pu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:50:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id x97so2984261ota.6;
        Fri, 28 Feb 2020 07:50:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wojIa6rVa31vXzIE/lHtQ3suG/pesMoWRIYn0QkiXJQ=;
        b=GKp2h67x0g8NP8ohkmYCNtxAC1neHe69EKV3Gmk+veYOSGFWBf3aeYq7p2OTNtpln0
         D0hw0+E+MSKf2i92oKFxJtU8PXuYxETff13C9UQdriym0X0D+ZT4Ac/H3kMcOVbFXoQt
         RNJqRwe2oK0AmyEA6ZWv9Ef5pOKIpnB629pCDENjZ0z7Ced68rKvuG0wSp8VzQauA9kU
         6YB8XXLhbbf48NiHFNQRbBBJkDBB9R0Qp72EJyRlmtvKFr5vuwsOmPAT9JjIFwyHDcx6
         PvhdRTm3p/FKKSfH7SwdFKdA/kX7TrvDpD3FJI7wWisYmRLxgFKUkZIiCbInpJcLCVhw
         DBTw==
X-Gm-Message-State: APjAAAVm+k1jTVCR8g0w7F7iesZUDeS1EzqmgQVYpHSckNkv0+BJV+r3
        BfZ26dLziDce9T0rjx1KnA==
X-Google-Smtp-Source: APXvYqwt/R/pC1bGU/7oJf7NOrLG0KKZF7zg8vbj/26gV3Nsi5k0hBqYVdC8MOsZ04YH1PU4R0ebjw==
X-Received: by 2002:a9d:d06:: with SMTP id 6mr3954158oti.176.1582905019525;
        Fri, 28 Feb 2020 07:50:19 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm3271814ote.32.2020.02.28.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:50:18 -0800 (PST)
Received: (nullmailer pid 27282 invoked by uid 1000);
        Fri, 28 Feb 2020 15:50:17 -0000
Date:   Fri, 28 Feb 2020 09:50:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/9] ASoC: meson: convert axg tdm interface to schema
Message-ID: <20200228155017.GA24730@bogus>
References: <20200224145821.262873-1-jbrunet@baylibre.com>
 <20200224145821.262873-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224145821.262873-3-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 03:58:14PM +0100, Jerome Brunet wrote:
> Convert the DT binding documentation for the Amlogic tdm interface to
> schema.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/sound/amlogic,axg-tdm-iface.txt  | 22 -------
>  .../bindings/sound/amlogic,axg-tdm-iface.yaml | 57 +++++++++++++++++++
>  2 files changed, 57 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
> deleted file mode 100644
> index cabfb26a5f22..000000000000
> --- a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.txt
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -* Amlogic Audio TDM Interfaces
> -
> -Required properties:
> -- compatible: 'amlogic,axg-tdm-iface'
> -- clocks: list of clock phandle, one for each entry clock-names.
> -- clock-names: should contain the following:
> -  * "sclk" : bit clock.
> -  * "lrclk": sample clock
> -  * "mclk" : master clock
> -	     -> optional if the interface is in clock slave mode.
> -- #sound-dai-cells: must be 0.
> -
> -Example of TDM_A on the A113 SoC:
> -
> -tdmif_a: audio-controller@0 {
> -	compatible = "amlogic,axg-tdm-iface";
> -	#sound-dai-cells = <0>;
> -	clocks = <&clkc_audio AUD_CLKID_MST_A_MCLK>,
> -		 <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> -		 <&clkc_audio AUD_CLKID_MST_A_LRCLK>;
> -	clock-names = "mclk", "sclk", "lrclk";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> new file mode 100644
> index 000000000000..5f04f9cf30a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/amlogic,axg-tdm-iface.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/amlogic,axg-tdm-iface.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Audio TDM Interfaces
> +
> +maintainers:
> +  - Jerome Brunet <jbrunet@baylibre.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^audio-controller-.*"
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  compatible:
> +    items:
> +      - const: 'amlogic,axg-tdm-iface'
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - description: Bit clock
> +      - description: Sample clock
> +      - description: Master clock #optional
> +
> +  clock-names:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - const: sclk
> +      - const: lrclk
> +      - const: mclk
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - clocks
> +  - clock-names

Add an:

additionalProperties: false

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
