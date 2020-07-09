Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB626C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8850120775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 03:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="raobTJTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgGIDio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 23:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGIDin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 23:38:43 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2B7C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 20:38:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so677599edm.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 20:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtjuErNIKJPKt6mfJPuDEE1udY89MBwcN8YDulEHHpA=;
        b=raobTJTpMajWWh1DB67I4/ixIZuCT8w3vl86Q6iXHe8AqyCsaVIQnEjEhi3xpXUVSY
         0sZ63uK1kh4Jq4GNjXjq1PXyhJBnXNVLrXeQybYWn7zcn8nuVxunI9SJNMAwua0zTL/6
         N1PoXUBA2cUrSZwgk8tTruN0Pzjo+BpZWuk8YT47mWs7NxF6eN2RJOPiPqaA5CBkqCrA
         cWuPO9IW3sP/7mhUWgqHI7r2h3+L5G+GEZ+152hw2pOUVzrPYQCm4q8Mtc4j2RtD39xc
         14zCSHFmqrXrZ7K1jR+L5WFLLufK7fsNNpNlnIegsjGENi2QENndj1DW7a2O57jMVMkS
         Kh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtjuErNIKJPKt6mfJPuDEE1udY89MBwcN8YDulEHHpA=;
        b=haF4e301TRqhPQx8zjVMRCG8Afv+tnsdIwjLn82+QHOh7eHbsNBH8jktYbDu2kURa4
         p1PId4sfIUfH2DBTdE7TAqK+Vi0B4HNRpae6UuiwfsR5rJgZrXL8WQT2Yrmpxt0LjwnF
         WkbHskctGCfPjI5MF8szuWCwt8NHJBq1lRS3qrwI55C1XNqZirPDs7yYo4QEUalWarvn
         Ztu/HWcNqXOgzjJfIkEKNttXgvdYRNNCZcDaUpuzAsfMPmDIkNUOLPkMiqhTkhkfqLZJ
         uvHJAgQWJgNHa2Ip/wrenBM0G9qPNofS17tuBL/1P2X+9f7jE5CxOr30D1zPFGVXLWOl
         zAuA==
X-Gm-Message-State: AOAM5334o7/Rg2eYF8oWwcYAX4mxFfbwJBlkhSYICJ6T7Q8xpv6wTVtf
        qb5UjWW09zUB3UpZYA8EIz+/3cJHCGuo++dtHFp3Ng==
X-Google-Smtp-Source: ABdhPJw5nGGUvNN51Fg2qfZAUYpiFgoQEWbsf39bUBkbdSfrldAhGBNqQDnuvj5zNJ0UqJqM9lo3PWsVoNPxBGZ10fU=
X-Received: by 2002:a05:6402:b79:: with SMTP id cb25mr49015887edb.154.1594265921222;
 Wed, 08 Jul 2020 20:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200709020629.91671-1-justin.he@arm.com> <20200709020629.91671-6-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-6-justin.he@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 20:38:30 -0700
Message-ID: <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is invalid
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kaly Xin <Kaly.Xin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 7:07 PM Jia He <justin.he@arm.com> wrote:
>
> numa_off is set unconditionally at the end of dummy_numa_init(),
> even with a fake numa node. ACPI detects node id as NUMA_NO_NODE(-1) in
> acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
> node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
>
> Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
> isn't present:
> $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
> kmem: probe of dax0.0 failed with error -22
>
> This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/dax/kmem.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f87399..218f66057994 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -31,22 +31,23 @@ int dev_dax_kmem_probe(struct device *dev)
>         int numa_node;
>         int rc;
>
> +       /* Hotplug starting at the beginning of the next block: */
> +       kmem_start = ALIGN(res->start, memory_block_size_bytes());
> +
>         /*
>          * Ensure good NUMA information for the persistent memory.
>          * Without this check, there is a risk that slow memory
>          * could be mixed in a node with faster memory, causing
> -        * unavoidable performance issues.
> +        * unavoidable performance issues. Furthermore, fallback node
> +        * id can be used when numa_node is invalid.
>          */
>         numa_node = dev_dax->target_node;
>         if (numa_node < 0) {
> -               dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
> -                        res, numa_node);
> -               return -EINVAL;
> +               numa_node = memory_add_physaddr_to_nid(kmem_start);

I think this fixup belongs to the core to set a fallback value for
dev_dax->target_node.

I'm close to having patches to provide a functional
phys_addr_to_target_node() for arm64.
