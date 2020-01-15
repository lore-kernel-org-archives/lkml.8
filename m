Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B28C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D524671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 01:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579053041;
	bh=UxnaQGzIT0+PGL8esA8JIS3vl1vobjBqLQe1d6qSd/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O6mo0OL1pwC38g70IYQJnWYfnpmPb2av2oiZCyPL15gjRgxccPYfXsVNQ8pQYUIBr
	 iprbaAfeMLE1pWBfzLaAj8+JPAKqzUay6gSMgG9v+EIMG+QsbqILZP0qtg7SjgxxRS
	 A4xhO3PEW/swllupaw1wB+1iMKMRokEBAIjo8eKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOBuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:50:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45251 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgAOBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 20:50:40 -0500
Received: by mail-oi1-f194.google.com with SMTP id n16so13883393oie.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 17:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+DC5uDF1yRidwXaAC7rLMyWxsUNF7MxyQx/Ttg6A48=;
        b=Y10xGOnTC1WTC2jsKwsYQL7ZZ+lrfMZrjGoDGLr9fC8LDxYHBeR0TcAaduyCUJAAAc
         rdR8VDwEoMcHWu8c9aeZ7Ye6Ip0mE5+DTwWQray4Huly4Xt8TL4rs3txCFEvVRvahmq3
         8VnEV4GlBYANCpeoEvILdt6NyxIhayXyzNhBdrZ9nu8gwiru9YouwLPwxWIJE5qfaffb
         Eb+9frZYUz4X/LOcKRN84YP5HmIKQA2n7T348AQHDRPBsSeQ8mwDk0CYCsCmlq4NSOYw
         +1O6z8N1yk8/1t6Pkh5OwE8grb9ttSoZknmiBBQUxM7tjbgoXyTnyssCO2YUVgngy53H
         sjNw==
X-Gm-Message-State: APjAAAWRhYCa529IeGyVygJcvYV7XwZXNfWObItuAF4KhUQuMPbjetFV
        qf7hVoOAbengqqpYKLTphzELAuM=
X-Google-Smtp-Source: APXvYqz+nceNadrxHhLPtJ93BEs0Yl/MhKX5AVbxla3/dD6xLlGX5K+cPaWqMmUSXWFw++2CKeJo9A==
X-Received: by 2002:aca:d6c4:: with SMTP id n187mr19629918oig.29.1579053039239;
        Tue, 14 Jan 2020 17:50:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm5197123oic.46.2020.01.14.17.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:50:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 19:50:37 -0600
Date:   Tue, 14 Jan 2020 19:50:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-am654: Update Output tap
 delay binding
Message-ID: <20200115015037.GA26114@bogus>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
 <20200108150920.14547-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108150920.14547-2-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 08:39:18PM +0530, Faiz Abbas wrote:
> According to latest AM65x Data Manual[1], a different output tap delay
> value is recommended for all speed modes. Therefore, replace the
> ti,otap-del-sel binding with one ti,otap-del-sel- for each MMC/SD speed
> mode.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-am654.txt   | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> index 50e87df47971..c6ccecb9ae5a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> @@ -18,7 +18,20 @@ Required Properties:
>  	- clocks: Handles to the clock inputs.
>  	- clock-names: Tuple including "clk_xin" and "clk_ahb"
>  	- interrupts: Interrupt specifiers
> -	- ti,otap-del-sel: Output Tap Delay select
> +	Output tap delay for each speed mode:
> +	- ti,otap-del-sel-legacy
> +	- ti,otap-del-sel-mmc-hs
> +	- ti,otap-del-sel-sd-hs
> +	- ti,otap-del-sel-sdr12
> +	- ti,otap-del-sel-sdr25
> +	- ti,otap-del-sel-sdr50
> +	- ti,otap-del-sel-sdr104
> +	- ti,otap-del-sel-ddr50
> +	- ti,otap-del-sel-ddr52
> +	- ti,otap-del-sel-hs200
> +	- ti,otap-del-sel-hs400
> +	  These bindings must be provided otherwise the driver will disable the
> +	  corresponding speed mode (i.e. all nodes must provide at least -legacy)

Why not just extend the existing property to be an array. We already 
have properties to enable/disable speed modes.

>  
>  Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
>  	- ti,trm-icp: DLL trim select
> @@ -38,6 +51,10 @@ Example:
>  		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>  		sdhci-caps-mask = <0x80000007 0x0>;
>  		mmc-ddr-1_8v;
> -		ti,otap-del-sel = <0x2>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-mmc-hs = <0x0>;
> +		ti,otap-del-sel-ddr52 = <0x5>;
> +		ti,otap-del-sel-hs200 = <0x5>;
> +		ti,otap-del-sel-hs400 = <0x0>;
>  		ti,trm-icp = <0x8>;
>  	};
> -- 
> 2.19.2
> 
