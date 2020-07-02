Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A46520737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYIi0Nhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgGBLzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:55:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54870 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726475AbgGBLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593690917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JPhHiGcfmRUjF2RngOoA4i4u5ZYB74t5T3BzZF3YsY=;
        b=RYIi0NhcbN4LVHJ9wBLsv3qmaPyUomD5Yd5VdJUtX+ZBI1dYUV8kGYltV2otNxu1l3SUf+
        Ib8B/ihI4elXUCn4J1cMQhRt9e3KkM/njB1bIXXTAH/r1OVB64Hx5zCoVK+c0zQVHgDT+g
        lKWW4j+TeqdMpJM8ZQpWPlYI+Z2OsUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-BA7ob32uNSm1XA_QXqBcFg-1; Thu, 02 Jul 2020 07:55:12 -0400
X-MC-Unique: BA7ob32uNSm1XA_QXqBcFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02CC719200CF;
        Thu,  2 Jul 2020 11:55:03 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E08F10027B5;
        Thu,  2 Jul 2020 11:54:57 +0000 (UTC)
Date:   Thu, 2 Jul 2020 19:54:54 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
Message-ID: <20200702115454.GB21026@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
 <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
 <6e96ae5a-91fd-726e-1eda-314f2317d8b4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e96ae5a-91fd-726e-1eda-314f2317d8b4@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/20 at 11:48pm, Hari Bathini wrote:
> 
> 
> On 01/07/20 1:10 pm, Dave Young wrote:
> > Hi Hari,
> > On 06/27/20 at 12:35am, Hari Bathini wrote:
> >> crashkernel region could have an overlap with special memory regions
> >> like  opal, rtas, tce-table & such. These regions are referred to as
> >> exclude memory ranges. Setup this ranges during image probe in order
> >> to avoid them while finding the buffer for different kdump segments.
> >> Implement kexec_locate_mem_hole_ppc64() that locates a memory hole
> >> accounting for these ranges. Also, override arch_kexec_add_buffer()
> >> to locate a memory hole & later call __kexec_add_buffer() function
> >> with kbuf->mem set to skip the generic locate memory hole lookup.
> >>
> >> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/crashdump-ppc64.h |   10 +
> >>  arch/powerpc/include/asm/kexec.h           |    7 -
> >>  arch/powerpc/kexec/elf_64.c                |    7 +
> >>  arch/powerpc/kexec/file_load_64.c          |  292 ++++++++++++++++++++++++++++
> >>  4 files changed, 312 insertions(+), 4 deletions(-)
> >>  create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
> >>
> > [snip]
> >>  /**
> >> + * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
> >> + *                             regions like opal/rtas, tce-table, initrd,
> >> + *                             kernel, htab which should be avoided while
> >> + *                             setting up kexec load segments.
> >> + * @mem_ranges:                Range list to add the memory ranges to.
> >> + *
> >> + * Returns 0 on success, negative errno on error.
> >> + */
> >> +static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = add_tce_mem_ranges(mem_ranges);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_initrd_mem_range(mem_ranges);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_htab_mem_range(mem_ranges);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_kernel_mem_range(mem_ranges);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_rtas_mem_range(mem_ranges, false);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_opal_mem_range(mem_ranges, false);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = add_reserved_ranges(mem_ranges);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	/* exclude memory ranges should be sorted for easy lookup */
> >> +	sort_memory_ranges(*mem_ranges);
> >> +out:
> >> +	if (ret)
> >> +		pr_err("Failed to setup exclude memory ranges\n");
> >> +	return ret;
> >> +}
> > 
> > I'm confused about the "overlap with crashkernel memory", does that mean
> > those normal kernel used memory could be put in crashkernel reserved
> 
> There are regions that could overlap with crashkernel region but they are
> not normal kernel used memory though. These are regions that kernel and/or
> f/w chose to place at a particular address for real mode accessibility
> and/or memory layout between kernel & f/w kind of thing.
> 
> > memory range?  If so why can't just skip those areas while crashkernel
> > doing the reservation?
> 
> crashkernel region has a dependency to be in the first memory block for it
> to be accessible in real mode. Accommodating this requirement while addressing
> other requirements would mean something like what we have now. A list of
> possible special memory regions in crashkernel region to take care of.
> 
> I have plans to split crashkernel region into low & high to have exclusive
> regions for crashkernel, even if that means to have two of them. But that
> is for another day with its own set of complexities to deal with...

Ok, I was not aware the powerpc crashkernel reservation is not
dynamically reserved.  But seems powerpc need those tricks at least for
the time being like you said.

Thanks
Dave

