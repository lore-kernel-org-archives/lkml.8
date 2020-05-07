Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ADDC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE1721582
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe3aqHVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEGTd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:33:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B62C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 12:33:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b6so2465685plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 12:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZ1SmtTXox+HLHe1kr6jo82KeNUkUxwLWM7wfxKHCRk=;
        b=Fe3aqHVU3NAY8yC4QMrkrw/E4YUbGIdmsNGkyz4T6H7+1DtVLd268H7Jt8/SADm8Fo
         4ow6Qc63rSbdGK7jwW6vjH2EbsvxFnBkUNeUpYnmd8wpnrRZHhQgonw22dnYHeHvGNwu
         zwojBTp+gXUdh2M8TTTy0I16fJD2hSU/+thBlBu2tQUFk0vH8uWJcA2uAGmGntHTBl6V
         1unmsFr4kMcpBLubbb59r8rp7jhaUsyXF8Gnra9El9fMJFxmrETPY8bkwYKZSBnLKq/a
         ftK4g5t532XJvQ83DR1i4FfCOtPcn5e5GGl96wUpjDMJhvMxOH+aXbM3xRbSCZhCxwvW
         usfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZ1SmtTXox+HLHe1kr6jo82KeNUkUxwLWM7wfxKHCRk=;
        b=lgFfn9BGUuC7Hb19A0IcQb3NNCPKPTHDVebQfod26hA5OM7x8L7kIqSvHd+UDS6W4o
         eJoeP9rvmbwgIN3PM6mO+F5hRyErmAIywnyXkMD96ShhnMm6FKQON8MUvvTbOqYhtb8g
         XhL2S/x1v/JhZeJDhIhOUPKKCyFOd7dXLy4T8u0KtbspR6X1jACVvifMHr8183FjDzaB
         8fYZvb4ZWSIgDFTZIjBULb2fn5JYQLu3+ribpMp9K4XZg/pgYWsis94OOTksiqXjOUqM
         78DsOkT0St7PujMPW2FE3ZZnjZ7KOUOuH7DCsnAnwJJIdsUwCFpX3LZvRC68vTxoZQaB
         bBTw==
X-Gm-Message-State: AGi0PuYOzgk1rL4xrs/fAZtZWAzGQO/MOnpILn0ZIOyAgCFE4iHb6m0V
        oq3cGH3gNgnrLIqXsPviM2tic4pdarg=
X-Google-Smtp-Source: APiQypJSyCdHWHyhaRwz5SoD1qlFosjHgN/RaORmzsn1gMvU0mQCUEffMA4EUN7e7EFNEdnGVvIt7Q==
X-Received: by 2002:a17:90a:2344:: with SMTP id f62mr1623845pje.152.1588880005228;
        Thu, 07 May 2020 12:33:25 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i13sm533343pja.40.2020.05.07.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 12:32:32 -0700 (PDT)
Date:   Thu, 7 May 2020 12:33:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 1/3] remoteproc: Make coredump functionality configurable
Message-ID: <20200507193300.GJ2329931@builder.lan>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Apr 11:38 PDT 2020, Rishabh Bhatnagar wrote:

$subject says that this patch makes coredump configurable, but this
patch simply moves the rproc_coredump() to its own file.

I think this is the right thing to do and should be done as verbatim as
possible (i.e. just make sure it still works). I do think you should
include the remaining functions for adding segments etc, so that we
capture all of "coredump" in this new file.

> Add a new file implementing coredump specific functionality.
> This would enable clients to have the option to implement custom
> dump functionality. The default coredump functionality remains same
> as rproc_coredump function.

So please update $subject and reword this message to describe the fact
that you're just moving code out of the core, for the purpose of
upcoming enhancements.

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

If you move this up right below remoteproc_core.o you're maintaining the
almost alphabetical order of these.

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

You should be able to remove this from remoteproc_core.c.

> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/remoteproc.h>
> +#include "remoteproc_internal.h"
> +
> +static void create_elf_header(void *data, int phnum, struct rproc *rproc)

As Mathieu pointed out, please move the code (as) verbatim (as possible)
in this commit and then follow up with enhancements in subsequent
commits.

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
> +	}
> +
> +	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +}
> +EXPORT_SYMBOL(rproc_default_coredump);

As Mathieu pointed out, there's no need to EXPORT_SYMBOL within
remoteproc.ko

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

We keep these inline functions to make the following of a ops function
pointer nicer looking, but this is just a function call. So please drop
this and let the core just call straight into the remoteproc_coredump.c.

Regards,
Bjorn

> +{
> +	return rproc_default_coredump(rproc);
> +
> +}
> +
>  #endif /* REMOTEPROC_INTERNAL_H */
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
