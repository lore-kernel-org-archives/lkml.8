Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5CFC2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DA620719
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586050133;
	bh=c0Mf3mvWyNHHAmvgmHxxzKG+n2Io+Yk07t3s0UuBuD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=07guAS4TOn+BpbS1M+ZXQCmxi0TOaL3KQNzrDoBZr5Uq9R06hBf/Zf+6fcgeEsWKi
	 lkMev9Mrbc/45p/J0yMwfClqmY4hUJlaTpNY6eAwSw+8f/OXZQHiNZ/bHsoPBEOkzK
	 hUUlIcRnGUcUixNfOc7AANGTbtymnbYtta3yBwCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDEB2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:28:52 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37496 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgDEB2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:28:51 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so11337397ilr.4;
        Sat, 04 Apr 2020 18:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WGbgIdmOv5Wc5UUMJfMtgDqF41fZaw2KceIkWNuOtOQ=;
        b=kyvXX7GCvZ66SP5U25XORmkfSYg2FfJx57yWv9Kt/407Ruy2weDbkU3sYqN+SmKLJT
         jpOJrbRqQhE9STp6lVxUzcpVprZEeck9wFg4aryki5bUeFmfgefrUfCENrP/Smz8fjeU
         mTQQzgoDqwcRbyDFHeBMnA7wk0SkcWGvfDV/KXAdXMMlxriRQA9J2iCwiQrG8Eqy7kcm
         bAU661DXvZI+jzpG/bHqt7LTOc/hfdVsjAbWFSXAS3U+zoBSiWzzaJG4iz7WXLYKWaSA
         lYiCs6A1jKh3cOKb40cFBZxq6G3TLcxVdAEEpxsaGYO+8pqPUm7zIdfRQCvJiMFblDrH
         KFtw==
X-Gm-Message-State: AGi0PubWCxKxeX7yFxQ3bwFxlpluEokCSLuFiYyu83yc3LLlDK3FpnVj
        KcvCiWNI8jIjc/vU4c+cMA==
X-Google-Smtp-Source: APiQypI6PbdotC9mrYE+CpW9fKH4YceucS0Yef5Gf0KZGyBkpO4RhQk/A/AMbdgA32TOlTBSGy2JIw==
X-Received: by 2002:a05:6e02:6cd:: with SMTP id p13mr14925447ils.150.1586050130495;
        Sat, 04 Apr 2020 18:28:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k81sm4425517ilf.44.2020.04.04.18.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 18:28:49 -0700 (PDT)
Received: (nullmailer pid 18915 invoked by uid 1000);
        Sun, 05 Apr 2020 01:28:47 -0000
Date:   Sat, 4 Apr 2020 19:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     devicetree@vger.kernel.org, aford@beaconembedded.com,
        charles.stevens@logicpd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] clk: vc5: Add bindings for output configurations
Message-ID: <20200405012847.GA5234@bogus>
References: <20200326213251.54457-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326213251.54457-1-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:51PM -0500, Adam Ford wrote:
> The Versaclock can be purchased in a non-programmed configuration.
> If that is the case, the driver needs to configure the chip to
> output the correct signal type, voltage and slew.
> 
> This RFC is proposing an additional binding to allow non-programmed
> chips to be configured beyond their default configuration.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> index 05a245c9df08..4bc46ed9ba4a 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
> @@ -30,6 +30,25 @@ Required properties:
>  		- 5p49v5933 and
>  		- 5p49v5935: (optional) property not present or "clkin".
>  
> +For all output ports, an option child node can be used to specify:
> +
> +- mode: can be one of
> +		  - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
> +		  - CMOS
> +		  - HCSL 
> +		  - LVDS: Low voltage differential signal
> +
> +- voltage-level:  can be one of the following microvolts
> +		  - 1800000
> +		  - 2500000
> +		  - 3300000
> +-  slew: Percent of normal, can be one of 
> +		  - P80 
> +		  - P85
> +		  - P90
> +		  - P100 
> +
> +
>  ==Mapping between clock specifier and physical pins==
>  
>  When referencing the provided clock in the DT using phandle and
> @@ -62,6 +81,8 @@ clock specifier, the following mapping applies:
>  
>  ==Example==
>  
> +#include <dt-bindings/versaclock.h>
> +
>  /* 25MHz reference crystal */
>  ref25: ref25m {
>  	compatible = "fixed-clock";
> @@ -80,6 +101,13 @@ i2c-master-node {
>  		/* Connect XIN input to 25MHz reference */
>  		clocks = <&ref25m>;
>  		clock-names = "xin";
> +
> +		ports@1 {

'ports' is already taken as a node name.

> +			reg = <1>;

What do the reg value signify?

> +			mode = <CMOS>;
> +			pwr_sel = <1800000>;

Not documented. Don't use '-' in property names.

> +			slew = <P80>;
> +		};
>  	};
>  };
>  
> -- 
> 2.25.1
> 
