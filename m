Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ED9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F42F2465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="isjU/5nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCBXNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:13:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55080 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCBXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:13:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so458143pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnjZ0Ovav8ThhXJbqB/J6Alq9KHUGhvFu8W6iODhPtE=;
        b=isjU/5nbZlZNuN0fg1k/tEp5bCxt83Xe5D3f3bYYgKBRkH2drx7YC8+On/HxTBl04m
         APyz2XsIxjS/zhADo0WQkJVVu3ypfPp71FZtpdXRtEwQ2UK9SdL7rUO9zd5UBxAkx06x
         x8X2VbTJ1mfblaoiGrX2BIlwTseyEYDj2DQ28J3KLvvwD5fhYRzirz8i6o17ZYJWBHQE
         lPe+kIPTgm5+PfZeWjDcrwO+0+PVo/XpdwVS/APWBzb6tNkacOy8em0KlRSXiY8x1VpX
         bbIMAbzjoAOWZUD25viq0KyXxhT9ik2QuzSp961xCHCA1nvzxzzOmDfgs5/LPIt0uoWl
         7SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnjZ0Ovav8ThhXJbqB/J6Alq9KHUGhvFu8W6iODhPtE=;
        b=POY51jJnqa2SoJ6K9f5gEwSorH/JBoGkvICQE78/AqaPCIr4kVM9U4MvrlIR3iVxfj
         LKrC0KphJhPAlnqG7RRJqh4nkqcEv/KNBZ9PoTXvcoLDdpSJe3nhlUvAk1GdFBh+Ytt5
         xVmJjywzitP+uU5R1R6JnU0EXXDRwaTda/Lkpwf0NIt6eVnXpb+WfWD+QEpqwWUsV+zb
         5xcRYh6wnh8HgHh0Vh/uC3KJiVHc6W5QRFj6MJIO9Q0/KzvU9KVthjG7UVkOJ0pCDj5h
         VfVadzKhVwqB1dyZUW2Nzfyvy/oE6Zibu24cMPEmF10fNvMKeGwDC0Gf+eylDztUX1O/
         d0BA==
X-Gm-Message-State: ANhLgQ3huzRHFDMKVXhIa7aK4VdY8bVO24SHvAnlnIe6W5L0DHWHzFB9
        Awze3w1Jrj8CM8qOt1NU/SPYDg==
X-Google-Smtp-Source: ADFU+vvwgZGBSGTSJS7sOaaK6KTefrZb5fJNWL/VfguLMXiwHxst0TaMhTqCP1i2MHKKY4X1QBWHqw==
X-Received: by 2002:a17:90a:a48:: with SMTP id o66mr924389pjo.66.1583190826077;
        Mon, 02 Mar 2020 15:13:46 -0800 (PST)
Received: from yoga (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id h5sm21413117pgi.28.2020.03.02.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:13:45 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:13:42 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-remoteproc@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>, s-anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v5 5/8] remoteproc: Rename rproc_elf_sanity_check for
 elf32
Message-ID: <20200302231342.GE262924@yoga>
References: <20200210162209.23149-1-cleger@kalray.eu>
 <20200302093902.27849-1-cleger@kalray.eu>
 <20200302093902.27849-6-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302093902.27849-6-cleger@kalray.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02 Mar 01:38 PST 2020, Clement Leger wrote:

> Since this function will be modified to support both elf32 and elf64,
> rename the existing one to elf32 (which is the only supported format
> at the moment). This will allow not to introduce possible side effect
> when adding elf64 support (ie: all backends will still support only
> elf32 if not requested explicitely using rproc_elf_sanity_check).
> 

Is there a reason for preventing ELF64 binaries be loaded?

Regards,
Bjorn

> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/remoteproc_core.c       | 2 +-
>  drivers/remoteproc/remoteproc_elf_loader.c | 6 +++---
>  drivers/remoteproc/remoteproc_internal.h   | 2 +-
>  drivers/remoteproc/st_remoteproc.c         | 2 +-
>  drivers/remoteproc/st_slim_rproc.c         | 2 +-
>  drivers/remoteproc/stm32_rproc.c           | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 4bfaf4a3c4a3..99f0b796fbc7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2055,7 +2055,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		rproc->ops->load = rproc_elf_load_segments;
>  		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
>  		rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
> -		rproc->ops->sanity_check = rproc_elf_sanity_check;
> +		rproc->ops->sanity_check = rproc_elf32_sanity_check;
>  		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
>  	}
>  
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index c2a9783cfb9a..5a67745f2638 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -25,13 +25,13 @@
>  #include "remoteproc_internal.h"
>  
>  /**
> - * rproc_elf_sanity_check() - Sanity Check ELF firmware image
> + * rproc_elf_sanity_check() - Sanity Check ELF32 firmware image
>   * @rproc: the remote processor handle
>   * @fw: the ELF firmware image
>   *
>   * Make sure this fw image is sane.
>   */
> -int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
> +int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  {
>  	const char *name = rproc->firmware;
>  	struct device *dev = &rproc->dev;
> @@ -89,7 +89,7 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(rproc_elf_sanity_check);
> +EXPORT_SYMBOL(rproc_elf32_sanity_check);
>  
>  /**
>   * rproc_elf_get_boot_addr() - Get rproc's boot address.
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 0deae5f237b8..28639c588d58 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -54,7 +54,7 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len);
>  phys_addr_t rproc_va_to_pa(void *cpu_addr);
>  int rproc_trigger_recovery(struct rproc *rproc);
>  
> -int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
> +int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw);
>  u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw);
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index a3268d95a50e..a6cbfa452764 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -233,7 +233,7 @@ static const struct rproc_ops st_rproc_ops = {
>  	.parse_fw		= st_rproc_parse_fw,
>  	.load			= rproc_elf_load_segments,
>  	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
> -	.sanity_check		= rproc_elf_sanity_check,
> +	.sanity_check		= rproc_elf32_sanity_check,
>  	.get_boot_addr		= rproc_elf_get_boot_addr,
>  };
>  
> diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> index 09bcb4d8b9e0..3cca8b65a8db 100644
> --- a/drivers/remoteproc/st_slim_rproc.c
> +++ b/drivers/remoteproc/st_slim_rproc.c
> @@ -203,7 +203,7 @@ static const struct rproc_ops slim_rproc_ops = {
>  	.da_to_va       = slim_rproc_da_to_va,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  	.load		= rproc_elf_load_segments,
> -	.sanity_check	= rproc_elf_sanity_check,
> +	.sanity_check	= rproc_elf32_sanity_check,
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index a18f88044111..9a8b5f5e2572 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -505,7 +505,7 @@ static struct rproc_ops st_rproc_ops = {
>  	.load		= rproc_elf_load_segments,
>  	.parse_fw	= stm32_rproc_parse_fw,
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> -	.sanity_check	= rproc_elf_sanity_check,
> +	.sanity_check	= rproc_elf32_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
> -- 
> 2.15.0.276.g89ea799
> 
