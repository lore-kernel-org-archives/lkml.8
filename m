Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C708C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087DD2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJa5CITi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgC3Sa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:30:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46200 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC3Sa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:30:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id cf14so21947127edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSbITaAyAzmhAT6gpCYOeXzgKkCsXrLUD6omquEuTqY=;
        b=WJa5CITi4iYXQT1Z7o4OzTgnLf9uIecH9M0QpLD3CUdOq7e664RYV+SuoFfPVnNH3o
         KiKmmmBeZNXR+i4pwta9kGEry09HnXz+ABQ6KJk0t/REVFppsHl27jPJSpg0sWDoRcW6
         CXpQRfWPIGJuf3Y8VzLa8/MrBYSe/VkaONHzl3trkyhkyFxkzpbDEAHVB1PxcnGyf78Z
         GgjDy9diqWeW/QAOyksDi0LUSQ6Ksne7EhwnKhF/6hCmqNWg4v6aDnMOZXz4qCtjC2a1
         4UCj+xFpG1F9Rk+QYsnBJgE672PIOTGV+WQSbnr1fYytOk2aEaPEnFjqi7l1W4HklniK
         I/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSbITaAyAzmhAT6gpCYOeXzgKkCsXrLUD6omquEuTqY=;
        b=Pg0suV6RxFtu+u9JXrtChEGogCBhfG3lzqEjCepUN2i57raK1wsTlt6pinm2tHpSun
         ALqeQ3GfOX7Wl07jWTaUWa5WfUI2XWfg35En+Bp9MqCLaXKE9I/Gy4WEnI4BZd04nQ4d
         Yccq28xaGfe5QRS4fnN+Q9JopMdhZRU9amRzN8lAkQhdcc8EFemqXuGTCSIeBy5yQVp2
         ORgZqHpYspageLRM8sfvKG5MhGpGLlfW5uT1AmkwlPj68pwTWT2jTZYfnULoiFF4Cmer
         AcIKaDoOeXvAJxjJIyfkBBEvrF9Jm1N9yoUY3BaAr10+0us3FaXZLM8k1fgoFnFI+y2C
         eQ/A==
X-Gm-Message-State: ANhLgQ0ZBYuRxQsvu/pxgWNrSUtwS/ZGo9EMHHEsiSl/SES45IgxSs75
        aMqRymcvX6dE6zJz9hzEYw2s6GC0zNvfWlmgmpXoK5s6
X-Google-Smtp-Source: ADFU+vuhTUFdM1bVr6g91y2tJylCPswBKWptZak/mV7zcR39OOhbOtoX54vMXfqsQpfKbQ8kdyxTUj3UC0HiM6Tg5YM=
X-Received: by 2002:a17:906:d7a6:: with SMTP id pk6mr6255024ejb.309.1585593026220;
 Mon, 30 Mar 2020 11:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-4-kirill.shutemov@linux.intel.com> <CAHbLzkoe-07mxAuA18QUi=H21_Ts0JcbP2SUT=02ZTPhaQB6ug@mail.gmail.com>
 <20200328121829.kzmcmcshbwynjmqc@box>
In-Reply-To: <20200328121829.kzmcmcshbwynjmqc@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Mar 2020 11:30:14 -0700
Message-ID: <CAHbLzkr8YQAG0GbdJn9=Ey7B2M11dxnGCc2nfN-G1fmFiv+BOw@mail.gmail.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of extra pins
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 5:18 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Fri, Mar 27, 2020 at 11:10:40AM -0700, Yang Shi wrote:
> > On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> > <kirill@shutemov.name> wrote:
> > >
> > > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > > pagevec. It's petty common for swapin case: we swap in pages just to
> > > fail due to the extra pin.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  mm/khugepaged.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 14d7afc90786..39e0994abeb8 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >                  * The page must only be referenced by the scanned process
> > >                  * and page swap cache.
> > >                  */
> > > +               if (page_count(page) != 1 + PageSwapCache(page)) {
> > > +                       /*
> > > +                        * Drain pagevec and retry just in case we can get rid
> > > +                        * of the extra pin, like in swapin case.
> > > +                        */
> > > +                       lru_add_drain();
> >
> > This is definitely correct.
> >
> > I'm wondering if we need one more lru_add_drain() before PageLRU check
> > in khugepaged_scan_pmd() or not? The page might be in lru cache then
> > get skipped. This would improve the success rate.
>
> Could you elaborate on the scenario, I don't follow.

I mean the below change:

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1195,6 +1195,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
                        goto out_unmap;
                }
                khugepaged_node_load[node]++;
+               if (!PageLRU(page))
+                       /* Flush the page out of lru cache */
+                       lru_add_drain();
                if (!PageLRU(page)) {
                        result = SCAN_PAGE_LRU;
                        goto out_unmap;

If the page is not on LRU we even can't reach collapse_huge_page(), right?

>
>
> --
>  Kirill A. Shutemov
