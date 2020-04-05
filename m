Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05DCC2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745432070E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586051152;
	bh=RmioMehaT4c6L64I7FjZ3tyOv3/RQvQLF1DZoJaWh3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Brgt3iNnbiiXlCqZfcY36GP/P5m7B8xDbW9ZEjSIpz49HZPBbQ1sz/MF5C/rgTEVA
	 D2Ic0+jJM3bPK6SzXD2hmYdJqa0LOAhWAO6JNn9oDCf8Pcvkla9Fw8xjSBmkKTwPOx
	 Az86sxWU9t1M4nWbGRhCNtnY29a/4je0dc8phwe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEBpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 21:45:51 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41545 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgDEBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 21:45:51 -0400
Received: by mail-il1-f195.google.com with SMTP id t6so11303095ilj.8;
        Sat, 04 Apr 2020 18:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JeC65YQxlFbywStaQPwOL1IiITFIehucwUMPinuGVYU=;
        b=VuVkZHP3eX0SLkq7+kDGBmA/meXZrGR+dP7RGlNYkzUbmVCuRrRtFHdCemHi5N2ABd
         CNFULsVTK937KDLWdiwerFqTqoj1B3ZiP02TQrvKOd0V1LaY0bzruy2WP/yX4GqRJIaQ
         piukEvIgDjtj3kuGBudeXVTZZtoIbLr/hT+27noGgpln1Y7oNWT0I/lvqFvxeHoloNCM
         FRiVeqO3PHdVTzFDc88364JUZyNq8ZuzM550etqaa1qZGLIZcIOKo7ljfDGo20JenuCR
         V13GHQURfrx2VAB1LJu2ZPs9ZKFb7IGnuSQLL0y0Kz6Q5Q9d01EXBjgGcirdGT438vMK
         Fgcw==
X-Gm-Message-State: AGi0PuY46iSypdbmrPs9XwOGF/HjYtk7fFDCS95hXbctKWl5X4y+2tAx
        rWLJcH3HYMFAYThQvG3Gyu6AdNY=
X-Google-Smtp-Source: APiQypKGDz0Y0zEMHk6yAPkq6/krHbJd+apIhCbdRryMurTdkMNVnTgxApaE2skI7RQm1z/XK+OBLw==
X-Received: by 2002:a92:912:: with SMTP id y18mr15759344ilg.299.1586051150651;
        Sat, 04 Apr 2020 18:45:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h12sm4476080ilq.66.2020.04.04.18.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 18:45:49 -0700 (PDT)
Received: (nullmailer pid 10043 invoked by uid 1000);
        Sun, 05 Apr 2020 01:45:48 -0000
Date:   Sat, 4 Apr 2020 19:45:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        John Youn <John.Youn@synopsys.com>
Subject: Re: [RESENDING RFC PATCH 1/4] dt-bindings: usb: Add
 snps,consolidate-sgl & consolidate-sgl
Message-ID: <20200405014548.GA25539@bogus>
References: <cover.1585297723.git.joglekar@synopsys.com>
 <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9ca8e08d7c4957789a209c77589f1aa4bd2f06.1585297723.git.joglekar@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:11:56PM +0530, Tejas Joglekar wrote:
> This commit adds the documentation for consolidate-sgl, and
> snps,consolidate-sgl property. These when set enables the quirk for
> XHCI driver for consolidation of sg list into a temporary buffer when small
> buffer sizes are scattered over the sg list not making up to MPS or total
> transfer size within TRB cache size with Synopsys xHC.
> 
> Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt     | 3 +++
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 9946ff9ba735..292d1f7969e4 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -104,6 +104,9 @@ Optional properties:
>  			this and tx-thr-num-pkt-prd to a valid, non-zero value
>  			1-16 (DWC_usb31 programming guide section 1.2.3) to
>  			enable periodic ESS TX threshold.
> + - snps,consolidate-sgl: enable sg list consolidation - host mode only. Set to use
> +			SG buffers of at least MPS size by consolidating smaller SG
> +			buffers list into a single buffer.

The preference is not to keep adding properties for every single quirk 
or feature. These should be implied by specific compatibles. As Synopsys 
knows what quirks/errata/features are in each version of IP, the 
compatible strings should reflect those versions. (And yes, I'm sure 
there's customer ECO fixes that aren't reflected in the version, but 
that's why we have SoC specific compatibles too.) This is the only way 
we can fix quirks in the OS without doing DT updates. For comparison, do 
you want to have to update your PC BIOS so an OS can work-around issues?

Rob
