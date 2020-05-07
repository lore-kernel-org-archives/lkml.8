Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76702C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F9F24976
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9KjjZ5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgEGUUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728609AbgEGUUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:20:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F6C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:20:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f7so3547322pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+U7NE1nmyW1megEDVcih1zXAnGvq/h4Jgwf62ESkjr0=;
        b=Z9KjjZ5caljWdicu2iQDe4UHHU376NJnmw7OtTKbg8hXcrGxms8FCbVeUUzYEIbj1u
         1KLsONXOKHbTPDaPqIbzNizpYEJy7U+k3j6y0r0imDcDYQYmTh3ENLG0gvimReUuGE4M
         m8gl+tU4uao1XXP1V5hEE56wvfGPLXF8alILcfdJgIwP69MkOAWQPDXwlh0eqh2/GDYB
         yUMyKrFl2oo8vxd47sQFlXfvkG73BjC6wTN7VkT1+Fj//Z1Ty5lAE8JjGeLsVutqDqez
         tsusgjDXUWnbV6IM37gXvuZ3PmFTHsXSkYdJm5kQABoPqBWPE022KIDcVlyPznPAwx6c
         Rv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+U7NE1nmyW1megEDVcih1zXAnGvq/h4Jgwf62ESkjr0=;
        b=UTXz09gJef3LImJn1700vx4lZB/teQyw2Seinp6t8A8lXITv3OSM5WHr/U0JoUHizi
         DLadqYnokTK5ZYCIMfme7je9xeHBHfr9YjXwZI934AjCLx+7AwSDAhzR0KZ2EaNOC2Fr
         ogkoEDOU+BhA/+PC+AlC1bmfZYpme/9tH6RY0STlog3k+mYb8n63WtKz7r7f6QNuwskK
         0Eia+747IBcOjEHjFaAucZuIR3O6lPf/uAOLYzSwQkmZDtTBzpmonG6zoi/BfmSLBecb
         W2afpJpx+Mb7OhqgI175u7Nf2wUqqXRHvWJJKHUVkuuUZitZmnqMUbfQCzWdaOCwwy3H
         3HBg==
X-Gm-Message-State: AGi0PuaagYJxtkmb5JmK9cXiGSuhTXOZQY3pC7VhhhVq1cxhHfd//w52
        52DmpxNcyME3ifz5ZzlzMbdN2geEz14=
X-Google-Smtp-Source: APiQypKApmnZMSjq993TU3XPBDJCR4bVujh47DQJzkTKgjux5gZE84YQJRbAkry3wC0xBfxAGF77yw==
X-Received: by 2002:a62:8448:: with SMTP id k69mr8085670pfd.67.1588882835202;
        Thu, 07 May 2020 13:20:35 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a19sm5873645pfd.91.2020.05.07.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:20:33 -0700 (PDT)
Date:   Thu, 7 May 2020 13:21:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 2/3] remoteproc: Add inline coredump functionality
Message-ID: <20200507202121.GK2329931@builder.lan>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Apr 11:38 PDT 2020, Rishabh Bhatnagar wrote:

> This patch adds the inline coredump functionality. The current
> coredump implementation uses vmalloc area to copy all the segments.
> But this might put a lot of strain on low memory targets as the
> firmware size sometimes is in ten's of MBs. The situation becomes
> worse if there are multiple remote processors  undergoing recovery
> at the same time. This patch directly copies the device memory to
> userspace buffer and avoids extra memory usage. This requires
> recovery to be halted until data is read by userspace and free
> function is called.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_coredump.c | 130 +++++++++++++++++++++++++++++++
>  drivers/remoteproc/remoteproc_internal.h |  23 +++++-
>  include/linux/remoteproc.h               |   2 +
>  3 files changed, 153 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index 9de0467..888b7dec91 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -12,6 +12,84 @@
>  #include <linux/remoteproc.h>
>  #include "remoteproc_internal.h"
>  
> +static void rproc_free_dump(void *data)

