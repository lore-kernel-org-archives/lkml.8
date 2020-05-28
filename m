Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82B9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2AC2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590704443;
	bh=gILXXRtvqSncq0mCCj8kjzwNxR2trvvwP4Z3q4foa10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A4LzsWsQwwo/dF+ggN/yPSc6u4Xmw/kC3AWsg6f6aA0CapBl4U+l2icvtxGziAdy6
	 c9oemU0xqm2OxrJjPr2Szp0/tiIkN5Zyv71MafbAfp+vhm7oSjioxlJkJ1H90Muo07
	 fOEv16cN9DTriQGd1Ald6m7FePFPpXGLroLRAvUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436974AbgE1WUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:20:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43436 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436902AbgE1WUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:20:23 -0400
Received: by mail-io1-f66.google.com with SMTP id h10so197890iob.10;
        Thu, 28 May 2020 15:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V1pVNRBWzHZ1G6jffgYB9BbYesxXCexItPOb/g+HRwk=;
        b=rqHhrMh13t6cZ8yJFpoi9AQLJbqrhIGCSiAtIzY3TSGsJbzGWvs6PM9aENGygzSvjG
         0b2kprJIvS7K+yfx93J4XBMMKMdH9LJ9MpUztDDtCWZ+jquuVI6AJi5j1LSCvzIP9hvH
         0qwXyGyY2iHNbMw7C1OR29xRYlNav4SXEZFGjq+GwiTHZ/E1PYN2yl0FxAGEzguSrwEs
         goDSrCfhHbU9QR7YfRiWbxplxFeYib6utIrQa5G3iDKf/QYh3cEcyLNnuPbZYBsZRLHn
         JDtbkD1akCl8BgGALQaDk/cQZI0erqEzi38McK0Jo65r1dIrnILZQzUh1UDlteBw/R9F
         umJQ==
X-Gm-Message-State: AOAM53052nP0n3KPwBwhlyQ8uLNyCcI/Qr93L0mGmIWN0s5AYsNxcVCo
        pNZI9XyU04uPsW7pL7tD+g==
X-Google-Smtp-Source: ABdhPJwj8PCtzTwAhMry0miLqUZxr77A1fRZS29Pm/8O3Pm0xpLEjyn2R+dRN+D30uJ90Rg4+GEwtA==
X-Received: by 2002:a5e:d903:: with SMTP id n3mr3603677iop.93.1590704422191;
        Thu, 28 May 2020 15:20:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q6sm3787197ilj.72.2020.05.28.15.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:20:21 -0700 (PDT)
Received: (nullmailer pid 785342 invoked by uid 1000);
        Thu, 28 May 2020 22:20:20 -0000
Date:   Thu, 28 May 2020 16:20:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: omap: Update PRM binding for genpd
Message-ID: <20200528222020.GA783133@bogus>
References: <20200520211334.61814-1-tony@atomide.com>
 <20200520211334.61814-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520211334.61814-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:13:29PM -0700, Tony Lindgren wrote:
> The PRM (Power and Reset Module) has registers to enable and disable
> power domains, so let's update the binding for that.

multiple domains? Then why 0 cells?

> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/prm-inst.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> --- a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
> @@ -18,6 +18,7 @@ Required properties:
>  		(base address and length)
>  
>  Optional properties:
> +- #power-domain-cells:	Should be 0 if the PRM instance is a power domain.

...power domain provider.

>  - #reset-cells:	Should be 1 if the PRM instance in question supports resets.
>  
>  Example:
> @@ -25,5 +26,6 @@ Example:
>  prm_dsp2: prm@1b00 {
>  	compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
>  	reg = <0x1b00 0x40>;
> +	#power-domain-cells = <0>;
>  	#reset-cells = <1>;
>  };
> -- 
> 2.26.2
