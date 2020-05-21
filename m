Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1E0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E0204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="myL6BqKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgEUVfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:35:13 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C0FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:35:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so3905561pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kutywKgnoHEl44XSBXIV43WOf+Rpg27NfL0U64rwzo4=;
        b=myL6BqKBPIRKEpXY7jHwJY4QZNfCEJFdTC6DJWlOLmzM0Ahfzr4RgT9VwTkjmdobBM
         gR1fJd6bbxuYZZ7TvaABmixuXMmZBOJWSEqmoKDTfK6aBwnU5GevjQJToLOejT848UnW
         c2bUReDQYKvlKC1kfdQUw6Y1eYFL2F8Bwzxwh/1OpVRHQxIxvtJWZWD7486T+QPVg+Dt
         yE5VWew0vwCLsNMtourmRme7/iufhctjwBxFGXMv+CWKLpxFu9BcGKvBxU0NjZtaGWdg
         QHaTkjQ2c1mStHm2184wtHI1EqmgYl/GcBaKesw/8BE/TpkETtY8v58y1vRAMdo9Mo9p
         m4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kutywKgnoHEl44XSBXIV43WOf+Rpg27NfL0U64rwzo4=;
        b=GF6sKHNT6I1+2dAFXrWDKrXzs+Dpwzi5rlMkt2uejE18FP2y/G/P6cLqrWdpUmc5PE
         MkhzOEIBAJ1QMQh++LXMcrxdM8w670AE3RNUJw9PCIc4+8mK4KaQVStF833rF4EaqdVj
         q4Z8A1wYAk9mRNukZKApq6rP8lZqRRJnfAvkxgky5cT9CMGo5Ic4eSBEgZGpG0hFZ6Hb
         IgGAFhkkxnWxEBbDlVoOQ9h4WYJSErjUuUKt1AlzdDN5wDNaiH4z8TrCACoamewgfs3I
         fw/REwRsWK90D3uxPZkajjtV0oMH9YxsSAbew2Sa12JAU5qZy3Irdwx6O6Hko2iKqK+A
         SsvQ==
X-Gm-Message-State: AOAM530VzfmdghgpvhWgLRda0cE69AnUAbNrWApTMuYqq4f5VSyLBugd
        yPzMp474b5+hCA8UJdUI4XPItdLh1w4=
X-Google-Smtp-Source: ABdhPJxA7+bepnDxnx+JGyGiJo97P7RK7l89HLEtpaF11y8rVBrgM27CSHpS1l4/vfzCsXZjrlyJKg==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr11243519pgh.406.1590096911719;
        Thu, 21 May 2020 14:35:11 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w14sm4799374pgo.75.2020.05.21.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:35:11 -0700 (PDT)
Date:   Thu, 21 May 2020 15:35:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v3 2/3] remoteproc: Add inline coredump functionality
Message-ID: <20200521213509.GB10768@xps15>
References: <1589486856-23440-1-git-send-email-rishabhb@codeaurora.org>
 <1589486856-23440-3-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589486856-23440-3-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rishab,

On Thu, May 14, 2020 at 01:07:35PM -0700, Rishabh Bhatnagar wrote:
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
> ---
>  drivers/remoteproc/remoteproc_coredump.c | 129 +++++++++++++++++++++++++++++--
>  include/linux/remoteproc.h               |  15 ++++
>  2 files changed, 139 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
> index ded0244..de75e89 100644
> --- a/drivers/remoteproc/remoteproc_coredump.c
> +++ b/drivers/remoteproc/remoteproc_coredump.c
> @@ -12,6 +12,12 @@
>  #include "remoteproc_internal.h"
>  #include "remoteproc_elf_helpers.h"
>  
> +struct rproc_coredump_state {
> +	struct rproc *rproc;
> +	void *header;
> +	struct completion dump_done;
> +};
> +

To use struct completion and related function linux/completion.h needs to be
included.

>  /**
>   * rproc_coredump_cleanup() - clean up dump_segments list
>   * @rproc: the remote processor handle
> @@ -114,12 +120,96 @@ int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine)
>  }
>  EXPORT_SYMBOL(rproc_coredump_set_elf_info);
>  
> +static void rproc_coredump_free(void *data)
> +{
> +	struct rproc_coredump_state *dump_state = data;
> +
> +	complete(&dump_state->dump_done);
> +	vfree(dump_state->header);
> +}
> +
> +static unsigned long rproc_coredump_find_segment(loff_t user_offset,
> +						  struct list_head *segments,
> +						  size_t *data_left)
> +{
> +	struct rproc_dump_segment *segment;
> +
> +	list_for_each_entry(segment, segments, node) {
> +		if (user_offset < segment->size) {
> +			*data_left = segment->size - user_offset;
> +			return segment->da + user_offset;
> +		}
> +		user_offset -= segment->size;
> +	}
> +
> +	*data_left = 0;
> +	return 0;
> +}
> +
> +static ssize_t rproc_coredump_read(char *buffer, loff_t offset, size_t count,
> +				    void *data, size_t header_sz)
> +{
> +	void *device_mem;
> +	size_t seg_data;
> +	size_t copy_sz, bytes_left = count;
> +	unsigned long addr;
> +	struct rproc_coredump_state *dump_state = data;
> +	struct rproc *rproc = dump_state->rproc;
> +	void *elfcore = dump_state->header;
> +
> +	/* Copy the vmalloc'ed header first. */
> +	if (offset < header_sz) {
> +		copy_sz = memory_read_from_buffer(buffer, count, &offset,
> +						  elfcore, header_sz);
> +		if (copy_sz < 0)
> +			return -EINVAL;
> +
> +		return copy_sz;
> +	}
> +
> +	/* Find out the segment memory chunk to be copied based on offset.
> +	 * Keep copying data until count bytes are read.
> +	 */

