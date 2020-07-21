Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A4C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7B42073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347579;
	bh=Ci4uPdNrn7JVB5LU0PFCw5AZKheuWEY0KSofqjrH4/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2BQe2fVgHKgYXEJMZtXA1knMVleiD/t+nj05h+mA0PM7hyirNc0XoJaSgMcaijClc
	 fFfPJ4w/aXx99dIRTsjsuQ/M8bG/HsxgRFFBQdFhFUdQDje2tzSsEebWM5zmyF9b0z
	 Lrnx63G8Di1/kmksdvWSBjQvHuxbee/ndqWwh6OM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgGUQGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:06:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45424 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgGUQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:06:16 -0400
Received: by mail-io1-f67.google.com with SMTP id e64so21966984iof.12;
        Tue, 21 Jul 2020 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmFiyYVAXh8dLGcqP1mUgHDGPOUnEx9ltZZJeHm/90U=;
        b=BgCnRSBMuc6+yGI6PMHGqPiH3hK8Vewze/VGgj851XgysHKRNJheCYl5lj+O1yPcp3
         pArTMzbusj2sVcfpD1K5UdxodmVbwWxmXouhnDe96wTcWPCuddYupLYDmxZRlYNLkfFo
         FfzpNV0fksGcFrpXNr33Vq5m5jyIEitm5gn8x8MzsiWX0KzzhzAEhglV/obpW/6q1SmW
         VZeq7WuQ1B40Mo1Saa+80Vq0bpJzvBmk9y2NVqwqgLUxU2PjeGaM7zcf4eJHPSrqqH+1
         jIBJHlH0P60E4aBVJPlFpXDVH7pnnlxd0BS86hynZjdVpc5bhrRk35/rvxBf1VKoY/gl
         fHHA==
X-Gm-Message-State: AOAM533qVudyJnv2nFD2fe10suKoNnN6pVnOVuN+uxAjRt7vrokGH57C
        EXEus/rgrjpUfrQbsOoBMw==
X-Google-Smtp-Source: ABdhPJz/byD3lCIAK+KOCr8tkp6iytOXF67GXPOZHcVpAtLQmMBl43jbmfyqhruhjKTJCj0McCmYNA==
X-Received: by 2002:a02:8308:: with SMTP id v8mr32365035jag.101.1595347575497;
        Tue, 21 Jul 2020 09:06:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v13sm10694113iox.12.2020.07.21.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:06:12 -0700 (PDT)
Received: (nullmailer pid 382755 invoked by uid 1000);
        Tue, 21 Jul 2020 16:06:10 -0000
Date:   Tue, 21 Jul 2020 10:06:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     maz@kernel.org, devicetree@vger.kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de, t-kristo@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, nm@ti.com, p.zabel@pengutronix.de
Subject: Re: [PATCH] firmware: ti_sci: Replace HTTP links with HTTPS ones
Message-ID: <20200721160610.GA382708@bogus>
References: <20200718105538.9542-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718105538.9542-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 12:55:38 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  .../devicetree/bindings/interrupt-controller/ti,sci-intr.txt    | 2 +-
>  drivers/firmware/ti_sci.c                                       | 2 +-
>  drivers/firmware/ti_sci.h                                       | 2 +-
>  drivers/irqchip/irq-ti-sci-inta.c                               | 2 +-
>  drivers/irqchip/irq-ti-sci-intr.c                               | 2 +-
>  drivers/reset/reset-ti-sci.c                                    | 2 +-
>  include/linux/soc/ti/ti_sci_inta_msi.h                          | 2 +-
>  include/linux/soc/ti/ti_sci_protocol.h                          | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
