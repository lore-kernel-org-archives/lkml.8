Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10AB6206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590705567;
	bh=Jnk5ZM/t3QA0DK+QEBE25tXLtfv+NGFDuJM220R7+cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m4tpHar3W7gPcMFUMY2E77DzWzWerKHN8bugbTW0Mqxv2WOewGz22RUdIUEvHkXyw
	 chBHJ7EvQiHLXLcVSQYQp8VitWp3hC7Ms3nv/xldzNCZ+1Jbyclyq6hR7fkBVBJAUi
	 iAdaHd/LkJ7idGuuu3/qtYIpU18TrRdt4bYtdmeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437263AbgE1WjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:39:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32942 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437076AbgE1WjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:39:19 -0400
Received: by mail-io1-f66.google.com with SMTP id k18so321783ion.0;
        Thu, 28 May 2020 15:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QywkqwL67CEWYAePg7QpYNEyzSKXdmv9SWfQghA1ISs=;
        b=ib3fossaY7xuh9mh25VkXdPbet9ReC/9WoU6lelVUF9xuwm/cdT6tGv0T6YwqncvPR
         lj3hFeX0+CE24S30sKKJQ2zTg/3auJuQFDdWe4TbQQ4Dpa2dtLRdTGvd0A62vLKQDXdg
         GYC9DaEKXUQR0FgtoUhWbo3ZkiSSXtu/I0TgRfCr93H9t3dU97upuJ5etcW9cInFasO/
         o+VmXGGTwqQnWR+yg1go/YVoFh8tr1cVtM+gGFUbeoXF3LIlnE26AEBQ3+JuZDJjf1n5
         tPemIN1Y22EHB1pdPPBrPwFwhINKwdu0jxqibqLi33XqHXIsoRMpRWGPEkMeJBwzLdMC
         z/fg==
X-Gm-Message-State: AOAM533GCyZDdLs13tTWeyqU+SvRhiNi8aylnLaDRtGtvn+VCLdRRHSH
        h/NCWaaP4x3zhrUU+Y+F3Q==
X-Google-Smtp-Source: ABdhPJxdT116KzRsm49ZPsxopPS2+Jbi/4nXkqdR1lWy+n/aC04YS4g5SEG70cyFhtdhbo/woYL/Gg==
X-Received: by 2002:a05:6602:1204:: with SMTP id y4mr4340823iot.44.1590705557992;
        Thu, 28 May 2020 15:39:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a17sm3708913ilr.68.2020.05.28.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:39:17 -0700 (PDT)
Received: (nullmailer pid 810372 invoked by uid 1000);
        Thu, 28 May 2020 22:39:16 -0000
Date:   Thu, 28 May 2020 16:39:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: care missing address
 #address-cells
Message-ID: <20200528223916.GA804926@bogus>
References: <87pnay3ptb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnay3ptb.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:54:56PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current simple-card will get below error,
> because it doesn't care about #address-cells at some part.
> 
> 	DTC     Documentation/devicetree/bindings/sound/simple-card.example.dt.yaml
> 	Documentation/devicetree/bindings/sound/simple-card.example.dts:171.46-173.15: \
> 		Warning (unit_address_vs_reg): /example-4/sound/simple-audio-card,cpu@0: \
> 		node has a unit name, but no reg or ranges property
> 	Documentation/devicetree/bindings/sound/simple-card.example.dts:175.37-177.15: \
> 		Warning (unit_address_vs_reg): /example-4/sound/simple-audio-card,cpu@1: \
> 		node has a unit name, but no reg or ranges property
> 	...
> 
> This patch fixup this issue.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index cb2bb5fac0e1..6c4c2c6d6d3c 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -208,6 +208,11 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> +      "#address-cells":
> +        const: 1
> +      "#size-cells":
> +        const: 0
> +
>        # common properties
>        frame-master:
>          $ref: "#/definitions/frame-master"
> @@ -288,7 +293,6 @@ examples:
>  
>          #address-cells = <1>;
>          #size-cells = <0>;
> -
>          simple-audio-card,dai-link@0 {		/* I2S - HDMI */
>              reg = <0>;
>              format = "i2s";
> @@ -392,11 +396,15 @@ examples:
>          simple-audio-card,routing = "ak4642 Playback", "DAI0 Playback",
>                                      "ak4642 Playback", "DAI1 Playback";
>  
> +        #address-cells = <1>;
> +        #size-cells = <0>;
>          dpcmcpu: simple-audio-card,cpu@0 {
> +            reg = <0>;

You need to add 'reg' to the schema. This isn't flagged because 
'additionalProperties: false' is missing there too. 

>              sound-dai = <&rcar_sound 0>;
>          };
>  
>          simple-audio-card,cpu@1 {
> +            reg = <1>;
>              sound-dai = <&rcar_sound 1>;
>          };
>  
> @@ -427,7 +435,12 @@ examples:
>              "pcm3168a Playback", "DAI3 Playback",
>              "pcm3168a Playback", "DAI4 Playback";
>  
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
>          simple-audio-card,dai-link@0 {
> +            reg = <0>;
> +
>              format = "left_j";
>              bitclock-master = <&sndcpu0>;
>              frame-master = <&sndcpu0>;
> @@ -441,22 +454,30 @@ examples:
>          };
>  
>          simple-audio-card,dai-link@1 {
> +            reg = <1>;
> +
>              format = "i2s";
>              bitclock-master = <&sndcpu1>;
>              frame-master = <&sndcpu1>;
>  
>              convert-channels = <8>; /* TDM Split */
>  
> +            #address-cells = <1>;
> +            #size-cells = <0>;
>              sndcpu1: cpu@0 {
> +                reg = <0>;
>                  sound-dai = <&rcar_sound 1>;
>              };
>              cpu@1 {
> +                reg = <1>;
>                  sound-dai = <&rcar_sound 2>;
>              };
>              cpu@2 {
> +                reg = <2>;
>                  sound-dai = <&rcar_sound 3>;
>              };
>              cpu@3 {
> +                reg = <3>;
>                  sound-dai = <&rcar_sound 4>;
>              };
>              codec {
> @@ -468,6 +489,8 @@ examples:
>          };
>  
>          simple-audio-card,dai-link@2 {
> +            reg = <2>;
> +
>              format = "i2s";
>              bitclock-master = <&sndcpu2>;
>              frame-master = <&sndcpu2>;
> -- 
> 2.17.1
> 
