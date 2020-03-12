Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85259C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE9B206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVRH8Apv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgCLNay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:30:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35289 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:30:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so6325929wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFj8ouBRBQRWFj3KwgY//JcyUR/0eXxupmXWGHAN4Vw=;
        b=DVRH8Apv2LINZDFgD8KwFPHDjaTQswejXip32XqeIb2rCC+defR+2oSnBWDwR453Yu
         DEvugxEZDrIRUJNtRn0zeIx+cSHY2U0RCKQdhEi6UkDRHNB0r2qNmhbnXcpzmiZk3HHa
         82cm6C+jrAlUw3zL0nur/Vk0u/RcYTKd4gdzi5aoWei0HOziatZC+G7E73xYwvRSRC/G
         dsmL9AycDzhogRPw5Zt7yRBZIuz+qtUzZU4PQmMJxOpE5ndZKY4ckZsL7XHMfRwcX0by
         oXrvsGOwbRS+CW45RK7Cxv0mnvR9zOI8OO0PFSRNxJvkf3O05wGTIKDxXzaUWIveMem4
         TQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFj8ouBRBQRWFj3KwgY//JcyUR/0eXxupmXWGHAN4Vw=;
        b=pkl3YUKONoS04oUrfMC67Gol/lZvN+s155eIKANSvIOXj5B0vzJD6UK7M8QyaJ5Uc7
         vmsyuR8ekyUdLKVKf/U/MimVt2c+N4Qq9oOwdMI0gi6yHi+Ad05HGv1bJ6q6TcU7wyQR
         O2Ner3Tg7oJA+Q1vqJOg5VJWuMD6n76xaN1eq6F0R2IjBL6n7tLzU8lcJyTXqUW1FVfh
         G+UzbULzKwdXDPmbO5UrVbT8/GcRsETCMn1cCvPwIpwDvRDS8v9+quOaDfy05a/SC9Pz
         Spdd1VWNuv0QkjLchYEdJsGE4HY75Kqh2J2LsAi9Q0OdC/QZfhYgfPVTJmSogsIlMhdc
         rRaw==
X-Gm-Message-State: ANhLgQ2s/Wm3RpoXdGlTNwO/SuOwYem/q75zXQurBXWG5V3tRGSS+v5x
        rIttnopkrzrhuKzDA3kXEx0aUloj9t1LdOD3lcA=
X-Google-Smtp-Source: ADFU+vsv1KiMmMA9QEO7iTQY9DWEiRMAYh9G6htFZh3AFiMGQuMRc9LZSyCS1oJr94mdwlv5KNdiaU7T9dFQbyn9KUk=
X-Received: by 2002:a1c:1fc7:: with SMTP id f190mr4787185wmf.2.1584019852225;
 Thu, 12 Mar 2020 06:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200312124414.439-1-bhe@redhat.com> <20200312124414.439-2-bhe@redhat.com>
In-Reply-To: <20200312124414.439-2-bhe@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 12 Mar 2020 14:30:41 +0100
Message-ID: <CAM9Jb+h5N=zd8iCsiRN+8EnnAYkFeT93FaOGpmzeM=B17UciKg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm/sparse.c: introduce new function fill_subsection_map()
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
> Factor out the code that fills the subsection map from section_activate()
> into fill_subsection_map(), this makes section_activate() cleaner and
> easier to follow.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/sparse.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index cf28505e82c5..5919bc5b1547 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -792,24 +792,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>                 ms->section_mem_map = (unsigned long)NULL;
>  }
>
> -static struct page * __meminit section_activate(int nid, unsigned long pfn,
> -               unsigned long nr_pages, struct vmem_altmap *altmap)
> +static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
>  {
> -       DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>         struct mem_section *ms = __pfn_to_section(pfn);
> -       struct mem_section_usage *usage = NULL;
> +       DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
>         unsigned long *subsection_map;
> -       struct page *memmap;
>         int rc = 0;
>
>         subsection_mask_set(map, pfn, nr_pages);
>
> -       if (!ms->usage) {
> -               usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> -               if (!usage)
> -                       return ERR_PTR(-ENOMEM);
> -               ms->usage = usage;
> -       }
>         subsection_map = &ms->usage->subsection_map[0];
>
>         if (bitmap_empty(map, SUBSECTIONS_PER_SECTION))
> @@ -820,6 +811,25 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>                 bitmap_or(subsection_map, map, subsection_map,
>                                 SUBSECTIONS_PER_SECTION);
>
> +       return rc;
> +}
> +
> +static struct page * __meminit section_activate(int nid, unsigned long pfn,
> +               unsigned long nr_pages, struct vmem_altmap *altmap)
> +{
> +       struct mem_section *ms = __pfn_to_section(pfn);
> +       struct mem_section_usage *usage = NULL;
> +       struct page *memmap;
> +       int rc = 0;
> +
> +       if (!ms->usage) {
> +               usage = kzalloc(mem_section_usage_size(), GFP_KERNEL);
> +               if (!usage)
> +                       return ERR_PTR(-ENOMEM);
> +               ms->usage = usage;
> +       }
> +
> +       rc = fill_subsection_map(pfn, nr_pages);
>         if (rc) {
>                 if (usage)
>                         ms->usage = NULL;
> --

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.2
>
>
