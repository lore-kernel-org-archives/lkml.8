Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E5C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD319222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utAh3QrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCJVxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:53:33 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:35674 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJVxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:53:33 -0400
Received: by mail-oi1-f179.google.com with SMTP id c1so15572624oiy.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28amOXdcgZ1tgbIjzoT1unfXPJs97/xVZ1Q2OiQ+6Jg=;
        b=utAh3QrVVsP59y4SPip+7/1ssGzl80dGiqWjfte5x5SdG00BBhDOBE4EuZG8BfyRo1
         So7NTUQq/NcOj4DC8vNG3FFcs18hqCogTLIO7apdCBLldxwFlTGWzFKmgGqQsv52Ty2D
         oONi77phJwslRWog4zvNFEetHTP4AlzmX1BNVrzR6KKMm7NGM7y/qKcXpCMuu/PISI3z
         /DvGLkZUvJdvcnBL40vZnQqOqRCOGt6P8LmiPdiqHtxHD/gXVvb8BAZixjNPGsLhMbbn
         SDpGZMeh1blnemUG37moJtlrM0r0xKga9cKxUBSuypbG/B3i92LvAlZ3UuMaSo4PyRaF
         GnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28amOXdcgZ1tgbIjzoT1unfXPJs97/xVZ1Q2OiQ+6Jg=;
        b=b/XJgiF1nQ6laJtf9zyVq/OMKkDxcpS1CVMwbEOmNVfddqs2DXtUMKCoKJ62Fdj1Ki
         SNezFUJuK7O+Y7HTmaJRfM6wg2YM1KV7nhTGI4ghy7V0e36onR5nyleqJz8jBMC3hdrD
         xgnZ8Kytq+eqh5iBxByyLNaxtU3qlvANnuOah3H8svh1rBHZNUxsssTkNghGT4GUQ3YB
         wR3NkZlFyG8kAVHD/J3wGBTST+PJXo7MD7pFMUvGa2AppO6XiE4vU/u4l+Iy/BqoQgOg
         NPHjGocxpIFSwBN/uOU18+eGYD+4WdupIMnlKypOV1GLPFE5ycZ8CKbfpjws8Gtm9AZi
         +RRA==
X-Gm-Message-State: ANhLgQ1ZFQNA/Wwbo6oCuvTTcDHI1VrSbRepg66Ro0f6mK1ybKmcgpi8
        rYQa2nrBoRaxme4NMYJUbbEIAd8a0FazRRhkYGX06Q==
X-Google-Smtp-Source: ADFU+vs/PynMMOdJ4xb1jh1/YKI8pt7pcS0qS8D/NxIHOFOj0Sv8txvnm32MO24awX4H5b9p3Vg3n3q0D+H75nlWAdE=
X-Received: by 2002:a05:6808:abc:: with SMTP id r28mr2766071oij.161.1583877211932;
 Tue, 10 Mar 2020 14:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz> <CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com>
 <CAG48ez2EWzn_xm0Q3YaPjSXrhVAAOUUvNDyDQ+jpgavmN6wLvQ@mail.gmail.com>
In-Reply-To: <CAG48ez2EWzn_xm0Q3YaPjSXrhVAAOUUvNDyDQ+jpgavmN6wLvQ@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 10 Mar 2020 14:52:55 -0700
Message-ID: <CAKOZues-ejm8kKOp9YaZwDy_HNhvWK12x2cqtqHBYj4DCQtXpQ@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Jann Horn <jannh@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 2:40 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Mar 10, 2020 at 9:19 PM Daniel Colascione <dancol@google.com> wrote:
> > On Tue, Mar 10, 2020 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > On Tue 10-03-20 19:08:28, Jann Horn wrote:
> > > > >From looking at the source code, it looks to me as if using
> > > > MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> > > > possible, even if other processes still have the same page mapped. Is
> > > > that correct?
> > > >
> > > > If so, that's probably bad in environments where many processes (with
> > > > different privileges) are forked from a single zygote process (like
> > > > Android and Chrome), I think? If you accidentally call it on a CoW
> > > > anonymous mapping with shared pages, you'll degrade the performance of
> > > > other processes. And if an attacker does it intentionally, they could
> > > > use that to aid with exploiting race conditions or weird
> > > > microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> > > > talks about "the assumption that attackers can provoke page faults or
> > > > microcode assists for (arbitrary) load operations in the victim
> > > > domain").
> > > >
> > > > Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> > > > pages with mapcount>1, or something like that? Or does it already do
> > > > that, and I just missed the check?
> > >
> > > I have brought up side channel attacks earlier [1] but only in the
> > > context of shared page cache pages. I didn't really consider shared
> > > anonymous pages to be a real problem. I was under impression that CoW
> > > pages shouldn't be a real problem because any security sensible
> > > applications shouldn't allow untrusted code to be forked and CoW
> > > anything really important. I believe we have made this assumption
> > > in other places - IIRC on gup with FOLL_FORCE but I admit I have
> > > very happily forgot most details.
> >
> > I'm more worried about the performance implications. Consider
> > libc.so's data section: that's a COW mapping, and we COW it during
> > zygote initialization as we load and relocate libc.so. Child processes
> > shouldn't be dirtying and re-COWing those relocated pages. If I
> > understand Jann's message correctly, MADV_PAGEOUT would force the
> > pages corresponding to the libc.so data segment out to zram just
> > because we MADV_PAGEOUT-ed a single process that happened to use libc.
> > We should leave those pages in memory, IMHO.
>
> Actually, the libc.so data section is a file mapping, so I think
> can_do_pageout() would decide whether the caller is allowed to force
> pageout based on whether the caller is the owner of (or capable over)
> libc (in other words, root, basically). But I think the bss section,
> as well as heap memory, could have pageout forced by anyone.

lmkd would have that capability though, right? But the point stands
regardless. It sounds like both security and performance suggest a
behavior change here. Thanks for bringing it up!
