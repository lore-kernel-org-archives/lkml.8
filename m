Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59219C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2926B207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592530693;
	bh=rJ8LLKX05NJujlYqFjrZOkunYxfCOXX+iYLlQpXqIh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QU0jtoMSW1T9iGSE8Asqr3s3yNkl2egoJtAHGchHVMZSQTMVmlIImrNpenQqLi1t0
	 4jIatvy7EmSSv1YF+/bBdv3sJpgvbOU4UBiu36ixD/MP+yS21YNZ78UApsZGXzoCMk
	 Zl15oTFNKWVg5fSYTZBnpgWPoGqw0smbXnpP83Ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgFSBiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:38:12 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37016 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgFSBiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:38:11 -0400
Received: by mail-il1-f195.google.com with SMTP id e11so7858218ilr.4;
        Thu, 18 Jun 2020 18:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ipp8uVtoQzp7J8CQ83R/TtPzLH+p8MFeBwT9doR7Bw8=;
        b=mzvioSs02VNqoxoacJrDFs9wwKw2fnp9vbL0RaLkYyzPFe8htNePBcPijNZpc6knhc
         rzibvN6gH0zSDXFrcYwRd9SWzwWlDAoJtQjcUMa3dw+PDvOdT8S5u13Le3IcybEjqe3x
         XWcQWOdOxxdsrJhSOmVgDM3acbUx2MeeDjBvgUoyzD+AXI7JvCXsHakEWnX79NKb9v46
         JMEi7ub1luxM6OaaLLpElbXkRGV3+T1NXMFv9+lJLKUgoAQnMdL8zmd8mpv/GD9tIkoC
         sARBnv+N2tqF4Y5FL4Lfo6/wV3mC6ECKJg7PIszqCBC5w4eoWsYyFtE+b8czRoH6tMpT
         E2iw==
X-Gm-Message-State: AOAM5339bRBuFvkQwTk3WWl1R6Nnod1i21pS/pI8uIkjuzMXaXzCGv3g
        7T3j19/ksFag36BpmOUZiS8=
X-Google-Smtp-Source: ABdhPJyMasH+ZMphKT3AZHNSh9RoTjEPaUpLIsSQB9A+7bEUSCOiWkJq+p4UzJxMEzOYsMS9CZkwxw==
X-Received: by 2002:a92:5b15:: with SMTP id p21mr1456935ilb.22.1592530689102;
        Thu, 18 Jun 2020 18:38:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a187sm705318iog.2.2020.06.18.18.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:38:08 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:38:07 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 2/5] fpga manager: xilinx-spi: valid for the 7 Series too
Message-ID: <20200619013807.GB3685@epycbox.lan>
References: <20200611211144.9421-1-luca@lucaceresoli.net>
 <20200611211144.9421-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611211144.9421-2-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:11:41PM +0200, Luca Ceresoli wrote:
> The Xilinx 7-series uses the same protocol, mention that.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/fpga/xilinx-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index 272ee0c22822..79106626c3f8 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Xilinx Spartan6 Slave Serial SPI Driver
> + * Xilinx Spartan6 and 7 Series Slave Serial SPI Driver
>   *
>   * Copyright (C) 2017 DENX Software Engineering
>   *
> -- 
> 2.27.0
> 

Applied to for-next,

Thanks
