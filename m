Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A30207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrH/bmlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgGTRHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgGTRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:07:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:07:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so8952788plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jo1u0t1Z+XulQer0FfuqSR8e9l8Wnppr5TvaFIdOOUM=;
        b=lrH/bmlu4EnjL6X/zexZgtSAR3uwjakgXGyqh6ZIHCxn7oFRvL1vhWIak9iMtIdJbX
         aXjIYMBO+1Jqibluj2+S4WsbxP0/PORYgYHikJOYHyclbokiiW3IFOnyeIlAce5MpZBy
         GAvsbTDH1E84rXgEL2FWxuYZ2M6B9dOWsBPHX1ZyBZJN6ix4hvPMwIQ7VR8osyT06QoI
         d7ZjJVsrBI0kKOPU4LAq5pUrbnaeKl9kVJZjeTlfu6dsOzjXE+1z+eoPwjtFeJVQB0RJ
         gl0CO53dR6UYjzhEw1fTbRlb0m62lN+U7luhrXQzP6+3d303+O8HcomerCLMyLRifNW/
         gHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jo1u0t1Z+XulQer0FfuqSR8e9l8Wnppr5TvaFIdOOUM=;
        b=kP884eUydEr8GeWLSGgiIbc/XT3XUJo/euYn5UPIL6PqgauLVSt30VBeRvE2ZS2OIk
         dZG+X32xRcE0E2Ch7sVXxQikX0TgAQT3IAbru2vie/unET8f4VLn+gUmNrouuEa8WuJ0
         TYa/Us+0QXyRTks1LDtJ3daosCB03u+xq5CssjocbLgNaczHwSgFcluFexBo+5Dgdxff
         6aZNewNlfiGV7ZDxYYyl8KD0SkjCLTQ16iviJsLolo9pDhVXYRu9yyo1sgdoDzWV9yuQ
         cqjHHNu4+S6H3bqN9tcyWvHq/Cra1zrUxtvGwQ8Zo8VUVRcqVHaCCXwldgQOFgzfTc9R
         8IHA==
X-Gm-Message-State: AOAM532YSKVAX3QAhbnvb5u2ULTE9uXJeZ7SKSDl0+FYCMH+Y8x1ZGFM
        QhxSKDo7q7O+2+JtLANm6yIenQ==
X-Google-Smtp-Source: ABdhPJzIaOWzwbSCzZ2SRSY55bN0p40qeeQU68bxxYEl2emFPpRrKJ8N8DnOj2WWz42ap52AKAI91Q==
X-Received: by 2002:a17:902:eb54:: with SMTP id i20mr18422789pli.183.1595264860423;
        Mon, 20 Jul 2020 10:07:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i67sm17921815pfg.13.2020.07.20.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 10:07:39 -0700 (PDT)
Date:   Mon, 20 Jul 2020 11:07:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, sibis@codearora.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH v8 4/5] remoteproc: Add inline coredump functionality
Message-ID: <20200720170737.GC1113627@xps15>
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

On Thu, Jul 16, 2020 at 03:20:34PM -0700, Rishabh Bhatnagar wrote:
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

Thanks for doing the modifications.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

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
