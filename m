Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7543C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3F82070A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHR/hn+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGQFPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgGQFPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:15:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24695C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:15:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so6106528pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xRyjyFwD7RhIKeY2QrIeunPUCz+dDbIaKHRVQfa73A=;
        b=cHR/hn+wCd8vfEHOTRGzpeI+1vzGkSoBclkWIk+AcpmIqAA5fCd3HNNp1lQfc9YNzQ
         uZA+FdH1xqb7Yjbs9LrKoZ0ouqAu0H07x3JdDCMyyXK3+O5kGR67bXf4oBF70+4PNtEQ
         j4gSWwJTb9PfgC4CFeQgz+oWBD93r679iyPKNtWzJd9BQThhI9RCF6oJ9PCu/E5pznA6
         7mOQgen9BkkxUBKrkQiMDUHbKkz6XEAtLczsjlSduBAXHnoipdjKnl+jiSgJHcdkqRss
         0jKw6sVhfTHg955lwkcJXyUanQ+x73c1QMvFcESLo26qKoZYE7yQPazy038+NZThC92M
         baPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xRyjyFwD7RhIKeY2QrIeunPUCz+dDbIaKHRVQfa73A=;
        b=WsDXXtMaHLA4p5fwjKy4ng0UPUp2jSPkossYWX0alB49OnLjSMPKOC+LG+J5F3zSy5
         VVJ1NySyYF02JWqzNPc0qEXtQlbP3W0jat8yJZLdF0w3fcF1U3EQBzwlDrscEN2/KEpH
         UYkXO52BLosInNiA/d13T2jXG57ghYV6etSMpeLdvbZe5JHCeiZ6RKLLEqigEDXZTQTR
         lWBiWH0tvli97yqciIFeQPPDMhcIryxmm997JimFa+h5x82CR9ZTMGDw2LjPSyI2kVU2
         0DAu9WAqpPjzcma3oYp1Yj4QuSVz9D3KUZVUkPmNs0TVnWk2Z92j4nzUJV+2VDt02qIq
         W+qw==
X-Gm-Message-State: AOAM5338hFsCNfNVBXxSyAvc05avbP55N+RjPS4ro1BQ5iQK9hvLITuj
        jZlER1kzRJmnwtPWRWAQW3GPLw==
X-Google-Smtp-Source: ABdhPJwgv8tLSOFqKIBDUatDleAqXXYHaku1HjW8l+4xLCsRvb4/dpoKewx8ouGTneXMh4e7J1l3Wg==
X-Received: by 2002:a63:6442:: with SMTP id y63mr6997563pgb.18.1594962910204;
        Thu, 16 Jul 2020 22:15:10 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y80sm6109352pfb.165.2020.07.16.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 22:15:09 -0700 (PDT)
Date:   Thu, 16 Jul 2020 22:13:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, sibis@codearora.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v8 4/5] remoteproc: Add inline coredump functionality
Message-ID: <20200717051307.GG2922385@builder.lan>
References: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
 <1594938035-7327-5-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594938035-7327-5-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Jul 15:20 PDT 2020, Rishabh Bhatnagar wrote:

