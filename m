Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719F4C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D43520838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582569672;
	bh=+XXUPs2oohHv/fZQpL9avJbDIDH/nbm3i/u9TygkMo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K0zLkAlsk7dou0Lc6FulY1IgE8mbXC/iFL1z6aKe3Uc9ADTTYo1SHzF+kORU6kLkJ
	 cBla88R0cDUt3P3UNYwz5kfSpOPfn/8hPwE0LefQ3VBbggJxzieOREvLYOsGP5TgKV
	 lqXUw+af6pNZsEBaJYwELLlOY1kUveLgpF6JnE+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgBXSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:41:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34724 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBXSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:41:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so9683567otl.1;
        Mon, 24 Feb 2020 10:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sVRf7GGeylhrZHXm0oszIDVdS6Xo7uktXxhGGTwofg=;
        b=iydNxzvclwjihQb67loXDkI8fF91EHbg9XHu2Ik2mIzwnEOWCM9bB33SM31iz1pXO8
         A9A1kQFNAZ9RbDV9LkDcTsssEIZoq/d1mcvRd50vZ/eh2tuMSmT0hmqSAS0xLjavUlfn
         P29+S9PK5vC2RvxTsj2r3+yjqXBzku0WOfQvpkT3kv6M+nIxbXMja/M35gv1RpIindjy
         AERUuuuJbG43MqZgMt3wLus7w9Yi8dvbDeDVe/Z/xKj8v0YM0xrCvwMSE9Siyk0EodaP
         fU6RwolapCkZNJRYhq1IG4fil3hdRY2opJ6zNxvE+DMJF7kOTPON06pzC2CAdH9aulbl
         J8dA==
X-Gm-Message-State: APjAAAVhWJ69d5jXUqxbxJp/wdGnA3DUoqnwtPUhxN/lqLbuHjPGvU3r
        Lj9m75qC9+Guh1iCKelYrw==
X-Google-Smtp-Source: APXvYqwOcQ+Wis2rH/zphuGcXoi5E6fO/77Hc1wq8cqj519RKyKMhXx/ovrxEJoXA98US2+hSw3maw==
X-Received: by 2002:a9d:6e02:: with SMTP id e2mr42973744otr.194.1582569668643;
        Mon, 24 Feb 2020 10:41:08 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm4685288oto.62.2020.02.24.10.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:41:08 -0800 (PST)
Received: (nullmailer pid 5865 invoked by uid 1000);
        Mon, 24 Feb 2020 18:41:07 -0000
Date:   Mon, 24 Feb 2020 12:41:07 -0600
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
Subject: Re: [PATCH 29/89] dt-bindings: display: Convert VC4 bindings to
 schemas
Message-ID: <20200224184107.GA4189@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <bf8aa2deea50cc3599caeb9ed1a07556353415df.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8aa2deea50cc3599caeb9ed1a07556353415df.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:31 +0100, Maxime Ripard wrote:
> The BCM283x SoCs have a display pipeline composed of several controllers
> with device tree bindings that are supported by Linux.
> 
> Now that we have the DT validation in place, let's split into separate
> files and convert the device tree bindings for those controllers to
> schemas.
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

warning: no schema found in file: Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml: ignoring, error in schema: properties
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml: properties: '#clock-cells' is a dependency of 'clock-output-names'
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1242907
Please check and re-submit.
