Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D789EC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBB02071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582395711;
	bh=jY4Y7QOL+KjG+Mt+brU+9X0gWDUk7y5CT5BqEsL3DNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JyJLUqRklqgzcWODw7e67JOeraRCM0P/U4l9x3tsIMxfuCM7Xkb7w6uA21w2pDGxP
	 /KOG0mqt+bJ6z77y2oWv4ZiIMrJxODDIAuJ+tL/PkDJOx/eAn6koRQtY57XGXQ97zI
	 VnGn/cLJGENB1tzyVuzN4s0tRnViuNPQaqa/WSKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgBVSVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:21:50 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37895 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgBVSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:21:49 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so2208119pjz.3;
        Sat, 22 Feb 2020 10:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iCwcVv4xnWxcWa1WsgaUhoEXl3ZCR2vSZR6hr5gWHNc=;
        b=qn/j0hsTDGj5g1hdy+11qB9A07uT+P3d3rAzVRn7MD6aFqzDvLxR5a7CC6njCrOMwj
         zrCaXS8fNHAWQG8ADogGQXzIzib18/3w4Ptqo57efJ0aryRaBg/t10WLRaAWuHGDtYIC
         ++rC3Ol/S9in7qcCWU33wUgOfM0Jo8QfbvTbj8ixwkvp676t5KUEIux+s2TjtzL7VDav
         DnBVe6ts4cQxB5Rt6ktGq5uLlP9CbToeYkRhKytEFDBHSBBp4mOjt4cCFoQ6Ps8HIvWn
         SrWYViJMZVrmT6JWmrW5Ixd7faUDoTB7zvuZDIUndERRJwPr7nr/cC63AJ2XAcoiOZl4
         8ukA==
X-Gm-Message-State: APjAAAW1HNDMdeWd4VPjyMzpeybAFJD+0ozGBSpwf85kUa0OIbhX9nDx
        h8df/Sl6OHODE7b7i1/NiaU=
X-Google-Smtp-Source: APXvYqwGViPPPxaNS7z+K4MXgi0LZN0EVHaNC8Lcr39w9C6uZBgZpJBc7aRJ3CH2jofuSwKjOzKP/Q==
X-Received: by 2002:a17:90a:9dc3:: with SMTP id x3mr10376777pjv.45.1582395707660;
        Sat, 22 Feb 2020 10:21:47 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id z3sm7012747pfz.155.2020.02.22.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 10:21:46 -0800 (PST)
Date:   Sat, 22 Feb 2020 10:21:45 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq: Remove clk_get error message for probe defer
Message-ID: <20200222182145.GA4905@epycbox.lan>
References: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0060e55f0b8d3a57e129d7eb096267cc96eae846.1581517026.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 03:17:08PM +0100, Michal Simek wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In probe, the driver checks for devm_clk_get return and print error
> message in the failing case. However for -EPROBE_DEFER this message is
> confusing so avoid it.
> 
> The similar change was done also by commit 28910cee898c
> ("fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer")
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/fpga/zynq-fpga.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index ee7765049607..07fa8d9ec675 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -583,7 +583,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  
>  	priv->clk = devm_clk_get(dev, "ref_clk");
>  	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "input clock not found\n");
> +		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "input clock not found\n");
>  		return PTR_ERR(priv->clk);
>  	}
>  
> -- 
> 2.25.0
> 
Applied to for-next.

Thanks,
Moritz