rproc_coredump_free()

> +{
> +	struct rproc_coredump_state *dump_state = data;
> +
> +	complete(&dump_state->dump_done);

vfree(dump_state->header);

> +}
> +
> +static unsigned long resolve_addr(loff_t user_offset,

rproc_coredump_find_segment()

> +				   struct list_head *segments,
> +				   unsigned long *data_left)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	list_for_each_entry(segment, segments, node) {
> +		if (user_offset >= segment->size)
> +			user_offset -= segment->size;
> +		else
> +			break;

		if (user_offset < segment->size) {
			*data_left = segment->size - user_offset;
			return segment->da + user_offset;
		}

		user_offset -= segment->size;
> +	}

	*data_left = 0;
	return 0;

> +
> +	if (&segment->node == segments) {
> +		*data_left = 0;
> +		return 0;
> +	}
> +
> +	*data_left = segment->size - user_offset;
> +
> +	return segment->da + user_offset;
> +}
> +
> +static ssize_t rproc_read_dump(char *buffer, loff_t offset, size_t count,
> +				void *data, size_t header_size)
> +{
> +	void *device_mem;
> +	size_t data_left, copy_size, bytes_left = count;
> +	unsigned long addr;
> +	struct rproc_coredump_state *dump_state = data;
> +	struct rproc *rproc = dump_state->rproc;
> +	void *elfcore = dump_state->header;
> +
> +	/* Copy the header first */
> +	if (offset < header_size) {
> +		copy_size = header_size - offset;
> +		copy_size = min(copy_size, bytes_left);
> +
> +		memcpy(buffer, elfcore + offset, copy_size);
> +		offset += copy_size;
> +		bytes_left -= copy_size;
> +		buffer += copy_size;
> +	}

Perhaps you can take inspiration from devcd_readv() here?

> +
> +	while (bytes_left) {
> +		addr = resolve_addr(offset - header_size,
> +				    &rproc->dump_segments, &data_left);
> +		/* EOF check */
> +		if (data_left == 0) {

Afaict data_left denotes the amount of data left in this particular
segment, rather than in the entire core.

I think you should start by making bytes_left the minimum of the core
size and @count and then have this loop as long as bytes_left, copying
data to the buffer either from header or an appropriate segment based on
the current offset.

> +			pr_info("Ramdump complete %lld bytes read", offset);

dev_dbg(&rproc->dev, ...)

> +			break;
> +		}
> +
> +		copy_size = min_t(size_t, bytes_left, data_left);
> +
> +		device_mem = rproc->ops->da_to_va(rproc, addr, copy_size);

rproc_da_to_va()

> +		if (!device_mem) {
> +			pr_err("Address:%lx with size %zd out of remoteproc carveout\n",

dev_err(&rproc->dev, "coredump: %#lx size %#zx outside of carveouts\n",
..);

> +				addr, copy_size);
> +			return -ENOMEM;
> +		}
> +		memcpy(buffer, device_mem, copy_size);
> +
> +		offset += copy_size;
> +		buffer += copy_size;
> +		bytes_left -= copy_size;
> +	}
> +
> +	return count - bytes_left;
> +}
> +
>  static void create_elf_header(void *data, int phnum, struct rproc *rproc)
>  {
>  	struct elf32_phdr *phdr;
> @@ -55,6 +133,58 @@ static void create_elf_header(void *data, int phnum, struct rproc *rproc)
>  }
>  
>  /**
> + * rproc_inline_coredump() - perform synchronized coredump
> + * @rproc:	rproc handle
> + *
> + * This function will generate an ELF header for the registered segments
> + * and create a devcoredump device associated with rproc. This function
> + * directly copies the segments from device memory to userspace. The
> + * recovery is stalled until the enitire coredump is read. This approach
> + * avoids using extra vmalloc memory(which can be really large).
> + */
> +void rproc_inline_coredump(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *segment;
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	struct rproc_coredump_state *dump_state;

This can live on the stack, unless you follow my suggestion below...

> +	size_t header_size;
> +	void *data;
> +	int phnum = 0;
> +
> +	if (list_empty(&rproc->dump_segments))
> +		return;
> +
> +	header_size = sizeof(*ehdr);
> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> +		header_size += sizeof(*phdr);
> +
> +		phnum++;
> +	}
> +
> +	data = vmalloc(header_size);
> +	if (!data)
> +		return;
> +
> +	ehdr = data;

