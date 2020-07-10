Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA2BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87C32078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLw6TmCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGJRcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGJRcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:32:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C59C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:32:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so6935859eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GyxplQHayEvmvrRHkO0OJLN3lFhVymyo1nylRHB6x70=;
        b=sLw6TmCekYtu1t+4HXvJDAcDEEqgIVQ5Yz+rND8BHv086zW0gYK3zzTYgrx+4P0P3r
         m+F+wfKoMU/oBymoiuE1pHgOGlAQKQ5wRGgxzfWlQ2vQPv7K0ygznPgwtCC31QpyHPmT
         d0yYLhKT/D96ALDbqiLZowWi9n4W0osE5MKF88gz6FMaX+Vj2zyNzVUTzDsD7W/yOZo+
         rHWirUpOLYMlrqa31FD38i0TmN5rOy8wBjrKmyvQxhFhKU/UCmHs8CoT7fNRSC1Zk0Id
         /+TM7PBwnhw//5vnkT9CsS7opth3wxzX1UozYwf1YVkIRz1s3gLf7/L0r1eV8YDHxuuP
         ZYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GyxplQHayEvmvrRHkO0OJLN3lFhVymyo1nylRHB6x70=;
        b=ZUguMaOUCp4R3UVin4SP1i3AIcKLjvm7BjH8FBb7LZXnUiMFD8q1Sx0KUZiaTrMmSU
         06wKlgWWc1yJlJFl71/B7OonyERQ60xyv2XGm0z4iiGiZD/jFy1ZfKhH3C3QkTuTwKEH
         gBOB22s1RDIPCrxCJbBX2B0euUW+r9dNQ/2JNg3zA9hb7fnZ3bdca5kFllCl1XbNpGYZ
         seyQWZdIDbbcCMz33UvuuPSDvpLwBa6tfdZDAtNG3enX6mMf2vyFp6rqiIAVtITWYYEC
         oUyThyRwWWr1h+jVXeie2D3/QSjo9HVSnYNluaAdARLGxbiJYeQGRJ7gZhN5Io6SP4L3
         MrBg==
X-Gm-Message-State: AOAM5325NJJPUDF2hpBGMGJLiRuDUCAz6vCnUc+o0Q1KTDqrG6tBk1b6
        SdSTPFjCGF1Fywp9OyyBIlDUOM8gKhXwPYXypx0=
X-Google-Smtp-Source: ABdhPJyiUicFYVDA5MJbuZfIficFmipK/W9bdoD7Ka6wvWgcgR8ONl2GAArU+JyiC1cRK7vIR/zcIRD+bDWSIOiElDw=
X-Received: by 2002:a17:907:2058:: with SMTP id pg24mr65715767ejb.79.1594402364502;
 Fri, 10 Jul 2020 10:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkq5rSHUSbHegM5mURytS7nEDyHHbxOYn8DaBwYB0qGocw@mail.gmail.com>
 <20200710141827.netxb2rimpge4qkd@box>
In-Reply-To: <20200710141827.netxb2rimpge4qkd@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 10 Jul 2020 10:32:24 -0700
Message-ID: <CAHbLzkq+Rs9662FA+vChBt5it2SRXS0QiwG0Rx8m+BZFad6uyA@mail.gmail.com>
Subject: Re: [RFC] Kill THP deferred split queue?
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 7:18 AM Kirill A. Shutemov <kirill@shutemov.name> w=
rote:
>
> On Tue, Jul 07, 2020 at 11:00:16AM -0700, Yang Shi wrote:
> > Hi folks,
> >
> > The THP deferred split queue is used to store PTE mapped THP (i.e.
> > partial unmapped THP) then they will get split by deferred split
> > shrinker when memory pressure kicks in.
> >
> > Now the page reclaim could handle such cases nicely without calling
> > the shrinker. Since the THPs on deferred split queue is not PMD mapped
> > so they will be split unconditionally, then the unmapped sub pages
> > would get freed. Please see the below code snippet:
> >
> >                              if (PageTransHuge(page)) {
> >                                         /* cannot split THP, skip it */
> >                                         if (!can_split_huge_page(page, =
NULL))
> >                                                 goto activate_locked;
> >                                         /*
> >                                          * Split pages without a PMD ma=
p right
> >                                          * away. Chances are some or al=
l of the
> >                                          * tail pages can be freed with=
out IO.
> >                                          */
> >                                         if (!compound_mapcount(page) &&
> >                                             split_huge_page_to_list(pag=
e,
> >                                                                     pag=
e_list))
> >                                                 goto activate_locked;
> >                                 }
> >
> > Then the unmapped pages will be moved to free_list by
> > move_pages_to_lru() called by shrink_inactive_list(). The mapped sub
> > pages will be kept on LRU. So, it does exactly the same thing as
> > deferred split shrinker and at the exact same timing.
> >
> > The only benefit of shrinker is they can be split and freed via "echo
> > 2 > /proc/sys/vm/drop_caches=E2=80=9D, but I'm not sure how many people=
 rely
> > on this?
> >
> > The benefit of killing deferred split queue is code simplification.
> >
> > Any comment is welcome.
>
> The point of handing it in shrinker is that these pages have to be droppe=
d
> before anything potentially useful get reclaimed. If the compound page ha=
s
> any active PTEs you are unlikely to reach it during normal reclaim.

Thanks. Yes, it looks so. We can't tell if the THP has inactive PTEs
or not easily via page_referenced(). It looks the whole THP would be
treated as active as long as one subpage is active.

>
> --
>  Kirill A. Shutemov
