Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CECAC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768EB2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsn+oA8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDWUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDWUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:38:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A2C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:38:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so2393738pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Vptrzb1tvzPqkSPvOY4tSDX0X1tdBNczhYsMXbWWm4=;
        b=bsn+oA8tphUP8gI1Iflje+jJPrRxXiTykxXB6uZ1cPQ/QJpVQF+4jrLu7LqTPMMbOa
         kO5nYbtIFp6o9R378TnZ3r4oqLtUn3THUw9O1F2a2KEzIsl0fjrHPmPEkXgmiwUiMHA0
         Cd+ESabNk8lnWtkJiS9ZOrvU4MYrt9lAPmYsej/N0s97moXkXaOYsfDSM2LsByDygNm1
         g6tmzyMzXC8BdgDHiG3JC1MuasNkF/b3KjAsPgs35cioY/mZtV2ujlV3rojiNE0ikYW8
         j2TdE/OwKyC7G2R0udWsGVeNgRoGbX7azpqXrr68W+d+rnbSXpZoZCRoMMP+u9Cm4+Z8
         qHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Vptrzb1tvzPqkSPvOY4tSDX0X1tdBNczhYsMXbWWm4=;
        b=lecjNtORYXcpuId4I3SSlYz1J3LLW4bDhf3cJFGkz0tFYWrmErPZqc5lsGWh8I0lia
         BXTkPuobdaI45dE10el28rK6KhSitRLdu8LAHBtbIuMXszoMaRQN5qPZBukUSR69Rwbk
         byUSs1Bj0jGIuDPGc7GoZosRk3miMyKsURHBNy1YjQflkn6+6pXX2U+KI7IHafhImSdl
         7b0majgx7Z48PDB3aISjfPrmwc177dozgrk3Fw9jMQ8g1n3wsuB6OxRUtIjNUPFRLV69
         dqzP110cOk+fcBnhI52dHaK27LTxveaaN2uiySQPTXu6G7qoLGqjr2d8JHDU2jSgLnIW
         ovhA==
X-Gm-Message-State: AGi0PuaH2QYr3kI1yfAvfRzLg5l6XwpDDzBcwplP47OEa/IxHkGJff6r
        hC9VhFBBWxIZWTUvvRoIkpuCHg==
X-Google-Smtp-Source: APiQypIUO9QTAn2LMUmp5HtqVocBNM/9I0Kzvi/6XhjpFQBJDj2ecCVp9J278pORl/05+zGh2qXhpQ==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr2630466pjc.0.1587674334217;
        Thu, 23 Apr 2020 13:38:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d8sm3494197pfd.159.2020.04.23.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:38:53 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:38:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 2/3] remoteproc: Add inline coredump functionality
Message-ID: <20200423203851.GA4317@xps15>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:38:31AM -0700, Rishabh Bhatnagar wrote:
> This patch adds the inline coredump functionality. The current
> coredump implementation uses vmalloc area to copy all the segments.
> But this might put a lot of strain on low memory targets as the
> firmware size sometimes is in ten's of MBs. The situation becomes

s/ten's/tens

> worse if there are multiple remote processors  undergoing recovery

/processors  undergoing/processor undergoing

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
> +{
> +	struct rproc_coredump_state *dump_state = data;
> +
> +	complete(&dump_state->dump_done);
> +}
> +
> +static unsigned long resolve_addr(loff_t user_offset,
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
> +	}
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
> +
> +	while (bytes_left) {
> +		addr = resolve_addr(offset - header_size,
> +				    &rproc->dump_segments, &data_left);
> +		/* EOF check */
> +		if (data_left == 0) {
> +			pr_info("Ramdump complete %lld bytes read", offset);
> +			break;
> +		}
> +
> +		copy_size = min_t(size_t, bytes_left, data_left);
> +
> +		device_mem = rproc->ops->da_to_va(rproc, addr, copy_size);
> +		if (!device_mem) {
> +			pr_err("Address:%lx with size %zd out of remoteproc carveout\n",
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

s/enitire/entire

> + * avoids using extra vmalloc memory(which can be really large).
> + */
> +void rproc_inline_coredump(struct rproc *rproc)
> +{
> +	struct rproc_dump_segment *segment;
> +	struct elf32_phdr *phdr;
> +	struct elf32_hdr *ehdr;
> +	struct rproc_coredump_state *dump_state;
> +	size_t header_size;
> +	void *data;
> +	int phnum = 0;
> +
> +	if (list_empty(&rproc->dump_segments))
> +		return;

The same check is also done in rproc_default_coredump().  As such it should
probably be moved to rproc_coredump().

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
> +	create_elf_header(data, phnum, rproc);
> +
> +	dump_state = kzalloc(sizeof(*dump_state), GFP_KERNEL);
> +	dump_state->rproc = rproc;
> +	dump_state->header = data;
> +	init_completion(&dump_state->dump_done);
> +
> +	dev_coredumpm(&rproc->dev, NULL, dump_state, header_size, GFP_KERNEL,
> +		      rproc_read_dump, rproc_free_dump);
> +
> +	/* Wait until the dump is read and free is called */
> +	wait_for_completion(&dump_state->dump_done);
> +
> +	kfree(dump_state);
> +}
> +EXPORT_SYMBOL(rproc_inline_coredump);

Because this is part of remoteproc.o and the symbol is not needed in the
individual drivers, I don't think you need the export.  The same applies to
rproc_default_coredump.

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
> +	struct rproc *rproc;
> +	void *header;
> +	struct completion dump_done;
> +};
> +
> +enum rproc_coredump_conf {
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

Please make this an 'enum rproc_coredump_conf'. 

>  	struct mutex lock;
>  	struct dentry *dbg_dir;
>  	struct list_head traces;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
