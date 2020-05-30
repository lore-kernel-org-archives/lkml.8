Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1327FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47E3208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2iomiCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgE3DLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE3DLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 23:11:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8DAC03E969;
        Fri, 29 May 2020 20:11:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z64so739024pfb.1;
        Fri, 29 May 2020 20:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=itkS+rLxG0j3d2wAPSaT9vUD+EmHbZGAjTEvDwroJZY=;
        b=X2iomiCi0U4lxn91zwW4jw40L+v7+RxtzVRJKbNo0p1P2o1d9ZZkBqTlJcYe8Zfi7q
         k+SnyLCZ/VEyqeCrl1/yeDDqbfeMJePdPjuT7RuttuHfdeGt40GSWfQnGj6rktoOXAiy
         11qfqjzyaTjQnCwaU5P8cu/BjmrcdqVFa86MoNEEZmRkCJAu/So+qkPDWA72ESY0TWx7
         obR60o1e4Nu+BrWcW9V1hrbDnrkJuKT81KljN4HsDF2Caqc+RmUW9CklbkGC2vpsicIo
         lRTFs3EV2FUH4Qlh/N0MnsCloMkR+GP6D8bjOdClyJwm7ZV0xcl+TjKFIXzcFulvKFvD
         V3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=itkS+rLxG0j3d2wAPSaT9vUD+EmHbZGAjTEvDwroJZY=;
        b=nzZtp7twJgJgj7y9bf7W62esNeBc7AAtZEQKqGpkwJxT+GIWwOXgOW04bLz4sul1Hp
         XOvgbqLBWde1qYrAlXzrhh6TYMbpST9WSXhaoccZdlOUDrpcksYpYyzCZznSrWU1XJ/N
         EnAYsvkFtaZ1Wf3WhC4pNMNVzgw0eUD+biKd1HLdnEb6U3nmGlIirKSxyvkZPZIFdFwo
         LXf5rrPmgy6idUimwk0w+MINDvpF7lwU79Eqd3n4z6cUo9EkZ5GiUiCaOwLi6VjyVDQZ
         ulNaCE7BaxGARTOpG9umbYMQnQO1RkovJzoKOO7qyR1uj3vq643Tv3pJHXMdMerRbz5G
         3zLw==
X-Gm-Message-State: AOAM530it3uH4Pp1ic6bOc8FNX4zwvk5gE0ecslM1e+goXnyS1EhDt6b
        CCJ4EzorwSwzA938kTmTYfg=
X-Google-Smtp-Source: ABdhPJzBxr7+VGrFtwwe6AOwSvfUQmx6ZgrcOqqOYbLQfJe8Ie4ICZQfQYSvVduIPnmFV+fNFOoQ4A==
X-Received: by 2002:a62:e801:: with SMTP id c1mr11425576pfi.217.1590808292708;
        Fri, 29 May 2020 20:11:32 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id n19sm5384613pfu.194.2020.05.29.20.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 20:11:31 -0700 (PDT)
Date:   Fri, 29 May 2020 20:11:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 9/9] staging: media: atomisp: add PMIC_OPREGION dependency
Message-ID: <20200530031129.GF1367069@ubuntu-s3-xlarge-x86>
References: <20200529200031.4117841-1-arnd@arndb.de>
 <20200529200031.4117841-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529200031.4117841-9-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:00:31PM +0200, Arnd Bergmann wrote:
> Without that driver, there is a link failure in
> 
> ERROR: modpost: "intel_soc_pmic_exec_mipi_pmic_seq_element"
> [drivers/staging/media/atomisp/pci/atomisp_gmin_platform.ko] undefined!
> 
> Add an explicit Kconfig dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It'd be interesting to know if this is strictly required for the driver
to work properly. The call to intel_soc_pmic_exec_mipi_pmic_seq_element
has some error handling after it, maybe that should just be surrounded
by an #ifdef or IS_ENABLED for PMIC_OPREGION, like some other drivers
do.

Regardless of that:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/staging/media/atomisp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
> index c4f3049b0706..e86311c14329 100644
> --- a/drivers/staging/media/atomisp/Kconfig
> +++ b/drivers/staging/media/atomisp/Kconfig
> @@ -11,6 +11,7 @@ menuconfig INTEL_ATOMISP
>  config VIDEO_ATOMISP
>  	tristate "Intel Atom Image Signal Processor Driver"
>  	depends on VIDEO_V4L2 && INTEL_ATOMISP
> +	depends on PMIC_OPREGION
>  	select IOSF_MBI
>  	select VIDEOBUF_VMALLOC
>  	---help---
> -- 
> 2.26.2
> 
