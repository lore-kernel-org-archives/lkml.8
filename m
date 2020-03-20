Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7426EC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445EE20781
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4VZqvnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCTJRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:17:32 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45770 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCTJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:17:31 -0400
Received: by mail-il1-f194.google.com with SMTP id m9so4882445ilq.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5yjE/VD/ici0HoXri9KyCxtUxAZijJK4qMSKaKWPS8=;
        b=D4VZqvnklKFyH0XWVVJo/Pr/kEQY5Fj4bYWa6AmSmMBB8qO/4hl6SE4YMOAtPPEKo1
         FFUvZHy686eGguHMbV00hZyGhA3F3Of1AN8frsBzlKPVQcMB+B7Tukj1M2Vwp7dOU6Tx
         iQUg93a+jAjN+8IGpxGYVgYar2Wjf9yI2aEdVDjn1mRvrymspnsZuaD5zanbuB1K0OFC
         UDNlNv1Syyb+v86xBZMdZN5eu9KFImj44GCoIBFPZuVi4FuaoVU5dQqbvFdc995f+TG0
         JyciDanu9Hv+NkQFZ7LtjnPx9XwYCT3luV6uYKFsfzKHYHBUqKcTIeqcshwvLb3vqRaX
         OuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5yjE/VD/ici0HoXri9KyCxtUxAZijJK4qMSKaKWPS8=;
        b=FJ1i0fxPIzQhIez4U/Vr2VyXVJydnTViOmcJ08cQQCXXwiqFqhfDEynQMR0tX1+ELP
         FINlM1AnfS1Lm7TmJOEpv1tNie9jQPlaflKQiszqL7SRpKf2eO4kIn+0M1rQUeQKYWl2
         X0lKG+2TSyXKcJD5YNtKGegTT07aP+0I+fehp63atOj2USzTqS9D3a9k0PBu9hCMRl9W
         1TZgyNSJ2NNEEihZfc4gOhuz2WV7UcFr/4WyTWFvmz6lrNbIuXuqIGjZr4D6iknU+KXI
         /+QuYjymoCn20mV7UA1Qu6gZAzVErShQgXa7K9+OvivrZgu+068CVZIdSzvjn8cki4dp
         JYVw==
X-Gm-Message-State: ANhLgQ1LHdR4JqdZE2CHxnlQx+nP/RHsnBk4IUoIw8al7qms1QQAClc7
        /e3O0u9rSBVsD+LBO+H/HvbAp+Fj8gyUo+K4ZXWNSxo=
X-Google-Smtp-Source: ADFU+vusRpBm4rNfGvTYBgBadB2eN25m8nlyvJ/Ghep4D00mRSg6qPP5/BS8BCLJSFX+OqDo3gsXeBag+fOVcLTcku8=
X-Received: by 2002:a92:250e:: with SMTP id l14mr7161441ill.201.1584695850718;
 Fri, 20 Mar 2020 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
 <1584333244-10480-4-git-send-email-kernelfans@gmail.com> <8d748bfe-b2b0-bb56-fb2c-71de86183ba5@nvidia.com>
In-Reply-To: <8d748bfe-b2b0-bb56-fb2c-71de86183ba5@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 20 Mar 2020 17:17:19 +0800
Message-ID: <CAFgQCTv0r1t0J+L4g9X=dfM+ofCy5j84=EU2YM6bXqx7Bykpdg@mail.gmail.com>
Subject: Re: [PATCHv6 3/3] mm/gup_benchemark: add LONGTERM_BENCHMARK test in
 gup fast path
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 6:27 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 3/15/20 9:34 PM, Pingfan Liu wrote:
> > Introduce a PIN_FAST_LONGTERM_BENCHMARK ioctl to test longterm pin in gup fast
> > path.
>
> 1. The subject line still has "benchemark", which should be "benchmark".
>
> 2. What do you really want to test? More about the use case to be tested would help.
> Just another sentence. I wouldn't normally ask, but in this case the implementation
> is slightly scrambled, and I can't suggest how to fix it because there's no information
> in the commit log as to the use case, nor the motivation.
Oh, the history about [3/3] is to verify the implementation method of
[2/3]. Please refer to
https://lore.kernel.org/linux-mm/20190611122935.GA9919@dhcp-128-55.nay.redhat.com/
Cite "
> > I think the concern is: for the successful gup_fast case with no CMA

> > pages, this patch is adding another complete loop through all the
> > pages. In the fast case.
> >
> > If the check were instead done as part of the gup_pte_range(), then
> > it would be a little more efficient for that case.
> >
> > As for whether it's worth it, *probably* this is too small an effect to measure.
> > But in order to attempt a measurement: running fio (https://github.com/axboe/fio)
> > with O_DIRECT on an NVMe drive, might shed some light. Here's an fio.conf file
> > that Jan Kara and Tom Talpey helped me come up with, for related testing:
"
But I think now, there is no motivation for it, and can be dropped it now.

Thanks,
Pingfan
