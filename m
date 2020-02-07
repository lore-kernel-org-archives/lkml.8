Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221DC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027CB21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bv7+O0Gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBGNST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 08:18:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42432 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 08:18:19 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so2079662otd.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 05:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AppHa1mPfAaiV/SFjOWJnS9mSSWNJs8o2NmtKzYnLIM=;
        b=Bv7+O0Gj9xzAxmxTKrE64kVHWDzLjK/48wyrFk5pv+zPmbR8MwZx8Mq9HSymH0TL+F
         gBqs2In+xlRc+Bc4Y3A2710Y+mDoCmsm5Phl1ZyDdMonr92CewoH05FNxI7b4vSIuyxp
         01lpriTCHmxoLgRRDZdAmRB+ZZ8RtnEgjuAQNztgMRWCX+hr/TL8mYBbbU5FXaN+TYJi
         KpzEQnEJ/41S/hjd77bv20LD4OrgAjU8T22ThyKEIhiFLJ57CKdXyqWOkUyzlhxaqZpY
         TSsDfTZeYUgJwDsJJDso9uDZ2kKP4XcI+ZUVnBB9mu0z6TAaTBIr+a3oOsrAlpGO/A6m
         HokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AppHa1mPfAaiV/SFjOWJnS9mSSWNJs8o2NmtKzYnLIM=;
        b=svI8KfJoJtNQfEPukb5yq6rQVG2NoKLDPHJN9RXugvx8or71ZL6HoNccrUnkKbK3nH
         CF6urptb9q151nPI6fhWVnTb82tMqaKwWPdigHwHsyVJ+2gkEwLsfMpSBmz9dRn6Aftn
         OtqWUSc9dLxclLJ6VxuWr8YKbcwH/GFOgZVhnWhHe9Mlu1heIlRjSm2ekiAQ0xLOxL5n
         9avoaWuEyj1ms+V5QQQLQ+jB8EVWboExedGuBUAjC9Sv/SSa/Pm6x2vu9BY67zhiTaJ1
         Rcwl0kvzAm3kmq2dybsPM3lHaNz6kSDZ1U9O/4o775zF+al3iabrt4wZNnRvK+DCcMoi
         C1xg==
X-Gm-Message-State: APjAAAX/zGYkAoqhaxDl1bsaxWN3u1aO8tJo1vPVkZgbeGQebi4Isd+C
        xcvMVMM3mx1qOWtcyDjkYSxLQ5rWCJbMyvbg0AHVYQ==
X-Google-Smtp-Source: APXvYqySp8t5lUY8/teOm/qXtbaVzYWnWcBeaLn8p5ibiMGK8WkrVN2kSGBYXg7A0wmRwctJqD8szGVi8N+/sIqUy5g=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr2746790otk.23.1581081497948;
 Fri, 07 Feb 2020 05:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20200206035235.2537-1-cai@lca.pw> <480a7dde-f678-c07b-2231-4da8e0a38753@nvidia.com>
 <1580997681.7365.14.camel@lca.pw> <CANpmjNNX1apK0izjPhRG3kG-O_iKG1nGrOEL+PAvpH86QLXZMg@mail.gmail.com>
 <423eb3c6-6db2-87d2-e0b7-a32600ee1cd4@nvidia.com>
In-Reply-To: <423eb3c6-6db2-87d2-e0b7-a32600ee1cd4@nvidia.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Feb 2020 14:18:06 +0100
Message-ID: <CANpmjNM6AFdMU3Oc8z5yJKhAEr7Z8AsOzgvwGgWAQ5j4J=D3xg@mail.gmail.com>
Subject: Re: [PATCH -next] mm: mark a intentional data race in page_zonenum()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 at 00:18, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/6/20 6:35 AM, Marco Elver wrote:
> ...
> >>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>> index 52269e56c514..cafccad584c2 100644
> >>>> --- a/include/linux/mm.h
> >>>> +++ b/include/linux/mm.h
> >>>> @@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
> >>>>
> >>>>   static inline enum zone_type page_zonenum(const struct page *page)
> >>>>   {
> >>>> -   return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> >>>> +   return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
> >>>
> >>>
> >>> I don't know about this. Lots of the kernel is written to do this sort
> >>> of thing, and adding a load of "data_race()" everywhere is...well, I'm not
> >>> sure if it's really the best way.  I wonder: could we maybe teach this
> >>> kcsan thing to understand a few of the key idioms, particularly about page
> >>> flags, instead of annotating all over the place?
> >>
> >> My understanding is that it is rather difficult to change the compilers, but it
> >> is a good question and I Cc Marco who is the maintainer for KCSAN that might
> >> give you a definite answer.
> >
> > The problem is that there is no general idiom where we could say with
> > confidence that a data race is safe across the whole kernel. Here it
>
> Yes. I'm grasping at straws now, but...what about the idiom that page_zonenum()
> uses: a set of bits that are "always" (after a certain early point) read-only?
> What are your thoughts on that?

I have replied to the other thread.

Thanks,
-- Marco



> > might not matter, but somewhere else it might matter a lot.
> >
> > If you think that it turns out the entire file may be littered with
> > 'data_race()', and you do not want to use annotations, you can
> > blacklist the file. I already had to do this for other files in mm/,
> > because concurrent flag modification/checking is pervasive and a lot
> > of them seem 'benign'. We decided to revisit those files later.
> >
> > Feel free to add 'KCSAN_SANITIZE_memory.o := n' or whatever other
> > files you think are full of these to mm/Makefile.
> >
> > The only problem I see with that is that it's not obvious what is
> > concurrently modified and what isn't. The annotations would have
> > helped document what is happening.
> >
> > Thanks,
> > -- Marco
> >
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
