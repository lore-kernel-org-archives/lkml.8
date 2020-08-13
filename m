Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A292C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E806220715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1FhycQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHMUzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:55:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4BEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 13:55:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z20so3169707plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t2Ekpydm8KEVs5kDCCLiiaVVVckxVW1E6L95WAw76z8=;
        b=n1FhycQKtRIWUqvPm2bf83B7wyE8LuhOHAYKChdHLMlkiJRZsZTJ4PjuNdUcXs4lMC
         tZaiKAN6dvunjY9ew/afd7bha0P94kklk3sd+xvvB+lSrHC+M5L6VQU16U5tY6lxuiFH
         9l8pEIEutjmsQYYntk+aUy9roQ0EXV3OjqW3fvfAuWL0RdjIs9QDl39I+4wQV/EjCS5A
         bkBc7G5DnmRjBuOZwtsabDtZH1Jztz6N4WR+HRaLGVcTFw3F3x3yy5XHGUX9sxRxgoq/
         g/VKDKtqEX0SiUmyDxo8GQAOYTZFcDqVBBT3y1Uvi8c1OgO6ur06tk8d+SCfEgjaSnuu
         zFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t2Ekpydm8KEVs5kDCCLiiaVVVckxVW1E6L95WAw76z8=;
        b=jMAjAsjO0PwY1KL0655z4xguDUS7LZMZdqyIzms8bT4GAST51n0PUVAJB4fhLCBaEt
         8hWdyGEBCn0VccPA//wI4n06+XKHKC41l2VhS/N0aGVavZ9szPqG8UFb/ZBrTHKuE/T5
         dVB/OGA5IUY2iCyqWnGcLa0uQuCyIwrWU1kIV93Bl34lmKTK9qYwBXesmJbAE0L7oEQq
         YWYmZFrCn2HIRzUGYZlL+W94gj79g46J4jug783miuucKFBn52uVMIfjpG/pZFUN9Xr6
         TzJuklh2/450k1vme8dJd923JPcsqbPbChdR2nspNz+2CK85HIoCzSUKXHKeRlTkdZQH
         YBTw==
X-Gm-Message-State: AOAM531L31Yih6g5O1FiYH72SvyaeWgNk8kF1VLICL+H/GcXutfUkAKF
        4lsbK8QxGbX6mlRzOuXJTaAopw==
X-Google-Smtp-Source: ABdhPJzsxCWnD0Wh7Fk72xMBKU/pMOWfpXAERj04r09jzF76N2Kbau2rmt3xUxEot2481EYGWIZkBg==
X-Received: by 2002:a17:90b:110a:: with SMTP id gi10mr6957234pjb.206.1597352142868;
        Thu, 13 Aug 2020 13:55:42 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 16sm6824963pfi.161.2020.08.13.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 13:55:42 -0700 (PDT)
Date:   Thu, 13 Aug 2020 14:55:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, gregkh@linuxfoundation.org,
        tingwei@codeaurora.org, Ruediger Oertel <ro@suse.com>
