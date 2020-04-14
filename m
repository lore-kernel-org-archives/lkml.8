Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1446DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4B12076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vf4FJxRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgDNPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440209AbgDNPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:07:44 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C0C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:07:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f2so6796ilq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pU7M95ov88jSHp/VQnt5NZEkZGsi4VE+ZPZVHu49Pjg=;
        b=vf4FJxRxr27g2CTlAwgyEerxuSMdNMwaeiQPuvoLNeKHv4jT15rCInSNRy+CxsLPb4
         TzAvAdYlL5uIriY2uV4LgbRCv7Nh0aOi8itP7nlgan2pNeCvKpt/RK+UNF15gmpiiWz/
         bFD0qmhhYIbG8e2eUFk88uhNZX6XgD54BX8ZUR5FY6+i4s7vKKsUc33Z7u0pbCYmMUOo
         +YmovdJuyV8vSXOsaoD0O06YqasLXuPkfmTgkhsqQOVQ5UUlOJpYXazrj9bQu4/GJXdk
         SNKbj1Nc/RzZrZm5s7NtqLX4Wu/aGF7kxyC7DOyX0h5E3V+P2pR/MKdeEjRHNJC01EPH
         r1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pU7M95ov88jSHp/VQnt5NZEkZGsi4VE+ZPZVHu49Pjg=;
        b=A2jD13epFg8he3m4qFxb4OezjV53S2u0lJ2wJelCmbvn+xKUEgFWymyR0xeFxCbUVU
         YUdVZHnwlQmjFGcUKkCMpUQcdiDwQ3UD6MfxTf1BSUVQDJQ0gnTSwKTcm2GFkJZHtSZh
         zrnfes7yhWpUE1nTRwAW8y2vTKW4DucRJmBsr6zvQCcSQZbTtGEnVdgg3StyLaOJhclq
         SowjrwietuGbzThax211XATgqt2NtA3mxzKaNraSW00uQm88i9Nx0ZZ5tDYwlgGjnmTD
         /K1EwmnAK1+iRY5o2qW6mNuwTjL8grtVtaoiRe8cFyFOIQ682T5rYZtP7fJ9JFSAzhGX
         Licw==
X-Gm-Message-State: AGi0PuZsKfkg9PXPZJIzR49wJfjg0fs3f2HePGpGkfmzcRo9m2xqLksv
        yO8wjH8ZoVuPbdC72Rol7Il6vlmY+w8lEkv7yYgljvLYstk=
X-Google-Smtp-Source: APiQypKM/AvQfVAqcwe7T2QcQbkPuo2dpc+JaYRs2FPKCcHLIOX5EbLFsH5sPOhCGeAaq6amQwG8MDoUVMPqj0enEe8=
X-Received: by 2002:a92:4b11:: with SMTP id m17mr737912ilg.42.1586876863830;
 Tue, 14 Apr 2020 08:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200412090728.GA19572@open-light-1.localdomain> <7de81a1c-0568-b8dd-02c5-b109a2e74a04@redhat.com>
In-Reply-To: <7de81a1c-0568-b8dd-02c5-b109a2e74a04@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 14 Apr 2020 08:07:32 -0700
Message-ID: <CAKgT0Uf2n10YM5V0osfRmO9Qveq_i=esfCq5o2Y0dO7c5SP1HQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] mm: Add PG_zero support
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:01 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.04.20 11:07, liliangleo wrote:
> > Zero out the page content usually happens when allocating pages,
> > this is a time consuming operation, it makes pin and mlock
> > operation very slowly, especially for a large batch of memory.
> >
> > This patch introduce a new feature for zero out pages before page
> > allocation, it can help to speed up page allocation.
> >
> > The idea is very simple, zero out free pages when the system is
> > not busy and mark the page with PG_zero, when allocating a page,
> > if the page need to be filled with zero, check the flag in the
> > struct page, if it's marked as PG_zero, zero out can be skipped,
> > it can save cpu time and speed up page allocation.
> >
> > This serial is based on the feature 'free page reporting' which
> > introduced by Alexander Duyck
> >
> > We can benefit from this feature in the flowing case:
> >     1. User space mlock a large chunk of memory
> >     2. VFIO pin pages for DMA
> >     3. Allocating transparent huge page
> >     4. Speed up page fault process
> >
> > My original intention for adding this feature is to shorten
> > VM creation time when VFIO device is attached, it works good
> > and the VM creation time is reduced obviously.
> >
> > Creating a VM [64G RAM, 32 CPUs] with GPU passthrough
> > =====================================================
> > QEMU use 4K pages, THP is off
> >                   round1      round2      round3
> > w/o this patch:    23.5s       24.7s       24.6s
> > w/ this patch:     10.2s       10.3s       11.2s
> >
> > QEMU use 4K pages, THP is on
> >                   round1      round2      round3
> > w/o this patch:    17.9s       14.8s       14.9s
> > w/ this patch:     1.9s        1.8s        1.9s
> > =====================================================
> >
> > Look forward to your feedbacks.
>
> I somehow have the feeling that this should not be glued to free page
> reporting. After all, you are proposing your own status indicator for
> each buddy page (PG_zero) already, which would mean you can build
> something similar to free page reporting fairly easily, and have it
> co-exist.
>
> The free page reporting infrastructure is helpful when wanting to
> asynchronously batch-process higher-order pages. I don't see the
> immediate need for the "batch-processing here".
>
> E.g., why not simply zero out pages as they are freed/placed into free
> lists? Especially, this is one of the simple alternatives to free page
> reporting as we have it today (guest zeroes free pages, hypervisor
> detects free pages using e.g., ksm).

The problem with doing it at free is that it would be just as
expensive as doing it at allocation, only you would likely see it in
more cases as more applications are more likely to free all of their
memory at once on exit, while only a few will pin all of their pages
at the start.

> That could even allow you to avoid the PG_zero flag completely. E.g.,
> once the feature is activated and running, all pages in the buddy free
> lists are zeroed out already. Zeroing happens synchronously from the
> page-freeing thread, not when starting a guest.
>
> Having that said, I agree with Dave here, that there might be better
> alternatives for this somewhat-special-case.

I wonder if it wouldn't make more sense to look at the option of
splitting the initialization work up over multiple CPUs instead of
leaving it all single threaded. The data above was creating a VM with
64GB of RAM and 32 CPUs. How fast could we zero the pages if we were
performing the zeroing over those 32 CPUs? I wonder if we couldn't
look at recruiting other CPUs on the same node to perform the zeroing
like what Dan had originally proposed for ZONE_DEVICE initialization a
couple years ago[1].

Thanks.

- Alex

[1]: https://lore.kernel.org/linux-mm/153077336359.40830.13007326947037437465.stgit@dwillia2-desk3.amr.corp.intel.com/
