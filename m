Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62733C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EA12071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbWC0d19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCLN1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:27:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36946 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgCLN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:27:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id a141so6297787wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MDu/td9l51L58IGhpqk8JA+3+xbgl2VVWeVr93Vibw8=;
        b=JbWC0d19KHusoB+PKOWaMpQL9e26jb6G/q2lHZ83MDYEomL6fpShH6+XMfxG+R/Fvd
         qXeRHlxqhm3OMMYjqndri42kEXBjzEYvNZBq/1ciiXT8G8BV8Nx+SEiQXqb9v9k+6wsJ
         CVoclpb6MeEKb2GjaOCc5zFiTp0e+H+B7e1GoyYSpi5CoWwDsC00Rg/pGGPWBHJ2Ud1A
         9Dfi4RIYis2gNYkZ4rpja8TgY9dxbFgs+4339BnsXXDs868HJjhxRKITqr9U0cG3bm7W
         ftXIJr4TGC7Y4WC+4ZWmwL4PhNh9Sf67RdRypOSTYBZ8b/dJeztrkVucpXpj2dr4CMPv
         yyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MDu/td9l51L58IGhpqk8JA+3+xbgl2VVWeVr93Vibw8=;
        b=BkQcJtVBYWugJdesL7S2hJjm1SYkKogqvI55XFUOaGNQ9GP2Tsew+/W8tJqk8M3rPH
         qiVupOJZsmoqNCjOWkFV05Bzhi8PebPBFqfJFRjus9RrOGDUZryArBmbgHkkwyNpW52z
         PUe4FYOvQjIidHIdF1LrywRZjEl8McbT5Qzgmn2WSTnKitfsbDLbpyxF/KHL2Pfc3QWb
         azq4ak6IyJID39IaN721oJroaA6DICI9dOKqT7HUqGKd2xKvCG9HSh2xfarXUwxwleQD
         ZzEDocMlpkEh7H+2nHa4KBZl+/gzVRlG019tRPqGVTKx1/MmCGYFVxRS7SvjPsJmFfAB
         FO/A==
X-Gm-Message-State: ANhLgQ3uouXQz/EgaaV4JCgvD0RqsxowqRmIhn4RzWJW3IfDWI42ZIy1
        o+nyjmfNuJtmxpG2Wq2s42tvhTbN3i+ddVZKFL0KOL3+DNs=
X-Google-Smtp-Source: ADFU+vsmU7hPEB1aHJzbqZPInMm0BSzqnQ2wKDzgBi+VNLsokYfZHWxYA6/FcHbANa3SdWIlyLi5SNmjj889oisdvUY=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr4925462wme.30.1584019620201;
 Thu, 12 Mar 2020 06:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200312124414.439-1-bhe@redhat.com> <20200312124414.439-3-bhe@redhat.com>
In-Reply-To: <20200312124414.439-3-bhe@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 12 Mar 2020 14:26:49 +0100
Message-ID: <CAM9Jb+ifBUiPxKAmvm_c-0MUCfNu_MndGWZe-bhaHNLKeSMtjQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm/sparse.c: introduce a new function clear_subsection_map()
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        David Hildenbrand <david@redhat.com>,
        richard.weiyang@gmail.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Factor out the code which clear subsection map of one memory region from
> section_deactivate() into clear_subsection_map().
>
> And also add helper function is_subsection_map_empty() to check if
> the current subsection map is empty or not.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/sparse.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 5919bc5b1547..0be4d4ed96de 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -726,15 +726,11 @@ static void free_map_bootmem(struct page *memmap)
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>
> -static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> -               struct vmem_altmap *altmap)
> +static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  {
>         DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>         DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
>         struct mem_section *ms = __pfn_to_section(pfn);
> -       bool section_is_early = early_section(ms);
> -       struct page *memmap = NULL;
> -       bool empty;
>         unsigned long *subsection_map = ms->usage
>                 ? &ms->usage->subsection_map[0] : NULL;
>
> @@ -745,8 +741,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>         if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
>                                 "section already deactivated (%#lx + %ld)\n",
>                                 pfn, nr_pages))
> -               return;
> +               return -EINVAL;
>
> +       bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> +       return 0;
> +}
> +
> +static bool is_subsection_map_empty(struct mem_section *ms)
> +{
> +       return bitmap_empty(&ms->usage->subsection_map[0],
> +                           SUBSECTIONS_PER_SECTION);
> +}
> +
> +static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> +               struct vmem_altmap *altmap)
> +{
> +       struct mem_section *ms = __pfn_to_section(pfn);
> +       bool section_is_early = early_section(ms);
> +       struct page *memmap = NULL;
> +       bool empty;
> +
> +       if (clear_subsection_map(pfn, nr_pages))
> +               return;
>         /*
>          * There are 3 cases to handle across two configurations
>          * (SPARSEMEM_VMEMMAP={y,n}):
> @@ -764,8 +780,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>          *
>          * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>          */
> -       bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -       empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> +       empty = is_subsection_map_empty(ms);
>         if (empty) {
>                 unsigned long section_nr = pfn_to_section_nr(pfn);
>
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.2
>
>