Subject: Re: [PATCH] coresight: fix offset by one error in counting ports
Message-ID: <20200813205540.GN3393195@xps15>
References: <20200813100456.11803-1-ykaukab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813100456.11803-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:04:55PM +0200, Mian Yousaf Kaukab wrote:
> Since port-numbers start from 0, add 1 to port-number to get the port
> count.
> 
> Fix following crash when Coresight is enabled on ACPI based systems:
> 
> [   61.061736] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> ...
> [   61.135494] pc : acpi_coresight_parse_graph+0x1c4/0x37c
> [   61.140705] lr : acpi_coresight_parse_graph+0x160/0x37c
> [   61.145915] sp : ffff800012f4ba40
> [   61.145917] x29: ffff800012f4ba40 x28: ffff00becce62f98
> [   61.159896] x27: 0000000000000005 x26: ffff00becd8a7c88
> [   61.165195] x25: ffff00becd8a7d88 x24: ffff00becce62f80
> [   61.170492] x23: ffff800011ef99c0 x22: ffff009efb8bc010
> [   61.175790] x21: 0000000000000018 x20: 0000000000000005
> [   61.181087] x19: ffff00becce62e80 x18: 0000000000000020
> [   61.186385] x17: 0000000000000001 x16: 00000000000002a8
> [   61.191682] x15: ffff000838648550 x14: ffffffffffffffff
> [   61.196980] x13: 0000000000000000 x12: ffff00becce62d87
> [   61.202277] x11: 00000000ffffff76 x10: 000000000000002e
> [   61.207575] x9 : ffff8000107e1a68 x8 : ffff00becce63000
> [   61.212873] x7 : 0000000000000018 x6 : 000000000000003f
> [   61.218170] x5 : 0000000000000000 x4 : 0000000000000000
> [   61.223467] x3 : 0000000000000000 x2 : 0000000000000000
> [   61.228764] x1 : ffff00becce62f80 x0 : 0000000000000000
> [   61.234062] Call trace:
> [   61.236497]  acpi_coresight_parse_graph+0x1c4/0x37c
> [   61.241361]  coresight_get_platform_data+0xdc/0x130
> [   61.246225]  tmc_probe+0x138/0x2dc
> [   61.246227]  amba_probe+0xdc/0x220
> [   61.255779]  really_probe+0xe8/0x49c
> [   61.255781]  driver_probe_device+0xec/0x140
> [   61.255782]  device_driver_attach+0xc8/0xd0
> [   61.255785]  __driver_attach+0xac/0x180
> [   61.265857]  bus_for_each_dev+0x78/0xcc
> [   61.265859]  driver_attach+0x2c/0x40
> [   61.265861]  bus_add_driver+0x150/0x244
> [   61.265863]  driver_register+0x80/0x13c
> [   61.273591]  amba_driver_register+0x60/0x70
> [   61.273594]  tmc_driver_init+0x20/0x2c
> [   61.281582]  do_one_initcall+0x50/0x230
> [   61.281585]  do_initcalls+0x104/0x144
> [   61.291831]  kernel_init_freeable+0x168/0x1dc
> [   61.291834]  kernel_init+0x1c/0x120
> [   61.299215]  ret_from_fork+0x10/0x18
> [   61.299219] Code: b9400022 f9400660 9b277c42 8b020000 (f9400404)
> [   61.307381] ---[ end trace 63c6c3d7ec6a9b7c ]---
> [   61.315225] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Fixes: d375b356e687 ("coresight: Fix support for sparsely populated ports")
> Reported-by: Ruediger Oertel <ro@suse.com>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>

I have applied your patch to my local branch - it will be published on Monday
with the release of v5.9-rc1.

Thanks,
Mathieu

> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index bfd44231d7ad..227e234a2470 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -711,11 +711,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>  			return dir;
>  
>  		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> -			if (ptr->outport > pdata->nr_outport)
> -				pdata->nr_outport = ptr->outport;
> +			if (ptr->outport >= pdata->nr_outport)
> +				pdata->nr_outport = ptr->outport + 1;
>  			ptr++;
>  		} else {
> -			WARN_ON(pdata->nr_inport == ptr->child_port);
> +			WARN_ON(pdata->nr_inport == ptr->child_port + 1);
>  			/*
>  			 * We do not track input port connections for a device.
>  			 * However we need the highest port number described,
> @@ -723,8 +723,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>  			 * record for an output connection. Hence, do not move
>  			 * the ptr for input connections
>  			 */
> -			if (ptr->child_port > pdata->nr_inport)
> -				pdata->nr_inport = ptr->child_port;
> +			if (ptr->child_port >= pdata->nr_inport)
> +				pdata->nr_inport = ptr->child_port + 1;
>  		}
>  	}
>  
> -- 
> 2.26.2
> 
