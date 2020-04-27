Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4E0C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECDB2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588023124;
	bh=vbxxqbvOSU0K7/JC6UZedlWWfjGAuX6Os1+u0cSki04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BqTd92PiRGfpseUo3kG9Zz5p+wtJg+rwnLFtpmKKvqN9JxiUaX9Ofiue+wsSpv5yz
	 FfBlFzWewRiaLllxTJKG/4RcBHzP4pSVtCDkpqZt9b80HnxMK0Yhy8WPMDTl7yJv8u
	 6Qe98Rbya3/rXiO/KwKmmofnklFpkA7MUtzuguUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgD0VcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:32:03 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43329 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgD0VcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:32:03 -0400
Received: by mail-oo1-f67.google.com with SMTP id h23so1617378oos.10;
        Mon, 27 Apr 2020 14:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w1uDZO2LdODIUIXzVhRK1SKj6P79fg3brB4R+H6ilss=;
        b=KHukn1nWzcbjVWaSOImjd+Dj+FhKvIUcTHwLygijVnx56z4A7yXN5dmtA2/M8xhu8h
         j2iPdOqpeuJgkfd7TeNW0BjAiyw+aAxBZl5qOHRJwR+7cGfMWUBUqh8OvYDvrQWpos2+
         M+6V2FK3cAIh0XWw1kXLakD7BX22beCm3O4D29EIRblx/CaMBOXtJ/xZb/u/0NVzC2n0
         Np3u2brFgj7bt9z/y8CYy2PrLvC317J9vn+2h4DTVOk+s9Ko7qizZTkX9nG5WYiQJ0t2
         ciFA6ajE9c67ecBrRnU/8BsOXI2qMGlZfr1wxEMt8NYwQx/BUAYQdabt8E+GM9BtQAGY
         2gjw==
X-Gm-Message-State: AGi0PubGQXZJfy66hCsUAHVHyU0Mt1xnyjabP3taonLIPqQ6opbUWNRw
        WjTAkiuzerLpPRQRsnkoxg==
X-Google-Smtp-Source: APiQypJf8rbZu6QH32eGiwrCo4i51dejGBYEAQsVJu6W92eQMIOBXv+t0wckN+3tyVZcrQoflUHTxw==
X-Received: by 2002:a4a:3e8b:: with SMTP id t133mr20894000oot.52.1588023122070;
        Mon, 27 Apr 2020 14:32:02 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u1sm2015687oif.54.2020.04.27.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:32:01 -0700 (PDT)
Received: (nullmailer pid 31301 invoked by uid 1000);
        Mon, 27 Apr 2020 21:32:00 -0000
Date:   Mon, 27 Apr 2020 16:32:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 27/91] dt-bindings: display: Convert VC4 bindings to
 schemas
Message-ID: <20200427213200.GA30618@bogus>
References: <cover.d1e741d37e43e1ba2d2ecd93fc81d42a6df99d14.1587742492.git-series.maxime@cerno.tech>
 <abfe72e59b796c86820d933bd81ba5ae0699e5b6.1587742492.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfe72e59b796c86820d933bd81ba5ae0699e5b6.1587742492.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 17:34:08 +0200, Maxime Ripard wrote:
> The BCM283x SoCs have a display pipeline composed of several controllers
> with device tree bindings that are supported by Linux.
> 
> Now that we have the DT validation in place, let's split into separate
> files and convert the device tree bindings for those controllers to
> schemas.
> 
> This is just a 1:1 conversion though, and some bindings were incomplete so
> it results in example validation warnings that are going to be addressed in
> the following patches.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt              | 174 +------------------------------------------------------------------------
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml         |  66 +++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml        |  73 ++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml        |  75 +++++++++++++++++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml         |  37 +++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml |  40 +++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml         |  37 +++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml         |  42 +++++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml         |  34 ++++++++++++++-
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml         |  44 ++++++++++++++++++-
>  MAINTAINERS                                                             |   2 +-
>  11 files changed, 449 insertions(+), 175 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/brcm,bcm-vc4.txt
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dpi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hdmi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-txp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-v3d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/brcm,bcm2835-vec.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
Documentation/devicetree/bindings/Makefile:11: recipe for target 'Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1276439

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
