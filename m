Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D128C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A0AF20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bn/AxBTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgDBRYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:24:41 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34001 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBRYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:24:40 -0400
Received: by mail-pj1-f65.google.com with SMTP id q16so41873pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fnsy5yUWiTn8/hbaEYoE5LAlbLYRS9NpYz2srxBPSc=;
        b=Bn/AxBTw6+f7Ugyvn8/X27GiALp9ZzUBbvVFmCAX311aZJ/sSE1z9xHsZCPFarXNTC
         A5E6BHWvIB4LFP3HwPNX2PGjjNdjNJT5YCf3+UipnGRuwKGi3rLqPi24V2SbvGNiLWfE
         QEL3/krXOptE/5vPkdQayFfzeL0WhOFNUDDkb2GK2nDZFt36ELXhPp6J2lGyRjE05cHL
         A0QB+KFY5p2WxzjZ360ZDW82j3j2bt+FjQMIAS97dxGggd64DLiUWily6BeBCORyQdxi
         zu0k4ncWtLIZm2MVegIBN1+mCoHGSC6aCef4Qx6M1YbCNnxM6fgKaK2EFaD8+7QFZKlf
         zqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fnsy5yUWiTn8/hbaEYoE5LAlbLYRS9NpYz2srxBPSc=;
        b=h6QSNbiOwsKHlRsm2QDi5Jt+uzQObS4N5/Xvzw2szeJ46cy2J70gUUXdctDdE01wx9
         dXmdNoJArJmUoI+XJf6B8l0vLurvOmfpvXui4UZqnuPXLKNib7+ODC70CAoEF1o6VO9S
         cfmFKuuzWx6pkqgz8bnWbeR0zbHrxAMqMddwoPDlsf/VrS/VLQDHBFTUzRdg2csg2CzA
         R0Jd7DkG3ZAUBoYbZYrj3TEWxYpjFTpGW25eEHowrU5nFwCZAuouRRo47WhF48EeXkgv
         qSZv07igGLcZX9938vwdPeBq7M/c/D42MDRma5DEozWimdTYw0X2tyv1oKZq82peUygI
         fvrQ==
X-Gm-Message-State: AGi0Pua+L8Vq1eKm1aiRfGrO9CImosrDjyzV5f0X9uYXHgfaFV+zdXky
        BCu6fyGgndvH9Vw2EVsRkS64XQ==
X-Google-Smtp-Source: APiQypIDi0rLx2QohirhE4hbnmWiP62qjpU0khykmKrejrCa7upS0aaccQBryOdVLmKfCcYYqY7faQ==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr5045176pjr.20.1585848278603;
        Thu, 02 Apr 2020 10:24:38 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm4268021pjp.1.2020.04.02.10.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:24:37 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:24:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        ohad@wizery.com, psodagud@codeaurora.org, tsoni@codeaurora.org,
        sidgup@codeaurora.org
Subject: Re: [PATCH] remoteproc: core: Add a memory efficient coredump
 function
Message-ID: <20200402172435.GA2785@xps15>
References: <1585353412-19644-1-git-send-email-rishabhb@codeaurora.org>
 <20200401195114.GD267644@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401195114.GD267644@minitux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 12:51:14PM -0700, Bjorn Andersson wrote:
