Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DB6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E2C20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 21:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdjhlwgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBCVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:35:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41693 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgBCVfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 16:35:40 -0500
Received: by mail-io1-f66.google.com with SMTP id m25so18477154ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 13:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPZ/wndNtGq4PmKFUPMXpdYlQfdeqHvXR9++rakqp3A=;
        b=FdjhlwgAGOu66VUqqDLXL/KJ9ELUF1MwQk+agEJRVCH+pVTOmaxVnqrfmnSiAL2jF3
         m4glQpP80GbA416FOt9gGXQSX3nz90a+WxXPQ4vg7axvkIaV/3lL+wTrl96W20VXfKQK
         zLA2jtfrL1EaH0zwXKJ54PaSwVPDJ5rtDNQleh72twHKr6NkH0YIh0gW1j3FCasQtLXp
         wco3tGaqgrbn8hIud5AqfK7lo8TjucAZoXqFPa9BaSsTn/K1RBr9qewCFwEx0hFMg2wC
         GO13DPu3M52m9+In08KaiYGF7j004WQtZ+UcEsGh1R1YyFFrroz2FcFWNnL+tuDM9w9J
         cXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPZ/wndNtGq4PmKFUPMXpdYlQfdeqHvXR9++rakqp3A=;
        b=Xd00Rt2FyONJu4bbU9PkrEWwL+Y/naffZ9XVoUsYSFlNcqb0zTXo7Q3mwdxCSm9oRP
         VCD73YAAIy+HsvKlWRSVQRIKjFQKaJ/OAJbaouUCfMBJ0Uq85q4zfnr15w2g54fQAnNy
         YdZtXw/lFNnRIgT+zPZq4bNeYYRv0QE2DFjqlFaY+eYNP35CgdwVwqp0Q5CgxKUlVcB8
         p3Cad+JqIHZ5gue2BtxLc9JZT5yeXiNzdJf/81FUlymCBC3Xi2XLK1UPvcPPY8olQ8YG
         MHfs43SUr1/OxHub115kx4ZL8pAzU9L880mQfHYwu+G6ORaj7mMMK6MHQttJOWif8T9I
         4VvA==
X-Gm-Message-State: APjAAAU8NwAGVLfaYEes3Qpdhcn/KNmbc5A/B9FIa7kuyqem3hud6DDb
        xi7TBQe2SEElaeTduULRox3OzZ18DPqIlJGqVaQ=
X-Google-Smtp-Source: APXvYqwUlAlSkXDhGzdpb3CT3Dr8tzInYiyjPXabQUHDoDU3OamIjsMZNmeX+EFoBmOr9X9vyuCODQpV4q5MYdBIWRw=
X-Received: by 2002:a02:ccea:: with SMTP id l10mr13626895jaq.114.1580765739722;
 Mon, 03 Feb 2020 13:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20200113144035.10848-1-david@redhat.com> <20200113144035.10848-2-david@redhat.com>
In-Reply-To: <20200113144035.10848-2-david@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 3 Feb 2020 13:35:29 -0800
Message-ID: <CAKgT0UdFphMbS04NMRYU=VUmbnVi_purz4UA0cqA3dd7YW-pJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix and rework pfn handling in memmap_init_zone()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 6:40 AM David Hildenbrand <david@redhat.com> wrote:
>
> Let's update the pfn manually whenever we continue the loop. This makes
> the code easier to read but also less error prone (and we can directly
> fix one issue).
>
> When overlap_memmap_init() returns true, pfn is updated to
> "memblock_region_memory_end_pfn(r)". So it already points at the *next*
> pfn to process. Incrementing the pfn another time is wrong, we might
> leave one uninitialized. I spotted this by inspecting the code, so I have
> no idea if this is relevant in practise (with kernelcore=mirror).
>
> Fixes: a9a9e77fbf27 ("mm: move mirrored memory specific code outside of memmap_init_zone")
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_alloc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a41bd7341de1..a92791512077 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5905,18 +5905,20 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>         }
>  #endif
>
> -       for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> +       for (pfn = start_pfn; pfn < end_pfn; ) {
>                 /*
>                  * There can be holes in boot-time mem_map[]s handed to this
>                  * function.  They do not exist on hotplugged memory.
>                  */
>                 if (context == MEMMAP_EARLY) {
>                         if (!early_pfn_valid(pfn)) {
> -                               pfn = next_pfn(pfn) - 1;
> +                               pfn = next_pfn(pfn);
>                                 continue;
>                         }
> -                       if (!early_pfn_in_nid(pfn, nid))
> +                       if (!early_pfn_in_nid(pfn, nid)) {
> +                               pfn++;
>                                 continue;
> +                       }
>                         if (overlap_memmap_init(zone, &pfn))
>                                 continue;
>                         if (defer_init(nid, pfn, end_pfn))

I'm pretty sure this is a bit broken. The overlap_memmap_init is going
to return memblock_region_memory_end_pfn instead of the start of the
next region. I think that is going to stick you in a mirrored region
without advancing in that case. You would also need to have that case
do a pfn++ before the continue;

> @@ -5944,6 +5946,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                         set_pageblock_migratetype(page, MIGRATE_MOVABLE);
>                         cond_resched();
>                 }
> +               pfn++;
>         }
>  }
>
> --
> 2.24.1
>
>