Wrong format for multi-line comment, the following is the standard format:

        /*
         * Find out the segment memory chunk to be copied based on offset.
         * Keep copying data until count bytes are read.
         */

> +	while (bytes_left) {
> +		addr = rproc_coredump_find_segment(offset - header_sz,
> +						   &rproc->dump_segments,
> +						   &seg_data);
> +		/* EOF check */
> +		if (seg_data == 0) {
> +			dev_info(&rproc->dev, "Ramdump done, %lld bytes read",
> +				 offset);
> +			break;
> +		}
> +
> +		copy_sz = min_t(size_t, bytes_left, seg_data);
> +
> +		device_mem = rproc_da_to_va(rproc, addr, copy_sz);
> +		if (!device_mem) {
> +			dev_err(&rproc->dev, "Coredump: %lx with size %zd out of remoteproc carveout\n",
> +				addr, copy_sz);
> +			return -ENOMEM;
> +		}
> +		memcpy(buffer, device_mem, copy_sz);
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
> @@ -132,8 +222,10 @@ void rproc_coredump(struct rproc *rproc)
>  	void *ptr;
>  	u8 class = rproc->elf_class;
>  	int phnum = 0;
> +	struct rproc_coredump_state dump_state;
> +	enum rproc_dump_mechanism dump_conf = rproc->dump_conf;
>  
> -	if (list_empty(&rproc->dump_segments))
> +	if (list_empty(&rproc->dump_segments) || dump_conf == COREDUMP_DISABLED)
>  		return;
>  
>  	if (class == ELFCLASSNONE) {
> @@ -143,7 +235,14 @@ void rproc_coredump(struct rproc *rproc)
>  
>  	data_size = elf_size_of_hdr(class);
>  	list_for_each_entry(segment, &rproc->dump_segments, node) {
> -		data_size += elf_size_of_phdr(class) + segment->size;
> +
> +		/* For default configuration buffer includes headers & segments.
> +		 * For inline dump buffer just includes headers as segments are
> +		 * directly read from device memory.
> +		 */

Same

> +		data_size += elf_size_of_phdr(class);
> +		if (dump_conf == COREDUMP_DEFAULT)
> +			data_size += segment->size;
>  
>  		phnum++;
>  	}
> @@ -182,6 +281,10 @@ void rproc_coredump(struct rproc *rproc)
>  		elf_phdr_set_p_flags(class, phdr, PF_R | PF_W | PF_X);
>  		elf_phdr_set_p_align(class, phdr, 0);
>  
> +		/* No need to copy segments for inline dumps */
> +		if (dump_conf == COREDUMP_INLINE)
> +			goto next_seg;
> +
>  		if (segment->dump) {
>  			segment->dump(rproc, segment, data + offset);
>  		} else {
> @@ -195,10 +298,26 @@ void rproc_coredump(struct rproc *rproc)
>  				memcpy(data + offset, ptr, segment->size);
>  			}
>  		}
> -
> +next_seg:
>  		offset += elf_phdr_get_p_filesz(class, phdr);
>  		phdr += elf_size_of_phdr(class);
>  	}
>  
> -	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> +	if (dump_conf == COREDUMP_DEFAULT) {
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
> +
> +	/* Wait until the dump is read and free is called. Data is freed
> +	 * by devcoredump framework automatically after 5 minutes.
> +	 */

Same

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +	wait_for_completion(&dump_state.dump_done);
>  }
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 0468be4..ab2b9b7 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -435,6 +435,19 @@ enum rproc_crash_type {
>  };
>  
>  /**
> + * enum rproc_dump_mechanism - Coredump options for core
> + * @COREDUMP_DEFAULT:	Copy dump to separate buffer and carry on with recovery
> + * @COREDUMP_INLINE:	Read segments directly from device memory. Stall
> +			recovery until all segments are read
> + * @COREDUMP_DISABLED:	Don't perform any dump
> + */
> +enum rproc_dump_mechanism {
> +	COREDUMP_DEFAULT,
> +	COREDUMP_INLINE,
> +	COREDUMP_DISABLED,
> +};
> +
> +/**
>   * struct rproc_dump_segment - segment info from ELF header
>   * @node:	list node related to the rproc segment list
>   * @da:		device address of the segment
> @@ -466,6 +479,7 @@ struct rproc_dump_segment {
>   * @dev: virtual device for refcounting and common remoteproc behavior
>   * @power: refcount of users who need this rproc powered up
>   * @state: state of the device
> + * @dump_conf: Currenlty selected coredump configuration
>   * @lock: lock which protects concurrent manipulations of the rproc
>   * @dbg_dir: debugfs directory of this rproc device
>   * @traces: list of trace buffers
> @@ -499,6 +513,7 @@ struct rproc {
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
