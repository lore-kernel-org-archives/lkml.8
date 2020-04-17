Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0FDC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB3920776
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqkD47l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgDQRLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgDQRLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:11:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07EC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:11:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p8so1405929pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MwZ5r02j5DDu60b1Yf9fovCXLqb5sheQ6pTSo/D8kaw=;
        b=qqkD47l8byHNt7HvcF2YWHI8Ln1OLaurWVoh8ZPaayTt3kJndV4E6vQECtjPzxFfSW
         X7VJJs7Vk775xW4hvTcgl22hvwy/7iauD3LJcPpkWR5VXnAoPkk8eqqEXKXBOXGzSD4L
         FEcy3aKLz8b5lt3JdCyLOLIQOuVDjGfyxfQNLRB4uco6lzfWJjRpSXle+6COvQd9GGPK
         GnqcdTMAMYCycNXQdX3ugEUBcvwd2s5p9wyKqgoo4caxt2KLoYpIqkxap6uZZfR19ijO
         AdF0H/bRlEkoh4fGxGwC8pSAMeKN1Mc8c42RcIvV9bkluBMJYUwC4Mtao9DYbS8dzpyC
         h6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwZ5r02j5DDu60b1Yf9fovCXLqb5sheQ6pTSo/D8kaw=;
        b=Blp6SoMhswGBVWy16nC4PdVKzfxdfwL3D43Hj2hTu2Cy7/v7ON7tq3P/OxfgCH/I1g
         RkyJYKTtMLmVNCbqx9azWu4Tz9S+FpPzphbHyFhIU7U0/yfaU4nYNqHKGq/ONisIkKb5
         1zI2W4fZncKmrzKAL+o58K1NcjELAOiLM+Xe1rHXRpDV/dkiSnEwibwehaEcz6h0mUuG
         H1JYIqIGhfBP/SGZGIKTnBVpOiOgLNsEBuGXHnTSJveipii6j8PlxvZ8d5hfslGAdsBL
         9fWZQladOhjClsv0xt8L9B5aLK8IBqjKR4gCrInUS7J8CuokMm7uoKK1mHW2xg1iUWdX
         PKtg==
X-Gm-Message-State: AGi0PuZePkRUmQCvDF6OHmNRzuCrskUi4deonRk0/iCUH03MCpgShW9Z
        9uAmmQZAdHHQfeksuPEy6QAiZrQpCLU=
X-Google-Smtp-Source: APiQypIulTHG+RBBZXvWiEQM4Jv4FTSexWl0Z/vnVRTL12zNnihOWSGrnncl1pym0ocnUvjzdqetOw==
X-Received: by 2002:a63:fc45:: with SMTP id r5mr2738667pgk.440.1587143479915;
        Fri, 17 Apr 2020 10:11:19 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o99sm6186906pjo.8.2020.04.17.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 10:11:19 -0700 (PDT)
Date:   Fri, 17 Apr 2020 10:11:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "sidgup@codeaurora.org" <sidgup@codeaurora.org>
Subject: Re: [PATCH 2/3] remoteproc: Add inline coredump functionality
Message-ID: <20200417171116.GE987656@yoga>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-2-git-send-email-rishabhb@codeaurora.org>
 <1b85229632dd44f198b3e0ff9414b458@SFHDAG7NODE2.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b85229632dd44f198b3e0ff9414b458@SFHDAG7NODE2.st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17 Apr 00:52 PDT 2020, Loic PALLARDY wrote:

> Hi Rishabh,
> 
> > -----Original Message-----
> > From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> > owner@vger.kernel.org> On Behalf Of Rishabh Bhatnagar
> > Sent: jeudi 16 avril 2020 20:39
> > To: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: bjorn.andersson@linaro.org; ohad@wizery.com;
> > mathieu.poirier@linaro.org; tsoni@codeaurora.org;
> > psodagud@codeaurora.org; sidgup@codeaurora.org; Rishabh Bhatnagar
> > <rishabhb@codeaurora.org>
> > Subject: [PATCH 2/3] remoteproc: Add inline coredump functionality
> > 
> > This patch adds the inline coredump functionality. The current
> > coredump implementation uses vmalloc area to copy all the segments.
> > But this might put a lot of strain on low memory targets as the
> > firmware size sometimes is in ten's of MBs. The situation becomes
> > worse if there are multiple remote processors  undergoing recovery
> > at the same time. This patch directly copies the device memory to
> > userspace buffer and avoids extra memory usage. This requires
> > recovery to be halted until data is read by userspace and free
> > function is called.
> > 
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >  drivers/remoteproc/remoteproc_coredump.c | 130
> > +++++++++++++++++++++++++++++++
> >  drivers/remoteproc/remoteproc_internal.h |  23 +++++-
> >  include/linux/remoteproc.h               |   2 +
> >  3 files changed, 153 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_coredump.c
> > b/drivers/remoteproc/remoteproc_coredump.c
> > index 9de0467..888b7dec91 100644
> > --- a/drivers/remoteproc/remoteproc_coredump.c
> > +++ b/drivers/remoteproc/remoteproc_coredump.c
> > @@ -12,6 +12,84 @@
> >  #include <linux/remoteproc.h>
> >  #include "remoteproc_internal.h"
> > 
> > +static void rproc_free_dump(void *data)
> > +{
> > +	struct rproc_coredump_state *dump_state = data;
> > +
> > +	complete(&dump_state->dump_done);
> > +}
> > +
> > +static unsigned long resolve_addr(loff_t user_offset,
> > +				   struct list_head *segments,
> > +				   unsigned long *data_left)
> > +{
> > +	struct rproc_dump_segment *segment;
> > +
> > +	list_for_each_entry(segment, segments, node) {
> > +		if (user_offset >= segment->size)
> > +			user_offset -= segment->size;
> > +		else
> > +			break;
> > +	}
> > +
> > +	if (&segment->node == segments) {
> > +		*data_left = 0;
> > +		return 0;
> > +	}
> > +
> > +	*data_left = segment->size - user_offset;
> > +
> > +	return segment->da + user_offset;
> > +}
> > +
> > +static ssize_t rproc_read_dump(char *buffer, loff_t offset, size_t count,
> > +				void *data, size_t header_size)
> > +{
> > +	void *device_mem;
> > +	size_t data_left, copy_size, bytes_left = count;
> > +	unsigned long addr;
> > +	struct rproc_coredump_state *dump_state = data;
> > +	struct rproc *rproc = dump_state->rproc;
> > +	void *elfcore = dump_state->header;
> > +
> > +	/* Copy the header first */
> > +	if (offset < header_size) {
> > +		copy_size = header_size - offset;
> > +		copy_size = min(copy_size, bytes_left);
> > +
> > +		memcpy(buffer, elfcore + offset, copy_size);
> > +		offset += copy_size;
> > +		bytes_left -= copy_size;
> > +		buffer += copy_size;
> > +	}
> > +
> > +	while (bytes_left) {
> > +		addr = resolve_addr(offset - header_size,
> > +				    &rproc->dump_segments, &data_left);
> > +		/* EOF check */
> > +		if (data_left == 0) {
> > +			pr_info("Ramdump complete %lld bytes read",
> > offset);
> > +			break;
> > +		}
> > +
> > +		copy_size = min_t(size_t, bytes_left, data_left);
> > +
> > +		device_mem = rproc->ops->da_to_va(rproc, addr,
> > copy_size);
> > +		if (!device_mem) {
> > +			pr_err("Address:%lx with size %zd out of remoteproc
> > carveout\n",
> > +				addr, copy_size);
> > +			return -ENOMEM;
> > +		}
> > +		memcpy(buffer, device_mem, copy_size);
> > +
> > +		offset += copy_size;
> > +		buffer += copy_size;
> > +		bytes_left -= copy_size;
> > +	}
> > +
> > +	return count - bytes_left;
> > +}
> > +
> >  static void create_elf_header(void *data, int phnum, struct rproc *rproc)
> >  {
> >  	struct elf32_phdr *phdr;
> > @@ -55,6 +133,58 @@ static void create_elf_header(void *data, int phnum,
> > struct rproc *rproc)
> >  }
> > 
> >  /**
> > + * rproc_inline_coredump() - perform synchronized coredump
> > + * @rproc:	rproc handle
> > + *
> > + * This function will generate an ELF header for the registered segments
> > + * and create a devcoredump device associated with rproc. This function
> > + * directly copies the segments from device memory to userspace. The
> > + * recovery is stalled until the enitire coredump is read. This approach
> Typo entire -> entire
> > + * avoids using extra vmalloc memory(which can be really large).
> > + */
> > +void rproc_inline_coredump(struct rproc *rproc)
> > +{
> > +	struct rproc_dump_segment *segment;
> > +	struct elf32_phdr *phdr;
> > +	struct elf32_hdr *ehdr;
> > +	struct rproc_coredump_state *dump_state;
> > +	size_t header_size;
> > +	void *data;
> > +	int phnum = 0;
> > +
> > +	if (list_empty(&rproc->dump_segments))
> > +		return;
> > +
> > +	header_size = sizeof(*ehdr);
> > +	list_for_each_entry(segment, &rproc->dump_segments, node) {
> > +		header_size += sizeof(*phdr);
> > +
> > +		phnum++;
> > +	}
> > +
> > +	data = vmalloc(header_size);
> > +	if (!data)
> > +		return;
> > +
> > +	ehdr = data;
> > +	create_elf_header(data, phnum, rproc);
> > +
> > +	dump_state = kzalloc(sizeof(*dump_state), GFP_KERNEL);
> > +	dump_state->rproc = rproc;
> > +	dump_state->header = data;
> > +	init_completion(&dump_state->dump_done);
> > +
> > +	dev_coredumpm(&rproc->dev, NULL, dump_state, header_size,
> > GFP_KERNEL,
> > +		      rproc_read_dump, rproc_free_dump);
> > +
> > +	/* Wait until the dump is read and free is called */
> > +	wait_for_completion(&dump_state->dump_done);
> 
> Maybe good to add a timeout with value programmable via debugfs?
> 

devcoredump provides a timeout already, although not configurable today.
I believe this is sufficient, but a mentioning in the comment would be
useful.

Regards,
Bjorn