> The current coredump implementation uses vmalloc area to copy
> all the segments. But this might put strain on low memory targets
> as the firmware size sometimes is in tens of MBs. The situation
> becomes worse if there are multiple remote processors undergoing
> recovery at the same time. This patch adds inline coredump
> functionality that avoids extra memory usage. This requires
> recovery to be halted until data is read by userspace and free
> function is called.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/remoteproc_coredump.c | 156 +++++++++++++++++++++++++++----
>  include/linux/remoteproc.h               |  16 ++++
>  2 files changed, 154 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index 390f563..bb15a29 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/devcoredump.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -12,6 +13,12 @@
>  #include "remoteproc_internal.h"
>  #include "remoteproc_elf_helpers.h"
>  
> +struct rproc_coredump_state {
> +	struct rproc *rproc;
> +	void *header;
> +	struct completion dump_done;
> +};
> +
>  /**
>   * rproc_coredump_cleanup() - clean up dump_segments list
>   * @rproc: the remote processor handle
> @@ -115,12 +122,110 @@ int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
>  }
>  EXPORT_SYMBOL(rproc_coredump_set_elf_info);
>  
> +static void rproc_coredump_free(void *data)
> +{
> +	struct rproc_coredump_state *dump_state = data;
> +
> +	vfree(dump_state->header);
> +	complete(&dump_state->dump_done);
> +}
> +
> +static void *rproc_coredump_find_segment(loff_t user_offset,
> +					 struct list_head *segments,
> +					 size_t *data_left)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	list_for_each_entry(segment, segments, node) {
> +		if (user_offset < segment->size) {
> +			*data_left = segment->size - user_offset;
> +			return segment;
> +		}
> +		user_offset -= segment->size;
> +	}
> +
> +	*data_left = 0;
> +	return NULL;
> +}
> +
> +static void rproc_copy_segment(struct rproc *rproc, void *dest,
> +			       struct rproc_dump_segment *segment,
> +			       size_t offset, size_t size)
> +{
> +	void *ptr;
> +
> +	if (segment->dump) {
> +		segment->dump(rproc, segment, dest, offset, size);
> +	} else {
> +		ptr = rproc_da_to_va(rproc, segment->da + offset, size);
> +		if (!ptr) {
> +			dev_err(&rproc->dev,
> +				"invalid copy request for segment %pad with offset %zu and size %zu)\n",
> +				&segment->da, offset, size);
> +			memset(dest, 0xff, size);
> +		} else {
> +			memcpy(dest, ptr, size);
> +		}
> +	}
> +}
> +
> +static ssize_t rproc_coredump_read(char *buffer, loff_t offset, size_t count,
> +				   void *data, size_t header_sz)
> +{
> +	size_t seg_data, bytes_left = count;
> +	ssize_t copy_sz;
> +	struct rproc_dump_segment *seg;
> +	struct rproc_coredump_state *dump_state = data;
> +	struct rproc *rproc = dump_state->rproc;
> +	void *elfcore = dump_state->header;
> +
> +	/* Copy the vmalloc'ed header first. */
> +	if (offset < header_sz) {
> +		copy_sz = memory_read_from_buffer(buffer, count, &offset,
> +						  elfcore, header_sz);
> +
> +		return copy_sz;
> +	}
> +
> +	/*
> +	 * Find out the segment memory chunk to be copied based on offset.
> +	 * Keep copying data until count bytes are read.
> +	 */
> +	while (bytes_left) {
> +		seg = rproc_coredump_find_segment(offset - header_sz,
> +						  &rproc->dump_segments,
> +						  &seg_data);
> +		/* EOF check */
> +		if (!seg) {
> +			dev_info(&rproc->dev, "Ramdump done, %lld bytes read",
> +				 offset);
> +			break;
> +		}
> +
> +		copy_sz = min_t(size_t, bytes_left, seg_data);
> +
> +		rproc_copy_segment(rproc, buffer, seg, seg->size - seg_data,
> +				   copy_sz);
> +
> +		offset += copy_sz;
> +		buffer += copy_sz;
> +		bytes_left -= copy_sz;
> +	}
> +
> +	return count - bytes_left;
> +}
> +
>  /**
>   * rproc_coredump() - perform coredump
>   * @rproc:	rproc handle
>   *
>   * This function will generate an ELF header for the registered segments
> - * and create a devcoredump device associated with rproc.
> + * and create a devcoredump device associated with rproc. Based on the
> + * coredump configuration this function will directly copy the segments
> + * from device memory to userspace or copy segments from device memory to
> + * a separate buffer, which can then be read by userspace.
> + * The first approach avoids using extra vmalloc memory. But it will stall
> + * recovery flow until dump is read by userspace.
>   */
>  void rproc_coredump(struct rproc *rproc)
>  {
> @@ -130,11 +235,13 @@ void rproc_coredump(struct rproc *rproc)
>  	size_t data_size;
>  	size_t offset;
>  	void *data;
> -	void *ptr;
>  	u8 class = rproc->elf_class;
>  	int phnum = 0;
> +	struct rproc_coredump_state dump_state;
> +	enum rproc_dump_mechanism dump_conf = rproc->dump_conf;
>  
> -	if (list_empty(&rproc->dump_segments))
> +	if (list_empty(&rproc->dump_segments) ||
> +	    dump_conf == RPROC_COREDUMP_DISABLED)
>  		return;
>  
>  	if (class == ELFCLASSNONE) {
> @@ -144,7 +251,14 @@ void rproc_coredump(struct rproc *rproc)
>  
>  	data_size = elf_size_of_hdr(class);
>  	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		data_size += elf_size_of_phdr(class) + segment->size;
> +		/*
> +		 * For default configuration buffer includes headers & segments.
> +		 * For inline dump buffer just includes headers as segments are
> +		 * directly read from device memory.
> +		 */
> +		data_size += elf_size_of_phdr(class);
> +		if (dump_conf == RPROC_COREDUMP_DEFAULT)
> +			data_size += segment->size;
>  
>  		phnum++;
>  	}
> @@ -183,23 +297,29 @@ void rproc_coredump(struct rproc *rproc)
>  		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
>  		elf_phdr_set_p_align(class, phdr, 0);
>  
> -		if (segment->dump) {
> -			segment->dump(rproc, segment, data + offset, 0, segment->size);
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
> +		if (dump_conf == RPROC_COREDUMP_DEFAULT)
> +			rproc_copy_segment(rproc, data + offset, segment, 0,
> +					   segment->size);
>  
>  		offset += elf_phdr_get_p_filesz(class, phdr);
>  		phdr += elf_size_of_phdr(class);
>  	}
> +	if (dump_conf == RPROC_COREDUMP_DEFAULT) {
> +		dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +		return;
> +	}
> +
> +	/* Initialize the dump state struct to be used by rproc_coredump_read */
> +	dump_state.rproc = rproc;
> +	dump_state.header = data;
> +	init_completion(&dump_state.dump_done);
> +
> +	dev_coredumpm(&rproc->dev, NULL, &dump_state, data_size, GFP_KERNEL,
> +		      rproc_coredump_read, rproc_coredump_free);
>  
> -	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +	/*
> +	 * Wait until the dump is read and free is called. Data is freed
> +	 * by devcoredump framework automatically after 5 minutes.
> +	 */
> +	wait_for_completion(&dump_state.dump_done);
>  }
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index eb08139..38d037d 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -435,6 +435,20 @@ enum rproc_crash_type {
>  };
>  
>  /**
> + * enum rproc_dump_mechanism - Coredump options for core
> + * @RPROC_COREDUMP_DEFAULT:	Copy dump to separate buffer and carry on with
> +				recovery
> + * @RPROC_COREDUMP_INLINE:	Read segments directly from device memory. Stall
> +				recovery until all segments are read
> + * @RPROC_COREDUMP_DISABLED:	Don't perform any dump
> + */
> +enum rproc_dump_mechanism {
> +	RPROC_COREDUMP_DEFAULT,
> +	RPROC_COREDUMP_INLINE,
> +	RPROC_COREDUMP_DISABLED,
> +};
> +
> +/**
>   * struct rproc_dump_segment - segment info from ELF header
>   * @node:	list node related to the rproc segment list
>   * @da:		device address of the segment
> @@ -466,6 +480,7 @@ struct rproc_dump_segment {
>   * @dev: virtual device for refcounting and common remoteproc behavior
>   * @power: refcount of users who need this rproc powered up
>   * @state: state of the device
> + * @dump_conf: Currently selected coredump configuration
>   * @lock: lock which protects concurrent manipulations of the rproc
>   * @dbg_dir: debugfs directory of this rproc device
>   * @traces: list of trace buffers
> @@ -499,6 +514,7 @@ struct rproc {
>  	struct device dev;
>  	atomic_t power;
>  	unsigned int state;
> +	enum rproc_dump_mechanism dump_conf;
>  	struct mutex lock;
>  	struct dentry *dbg_dir;
>  	struct list_head traces;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
