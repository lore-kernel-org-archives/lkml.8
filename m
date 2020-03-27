Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591DBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B39320658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjFVfqnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgC0QRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:17:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47058 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgC0QRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:17:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so4781304pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jhwYADhdGcLZbWIzbwxBzjxRAObWsK9tu6OvJnZhgK8=;
        b=mjFVfqnvAEAdGQxoWYIHbYy0+wwJhPKkgVBXpuF+JLGBQHrARncYWjhkj60r3u/Ohy
         gMlDZxixdo2YrheHdj9PypFdZMB4paHUWQ0Dysvo3Dh5fJaL5hUpsnIv/KsaI/XPQ6VC
         mXRHbbwQqeOtFbCLT6H5JqwjEOKjI4zV1UzKrgYsI+otvfieN3FwQ4AwuDFr19uD/GnN
         N/soZ2oeh19LWDzC3NqMTPMWCHm0v4z9h5ktH+BeEw37BkMO5xVf+2faWKp6mI/nLwa0
         AbLTb8CrC0uhcaCKalPUaZC0OYxrZqF3/lI5W6+/LkIN0haEj7jwE5xbAQreuF2zG7qP
         VHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jhwYADhdGcLZbWIzbwxBzjxRAObWsK9tu6OvJnZhgK8=;
        b=n/bdYbUbecx8s6NXjHbp7v2HxUsDq/AIxo4D4XWEVrm4RKm98TkyFPW2F0YDHK7w+Z
         3wSDQLRiyr9FDeWEUCQv0WexkUDGpk6CH22BkIgnQ+vSf4ey9JOtBn912msGhcrn03pZ
         T9eirIU5N4CGzISQsT0SyueaeJM3KoAndkpoLFwRHP9tXRRa8NwBPOpCR5Igq4rLRDSk
         QzY8BdFZ8gV+ThsAR31Nlfj9i18dO4bk9iohqQ42vT+NtiVd9hyGADJ6kTU7hPB9sAXT
         kMLsAdeXGkuxB9iKbhKN7VSjgWirf6scFJHoEV2FuhyPBv++CNYHNM1jzOcJ+ApoOuEs
         gkvQ==
X-Gm-Message-State: ANhLgQ3lx3udJPom8t1BSBps/i6OCVHndm+9DHlYCJp8Y3wr66hSYsdE
        8jnLPoyxdqgr4SJl4IeB9or81Q==
X-Google-Smtp-Source: ADFU+vuHJjTwlUlAnTmVZwL7ukhLfqdQyllSGr+zoP1DUk27+DscTsfzu3LkM6z3KfW5PHAuL3zRCQ==
X-Received: by 2002:a62:2cc3:: with SMTP id s186mr15383429pfs.236.1585325856083;
        Fri, 27 Mar 2020 09:17:36 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d3sm4136628pjz.2.2020.03.27.09.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 09:17:35 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:17:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Clement Leger <cleger@kalray.eu>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] remoteproc: remove rproc_elf32_sanity_check
Message-ID: <20200327161733.GA18041@xps15>
References: <20200327084939.8321-1-cleger@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327084939.8321-1-cleger@kalray.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:49:39AM +0100, Clement Leger wrote:
> Since checks are present in the remoteproc elf loader before calling
> da_to_va, loading a elf64 will work on 32bits flavors of kernel.
> Indeed, if a segment size is larger than what size_t can hold, the
> loader will return an error so the functionality is equivalent to
> what exists today.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/remoteproc_core.c       |  2 +-
>  drivers/remoteproc/remoteproc_elf_loader.c | 21 ---------------------
>  drivers/remoteproc/remoteproc_internal.h   |  1 -
>  drivers/remoteproc/st_remoteproc.c         |  2 +-
>  drivers/remoteproc/st_slim_rproc.c         |  2 +-
>  drivers/remoteproc/stm32_rproc.c           |  2 +-
>  6 files changed, 4 insertions(+), 26 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a9ac1d01e09b..02ff076b0122 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2069,7 +2069,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>  		rproc->ops->parse_fw = rproc_elf_load_rsc_table;
>  		rproc->ops->find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table;
>  		if (!rproc->ops->sanity_check)
> -			rproc->ops->sanity_check = rproc_elf32_sanity_check;
> +			rproc->ops->sanity_check = rproc_elf_sanity_check;
>  		rproc->ops->get_boot_addr = rproc_elf_get_boot_addr;
>  	}
>  
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 16e2c496fd45..29034f99898d 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -112,27 +112,6 @@ int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
>  }
>  EXPORT_SYMBOL(rproc_elf_sanity_check);
>  
> -/**
> - * rproc_elf_sanity_check() - Sanity Check ELF32 firmware image
> - * @rproc: the remote processor handle
> - * @fw: the ELF32 firmware image
> - *
> - * Make sure this fw image is sane.
> - */
> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw)
> -{
> -	int ret = rproc_elf_sanity_check(rproc, fw);
> -
> -	if (ret)
> -		return ret;
> -
> -	if (fw_elf_get_class(fw) == ELFCLASS32)
> -		return 0;
> -
> -	return -EINVAL;
> -}
> -EXPORT_SYMBOL(rproc_elf32_sanity_check);
> -
>  /**
>   * rproc_elf_get_boot_addr() - Get rproc's boot address.
>   * @rproc: the remote processor handle
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index b389dc79da81..31994715fd43 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -54,7 +54,6 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len);
>  phys_addr_t rproc_va_to_pa(void *cpu_addr);
>  int rproc_trigger_recovery(struct rproc *rproc);
>  
> -int rproc_elf32_sanity_check(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
>  u64 rproc_elf_get_boot_addr(struct rproc *rproc, const struct firmware *fw);
>  int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index a6cbfa452764..a3268d95a50e 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -233,7 +233,7 @@ static const struct rproc_ops st_rproc_ops = {
>  	.parse_fw		= st_rproc_parse_fw,
>  	.load			= rproc_elf_load_segments,
>  	.find_loaded_rsc_table	= rproc_elf_find_loaded_rsc_table,
> -	.sanity_check		= rproc_elf32_sanity_check,
> +	.sanity_check		= rproc_elf_sanity_check,
>  	.get_boot_addr		= rproc_elf_get_boot_addr,
>  };
>  
> diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
> index 3cca8b65a8db..09bcb4d8b9e0 100644
> --- a/drivers/remoteproc/st_slim_rproc.c
> +++ b/drivers/remoteproc/st_slim_rproc.c
> @@ -203,7 +203,7 @@ static const struct rproc_ops slim_rproc_ops = {
>  	.da_to_va       = slim_rproc_da_to_va,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  	.load		= rproc_elf_load_segments,
> -	.sanity_check	= rproc_elf32_sanity_check,
> +	.sanity_check	= rproc_elf_sanity_check,
>  };
>  
>  /**
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 6a66dbf2df40..2e07a95439c8 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -505,7 +505,7 @@ static struct rproc_ops st_rproc_ops = {
>  	.load		= rproc_elf_load_segments,
>  	.parse_fw	= stm32_rproc_parse_fw,
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> -	.sanity_check	= rproc_elf32_sanity_check,
> +	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
> -- 
> 2.17.1
> 
