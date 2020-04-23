Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C53C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDF020736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEJ2uS5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgDWSHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730116AbgDWSHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:07:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B149C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:07:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so3339575pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6bHjyyZoaK5oXAIMemM6leVY+U7PZvJ5B9lnPpA7L2k=;
        b=hEJ2uS5hBAbSGdMBW7OY/L8gMFYEU4LfZsGak3wbbCbDbHF7syQ7M0jSZnBzXWPbpU
         Vn70AzNEgZSyWuOoiSF2tNo/du/APqyEb+iOo7krvdz1OEfD6mYpAfyTUoBvARuWwz/v
         lOf5ZSnAOkd4ODHAQ0mqAaNY6iJqoHkvIrMjHxVcTXHWeA5UsONM1onb7Bi6dMbdD0NK
         KNcDu8+U8UJIjkymRMff1rnL+7S5XF1ifmJfQCmXrJ+j+AIn8TaYmcZk9IQdtZ9iernD
         XNPIO4oU73d9xlYtOdPa4fd4mK8TTHMbAaOc99eueOXcecx57+0Ok8SCN8jbY1UDykH4
         F5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bHjyyZoaK5oXAIMemM6leVY+U7PZvJ5B9lnPpA7L2k=;
        b=pX0H4876j7pyhKEBFKmjDJdTALKSDHkYYaY/MFKoO9aO9aL1r1qiQ4TKt0ofmCn+nC
         HBousZWLHw6iZ3dKQKAvlU1w1qxNg77shicOrJJGgoAylep2l4bcOrMidaaLrSfC/m0N
         keIUteMqQ29BwPDJoubIBbMvAB3NL89FDHJMPz2UUNauzz1ORonhB5yqNl+9Jaur/AP9
         B7xMgGiKvahPkPT91tW8h71ASxYpElZOKJrZYQ7AP56+OgsOcctYo4Oe6yuC+Nfgf9V9
         AQe1vC9Jsl9+e3tCdrV2ggyF08Ick8LzuAFN26LtEzkHm4HDb1T8tJ/IhiCWHv/37zHA
         rp0A==
X-Gm-Message-State: AGi0PuYyJFxXVk8cOy5wZzZsDDyeUykPPxX+pe9UEsmnJDgdeLsm9kdV
        5laSfMzHROYyBh+NHG+A/7hXMQ==
X-Google-Smtp-Source: APiQypK6Ls88dlYekwKJIGMc4/sEra3k6u+5sAuLWo1XVNhJstcTZ0agDroDUzFaNLzz8fIeuhdI2A==
X-Received: by 2002:a63:2c07:: with SMTP id s7mr4978957pgs.230.1587665237534;
        Thu, 23 Apr 2020 11:07:17 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s12sm2594895pgi.38.2020.04.23.11.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:07:17 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:07:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 1/3] remoteproc: Make coredump functionality configurable
Message-ID: <20200423180715.GA6001@xps15>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishabh,

On Thu, Apr 16, 2020 at 11:38:30AM -0700, Rishabh Bhatnagar wrote:
> Add a new file implementing coredump specific functionality.
> This would enable clients to have the option to implement custom
> dump functionality. The default coredump functionality remains same
> as rproc_coredump function.

Next time please add a cover letter that mentions the baseline your work applies
on and version your patches.

> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/Makefile              |   1 +
>  drivers/remoteproc/remoteproc_core.c     |  83 -----------------------
>  drivers/remoteproc/remoteproc_coredump.c | 111 +++++++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  10 +++
>  4 files changed, 122 insertions(+), 83 deletions(-)
>  create mode 100644 drivers/remoteproc/remoteproc_coredump.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e30a1b1..f1d1264 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -9,6 +9,7 @@ remoteproc-y				+= remoteproc_debugfs.o
>  remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
>  remoteproc-y				+= remoteproc_elf_loader.o
> +remoteproc-y				+= remoteproc_coredump.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>  obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 097f33e..c0e9e5d 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1555,89 +1555,6 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
>  EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
>  
>  /**
> - * rproc_coredump() - perform coredump
> - * @rproc:	rproc handle
> - *
> - * This function will generate an ELF header for the registered segments
> - * and create a devcoredump device associated with rproc.
> - */
> -static void rproc_coredump(struct rproc *rproc)
> -{
> -	struct rproc_dump_segment *segment;
> -	struct elf32_phdr *phdr;
> -	struct elf32_hdr *ehdr;
> -	size_t data_size;
> -	size_t offset;
> -	void *data;
> -	void *ptr;
> -	int phnum = 0;
> -
> -	if (list_empty(&rproc->dump_segments))
> -		return;
> -
> -	data_size = sizeof(*ehdr);
> -	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		data_size += sizeof(*phdr) + segment->size;
> -
> -		phnum++;
> -	}
> -
> -	data = vmalloc(data_size);
> -	if (!data)
> -		return;
> -
> -	ehdr = data;
> -
> -	memset(ehdr, 0, sizeof(*ehdr));
> -	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> -	ehdr->e_ident[EI_CLASS] = ELFCLASS32;
> -	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> -	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> -	ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
> -	ehdr->e_type = ET_CORE;
> -	ehdr->e_machine = EM_NONE;
> -	ehdr->e_version = EV_CURRENT;
> -	ehdr->e_entry = rproc->bootaddr;
> -	ehdr->e_phoff = sizeof(*ehdr);
> -	ehdr->e_ehsize = sizeof(*ehdr);
> -	ehdr->e_phentsize = sizeof(*phdr);
> -	ehdr->e_phnum = phnum;
> -
> -	phdr = data + ehdr->e_phoff;
> -	offset = ehdr->e_phoff + sizeof(*phdr) * ehdr->e_phnum;
> -	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		memset(phdr, 0, sizeof(*phdr));
> -		phdr->p_type = PT_LOAD;
> -		phdr->p_offset = offset;
> -		phdr->p_vaddr = segment->da;
> -		phdr->p_paddr = segment->da;
> -		phdr->p_filesz = segment->size;
> -		phdr->p_memsz = segment->size;
> -		phdr->p_flags = PF_R | PF_W | PF_X;
> -		phdr->p_align = 0;
> -
> -		if (segment->dump) {
> -			segment->dump(rproc, segment, data + offset);
> -		} else {
> -			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> -			if (!ptr) {
> -				dev_err(&rproc->dev,
> -					"invalid coredump segment (%pad, %zu)\n",
> -					&segment->da, segment->size);
> -				memset(data + offset, 0xff, segment->size);
> -			} else {
> -				memcpy(data + offset, ptr, segment->size);
> -			}
> -		}
> -
> -		offset += phdr->p_filesz;
> -		phdr++;
> -	}
> -
> -	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> -}
> -
> -/**
>   * rproc_trigger_recovery() - recover a remoteproc
>   * @rproc: the remote processor
>   *
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> new file mode 100644
> index 0000000..9de0467
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Coredump functionality for Remoteproc framework.
> + *
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/devcoredump.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/remoteproc.h>
> +#include "remoteproc_internal.h"
> +
> +static void create_elf_header(void *data, int phnum, struct rproc *rproc)
> +{
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	struct rproc_dump_segment *segment;
> +	int offset;
> +
> +	ehdr = data;
> +
> +	memset(ehdr, 0, sizeof(*ehdr));
> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> +	ehdr->e_ident[EI_CLASS] = ELFCLASS32;
> +	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> +	ehdr->e_ident[EI_OSABI] = ELFOSABI_NONE;
> +	ehdr->e_type = ET_CORE;
> +	ehdr->e_machine = EM_NONE;
> +	ehdr->e_version = EV_CURRENT;
> +	ehdr->e_entry = rproc->bootaddr;
> +	ehdr->e_phoff = sizeof(*ehdr);
> +	ehdr->e_ehsize = sizeof(*ehdr);
> +	ehdr->e_phentsize = sizeof(*phdr);
> +	ehdr->e_phnum = phnum;
> +
> +	phdr = data + ehdr->e_phoff;
> +	offset = ehdr->e_phoff + sizeof(*phdr) * ehdr->e_phnum;
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		memset(phdr, 0, sizeof(*phdr));
> +		phdr->p_type = PT_LOAD;
> +		phdr->p_offset = offset;
> +		phdr->p_vaddr = segment->da;
> +		phdr->p_paddr = segment->da;
> +		phdr->p_filesz = segment->size;
> +		phdr->p_memsz = segment->size;
> +		phdr->p_flags = PF_R | PF_W | PF_X;
> +		phdr->p_align = 0;
> +
> +		offset += phdr->p_filesz;
> +		phdr++;
> +	}
> +}
> +
> +/**
> + * rproc_default_coredump() - perform coredump
> + * @rproc:	rproc handle
> + *
> + * This function will generate an ELF header for the registered segments
> + * and create a devcoredump device associated with rproc.
> + */
> +void rproc_default_coredump(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *segment;
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	size_t data_size;
> +	void *data, *ptr;
> +	int offset, phnum = 0;
> +
> +	if (list_empty(&rproc->dump_segments))
> +		return;
> +
> +	data_size = sizeof(*ehdr);
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		data_size += sizeof(*phdr) + segment->size;
> +
> +		phnum++;
> +	}
> +
> +	data = vmalloc(data_size);
> +	if (!data)
> +		return;
> +
> +	ehdr = data;
> +	create_elf_header(data, phnum, rproc);

Please leave function rproc_default_coredump() the same way it originally was
for this patch.  Modifications can be done in later patches. 

> +
> +	phdr = data + ehdr->e_phoff;
> +	offset = ehdr->e_phoff + sizeof(*phdr) * ehdr->e_phnum;
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		if (segment->dump) {
> +			segment->dump(rproc, segment, data + offset);
> +		} else {
> +			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> +			if (!ptr) {
> +				dev_err(&rproc->dev,
> +					"invalid coredump segment (%pad, %zu)\n",
> +					&segment->da, segment->size);
> +				memset(data + offset, 0xff, segment->size);
> +			} else {
> +				memcpy(data + offset, ptr, segment->size);
> +			}
> +		}
> +		phdr++;

Here @offset is not updated and as such will trample the previous value with
each iteration.  To be honest I would rather keep the initialisation of @phdr in
this loop, that way it is done only once. 

Thanks,
Mathieu

> +	}
> +
> +	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL(rproc_default_coredump);
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 493ef92..28b6af2 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -47,6 +47,9 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  int rproc_init_sysfs(void);
>  void rproc_exit_sysfs(void);
>  
> +/* from remoteproc_coredump.c */
> +void rproc_default_coredump(struct rproc *rproc);
> +
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> @@ -119,4 +122,11 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  	return NULL;
>  }
>  
> +static inline
> +void rproc_coredump(struct rproc *rproc)
> +{
> +	return rproc_default_coredump(rproc);
> +
> +}
> +
>  #endif /* REMOTEPROC_INTERNAL_H */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
