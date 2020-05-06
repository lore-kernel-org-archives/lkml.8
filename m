Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4CC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD082070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588795834;
	bh=KoHL0QMrNi4SeTbZjTo/wlcbRErKVLsokjGXsQ/8N1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wha94nRfdQvuJOVlsYhKgxAPOiIT5qDtgfSJtkqaR4iW1r4YQy4VLyBf9BPllPbLi
	 sI7Zgkg+g9vvqr3NoBbAFJPOnyayXMY9Xnp99iUPoEhL0eRinWTRVpeFGcIM1dS7Jv
	 QN6gVvUDFjoWMfJZXurA9BQHC2mpGWb4X7yVQNSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEFUKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:10:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42009 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEFUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:10:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id i13so2927857oie.9;
        Wed, 06 May 2020 13:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kr9G0io6GcOAL+vMLpiHMdNZyvsp/S0aghS63cxQZpo=;
        b=MG5wybrJJBbH1dn6FT9f29WHseJoQE6ErI32jj/DlRv9ITAfahJgknh6703jjbWtMA
         ojwXaOYp2qFv9kbigWV2uJiIgmH7wWVQizyM4Y8I0Ef0l9hJxza1GwW8Qv0pwiOq8mrx
         U4z/Vv9mnfof8KhScwMc1OEW7A2rd1BZI9/+d6Cgz+99HU50IQ3Y+qQcyAbJkCPKpnq3
         FudVDV8XgOS1W8jR0YJ9R/0f9jOxfkASzsgk0TDWXCj+P8rlk4IoSIHIjs0aZ2eA+xOq
         yDAzPPwCGY2wGFZoTfRKz1x6rQSFhMW9BOYWhSRy8FGgXfUcReDXAuDcgmpZakzAqllq
         BDnQ==
X-Gm-Message-State: AGi0PuYNY5MmVnrt5SRHbyIdiJ/g84/fR6rvCqZJuXOW+kEqlkFSbqrp
        WtxWZlseEWtmEJwRhmJ0nA==
X-Google-Smtp-Source: APiQypKRKlHn1JxPJ2QPh/ADqVMmgsz/+XWbdIoDk44iIftBLeGvnMfd1duy/J0Dd6xx5aDLGDr57A==
X-Received: by 2002:aca:4982:: with SMTP id w124mr1394719oia.167.1588795831480;
        Wed, 06 May 2020 13:10:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d61sm754458otb.58.2020.05.06.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:10:30 -0700 (PDT)
Received: (nullmailer pid 6640 invoked by uid 1000);
        Wed, 06 May 2020 20:10:30 -0000
Date:   Wed, 6 May 2020 15:10:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4642: switch to yaml base
 Documentation
Message-ID: <20200506201030.GA2041@bogus>
References: <87h7xdv2m6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7xdv2m6.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:17:53PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/ak4642.txt      | 37 ------------
>  .../devicetree/bindings/sound/ak4642.yaml     | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4642.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4642.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4642.txt b/Documentation/devicetree/bindings/sound/ak4642.txt
> deleted file mode 100644
> index 58e48ee97175..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4642.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -AK4642 I2C transmitter
> -
> -This device supports I2C mode only.
> -
> -Required properties:
> -
> -  - compatible : "asahi-kasei,ak4642" or "asahi-kasei,ak4643" or "asahi-kasei,ak4648"
> -  - reg : The chip select number on the I2C bus
> -
> -Optional properties:
> -
> -  - #clock-cells :		common clock binding; shall be set to 0
> -  - clocks :			common clock binding; MCKI clock
> -  - clock-frequency :		common clock binding; frequency of MCKO
> -  - clock-output-names :	common clock binding; MCKO clock name
> -
> -Example 1:
> -
> -&i2c {
> -	ak4648: ak4648@12 {
> -		compatible = "asahi-kasei,ak4642";
> -		reg = <0x12>;
> -	};
> -};
> -
> -Example 2:
> -
> -&i2c {
> -	ak4643: codec@12 {
> -		compatible = "asahi-kasei,ak4643";
> -		reg = <0x12>;
> -		#clock-cells = <0>;
> -		clocks = <&audio_clock>;
> -		clock-frequency = <12288000>;
> -		clock-output-names = "ak4643_mcko";
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ak4642.yaml b/Documentation/devicetree/bindings/sound/ak4642.yaml
> new file mode 100644
> index 000000000000..6cd213be2266
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak4642.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ak4642.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4642 I2C transmitter Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asahi-kasei,ak4642
> +      - asahi-kasei,ak4643
> +      - asahi-kasei,ak4648
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0

Need a blank line here.

> +  "#sound-dai-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-frequency:
> +    description: common clock binding; frequency of MCKO
> +    $ref: /schemas/types.yaml#/definitions/uint32

Already has a type. Is there some range of frequencies?

> +
> +  clock-output-names:
> +    description: common clock name
> +    $ref: /schemas/types.yaml#/definitions/string

Already has a type. Just 'maxItems: 1'.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        ak4643: codec@12 {
> +            compatible = "asahi-kasei,ak4643";
> +            #sound-dai-cells = <0>;
> +            reg = <0x12>;
> +            #clock-cells = <0>;
> +            clocks = <&audio_clock>;
> +            clock-frequency = <12288000>;
> +            clock-output-names = "ak4643_mcko";
> +        };
> +    };
> -- 
> 2.17.1
> 
