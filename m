Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADE7C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AC72072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="np+Pocid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCIKNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:13:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54447 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:13:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so5110746wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 03:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFuf8GFpev5twk0QaqHwaNiwymgxr3SwDszLsCo5vlg=;
        b=np+PocidBFg9XfEvgxmypOD6iIeyig1k2Ezuad1gfOlSq6k0fAVnOeDgA4QRMDlfFN
         PJV//aGW+eT5TdTXcRx0n7AeTMhEYWS5ry/cmZF2uFs4uWVs5u64xHGtB4aPW5VTzNWR
         J7S58R4vrUaRNcvz2b7Mq8S4BOO4LsAhnS3H3EutDkWD1dsQZmCbahH4CcgrfzORyxTW
         dcmIhs5a6VRj91kU87XZZUGuYXn85Emb5P1FpWyCYCakTmKSPffa/flzrp6gqK+BdPp7
         WB3Asc78cEK39lZJnUh7CsJBUuWJINO6GTi9OZOwCPMNL3tEO8eGRCY3p/QyKKd5vWu+
         gYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFuf8GFpev5twk0QaqHwaNiwymgxr3SwDszLsCo5vlg=;
        b=Hfe+t6KThozgRjf+oZRzaYVbHmozrjUGcABMHBB2lgBZkv8mIkibvLXXXuwiDgyU7F
         yIGfCIAbxCujjkljLYNippIUuw2nd3J+DCJKMhDHZX/QeBzt7nwC34OdZI7PP0jalPkE
         DsBKpeKQF84tuDp0R/1jYIogAySO03I6vtPLmAsottxHONBuOeuzwqbrf1c7XflSnQqp
         mq9TD6oAUKqIKBM8eTBJz+msEw8P2zVykhsByR4eCdZzuTIyiktGrqRw/TEn2/hMGzwF
         cJCsKfzNKtTYsFghIx4IJ8QqDj7fZIZJG+4a2BBGfJqODWbJOfVdXXBGgYFnMm+rXqM6
         iFOA==
X-Gm-Message-State: ANhLgQ2RzH/OY7fFcL68Rb/wEhS+0yiRqsgN1UxwqqWHQp2S4bfUVuCf
        cp74tXivC6A57CVXBH1T/TCVPm+QF5Z3laZvgNQVp/Tc
X-Google-Smtp-Source: ADFU+vuU9FoRiMJiu9IVxbD5WQKM4hjnVaFglC4os6CnFbOfekuD9HKMxTdjd7p6SfLfZWl+HPijt9oZj/TezPOAJso=
X-Received: by 2002:a1c:25c5:: with SMTP id l188mr20494560wml.105.1583748799568;
 Mon, 09 Mar 2020 03:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200307084229.28251-1-bhe@redhat.com> <20200307084229.28251-2-bhe@redhat.com>
In-Reply-To: <20200307084229.28251-2-bhe@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 9 Mar 2020 11:13:08 +0100
Message-ID: <CAM9Jb+jXU3cvo3gP0iKQcuBvGE38kgAUhXe=ENtitWYsZZQKvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        David Hildenbrand <david@redhat.com>,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> In section_deactivate(), pfn_to_page() doesn't work any more after
> ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> It caused hot remove failure:
>
> kernel BUG at mm/page_alloc.c:4806!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> RIP: 0010:free_pages+0x85/0xa0
> Call Trace:
>  __remove_pages+0x99/0xc0
>  arch_remove_memory+0x23/0x4d
>  try_remove_memory+0xc8/0x130
>  ? walk_memory_blocks+0x72/0xa0
>  __remove_memory+0xa/0x11
>  acpi_memory_device_remove+0x72/0x100
>  acpi_bus_trim+0x55/0x90
>  acpi_device_hotplug+0x2eb/0x3d0
>  acpi_hotplug_work_fn+0x1a/0x30
>  process_one_work+0x1a7/0x370
>  worker_thread+0x30/0x380
>  ? flush_rcu_work+0x30/0x30
>  kthread+0x112/0x130
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x35/0x40
>
> Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> to fix it.
>
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/sparse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 42c18a38ffaa..1b50c15677d7 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -734,6 +734,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>         struct mem_section *ms = __pfn_to_section(pfn);
>         bool section_is_early = early_section(ms);
>         struct page *memmap = NULL;
> +       bool empty = false;
>         unsigned long *subsection_map = ms->usage
>                 ? &ms->usage->subsection_map[0] : NULL;
>
> @@ -764,7 +765,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>          * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>          */
>         bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -       if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> +       empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> +       if (empty) {
>                 unsigned long section_nr = pfn_to_section_nr(pfn);
>
>                 /*
> @@ -779,13 +781,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>                         ms->usage = NULL;
>                 }
>                 memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -               ms->section_mem_map = (unsigned long)NULL;
>         }
>
>         if (section_is_early && memmap)
>                 free_map_bootmem(memmap);
>         else
>                 depopulate_section_memmap(pfn, nr_pages, altmap);
> +
> +       if (empty)
> +               ms->section_mem_map = (unsigned long)NULL;
>  }
>
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.17.2
>
>
