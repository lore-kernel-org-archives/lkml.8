Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BE6C4BA20
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14AA2465D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kyRX5Cn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgBZSJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:09:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42207 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgBZSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:09:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so282813otd.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/1VSrHV/eL0yjS7JzLq6CkDS40xQ5EKyFULmMfEARM=;
        b=kyRX5Cn0P/ON9gnA/ScfZ7oJkXAhWPXVLNx+beL35VdYa4shGdzN7u2FcFsUM++b2n
         lhoSm+twMkJopIMCGGM6P0DGpCliQXivQ8UpJyka/vhLBPkgOCPJDP/s+V9fbFyvQJE4
         xo6pmVrTBkETwSWsQy8QMmWmUnhGOxr9bgYfeRj/XsqigRK7XQJDhsIPziELekou41N9
         iN+TTGLkjTU4S70vyvb2VpcHy6jjx9Ds4AIgYEFIvD1CR50wVHkNf6Y2mEJ4MK+nNgCT
         RdvdyuO737GSlyOH6abS0gvyNKu+23jdoYyLCrOrolzytxlbMhwTO1Sy6CanmAKvf9UB
         Zcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/1VSrHV/eL0yjS7JzLq6CkDS40xQ5EKyFULmMfEARM=;
        b=Xow3GD1iSGTezGJX1d8s/JL29QWsMZeMxR1Uytck56SC877/2GNIgoVzarODs67fdw
         VTsPRc6ua2xspCYyKD7BxvJFFII6yMgHvjLfm00BN4GZhLW3BkpnoqugrW79ORhnNsT7
         pcXkNhwwJhuMEOGx4abz5FQ/PJMwJXKm6aZ3jna4lVSpreinpD2kbUm35PZB/NBEwZyp
         F/E1SNVcMaC3ryoXnL9QL4zrWD3KJUDC3K5JFCOzhOulXBA49o65GwBDLccmygmzcOoN
         yhQHhczHOhIinJ5Qbmf/1BUR/8ZoH+FfpPV5gcXS9visztrkVpZxrpu3+18iVLVEe61M
         vl9w==
X-Gm-Message-State: APjAAAVEfNdkYZ4KUPQPuAoOAUXGCDM0hSevSFxkwBshb+wyPwu5cq+T
        Rm9IClKmuhPWhucE8i0Rtyw8geEmCDRBrv1U0CwOWg==
X-Google-Smtp-Source: APXvYqxexJYWBUQ0767VigneOX3hNatJ8i0pFmq0VMgMtXbecSlgtD1dW4b8q+DHv6aKK0BddyFnlOYVd5ZbJwfV+KY=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr3941574otm.247.1582740565960;
 Wed, 26 Feb 2020 10:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20200220043316.19668-1-bhe@redhat.com> <20200220043316.19668-2-bhe@redhat.com>
In-Reply-To: <20200220043316.19668-2-bhe@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Feb 2020 10:09:15 -0800
Message-ID: <CAPcyv4g9Ywpz=37tjmw_1TAkKEpQ7R--yHoExdrSd4sJ0gqY3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 8:34 PM Baoquan He <bhe@redhat.com> wrote:
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
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 596b2a45b100..b8e52c8fed7f 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -779,13 +779,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
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
> +       if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> +               ms->section_mem_map = (unsigned long)NULL;

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
