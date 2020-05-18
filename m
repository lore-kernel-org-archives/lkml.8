Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F282620829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826530;
	bh=M6+1nKPWIWpMgmZAECb6NVpZv7SnhR0M+siamq5wA1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xW3Ayskxo8q5VpKC8bQDVsEH713pyHzOm9tTAszmCfVmNRpygnr3BFGgl8+AMJnBt
	 /AnBzqk1EXxj8eE+9vCIxbSjsf+I+NyEq4RPjQXmetdfCVFvC0nAKIcRmOLXXzEAOe
	 F2xFRK8MDU8l0mJvDhEaUuqWGDrwstftCULcpcxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbgERS2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:28:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39320 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387852AbgERS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:28:46 -0400
Received: by mail-io1-f66.google.com with SMTP id x5so11736276ioh.6;
        Mon, 18 May 2020 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/p9YM/GnXrG9SKVwxPAWMOdMPZXYXdovPfbgwwKorf0=;
        b=uTdl7pZOW8+uirJ3eO/GWJwnWxrfAzJUIbEElcUSMKU+sIVDYzSiBXubBIFSp5au0O
         +GhBp3u+JwUFs30BhMReStMIs3sxPwNzjJ7z7IanEixBk3Kt0Gpewsc2jJ9Y8kh1UjbZ
         HJpmGglImj/rYWH2QD97u6HoF61H3/f2yK0BBK6HZMHwhV3s+KI1VBbWIv/u3TX4Yl4a
         yhLIqbPQ+/CRGqqxLSrru9LqzZWFb4WyWg6SRUK55r+Dv+42G5/AShhnrghncwvfrgnz
         SpeSAw5zNKkEO1utlGz6z/1TVVeKljd2E6endhC/OO36wGT+SzC+Jaj5DqBTs27ADCCG
         dKlw==
X-Gm-Message-State: AOAM530T7Eq/0EebV/XYrG5aEDxTlkPhRKNP5OkqJKyWyOO3IMfZEJcf
        9Rbu1byRVb+P2cGLsF0R+w==
X-Google-Smtp-Source: ABdhPJyQMHKgCPUCeovV3BchpiRD9KADEVI8p81q+CRYTGF8ksnKQdsZoo8KTJr7NyfISNcmJcVulQ==
X-Received: by 2002:a5e:c303:: with SMTP id a3mr15796959iok.15.1589826525234;
        Mon, 18 May 2020 11:28:45 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j2sm4147519ioo.8.2020.05.18.11.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:28:44 -0700 (PDT)
Received: (nullmailer pid 5690 invoked by uid 1000);
        Mon, 18 May 2020 18:28:43 -0000
Date:   Mon, 18 May 2020 12:28:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     srk@48.io
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Cross <xobs@kosagi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: n133hse-ea1: Add Innolux N133HSE panel
Message-ID: <20200518182843.GA4265@bogus>
References: <20200509111834.26335-1-srk@48.io>
 <20200509111834.26335-2-srk@48.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509111834.26335-2-srk@48.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 01:18:33PM +0200, srk@48.io wrote:
> From: Sean Cross <xobs@kosagi.com>
> 
> The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
> integrated backlight, and connects via eDP.
> 
> It is used in the Kosagi Novena.
> 
> Signed-off-by: Sean Cross <xobs@kosagi.com>
> Signed-off-by: Richard Marko <srk@48.io>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> To: dri-devel@lists.freedesktop.org
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 393ffc6acbba..756bf6a48e8d 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -139,6 +139,8 @@ properties:
>        - innolux,g121i1-l01
>          # Innolux Corporation 12.1" G121X1-L03 XGA (1024x768) TFT LCD panel
>        - innolux,g121x1-l03
> +        # Innolux Corporation 13.3" FHD (1920x1080) TFT LCD panel
> +      - innolux,n133hse-ea1
>          # Innolux Corporation 11.6" WXGA (1366x768) TFT LCD panel
>        - innolux,n116bge

Alpha-numeric order please.

>          # InnoLux 15.6" WXGA TFT LCD panel
> -- 
> 2.25.1
> 