> On Fri 27 Mar 16:56 PDT 2020, Rishabh Bhatnagar wrote:
> 
> > The current coredump implementation uses vmalloc area to copy
> > all the segments. But this might put a lot of strain on low memory
> > targets as the firmware size sometimes is in ten's of MBs.
> > The situation becomes worse if there are multiple remote processors
> > undergoing recovery at the same time.
> > This patch directly copies the device memory to userspace buffer
> > and avoids extra memory usage. This requires recovery to be halted
> > until data is read by userspace and free function is called.
> > 
> > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 107 +++++++++++++++++++++++++++++------
> >  include/linux/remoteproc.h           |   4 ++
> >  2 files changed, 94 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 097f33e..2d881e5 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1516,6 +1516,86 @@ int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size)
> >  }
> >  EXPORT_SYMBOL(rproc_coredump_add_segment);
> >  
> > +
> > +void rproc_free_dump(void *data)
> 
> static
> 
> > +{
> > +	struct rproc *rproc = data;
> > +
> > +	dev_info(&rproc->dev, "Userspace done reading rproc dump\n");
> 
> Please drop the info prints throughout.
> 
> > +	complete(&rproc->dump_done);
> > +}
> > +
> > +static unsigned long get_offset(loff_t user_offset, struct list_head *segments,
> > +				unsigned long *data_left)
> 
> Please rename this rproc_coredump_resolve_segment(), or something along
> those lines.
> 
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
> > +				void *data, size_t elfcorelen)
> > +{
> > +	void *device_mem = NULL;
> > +	unsigned long data_left = 0;
> > +	unsigned long bytes_left = count;
> > +	unsigned long addr = 0;
> > +	size_t copy_size = 0;
> > +	struct rproc *rproc = data;
> > +
> > +	if (offset < elfcorelen) {
> > +		copy_size = elfcorelen - offset;
> > +		copy_size = min(copy_size, bytes_left);
> > +
> > +		memcpy(buffer, rproc->elfcore + offset, copy_size);
> > +		offset += copy_size;
> > +		bytes_left -= copy_size;
> > +		buffer += copy_size;
> > +	}
> > +
> > +	while (bytes_left) {
> > +		addr = get_offset(offset - elfcorelen, &rproc->dump_segments,
> > +				&data_left);
> > +	/* EOF check */
> 
> Indentation, and "if no data left" does indicate that this is the end of
> the loop already.
> 
> > +		if (data_left == 0) {
> > +			pr_info("Ramdump complete. %lld bytes read.", offset);
> > +			return 0;
> 
> You might have copied data to the buffer, so returning 0 here doesn't
> seem right. Presumably instead you should break and return offset -
> original offset or something like that.
> 
> > +		}
> > +
> > +		copy_size = min_t(size_t, bytes_left, data_left);
> > +
> > +		device_mem = rproc->ops->da_to_va(rproc, addr, copy_size);
> > +		if (!device_mem) {
> > +			pr_err("Unable to ioremap: addr %lx, size %zd\n",
> > +				 addr, copy_size);
> > +			return -ENOMEM;
> > +		}
> > +		memcpy(buffer, device_mem, copy_size);
> > +
> > +		offset += copy_size;
> > +		buffer += copy_size;
> > +		bytes_left -= copy_size;
> > +		dev_dbg(&rproc->dev, "Copied %d bytes to userspace\n",
> > +			copy_size);
> > +	}
> > +
> > +	return count;
> 
> This should be the number of bytes actually returned, so if count is
> larger than the sum of the segment sizes this will be wrong.
> 
> > +}
> > +
> >  /**
> >   * rproc_coredump_add_custom_segment() - add custom coredump segment
> >   * @rproc:	handle of a remote processor
> > @@ -1566,27 +1646,27 @@ static void rproc_coredump(struct rproc *rproc)
> >  	struct rproc_dump_segment *segment;
> >  	struct elf32_phdr *phdr;
> >  	struct elf32_hdr *ehdr;
> > -	size_t data_size;
> > +	size_t header_size;
> >  	size_t offset;
> >  	void *data;
> > -	void *ptr;
> >  	int phnum = 0;
> >  
> >  	if (list_empty(&rproc->dump_segments))
> >  		return;
> >  
> > -	data_size = sizeof(*ehdr);
> > +	header_size = sizeof(*ehdr);
> >  	list_for_each_entry(segment, &rproc->dump_segments, node) {
> > -		data_size += sizeof(*phdr) + segment->size;
> > +		header_size += sizeof(*phdr);
> >  
> >  		phnum++;
> >  	}
> >  
> > -	data = vmalloc(data_size);
> > +	data = vmalloc(header_size);
> >  	if (!data)
> >  		return;
> >  
> >  	ehdr = data;
> > +	rproc->elfcore = data;
> 
> Rather than using a rproc-global variable I would prefer that you create
> a new rproc_coredump_state struct that carries the header pointer and
> the information needed by the read & free functions.
> 
> >  
> >  	memset(ehdr, 0, sizeof(*ehdr));
> >  	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> > @@ -1618,23 +1698,14 @@ static void rproc_coredump(struct rproc *rproc)
> >  
> >  		if (segment->dump) {
> >  			segment->dump(rproc, segment, data + offset);

I'm not exactly sure why custom segments can be copied to the elf image but not
generic ones... And as far as I can tell accessing "data + offset" will blow up
because only the memory for the program headers has been allocated, not for the
program segments. 


> > -		} else {
> > -			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
> > -			if (!ptr) {
> > -				dev_err(&rproc->dev,
> > -					"invalid coredump segment (%pad, %zu)\n",
> > -					&segment->da, segment->size);
> > -				memset(data + offset, 0xff, segment->size);
> > -			} else {
> > -				memcpy(data + offset, ptr, segment->size);
> > -			}
> > -		}
> >  
> >  		offset += phdr->p_filesz;
> >  		phdr++;
> >  	}
> > +	dev_coredumpm(&rproc->dev, NULL, rproc, header_size, GFP_KERNEL,
> > +			rproc_read_dump, rproc_free_dump);
> >  
> > -	dev_coredumpv(&rproc->dev, data, data_size, GFP_KERNEL);
> > +	wait_for_completion(&rproc->dump_done);
> 
> This will mean that recovery handling will break on installations that
> doesn't have your ramdump collector - as it will just sit here forever
> (5 minutes) waiting for userspace to do its job.

Right, that problem also came to mind.

> 
> I think we need to device a new sysfs attribute, through which you can
> enable the "inline" coredump mechanism. That way recovery would work for
> all systems and in your specific case you could reconfigure it - perhaps
> once the ramdump collector starts.

Another option is to make rproc_coredump() customizable, as with all the other
functions in remoteproc_internal.h.  That way the current rproc_coredump() is
kept intact and we don't need a new sysfs entry.

Thanks,
Mathieu

> 
> Regards,
> Bjorn
> 
> >  }
> >  
> >  /**
> > @@ -1665,6 +1736,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
> >  
> >  	/* generate coredump */
> >  	rproc_coredump(rproc);
> > +	reinit_completion(&rproc->dump_done);
> >  
> >  	/* load firmware */
> >  	ret = request_firmware(&firmware_p, rproc->firmware, dev);
> > @@ -2067,6 +2139,7 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> >  	INIT_LIST_HEAD(&rproc->rvdevs);
> >  	INIT_LIST_HEAD(&rproc->subdevs);
> >  	INIT_LIST_HEAD(&rproc->dump_segments);
> > +	init_completion(&rproc->dump_done);
> >  
> >  	INIT_WORK(&rproc->crash_handler, rproc_crash_handler_work);
> >  
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > index 16ad666..461b235 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -481,6 +481,8 @@ struct rproc_dump_segment {
> >   * @auto_boot: flag to indicate if remote processor should be auto-started
> >   * @dump_segments: list of segments in the firmware
> >   * @nb_vdev: number of vdev currently handled by rproc
> > + * @dump_done: completion variable when dump is complete
> > + * @elfcore: pointer to elf header buffer
> >   */
> >  struct rproc {
> >  	struct list_head node;
> > @@ -514,6 +516,8 @@ struct rproc {
> >  	bool auto_boot;
> >  	struct list_head dump_segments;
> >  	int nb_vdev;
> > +	struct completion dump_done;
> > +	void *elfcore;
> >  };
> >  
> >  /**
> > -- 
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> > a Linux Foundation Collaborative Project
