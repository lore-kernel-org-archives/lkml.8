Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DF820823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBpeA0mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgESX3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgESX3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:29:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:29:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so557347pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9VlJDshGqFwXsERNxtqx50EEl+t1E1Y1k/WKH7hZ7A=;
        b=SBpeA0mBEt+lJPky8uGVBeUXVTVp7DhvKla5yUsppPKM5/keYGd8G2e/UXqS7n0ClT
         nTNCSnv943KCBqkZHgHwCZOmQAY4IMdBrvrgG0n9GkTbhWZu5821FLpRk62wPZLrxAbP
         EVJpJQspBfwSlMYR8rrBuNzryrpXqDN4CiItb8BKJeEBE59u1VQ3kGyjL2xqFkGS4OKp
         iE9wbYKFfHz9nEf6gawOlJAMP7Q/gWyvgLJlXmbx7rUyiS+mPXStE6YJ6+acV3HVJVtV
         nOKwKlyHEmK6FicHX9erMLgZvTDh2MBze49BQwGPRfZGEehcJDOVMuMMQ2NBU9etsMlS
         z4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9VlJDshGqFwXsERNxtqx50EEl+t1E1Y1k/WKH7hZ7A=;
        b=Xx0hHkZhH2P7wjx/aW0fM6jO8t6OWl54Ed9O2kJAjSYLLDdAm1reGCEKC1v57l2GzL
         8tBQt04pblDxLWXCWpwTfsQ0OHlyNcF/21uZfS0bVTQ7lsGVd1/0NHjX+VG/8pIHJueu
         8tz9K/Qu+hqOZmy+qu3EU8gf+9TWItnDJFBu3XwZx399W5CTsmkcC0ldwGKl+9kOifRP
         ZNGQtYLI6ZuwivdWVmRgb7cBe1K9ESs7yCQKJ1EZdSn6ZKSFAxV0QoPbYQgKdrBa+pHN
         a854qQXwuxNy3g/9kohM7QlxeaQHwKPlhY9nAz4ylzrYHpqGIF9kjnyDUlDtW5h29ubR
         slSQ==
X-Gm-Message-State: AOAM531a8NUi4+zG0oeOi4DHdxpskADxMaeSY4aX0Ku6l4sexxFrsDkB
        vuJncI5oLtnI1CimGwlyOzWmRw==
X-Google-Smtp-Source: ABdhPJyOVkF4UKvLo+5vwRzQxQ4TQeJrBXovGBNqo8QEth9jq8B3pHBuoPYqX/7MjAr3MjXwBPhbEg==
X-Received: by 2002:a05:6a00:d2:: with SMTP id e18mr1547133pfj.252.1589930988791;
        Tue, 19 May 2020 16:29:48 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g184sm458425pfb.80.2020.05.19.16.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:29:47 -0700 (PDT)
Date:   Tue, 19 May 2020 16:28:26 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 1/3] remoteproc: Move coredump functionality to a new
 file
Message-ID: <20200519232826.GE408178@builder.lan>
References: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
 <1589486856-23440-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589486856-23440-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 May 13:07 PDT 2020, Rishabh Bhatnagar wrote:

