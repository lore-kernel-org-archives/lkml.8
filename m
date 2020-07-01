Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B77E20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhrcp2PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGAHk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:40:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727836AbgGAHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593589225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=izZP1MGTnUa71zOMjrTosKXYO8Y0RHaKMcIyCK6vJao=;
        b=Xhrcp2PXk3QzkokwRd3QcmIaftFPwO/YJi9DekMEzv+Mkxhe0GEqAuborXTAbp+71HxP6B
        FDvMURzahDw1jTcQrjvLPdQKQzrswl2OjbVXMs3PGTKzbSjPgEJMZPvkoF4TPK50AblijS
        Sj0PC6+eGQ7Y5RvJRIUPiLTnX/bm3DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-MtDWQ3oVPeK49MAHXPiNSA-1; Wed, 01 Jul 2020 03:40:23 -0400
X-MC-Unique: MtDWQ3oVPeK49MAHXPiNSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F29A2CCC;
        Wed,  1 Jul 2020 07:40:21 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-207.pek2.redhat.com [10.72.12.207])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E639060FC2;
        Wed,  1 Jul 2020 07:40:15 +0000 (UTC)
Date:   Wed, 1 Jul 2020 15:40:12 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 04/11] ppc64/kexec_file: avoid stomping memory used by
 special regions
Message-ID: <20200701074012.GA4496@dhcp-128-65.nay.redhat.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159319831192.16351.17443438699302756548.stgit@hbathini.in.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hari,
On 06/27/20 at 12:35am, Hari Bathini wrote:
> crashkernel region could have an overlap with special memory regions
> like  opal, rtas, tce-table & such. These regions are referred to as
> exclude memory ranges. Setup this ranges during image probe in order
> to avoid them while finding the buffer for different kdump segments.
> Implement kexec_locate_mem_hole_ppc64() that locates a memory hole
> accounting for these ranges. Also, override arch_kexec_add_buffer()
> to locate a memory hole & later call __kexec_add_buffer() function
> with kbuf->mem set to skip the generic locate memory hole lookup.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/crashdump-ppc64.h |   10 +
>  arch/powerpc/include/asm/kexec.h           |    7 -
>  arch/powerpc/kexec/elf_64.c                |    7 +
>  arch/powerpc/kexec/file_load_64.c          |  292 ++++++++++++++++++++++++++++
>  4 files changed, 312 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/crashdump-ppc64.h
> 
[snip]
>  /**
> + * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
> + *                             regions like opal/rtas, tce-table, initrd,
> + *                             kernel, htab which should be avoided while
> + *                             setting up kexec load segments.
> + * @mem_ranges:                Range list to add the memory ranges to.
> + *
> + * Returns 0 on success, negative errno on error.
> + */
> +static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
> +{
> +	int ret;
> +
> +	ret = add_tce_mem_ranges(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_initrd_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_htab_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_kernel_mem_range(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_rtas_mem_range(mem_ranges, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_opal_mem_range(mem_ranges, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = add_reserved_ranges(mem_ranges);
> +	if (ret)
> +		goto out;
> +
> +	/* exclude memory ranges should be sorted for easy lookup */
> +	sort_memory_ranges(*mem_ranges);
> +out:
> +	if (ret)
> +		pr_err("Failed to setup exclude memory ranges\n");
> +	return ret;
> +}

I'm confused about the "overlap with crashkernel memory", does that mean
those normal kernel used memory could be put in crashkernel reserved
memory range?  If so why can't just skip those areas while crashkernel
doing the reservation?

Thanks
Dave

