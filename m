Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5F9C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE5E20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582650979;
	bh=nQttMMjESw/GV0+wSXlMHBnEJzbdbpLJQA9bpevJawA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y53swFO49Y0PhWCcywys3UuKt8IYXLhM4aCaf0emMSO/TqDItQe5C9ZSEMSUq8b16
	 v5lmKCxZ+C0fjtwtChLHSzfR9TjK/TGIZgd05ikpXnwpDOvH1orXyRfDvZkT3l0mNj
	 iwVZ8b+CeKpsDHu/0S1dDgnW5uoUbm8k5e0K3A4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgBYRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:16:17 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42055 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgBYRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:16:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so207150otd.9;
        Tue, 25 Feb 2020 09:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OE6eipVQm4bME6AE3KlIKW+8PF5MdzZLKNm5AdRaXEo=;
        b=rQIg1GE9eyS2IYLsDHR+TS+HDM1TYbDc2yE3+37bHhHqqkZmndvlcEaOFZYA8OnToe
         ioULHnqI0zfsC4wlDvHbgeFDidMitC46awjuibVOQaXlPEHVwIhXJLRiTP+hno/Atd0G
         n+iug7+8WQzUwF91tmB2gRq1vIX6X+lb+1h2QWfhYTpBEMS67Y3Tmwjqsyp5Kmu3nOTO
         kHKtANq8l1qexkZnIMCxppS+HZSCX2uwdKKSJUgLb9fO0w6HUrIRprZvuhvZlLaztcLV
         RKIEkdkzqgqYApBT6S3G5VLYjtbFBgIlVC05l7SggAZiLPGdyGvs1NYThjZwkM5eW0c+
         cEPQ==
X-Gm-Message-State: APjAAAV8fVy0J56cGDblE3n1K24Wl9kp9gE0HFxsiSwOieZJcA9SB4Q2
        B4baGbBAIqr35K+zzoGQcw==
X-Google-Smtp-Source: APXvYqwU0mKHqcSecaw+GXPaK947LH2SDNl/9+T8PUAMCjq938LQ4s7sM8N5fIiMZJA8eWGLsGru4g==
X-Received: by 2002:a9d:760d:: with SMTP id k13mr43428788otl.42.1582650975368;
        Tue, 25 Feb 2020 09:16:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t21sm5863311otr.42.2020.02.25.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:16:14 -0800 (PST)
Received: (nullmailer pid 13718 invoked by uid 1000);
        Tue, 25 Feb 2020 17:16:13 -0000
Date:   Tue, 25 Feb 2020 11:16:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
Message-ID: <20200225171613.GA7063@bogus>
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-2-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207052627.130118-2-drinkcat@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:26:21PM +0800, Nicolas Boichat wrote:
> Define a compatible string for the Mali Bifrost GPU found in
> Mediatek's MT8183 SoCs.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
> 
> v4:
>  - Add power-domain-names description
>    (kept Alyssa's reviewed-by as the change is minor)
> v3:
>  - No change
> 
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 4ea6a8789699709..0d93b3981445977 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -17,6 +17,7 @@ properties:
>      items:
>        - enum:
>            - amlogic,meson-g12a-mali
> +          - mediatek,mt8183-mali
>            - realtek,rtd1619-mali
>            - rockchip,px30-mali
>        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> @@ -62,6 +63,30 @@ allOf:
>            minItems: 2
>        required:
>          - resets
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mediatek,mt8183-mali
> +    then:
> +      properties:
> +        sram-supply: true
> +        power-domains:
> +          description:
> +            List of phandle and PM domain specifier as documented in
> +            Documentation/devicetree/bindings/power/power_domain.txt
> +          minItems: 3
> +          maxItems: 3
> +        power-domain-names:
> +          items:
> +            - const: core0
> +            - const: core1
> +            - const: 2d

AFAIK, there's no '2d' block in bifrost GPUs. A power domain for each 
core group is correct though.

Rob