> Move all coredump functionality to an individual file. This is
> being done so that the current functionality can be extended
> in future patchsets.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thanks,
Bjorn

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/Makefile              |   1 +
>  drivers/remoteproc/remoteproc_core.c     | 191 -----------------------------
>  drivers/remoteproc/remoteproc_coredump.c | 204 +++++++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |   4 +
>  4 files changed, 209 insertions(+), 191 deletions(-)
>  create mode 100644 drivers/remoteproc/remoteproc_coredump.c
> 
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 0effd38..f1a33c3 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_REMOTEPROC)		+= remoteproc.o
>  remoteproc-y				:= remoteproc_core.o
> +remoteproc-y				+= remoteproc_coredump.o
>  remoteproc-y				+= remoteproc_debugfs.o
>  remoteproc-y				+= remoteproc_sysfs.o
>  remoteproc-y				+= remoteproc_virtio.o
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 4bd0f45..22575f4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -26,7 +26,6 @@
>  #include <linux/firmware.h>
>  #include <linux/string.h>
>  #include <linux/debugfs.h>
> -#include <linux/devcoredump.h>
>  #include <linux/rculist.h>
>  #include <linux/remoteproc.h>
>  #include <linux/iommu.h>
> @@ -40,7 +39,6 @@
>  #include <linux/platform_device.h>
>  
>  #include "remoteproc_internal.h"
> -#include "remoteproc_elf_helpers.h"
>  
>  #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
>  
> @@ -1238,19 +1236,6 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
>  	return 0;
>  }
>  
> -/**
> - * rproc_coredump_cleanup() - clean up dump_segments list
> - * @rproc: the remote processor handle
> - */
> -static void rproc_coredump_cleanup(struct rproc *rproc)
> -{
> -	struct rproc_dump_segment *entry, *tmp;
> -
> -	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> -		list_del(&entry->node);
> -		kfree(entry);
> -	}
> -}
>  
>  /**
>   * rproc_resource_cleanup() - clean up and free all acquired resources
> @@ -1509,182 +1494,6 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  	return 0;
>  }
>  
> -/**
> - * rproc_coredump_add_segment() - add segment of device memory to coredump
> - * @rproc:	handle of a remote processor
> - * @da:		device address
> - * @size:	size of segment
> - *
> - * Add device memory to the list of segments to be included in a coredump for
> - * the remoteproc.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
> -{
> -	struct rproc_dump_segment *segment;
> -
> -	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
> -	if (!segment)
> -		return -ENOMEM;
> -
> -	segment->da = da;
> -	segment->size = size;
> -
> -	list_add_tail(&segment->node, &rproc->dump_segments);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(rproc_coredump_add_segment);
> -
> -/**
> - * rproc_coredump_add_custom_segment() - add custom coredump segment
> - * @rproc:	handle of a remote processor
> - * @da:		device address
> - * @size:	size of segment
> - * @dumpfn:	custom dump function called for each segment during coredump
> - * @priv:	private data
> - *
> - * Add device memory to the list of segments to be included in the coredump
> - * and associate the segment with the given custom dump function and private
> - * data.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int rproc_coredump_add_custom_segment(struct rproc *rproc,
> -				      dma_addr_t da, size_t size,
> -				      void (*dumpfn)(struct rproc *rproc,
> -						     struct rproc_dump_segment *segment,
> -						     void *dest),
> -				      void *priv)
> -{
> -	struct rproc_dump_segment *segment;
> -
> -	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
> -	if (!segment)
> -		return -ENOMEM;
> -
> -	segment->da = da;
> -	segment->size = size;
> -	segment->priv = priv;
> -	segment->dump = dumpfn;
> -
> -	list_add_tail(&segment->node, &rproc->dump_segments);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
> -
> -/**
> - * rproc_coredump_set_elf_info() - set coredump elf information
> - * @rproc:	handle of a remote processor
> - * @class:	elf class for coredump elf file
> - * @machine:	elf machine for coredump elf file
> - *
> - * Set elf information which will be used for coredump elf file.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
> -{
> -	if (class != ELFCLASS64 && class != ELFCLASS32)
> -		return -EINVAL;
> -
> -	rproc->elf_class = class;
> -	rproc->elf_machine = machine;
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(rproc_coredump_set_elf_info);
> -
> -/**
> - * rproc_coredump() - perform coredump
> - * @rproc:	rproc handle
> - *
> - * This function will generate an ELF header for the registered segments
> - * and create a devcoredump device associated with rproc.
> - */
> -static void rproc_coredump(struct rproc *rproc)
> -{
> -	struct rproc_dump_segment *segment;
> -	void *phdr;
> -	void *ehdr;
> -	size_t data_size;
> -	size_t offset;
> -	void *data;
> -	void *ptr;
> -	u8 class = rproc->elf_class;
> -	int phnum = 0;
> -
> -	if (list_empty(&rproc->dump_segments))
> -		return;
> -
> -	if (class == ELFCLASSNONE) {
> -		dev_err(&rproc->dev, "Elf class is not set\n");
> -		return;
> -	}
> -
> -	data_size = elf_size_of_hdr(class);
> -	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		data_size += elf_size_of_phdr(class) + segment->size;
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
> -	memset(ehdr, 0, elf_size_of_hdr(class));
> -	/* e_ident field is common for both elf32 and elf64 */
> -	elf_hdr_init_ident(ehdr, class);
> -
> -	elf_hdr_set_e_type(class, ehdr, ET_CORE);
> -	elf_hdr_set_e_machine(class, ehdr, rproc->elf_machine);
> -	elf_hdr_set_e_version(class, ehdr, EV_CURRENT);
> -	elf_hdr_set_e_entry(class, ehdr, rproc->bootaddr);
> -	elf_hdr_set_e_phoff(class, ehdr, elf_size_of_hdr(class));
> -	elf_hdr_set_e_ehsize(class, ehdr, elf_size_of_hdr(class));
> -	elf_hdr_set_e_phentsize(class, ehdr, elf_size_of_phdr(class));
> -	elf_hdr_set_e_phnum(class, ehdr, phnum);
> -
> -	phdr = data + elf_hdr_get_e_phoff(class, ehdr);
> -	offset = elf_hdr_get_e_phoff(class, ehdr);
> -	offset += elf_size_of_phdr(class) * elf_hdr_get_e_phnum(class, ehdr);
> -
> -	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		memset(phdr, 0, elf_size_of_phdr(class));
> -		elf_phdr_set_p_type(class, phdr, PT_LOAD);
> -		elf_phdr_set_p_offset(class, phdr, offset);
> -		elf_phdr_set_p_vaddr(class, phdr, segment->da);
> -		elf_phdr_set_p_paddr(class, phdr, segment->da);
> -		elf_phdr_set_p_filesz(class, phdr, segment->size);
> -		elf_phdr_set_p_memsz(class, phdr, segment->size);
> -		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
> -		elf_phdr_set_p_align(class, phdr, 0);
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
> -		offset += elf_phdr_get_p_filesz(class, phdr);
> -		phdr += elf_size_of_phdr(class);
> -	}
> -
> -	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> -}
>  
>  /**
>   * rproc_trigger_recovery() - recover a remoteproc
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> new file mode 100644
> index 0000000..ded0244
> --- /dev/null
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -0,0 +1,204 @@
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
> +#include <linux/remoteproc.h>
> +#include "remoteproc_internal.h"
> +#include "remoteproc_elf_helpers.h"
> +
> +/**
> + * rproc_coredump_cleanup() - clean up dump_segments list
> + * @rproc: the remote processor handle
> + */
> +void rproc_coredump_cleanup(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> +		list_del(&entry->node);
> +		kfree(entry);
> +	}
> +}
> +
> +/**
> + * rproc_coredump_add_segment() - add segment of device memory to coredump
> + * @rproc:	handle of a remote processor
> + * @da:		device address
> + * @size:	size of segment
> + *
> + * Add device memory to the list of segments to be included in a coredump for
> + * the remoteproc.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
> +	if (!segment)
> +		return -ENOMEM;
> +
> +	segment->da = da;
> +	segment->size = size;
> +
> +	list_add_tail(&segment->node, &rproc->dump_segments);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rproc_coredump_add_segment);
> +
> +/**
> + * rproc_coredump_add_custom_segment() - add custom coredump segment
> + * @rproc:	handle of a remote processor
> + * @da:		device address
> + * @size:	size of segment
> + * @dumpfn:	custom dump function called for each segment during coredump
> + * @priv:	private data
> + *
> + * Add device memory to the list of segments to be included in the coredump
> + * and associate the segment with the given custom dump function and private
> + * data.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int rproc_coredump_add_custom_segment(struct rproc *rproc,
> +				      dma_addr_t da, size_t size,
> +				      void (*dumpfn)(struct rproc *rproc,
> +						     struct rproc_dump_segment *segment,
> +						     void *dest),
> +				      void *priv)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	segment = kzalloc(sizeof(*segment), GFP_KERNEL);
> +	if (!segment)
> +		return -ENOMEM;
> +
> +	segment->da = da;
> +	segment->size = size;
> +	segment->priv = priv;
> +	segment->dump = dumpfn;
> +
> +	list_add_tail(&segment->node, &rproc->dump_segments);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rproc_coredump_add_custom_segment);
> +
> +/**
> + * rproc_coredump_set_elf_info() - set coredump elf information
> + * @rproc:	handle of a remote processor
> + * @class:	elf class for coredump elf file
> + * @machine:	elf machine for coredump elf file
> + *
> + * Set elf information which will be used for coredump elf file.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
> +{
> +	if (class != ELFCLASS64 && class != ELFCLASS32)
> +		return -EINVAL;
> +
> +	rproc->elf_class = class;
> +	rproc->elf_machine = machine;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rproc_coredump_set_elf_info);
> +
> +/**
> + * rproc_coredump() - perform coredump
> + * @rproc:	rproc handle
> + *
> + * This function will generate an ELF header for the registered segments
> + * and create a devcoredump device associated with rproc.
> + */
> +void rproc_coredump(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *segment;
> +	void *phdr;
> +	void *ehdr;
> +	size_t data_size;
> +	size_t offset;
> +	void *data;
> +	void *ptr;
> +	u8 class = rproc->elf_class;
> +	int phnum = 0;
> +
> +	if (list_empty(&rproc->dump_segments))
> +		return;
> +
> +	if (class == ELFCLASSNONE) {
> +		dev_err(&rproc->dev, "Elf class is not set\n");
> +		return;
> +	}
> +
> +	data_size = elf_size_of_hdr(class);
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		data_size += elf_size_of_phdr(class) + segment->size;
> +
> +		phnum++;
> +	}
> +
> +	data = vmalloc(data_size);
> +	if (!data)
> +		return;
> +
> +	ehdr = data;
> +
> +	memset(ehdr, 0, elf_size_of_hdr(class));
> +	/* e_ident field is common for both elf32 and elf64 */
> +	elf_hdr_init_ident(ehdr, class);
> +
> +	elf_hdr_set_e_type(class, ehdr, ET_CORE);
> +	elf_hdr_set_e_machine(class, ehdr, rproc->elf_machine);
> +	elf_hdr_set_e_version(class, ehdr, EV_CURRENT);
> +	elf_hdr_set_e_entry(class, ehdr, rproc->bootaddr);
> +	elf_hdr_set_e_phoff(class, ehdr, elf_size_of_hdr(class));
> +	elf_hdr_set_e_ehsize(class, ehdr, elf_size_of_hdr(class));
> +	elf_hdr_set_e_phentsize(class, ehdr, elf_size_of_phdr(class));
> +	elf_hdr_set_e_phnum(class, ehdr, phnum);
> +
> +	phdr = data + elf_hdr_get_e_phoff(class, ehdr);
> +	offset = elf_hdr_get_e_phoff(class, ehdr);
> +	offset += elf_size_of_phdr(class) * elf_hdr_get_e_phnum(class, ehdr);
> +
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		memset(phdr, 0, elf_size_of_phdr(class));
> +		elf_phdr_set_p_type(class, phdr, PT_LOAD);
> +		elf_phdr_set_p_offset(class, phdr, offset);
> +		elf_phdr_set_p_vaddr(class, phdr, segment->da);
> +		elf_phdr_set_p_paddr(class, phdr, segment->da);
> +		elf_phdr_set_p_filesz(class, phdr, segment->size);
> +		elf_phdr_set_p_memsz(class, phdr, segment->size);
> +		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
> +		elf_phdr_set_p_align(class, phdr, 0);
> +
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
> +
> +		offset += elf_phdr_get_p_filesz(class, phdr);
> +		phdr += elf_size_of_phdr(class);
> +	}
> +
> +	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +}
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 4ba7cb5..97d441b 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -47,6 +47,10 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  int rproc_init_sysfs(void);
>  void rproc_exit_sysfs(void);
>  
> +/* from remoteproc_coredump.c */
> +void rproc_coredump_cleanup(struct rproc *rproc);
> +void rproc_coredump(struct rproc *rproc);
> +
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
