Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868DC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD37217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgBMLiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:38:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51673 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:38:00 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2CoR-0008Dp-Bg; Thu, 13 Feb 2020 12:37:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E2B141013A6; Thu, 13 Feb 2020 12:37:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>, mingo@redhat.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, x86@kernel.org
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup facility
In-Reply-To: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com> <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Thu, 13 Feb 2020 12:37:42 +0100
Message-ID: <874kvu3egp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
> +/**
> + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> + * @dst: numa_meminfo to move block to
> + * @idx: Index of memblk to remove
> + * @src: numa_meminfo to remove memblk from
> + *
> + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> + * @dst->nr_blks, then remove it from @src.

This is not correct. It's suggesting that these operations are only
happening when @dst is non-NULL. Remove is unconditional though.

Also this is called with &numa_reserved_meminfo as @dst argument, which is:

> +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;

So how would @dst ever be NULL?
 
> + */
> +static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
> +		struct numa_meminfo *src)
> +{
> +	if (dst) {
> +		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +				sizeof(struct numa_memblk));
> +		dst->nr_blks++;
> +	}
> +	numa_remove_memblk_from(idx, src);
> +}

...

> -		/* make sure all blocks are inside the limits */
> +		/* move / save reserved memory ranges */
> +		if (!memblock_overlaps_region(&memblock.memory,
> +					bi->start, bi->end - bi->start)) {
> +			numa_move_memblk(&numa_reserved_meminfo, i--, mi);

Thanks,

        tglx
