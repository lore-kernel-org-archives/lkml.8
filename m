Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BA3C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CBF21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582754197;
	bh=GMb0pFKuJD8eamc1LOmXrmucjV8IEey7X54UNjLcyxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=euMr++i204GXr1gpKv1gMVD+2I+O9vdrOUx5d7MSZbIPXZajqZM8jsV50aVG6Vegp
	 R/sd9DhNpGEDUXBIEBuEptynD82bVCQZvgWsDAmCN/h236ZiC6EkDtV23s+oHjZgPe
	 pJIlEVOjRfLdFHSvYgkmrjwr0tKjXCx6jCuPgyoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgBZV4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:56:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46157 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBZV4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:56:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so1104866oid.13;
        Wed, 26 Feb 2020 13:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4BX9Auu8o01WTrJq32cfiMhmljuxjW/fjyXmcSHWTU=;
        b=MEqhjFEHBaJs9HucxcgH1qo0xcZGmot10t+AxW45PxPw9WJcxTjRml6UEiwE7qQMIi
         3QMjjor2PFEwhPpMzV8FqGvSa5PRvu+3T3RsTv6F4b5OthVYzDrhR1KXIrK3IfoCQZMY
         wEz/N+OHSi7fkR5ufGsaRkSEsU82OuLGDvYcM+U372BwcYRMQAg0g2x6XHVTmQMGHSaj
         UMBONWCvnPktC8Uew9J9egLkEnWdM+H92SspQMCFVY+/fxL+BphI94Cj6WWkpe/NFwvk
         bIMcuwdYujHvJ5JpHaufdkoQrD65Ao9iryDFN5v+K38Nwt+2Ut33GRvWLWdCutR7zncH
         xjHw==
X-Gm-Message-State: APjAAAUxj/4CVyMVpXZBl864JSBhwqSYGYF6w/9+YbXJdGzp5lhkww6K
        Jl2q+yEvr2KOnvQcR3KvZA==
X-Google-Smtp-Source: APXvYqws1PYPwS1qIlnOlXd8Ptqpulqo05xSrU6w8Ew1XswmUcuyfnWvsmKpxnrrYAr0zE674FvP8g==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr958886oig.40.1582754194758;
        Wed, 26 Feb 2020 13:56:34 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm1210156oti.44.2020.02.26.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:56:34 -0800 (PST)
Received: (nullmailer pid 32209 invoked by uid 1000);
        Wed, 26 Feb 2020 21:56:33 -0000
Date:   Wed, 26 Feb 2020 15:56:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Belin <nbelin@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com,
        devicetree@vger.kernel.org, baylibre-upstreaming@groups.io,
        Nicolas Belin <nbelin@baylibre.com>
Subject: Re: [PATCH RFC v2 2/3] dt-bindings: leds: Shiji Lighting APA102C LED
 driver
Message-ID: <20200226215633.GA20374@bogus>
References: <1582727592-4510-1-git-send-email-nbelin@baylibre.com>
 <1582727592-4510-3-git-send-email-nbelin@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582727592-4510-3-git-send-email-nbelin@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 15:33:11 +0100, Nicolas Belin wrote:
> Document Shiji Lighting APA102C LED driver device tree bindings.
> 
> Signed-off-by: Nicolas Belin <nbelin@baylibre.com>
> ---
>  .../devicetree/bindings/leds/leds-apa102c.yaml     | 154 +++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/leds/leds-apa102c.example.dts:33.30-31 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/leds/leds-apa102c.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/leds/leds-apa102c.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1245095
Please check and re-submit.
