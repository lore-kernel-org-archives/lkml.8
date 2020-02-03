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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE8C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B825A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 23:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnOMM6Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBCXRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:17:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42764 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 18:17:42 -0500
Received: by mail-io1-f66.google.com with SMTP id s6so8360148iol.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+tDvtzVGg2KSq7T5luQWCSg6VFxYPHqxgUAO4e7oxrs=;
        b=SnOMM6GjX6albBnFz8qLixcUOyXC8NzNWszG/RXLPpxwBZwdulnjgWIV7sUDv3dm1h
         0vcdUuSS+bYM5GCByB42Vz1YnGDXJukXxHIy4FdfV+8MWXO6lwD1G7pwh7p/5c6Zzf2V
         85pIMMPa7wtQdF0RMzn5M7yJDEfREvbumwZD1NoyyH0CLiRHg7stvIF6r+Dukr+4zPtH
         lB/pVI4cbP9dseg8oAaH9qbm6rFiPK52oYXjPvlIzcSoLgYc7wdcL8/1yNicnC5H+dzb
         BjMRBXfu9UEqfwHxBWYXhKEgWaLMVcdWNLKk940V3LKOIGxRKRszsTZdFloZOMKOUx+4
         yL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+tDvtzVGg2KSq7T5luQWCSg6VFxYPHqxgUAO4e7oxrs=;
        b=jklsJ3NpekGVOLXUVEOogvCTV7koVhIoLUjyRUZd/Qoz5vXoGSP2bNHLyzB1PFBRVY
         EcVXyYpPLRh6MRENdJoB1vrxUZ1a5F0+qp57ojuUGakYqjiqsBF1eML8F878Ihrn5dpg
         Wz6kc61Z2tPraKd6ybZurdDXB8gj8aKKzn+QCrL8Ql57CQdxQt98LpWAr4QPdGY8Oy2e
         rfRV3IqYurhe5PvI4JbhfdoHclW7ssc059fO38jPJllWyWEhX0kL/trfPC7VGFBabGOO
         drREgNxC7KMevIc8KoS4cSF4pnmBKxyg5MkHPKJSdpNOxTsS1qYSusgNb6U0AvK89ikx
         qdsQ==
X-Gm-Message-State: APjAAAXDMyMrTXdei1QGADKXcDHyjKOJnFZ5q6JkBIFKP7Ky0ICRMYE8
        vq17Cfj6Lmt1DcCfdXV6+IZ4fXNBghzRxcavUps=
X-Google-Smtp-Source: APXvYqxpRmooXuIi+SOWAl9WIAxQngPh9uM/6vZFn9xm/X9aWdsztOqz3x5u9XHoj/TYdn4FUaGWCtTP8N6OxnIZuHU=
X-Received: by 2002:a6b:6e06:: with SMTP id d6mr20095773ioh.95.1580771861858;
 Mon, 03 Feb 2020 15:17:41 -0800 (PST)
MIME-Version: 1.0
References: <CAKgT0UdFphMbS04NMRYU=VUmbnVi_purz4UA0cqA3dd7YW-pJA@mail.gmail.com>
 <1583F4CF-6CD8-4AB6-A2F6-60E6AEE5D5B2@redhat.com>
In-Reply-To: <1583F4CF-6CD8-4AB6-A2F6-60E6AEE5D5B2@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 3 Feb 2020 15:17:30 -0800
Message-ID: <CAKgT0UeGZcUfC1m+uFtLgZWKEiRK_CkCvauZYB0VaeVc6uN50Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm/page_alloc: fix and rework pfn handling in memmap_init_zone()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 1:44 PM David Hildenbrand <david@redhat.com> wrote:
>
>
>
> > Am 03.02.2020 um 22:35 schrieb Alexander Duyck <alexander.duyck@gmail.c=
om>:
> >
> > =EF=BB=BFOn Mon, Jan 13, 2020 at 6:40 AM David Hildenbrand <david@redha=
t.com> wrote:
> >>
> >> Let's update the pfn manually whenever we continue the loop. This make=
s
> >> the code easier to read but also less error prone (and we can directly
> >> fix one issue).
> >>
> >> When overlap_memmap_init() returns true, pfn is updated to
> >> "memblock_region_memory_end_pfn(r)". So it already points at the *next=
*
> >> pfn to process. Incrementing the pfn another time is wrong, we might
> >> leave one uninitialized. I spotted this by inspecting the code, so I h=
ave
> >> no idea if this is relevant in practise (with kernelcore=3Dmirror).
> >>
> >> Fixes: a9a9e77fbf27 ("mm: move mirrored memory specific code outside o=
f memmap_init_zone")
> >> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Oscar Salvador <osalvador@suse.de>
> >> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >> mm/page_alloc.c | 9 ++++++---
> >> 1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index a41bd7341de1..a92791512077 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5905,18 +5905,20 @@ void __meminit memmap_init_zone(unsigned long =
size, int nid, unsigned long zone,
> >>        }
> >> #endif
> >>
> >> -       for (pfn =3D start_pfn; pfn < end_pfn; pfn++) {
> >> +       for (pfn =3D start_pfn; pfn < end_pfn; ) {
> >>                /*
> >>                 * There can be holes in boot-time mem_map[]s handed to=
 this
> >>                 * function.  They do not exist on hotplugged memory.
> >>                 */
> >>                if (context =3D=3D MEMMAP_EARLY) {
> >>                        if (!early_pfn_valid(pfn)) {
> >> -                               pfn =3D next_pfn(pfn) - 1;
> >> +                               pfn =3D next_pfn(pfn);
> >>                                continue;
> >>                        }
> >> -                       if (!early_pfn_in_nid(pfn, nid))
> >> +                       if (!early_pfn_in_nid(pfn, nid)) {
> >> +                               pfn++;
> >>                                continue;
> >> +                       }
> >>                        if (overlap_memmap_init(zone, &pfn))
> >>                                continue;
> >>                        if (defer_init(nid, pfn, end_pfn))
> >
> > I'm pretty sure this is a bit broken. The overlap_memmap_init is going
> > to return memblock_region_memory_end_pfn instead of the start of the
> > next region. I think that is going to stick you in a mirrored region
> > without advancing in that case. You would also need to have that case
> > do a pfn++ before the continue;
>
> Thanks for having a look.
>
> Did you read the description regarding this change?

Actually I hadn't read it all that closely, so my bad on that. The
part that had caught my attention though was that
memblock_region_memory_end is using PFN_DOWN to identify the end of
the memory region, Given that we probably shouldn't be messing with
the PFNs that may contain any of this memory it might make more sense
to use memblock_region_reserved_end_pfn which uses PFN_UP so that we
exclude all memory that is in the mirrored region just in case
something doesn't end on a PFN aligned boundary.

If we know that the mirrored region is going to always be page size
aligned then I guess you are good to go. That was the only thing I
wasn't sure about.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
