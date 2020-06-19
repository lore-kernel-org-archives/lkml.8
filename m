Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62690C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A00F20809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592530716;
	bh=J4S8mM/al6OICP8T9AlD75GXLAIgGXov24QiNUFiy/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNTBFRItDM5ESKW1+5KpVLmPxu8jdxysW5kxzMWYBWmyUOerZtYy8TXInSboGk3g4
	 ZFPV8oRuKn1qr9GF/Ma4+6bhoo32TkCmNJNPGsnkd1nIqbl54D9xh2mhr54dUPeAw+
	 0vFxC+NSRdJrLR8W9FaMq5vxMm2SO6dhaJy20Mmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgFSBie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:38:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33346 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgFSBid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:38:33 -0400
Received: by mail-il1-f193.google.com with SMTP id z2so7867897ilq.0;
        Thu, 18 Jun 2020 18:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYe4dm89OvAp8NEAW4Mj6NX5Hz+7LzKddjXjWWo+/oA=;
        b=W3qqZkSbhWwmaWc3/8nl0jYl5lxMGWyT8baT3mNDJCtb004u85Jr9syoWa/xrIiWxs
         AODRxSAK6dcawAeC7c97IQKWf4iMnITcdBT+8gPGgq3Dbmz76gqK1CSGFQSRr7cMTdz4
         W4xe9vHfgbvM/K13jBLz2NTw1aR7Z395t6/rJlJzcFXn4Y5WB/D7OZQDdsArWNZohvaO
         1ZVTnG9ts7K4mjG2PLel2McyAGIFywucNhdARNzn8Gga59f235qOf9uKIQM4Sr4R6pbd
         5kyoSU0rtQUoHNfsPSGM90uzLIzDILU77oap07xYCfQNRI4umd0dyPjM+sxlZ9HyyRDL
         tRhg==
X-Gm-Message-State: AOAM531THki9uoy9xvNrDUbHVkssYABc24YJfVYSmOjavjXeqsApVeGv
        cyDrchyfVJOyFE7vj58ml/Q=
X-Google-Smtp-Source: ABdhPJxBolKVx4TEXm9JJNyf4PvqzmqX6Mg/A7H1vOeO8iTVX7Nm4yElXMnQyAEt9w4m2bvywoLVsg==
X-Received: by 2002:a92:d112:: with SMTP id a18mr1353053ilb.3.1592530711973;
        Thu, 18 Jun 2020 18:38:31 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z16sm2386746ilz.64.2020.06.18.18.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:38:31 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:38:30 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/5] fpga manager: xilinx-spi: remove unneeded, mistyped
 variables
Message-ID: <20200619013830.GC3685@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:11:42PM +0200, Luca Ceresoli wrote:
> Using variables does not add readability here: parameters passed
> to udelay*() are obviously in microseconds and their meaning is clear
> from the context.
> 
> The type is also wrong, udelay expects an unsigned long.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 79106626c3f8..799ae04301be 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -41,8 +41,6 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  				 const char *buf, size_t count)
>  {
>  	struct xilinx_spi_conf *conf = mgr->priv;
> -	const size_t prog_latency_7500us = 7500;
> -	const size_t prog_pulse_1us = 1;
>  
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_err(&mgr->dev, "Partial reconfiguration not supported.\n");
> @@ -51,7 +49,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  
>  	gpiod_set_value(conf->prog_b, 1);
>  
> -	udelay(prog_pulse_1us); /* min is 500 ns */
> +	udelay(1); /* min is 500 ns */
>  
>  	gpiod_set_value(conf->prog_b, 0);
>  
> @@ -61,7 +59,7 @@ static int xilinx_spi_write_init(struct fpga_manager *mgr,
>  	}
>  
>  	/* program latency */
> -	usleep_range(prog_latency_7500us, prog_latency_7500us + 100);
> +	usleep_range(7500, 7600);
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 
Applied to for-next,

Thanks!
