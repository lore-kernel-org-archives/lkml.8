Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D3DC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1182072F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589050674;
	bh=iopScO+2HkHf5IQSDKU6t8wHnI4/was7SushLcKBLNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fI34xYLgbw0s/L1y3YzvXnU8nixCtqVUYYCuT8NjqN5HkYlEwZK14ZBC2nng8r1jl
	 uQi5/Pm+1R8F0HG7tW2HAnfmi/2NUO6M9thfUeEoDqeQGLerwnhMRbz3dedum9wKLC
	 uQ49URmV7y64NGmmqxIEIlR5d3o8OzljHQ9eKbBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEIS5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 14:57:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43766 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgEIS5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 14:57:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id l12so2472409pgr.10;
        Sat, 09 May 2020 11:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zttBbKYVFPa2BZUCkTkRSn2zjIPdo5XhSTTLcAliYr8=;
        b=fDgzplDwWLQQnxTV4/Qsn/JAswsgDQA/F/3ngC3sJhOnaNl9dy1GVZoAL/xFRkAoBv
         n2cUw6tlXytHj7W82sZ+dokw5xpKpQ7c2GVsCAx7L5HkQEIMKmkvBjtO91GH6gf/ee/B
         oESTjXxWZDJAz+ofSiX63nXUntJA2/jclolXK5NgP99v7edyvPKRcfcbpPRg5NT7jUf7
         6Ptobj60E4G+PFmMh+nY8wCuQXxIz4WzVbrhdvcXk/k3r0k29aoPiDi1SvwhP+frSUdm
         3M6Uzaf+WKtMkCvTL0BzmZHzgz6Q4kd+cleZsndjE3Q3AaAV4hehw1ZHStattOeVMIVd
         Vcog==
X-Gm-Message-State: AGi0PubARbPJwx3zKKBzXyfXqOVttMtUfpPu0DiXfT44YJCPlj3VvWuD
        wL6/uO6S/ScYhmv5mZsK0ZI=
X-Google-Smtp-Source: APiQypJx3+0uZ1IpoYh4IC9se3roW9MvXg0k4n7h7/YW0Z1BmiIRawK/Yh/RGSY0146BWzhWH34lcw==
X-Received: by 2002:aa7:8dc1:: with SMTP id j1mr9059840pfr.285.1589050672360;
        Sat, 09 May 2020 11:57:52 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c10sm4995523pfm.50.2020.05.09.11.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 11:57:51 -0700 (PDT)
Date:   Sat, 9 May 2020 11:57:50 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>, Wu Hao <hao.wu@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: zynqmp: fix modular build
Message-ID: <20200509185750.GA6715@epycbox.lan>
References: <20200505140041.231844-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505140041.231844-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:00:11PM +0200, Arnd Bergmann wrote:
> Two symbols need to be exported to allow the zynqmp-fpga module
> to get loaded dynamically:
> 
> ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
> ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!
> 
> To ensure this is done correctly, also fix the Kconfig dependency
> to only allow building the fpga driver when the firmware driver is
> either disabled, or when it is reachable. With that, the dependency
> on the SoC itself can be removed, and there are no surprises when
> the fpga driver is built-in but the firmware a module.
> 
> Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/fpga/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index b2408a710662..7cd5a29fc437 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -208,7 +208,7 @@ config FPGA_DFL_PCI
>  
>  config FPGA_MGR_ZYNQMP_FPGA
>  	tristate "Xilinx ZynqMP FPGA"
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
>  	help
>  	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
>  	  This driver uses the processor configuration port(PCAP)
> -- 
> 2.26.0
> 
Applied to fixes,

Thanks
