Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D61C47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9801720714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kdwPjvgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgELAMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:12:13 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35317 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbgELAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:12:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589242331; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=QHszDrIMVN99/jD4G56OXR119xDaLNJMuDIjI7mlYDQ=;
 b=kdwPjvgVs82PRyESV7jAVIQULiXHZOw6diFKUzWsAj2jE2zAYZg+KMFa0RiyoGIdNDeJH8VJ
 vEa6sTH3d/EmODgJNoV1cVMFoJskPbrzMuIZbsn9vojF45RXuV1M5oMA2AZndaDZLedvinkY
 jM/qIQWFsjuEcMElfEO58OmgdCo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9e9c9.7efd1e3553e8-smtp-out-n02;
 Tue, 12 May 2020 00:11:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AB28C433F2; Tue, 12 May 2020 00:11:53 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2AC4EC433CB;
        Tue, 12 May 2020 00:11:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 May 2020 17:11:52 -0700
From:   rishabhb@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH 2/3] remoteproc: Add inline coredump functionality
In-Reply-To: <20200507202121.GK2329931@builder.lan>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
 <20200507202121.GK2329931@builder.lan>
Message-ID: <7deb97ab40dd36d5a51111147cf4c14e@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-07 13:21, Bjorn Andersson wrote:
> On Thu 16 Apr 11:38 PDT 2020, Rishabh Bhatnagar wrote:
> 
>> This patch adds the inline coredump functionality. The current
>> coredump implementation uses vmalloc area to copy all the segments.
>> But this might put a lot of strain on low memory targets as the
>> firmware size sometimes is in ten's of MBs. The situation becomes
>> worse if there are multiple remote processors  undergoing recovery
>> at the same time. This patch directly copies the device memory to
>> userspace buffer and avoids extra memory usage. This requires
>> recovery to be halted until data is read by userspace and free
>> function is called.
>> 
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/remoteproc/remoteproc_coredump.c | 130 
>> +++++++++++++++++++++++++++++++
>>  drivers/remoteproc/remoteproc_internal.h |  23 +++++-
>>  include/linux/remoteproc.h               |   2 +
>>  3 files changed, 153 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/remoteproc_coredump.c 
>> b/drivers/remoteproc/remoteproc_coredump.c
>> index 9de0467..888b7dec91 100644
>> --- a/drivers/remoteproc/remoteproc_coredump.c
>> +++ b/drivers/remoteproc/remoteproc_coredump.c
>> @@ -12,6 +12,84 @@
>>  #include <linux/remoteproc.h>
>>  #include "remoteproc_internal.h"
>> 
>> +static void rproc_free_dump(void *data)
> 
> rproc_coredump_free()
> 
>> +{
>> +	struct rproc_coredump_state *dump_state = data;
>> +
>> +	complete(&dump_state->dump_done);
> 
> vfree(dump_state->header);
> 
>> +}
>> +
>> +static unsigned long resolve_addr(loff_t user_offset,
> 
> rproc_coredump_find_segment()
> 
>> +				   struct list_head *segments,
>> +				   unsigned long *data_left)
>> +{
>> +	struct rproc_dump_segment *segment;
>> +
>> +	list_for_each_entry(segment, segments, node) {
>> +		if (user_offset >= segment->size)
>> +			user_offset -= segment->size;
>> +		else
>> +			break;
> 
> 		if (user_offset < segment->size) {
> 			*data_left = segment->size - user_offset;
> 			return segment->da + user_offset;
> 		}
> 
> 		user_offset -= segment->size;
>> +	}
> 
> 	*data_left = 0;
> 	return 0;
> 
>> +
>> +	if (&segment->node == segments) {
>> +		*data_left = 0;
>> +		return 0;
>> +	}
>> +
>> +	*data_left = segment->size - user_offset;
>> +
>> +	return segment->da + user_offset;
>> +}
>> +
>> +static ssize_t rproc_read_dump(char *buffer, loff_t offset, size_t 
>> count,
>> +				void *data, size_t header_size)
>> +{
>> +	void *device_mem;
>> +	size_t data_left, copy_size, bytes_left = count;
>> +	unsigned long addr;
>> +	struct rproc_coredump_state *dump_state = data;
>> +	struct rproc *rproc = dump_state->rproc;
>> +	void *elfcore = dump_state->header;
>> +
>> +	/* Copy the header first */
>> +	if (offset < header_size) {
>> +		copy_size = header_size - offset;
>> +		copy_size = min(copy_size, bytes_left);
>> +
>> +		memcpy(buffer, elfcore + offset, copy_size);
>> +		offset += copy_size;
>> +		bytes_left -= copy_size;
>> +		buffer += copy_size;
>> +	}
> 
> Perhaps you can take inspiration from devcd_readv() here?
> 
>> +
>> +	while (bytes_left) {
>> +		addr = resolve_addr(offset - header_size,
>> +				    &rproc->dump_segments, &data_left);
>> +		/* EOF check */
>> +		if (data_left == 0) {
> 
> Afaict data_left denotes the amount of data left in this particular
> segment, rather than in the entire core.
> 
Yes, but it only returns 0 when the final segment has been copied 
completely.
Otherwise it gives data left to copy for every segment and moves to next 
segment
once the current one is copied.
> I think you should start by making bytes_left the minimum of the core
> size and @count and then have this loop as long as bytes_left, copying
> data to the buffer either from header or an appropriate segment based 
> on
> the current offset.
> 
That would require an extra function that calculates entire core size,
as its not available right now. Do you see any missed corner cases with 
this
approach?
>> +			pr_info("Ramdump complete %lld bytes read", offset);
> 
> dev_dbg(&rproc->dev, ...)
> 
>> +			break;
>> +		}
>> +
>> +		copy_size = min_t(size_t, bytes_left, data_left);
>> +
>> +		device_mem = rproc->ops->da_to_va(rproc, addr, copy_size);
> 
> rproc_da_to_va()
> 
>> +		if (!device_mem) {
>> +			pr_err("Address:%lx with size %zd out of remoteproc carveout\n",
> 
> dev_err(&rproc->dev, "coredump: %#lx size %#zx outside of carveouts\n",
> ..);
> 
>> +				addr, copy_size);
>> +			return -ENOMEM;
>> +		}
>> +		memcpy(buffer, device_mem, copy_size);
>> +
>> +		offset += copy_size;
>> +		buffer += copy_size;
>> +		bytes_left -= copy_size;
>> +	}
>> +
>> +	return count - bytes_left;
>> +}
>> +
>>  static void create_elf_header(void *data, int phnum, struct rproc 
>> *rproc)
>>  {
>>  	struct elf32_phdr *phdr;
>> @@ -55,6 +133,58 @@ static void create_elf_header(void *data, int 
>> phnum, struct rproc *rproc)
>>  }
>> 
>>  /**
>> + * rproc_inline_coredump() - perform synchronized coredump
>> + * @rproc:	rproc handle
>> + *
>> + * This function will generate an ELF header for the registered 
>> segments
>> + * and create a devcoredump device associated with rproc. This 
>> function
>> + * directly copies the segments from device memory to userspace. The
>> + * recovery is stalled until the enitire coredump is read. This 
>> approach
>> + * avoids using extra vmalloc memory(which can be really large).
>> + */
>> +void rproc_inline_coredump(struct rproc *rproc)
>> +{
>> +	struct rproc_dump_segment *segment;
>> +	struct elf32_phdr *phdr;
>> +	struct elf32_hdr *ehdr;
>> +	struct rproc_coredump_state *dump_state;
> 
> This can live on the stack, unless you follow my suggestion below...
> 
>> +	size_t header_size;
>> +	void *data;
>> +	int phnum = 0;
>> +
>> +	if (list_empty(&rproc->dump_segments))
>> +		return;
>> +
>> +	header_size = sizeof(*ehdr);
>> +	list_for_each_entry(segment, &rproc->dump_segments, node) {
>> +		header_size += sizeof(*phdr);
>> +
>> +		phnum++;
>> +	}
>> +
>> +	data = vmalloc(header_size);
>> +	if (!data)
>> +		return;
>> +
>> +	ehdr = data;
> 
> ehdr is unused.
> 
>> +	create_elf_header(data, phnum, rproc);
>> +
>> +	dump_state = kzalloc(sizeof(*dump_state), GFP_KERNEL);
>> +	dump_state->rproc = rproc;
>> +	dump_state->header = data;
>> +	init_completion(&dump_state->dump_done);
>> +
>> +	dev_coredumpm(&rproc->dev, NULL, dump_state, header_size, 
>> GFP_KERNEL,
>> +		      rproc_read_dump, rproc_free_dump);
> 
> I can help feeling that if you vmalloc() either the header or the 
> entire
> thing depending on DEFAULT vs INLINE and populate it with either all
> segments or just the header, then you should be able to use the same
> (custom) read function to serve both cases.
> 
> You should by doing this be able to avoid some duplication, your two
> code paths would not diverge and the main difference would be if you
> wait or not below (the kfree would have to go in the rproc_free_dump).
> 
>> +
>> +	/* Wait until the dump is read and free is called */
>> +	wait_for_completion(&dump_state->dump_done);
>> +
>> +	kfree(dump_state);
>> +}
>> +EXPORT_SYMBOL(rproc_inline_coredump);
>> +
>> +/**
>>   * rproc_default_coredump() - perform coredump
>>   * @rproc:	rproc handle
>>   *
>> diff --git a/drivers/remoteproc/remoteproc_internal.h 
>> b/drivers/remoteproc/remoteproc_internal.h
>> index 28b6af2..ea6146e 100644
>> --- a/drivers/remoteproc/remoteproc_internal.h
>> +++ b/drivers/remoteproc/remoteproc_internal.h
>> @@ -24,6 +24,18 @@ struct rproc_debug_trace {
>>  	struct rproc_mem_entry trace_mem;
>>  };
>> 
>> +struct rproc_coredump_state {
> 
> This is only used within remoteproc_coredump.c, so please move it 
> there.
> 
>> +	struct rproc *rproc;
>> +	void *header;
>> +	struct completion dump_done;
>> +};
>> +
>> +enum rproc_coredump_conf {
> 
> How about rproc_coredump_mechanism?
> 
>> +	COREDUMP_DEFAULT,
>> +	COREDUMP_INLINE,
>> +	COREDUMP_DISABLED,
>> +};
>> +
>>  /* from remoteproc_core.c */
>>  void rproc_release(struct kref *kref);
>>  irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
>> @@ -49,6 +61,7 @@ struct dentry *rproc_create_trace_file(const char 
>> *name, struct rproc *rproc,
>> 
>>  /* from remoteproc_coredump.c */
>>  void rproc_default_coredump(struct rproc *rproc);
>> +void rproc_inline_coredump(struct rproc *rproc);
>> 
>>  void rproc_free_vring(struct rproc_vring *rvring);
>>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>> @@ -125,8 +138,14 @@ struct resource_table 
>> *rproc_find_loaded_rsc_table(struct rproc *rproc,
>>  static inline
>>  void rproc_coredump(struct rproc *rproc)
>>  {
>> -	return rproc_default_coredump(rproc);
>> -
>> +	switch (rproc->coredump_conf) {
>> +	case COREDUMP_DEFAULT:
>> +		return rproc_default_coredump(rproc);
>> +	case COREDUMP_INLINE:
>> +		return rproc_inline_coredump(rproc);
>> +	default:
>> +		break;
>> +	}
> 
> I think this better belong inside remoteproc_coredump.c
> 
> Regards,
> Bjorn
> 
>>  }
>> 
>>  #endif /* REMOTEPROC_INTERNAL_H */
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 16ad666..23298ce 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -459,6 +459,7 @@ struct rproc_dump_segment {
>>   * @dev: virtual device for refcounting and common remoteproc 
>> behavior
>>   * @power: refcount of users who need this rproc powered up
>>   * @state: state of the device
>> + * @coredump_conf: Currenlty selected coredump configuration
>>   * @lock: lock which protects concurrent manipulations of the rproc
>>   * @dbg_dir: debugfs directory of this rproc device
>>   * @traces: list of trace buffers
>> @@ -492,6 +493,7 @@ struct rproc {
>>  	struct device dev;
>>  	atomic_t power;
>>  	unsigned int state;
>> +	unsigned int coredump_conf;
>>  	struct mutex lock;
>>  	struct dentry *dbg_dir;
>>  	struct list_head traces;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