ehdr is unused.

> +	create_elf_header(data, phnum, rproc);
> +
> +	dump_state = kzalloc(sizeof(*dump_state), GFP_KERNEL);
> +	dump_state->rproc = rproc;
> +	dump_state->header = data;
> +	init_completion(&dump_state->dump_done);
> +
> +	dev_coredumpm(&rproc->dev, NULL, dump_state, header_size, GFP_KERNEL,
> +		      rproc_read_dump, rproc_free_dump);

I can help feeling that if you vmalloc() either the header or the entire
thing depending on DEFAULT vs INLINE and populate it with either all
segments or just the header, then you should be able to use the same
(custom) read function to serve both cases.

You should by doing this be able to avoid some duplication, your two
code paths would not diverge and the main difference would be if you
wait or not below (the kfree would have to go in the rproc_free_dump).

> +
> +	/* Wait until the dump is read and free is called */
> +	wait_for_completion(&dump_state->dump_done);
> +
> +	kfree(dump_state);
> +}
> +EXPORT_SYMBOL(rproc_inline_coredump);
> +
> +/**
>   * rproc_default_coredump() - perform coredump
>   * @rproc:	rproc handle
>   *
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 28b6af2..ea6146e 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,18 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +struct rproc_coredump_state {

This is only used within remoteproc_coredump.c, so please move it there.

> +	struct rproc *rproc;
> +	void *header;
> +	struct completion dump_done;
> +};
> +
> +enum rproc_coredump_conf {

How about rproc_coredump_mechanism?

> +	COREDUMP_DEFAULT,
> +	COREDUMP_INLINE,
> +	COREDUMP_DISABLED,
> +};
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
> @@ -49,6 +61,7 @@ struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
>  
>  /* from remoteproc_coredump.c */
>  void rproc_default_coredump(struct rproc *rproc);
> +void rproc_inline_coredump(struct rproc *rproc);
>  
>  void rproc_free_vring(struct rproc_vring *rvring);
>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
> @@ -125,8 +138,14 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
>  static inline
>  void rproc_coredump(struct rproc *rproc)
>  {
> -	return rproc_default_coredump(rproc);
> -
> +	switch (rproc->coredump_conf) {
> +	case COREDUMP_DEFAULT:
> +		return rproc_default_coredump(rproc);
> +	case COREDUMP_INLINE:
> +		return rproc_inline_coredump(rproc);
> +	default:
> +		break;
> +	}

I think this better belong inside remoteproc_coredump.c

Regards,
Bjorn

>  }
>  
>  #endif /* REMOTEPROC_INTERNAL_H */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad666..23298ce 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -459,6 +459,7 @@ struct rproc_dump_segment {
>   * @dev: virtual device for refcounting and common remoteproc behavior
>   * @power: refcount of users who need this rproc powered up
>   * @state: state of the device
> + * @coredump_conf: Currenlty selected coredump configuration
>   * @lock: lock which protects concurrent manipulations of the rproc
>   * @dbg_dir: debugfs directory of this rproc device
>   * @traces: list of trace buffers
> @@ -492,6 +493,7 @@ struct rproc {
>  	struct device dev;
>  	atomic_t power;
>  	unsigned int state;
> +	unsigned int coredump_conf;
>  	struct mutex lock;
>  	struct dentry *dbg_dir;
>  	struct list_head traces;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
