Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F7C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546F520723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 12:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="t57oPtPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgC1MS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:18:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40546 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1MS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 08:18:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so12922834ljj.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLgjRkbqkZXUrHTSAMZJhzjxeF+WpWX9n+s+f97+oHU=;
        b=t57oPtPyEDn94rGhZYNo/2+yHohX/cUM4XQOYORvnWvJyUH6F/Rdr1Oxv+VfAjkku+
         +8hZ4qXHGdice8U2dY/9xU9EHDjISIUbbXFgfDtDT/NQrdAP+VIeoCJWBRtlpbSlzeKV
         FSz6/yzF8aQ7Z9DJcbpeX4rdT0ckxUEKyJBK2YA5FdwmC7AlVWO2ZjlLaLJCJbZiLt47
         CyJZIKdoSnrU8dzPykoyfaWarI105Q5LBGve13meRT2YyCOPxnCHBaQ3yZbGwFNSneVX
         IZ5uF3kADFDLwBckXZ4ZPS6EjE+Aj4BX5qIEFhbZb6Ld1I7rlgy6LVlw/TARQ4ckYTm2
         3DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLgjRkbqkZXUrHTSAMZJhzjxeF+WpWX9n+s+f97+oHU=;
        b=f8AbSBrNif29xFkX+B7z/OE7ZD41XcqQEe31eKtlpzpqRZJqr+M7cDJgAgQau/xyhW
         jv8o5Wuhw+kAQ1qUG6NaxXaFyK4ysFKWgteW/z20BvxY7qda+mgtEqhXyPuQTP0tEcQC
         f2BG0pL95Jbo4t7qcnd1P2TpN/ZsSpzqJQA/z7UdA/qFrSxDzscSFf5WdVCaYGMG/VaZ
         xQPI471XzYJye4vY3ziwZiRF7B9xXF7RNyOT5RmtcOGfEH/KjFrKOg/wS/YpzaUfLU18
         NkuNxf8Qsqya4IW54YsJr43zxNJn6vSFXo81fcse77A3mSGPQTlM5vzjpnw26sLrXOk/
         ozGA==
X-Gm-Message-State: AGi0PubnK7rOA2fS8GIydvNqAoUn58bqn73KK4GKsyJz3EzTeeaIEBqC
        k9KOTtv1KBvK9eVL7N7kEioMpA==
X-Google-Smtp-Source: APiQypLRBIt23Mve8TSr7DgnTEuywVLE62QgLty8d3VrixDm9zomvZg4gf5EvRTzi6HE4Bnliiegrg==
X-Received: by 2002:a2e:8109:: with SMTP id d9mr2148319ljg.31.1585397906879;
        Sat, 28 Mar 2020 05:18:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f23sm177168lja.60.2020.03.28.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:18:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A1335100D25; Sat, 28 Mar 2020 15:18:29 +0300 (+03)
Date:   Sat, 28 Mar 2020 15:18:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 3/7] khugepaged: Drain LRU add pagevec to get rid of
 extra pins
Message-ID: <20200328121829.kzmcmcshbwynjmqc@box>
References: <20200327170601.18563-1-kirill.shutemov@linux.intel.com>
 <20200327170601.18563-4-kirill.shutemov@linux.intel.com>
 <CAHbLzkoe-07mxAuA18QUi=H21_Ts0JcbP2SUT=02ZTPhaQB6ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoe-07mxAuA18QUi=H21_Ts0JcbP2SUT=02ZTPhaQB6ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:10:40AM -0700, Yang Shi wrote:
> On Fri, Mar 27, 2020 at 10:06 AM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > __collapse_huge_page_isolate() may fail due to extra pin in the LRU add
> > pagevec. It's petty common for swapin case: we swap in pages just to
> > fail due to the extra pin.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  mm/khugepaged.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 14d7afc90786..39e0994abeb8 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -585,11 +585,19 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >                  * The page must only be referenced by the scanned process
> >                  * and page swap cache.
> >                  */
> > +               if (page_count(page) != 1 + PageSwapCache(page)) {
> > +                       /*
> > +                        * Drain pagevec and retry just in case we can get rid
> > +                        * of the extra pin, like in swapin case.
> > +                        */
> > +                       lru_add_drain();
> 
> This is definitely correct.
> 
> I'm wondering if we need one more lru_add_drain() before PageLRU check
> in khugepaged_scan_pmd() or not? The page might be in lru cache then
> get skipped. This would improve the success rate.

Could you elaborate on the scenario, I don't follow.


-- 
 Kirill A. Shutemov
