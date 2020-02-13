Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9CC2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581586623;
	bh=qEZ9Q/LMTBjrl3jdO0d2lMKwyD5FTZ233m0J1jnxZs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YUeT3SUWBgts8mbcN04s606WXfvLe8NKVBCza4FA1DXL55N52DYbTPJ71JKePaN7w
	 aFulY3r0ZNlMxH8bIROztiizMgFKmK+OO8/fl5oj1nPJXnFqrSpHq9bZNabnWe5Z5a
	 yuytEwY9G9xy5WRzAJHbQyuELaFPZiQD95fe42A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgBMJhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:37:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36349 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:37:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so5787434wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ddOOU7ADcvoppp6eAulmSphKMiop/CEQ61m/8NvcqDQ=;
        b=NDdGL9fs7cw3ugwN8ScXvJ7UBvAn3vIVsNOgwgQ6ZGQZCsu78t1TVqWKx8whA4ZN2z
         ++otcIVJj9A6pjMNGGsHNDbXlwIhabm/CoWR+DYf682VTfrJD9lUCT37OcZj0TIJPJ9p
         QrFNqU6AB4PHIIkL8SHU8xKbDb6PdXd/uw04of9FF+q/fTwrkMjEBtAK9xR4Z17vcG50
         RvaDlWe2GcNa4R3qM7yVjiF8Y9TKt0gwXJdRBT3QU9KbGxWEEjR3x/iLFWC42TLI2GFc
         onmmlGymk8ih6mdB0j4CZfgn17rDB4eg573xHcbqs/pq5M5Dkp+pDWBoxJD8rBzRQYZ4
         SCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ddOOU7ADcvoppp6eAulmSphKMiop/CEQ61m/8NvcqDQ=;
        b=ouHNeKSd6pdLGuv0nKTka5967uArFkGWYQcIysMVf66ert1tIAwukNQP/AiTY9D4xd
         oXWu129TtfQ6HupIyg+tcAhQhWHvOMPmX9P9i2H+7eyZuUcCboJpKs7t1uJ2ZwXrkJUD
         FzYpi7SzW9kPEMdWFHW8d9l1+kJs21eOqJWLKpyorRuP6za0tVVfj5dZcnjV3I1kn1bI
         OID/3YX9JlLnXTlDq9Gk9ZOiwqaJFq96O80GPoGm+/E1s8attC6kNfhJ6i8wobqhwLXK
         IBUtLlcO9PbE2n37bruKZoBnthmPII6dZOTeXubglcohOVNuBLff2+uIK/7jkWR5n7a1
         9j1g==
X-Gm-Message-State: APjAAAUbPhQD9BuCYMDsg9xmNbGCYHgBwdLhsCysCbpvzHnQobhrNfY9
        xvJuOofuv0NGnvT5GZd5hT0=
X-Google-Smtp-Source: APXvYqyHpONbd0AeqhQgm0Eh89qHgNmDNdfLCOP3KT6yQpoin8+qpBUxwcEIsqVhVCAOzNndm3EcSA==
X-Received: by 2002:a05:600c:34b:: with SMTP id u11mr4735092wmd.69.1581586619722;
        Thu, 13 Feb 2020 01:36:59 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q14sm2117512wrj.81.2020.02.13.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:36:59 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:36:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        kbuild test robot <lkp@intel.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v4 5/6] x86/numa: Provide a range-to-target_node lookup
 facility
Message-ID: <20200213093656.GB90266@gmail.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157966230092.2508551.3905721944859436879.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dan Williams <dan.j.williams@intel.com> wrote:

> The DEV_DAX_KMEM facility is a generic mechanism to allow device-dax
> instances, fronting performance-differentiated-memory like pmem, to be
> added to the System RAM pool. The numa node for that hot-added memory is
> derived from the device-dax instance's 'target_node' attribute.
> 
> Recall that the 'target_node' is the ACPI-PXM-to-node translation for
> memory when it comes online whereas the 'numa_node' attribute of the
> device represents the closest online cpu node.
> 
> Presently useful target_node information from the ACPI SRAT is discarded
> with the expectation that "Reserved" memory will never be onlined. Now,
> DEV_DAX_KMEM violates that assumption, there is a need to retain the
> translation. Move, rather than discard, numa_memblk data to a secondary
> array that memory_add_physaddr_to_target_node() may consider at a later
> point in time.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c   |   68 +++++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/numa.h |    8 +++++-
>  mm/mempolicy.c       |    5 ++++
>  3 files changed, 70 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 5289d9d6799a..f2c8fca36f28 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -26,6 +26,7 @@ struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
>  EXPORT_SYMBOL(node_data);
>  
>  static struct numa_meminfo numa_meminfo __initdata_numa;
> +static struct numa_meminfo numa_reserved_meminfo __initdata_numa;
>  
>  static int numa_distance_cnt;
>  static u8 *numa_distance;
> @@ -164,6 +165,26 @@ void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi)
>  		(mi->nr_blks - idx) * sizeof(mi->blk[0]));
>  }
>  
> +/**
> + * numa_move_memblk - Move one numa_memblk from one numa_meminfo to another
> + * @dst: numa_meminfo to move block to
> + * @idx: Index of memblk to remove
> + * @src: numa_meminfo to remove memblk from
> + *
> + * If @dst is non-NULL add it at the @dst->nr_blks index and increment
> + * @dst->nr_blks, then remove it from @src.
> + */
> +static void __init numa_move_memblk(struct numa_meminfo *dst, int idx,
> +		struct numa_meminfo *src)

Nit, this is obviously not how we format function definitions if 
checkpatch complains about the col80 limit.


> +{
> +	if (dst) {
> +		memcpy(&dst->blk[dst->nr_blks], &src->blk[idx],
> +				sizeof(struct numa_memblk));

This linebreak is actually unnecessary ...

Thanks,

	Ingo
