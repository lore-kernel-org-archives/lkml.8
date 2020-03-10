Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8742C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD0222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVHbW9YK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCJVk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:40:28 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:37038 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:40:28 -0400
Received: by mail-ot1-f54.google.com with SMTP id b3so14763908otp.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 14:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30v28QZwvgciyeUbGcFniNwVinb7jSfmAcitW4ywOgw=;
        b=pVHbW9YKRfFKZADsnAMJUGWLLN4457YVQMmhbheWBFB3MwtHdAS3MmRJYpyKaJnsOb
         rFf6OXsUpkBbr5iDyWHykufITmHwEqrVNRlJqU63iuzLFlg1Z9MIRUH7UWE4GgLt0miz
         5WTmAnuC4FApvZNx+enghhHzYN0PInrSX/8HNHkBs5vuFg6tkrFnlhEmj47EoYVX5IjP
         YOccE9PudP0FfqfHBvzgCI8LKHZgbRKKToWxImEyQlMGHTFJqk+EXMcAF0uDr+n5LQKg
         fy1W/aiXBgKwdLBhXziDEqmkP5FSQOg05yyWFYcle69NPG2P47ndKV1i5Wvpy21K2sEQ
         X47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30v28QZwvgciyeUbGcFniNwVinb7jSfmAcitW4ywOgw=;
        b=HTQifvdQrH2cCPNSguMleJuDPLVSPPKmrXeVN8jE39xeVamRdOgiJMu8Svgl1Fp3m4
         A9SG4HrxooJWAdCseVq2alcGOfjj/tOi30IBy4jpBAL8za6kEhQztO6imi7cMlDNTZIB
         H+G/EkRfJ5QfMdrmyxKReAemMjzkIQpcLE8+YuDU+u5T7YapPQuPHqD/ce020a6rnb/s
         JdjAbA4uqgzk8dGxDMCU2flCIy16yx2W2d+hzxNaLBc50kBKmKYXPC2GauoUUGjtVDPh
         rFfm0/AvA1oqf6K5yU5GnxQMtdE9VJ75K8jxmbQA+12Etfktx0wI70+kVf0JX/ttu1B1
         j+bA==
X-Gm-Message-State: ANhLgQ1gaq9Q5mHBHdB1zPAoiBmofJv2bEtT8iZXSA69EYCR+vFxzeQX
        O09uS3BP8iqrIR7arUKh6KotAlYP2bAFtesfp4EPgA==
X-Google-Smtp-Source: ADFU+vuwo43Am+Q4ZOSwVz+gheEF2PfMeUE0HNw3+JQ8rS3wiOXwG1aHHfvywTiOdtBznco4h3w5ww0CkXTuxEA/kKc=
X-Received: by 2002:a9d:6654:: with SMTP id q20mr5592078otm.180.1583876427094;
 Tue, 10 Mar 2020 14:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz> <CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com>
In-Reply-To: <CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 10 Mar 2020 22:40:00 +0100
Message-ID: <CAG48ez2EWzn_xm0Q3YaPjSXrhVAAOUUvNDyDQ+jpgavmN6wLvQ@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Daniel Colascione <dancol@google.com>
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

On Tue, Mar 10, 2020 at 9:19 PM Daniel Colascione <dancol@google.com> wrote:
> On Tue, Mar 10, 2020 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
> > On Tue 10-03-20 19:08:28, Jann Horn wrote:
> > > >From looking at the source code, it looks to me as if using
> > > MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> > > possible, even if other processes still have the same page mapped. Is
> > > that correct?
> > >
> > > If so, that's probably bad in environments where many processes (with
> > > different privileges) are forked from a single zygote process (like
> > > Android and Chrome), I think? If you accidentally call it on a CoW
> > > anonymous mapping with shared pages, you'll degrade the performance of
> > > other processes. And if an attacker does it intentionally, they could
> > > use that to aid with exploiting race conditions or weird
> > > microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> > > talks about "the assumption that attackers can provoke page faults or
> > > microcode assists for (arbitrary) load operations in the victim
> > > domain").
> > >
> > > Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> > > pages with mapcount>1, or something like that? Or does it already do
> > > that, and I just missed the check?
> >
> > I have brought up side channel attacks earlier [1] but only in the
> > context of shared page cache pages. I didn't really consider shared
> > anonymous pages to be a real problem. I was under impression that CoW
> > pages shouldn't be a real problem because any security sensible
> > applications shouldn't allow untrusted code to be forked and CoW
> > anything really important. I believe we have made this assumption
> > in other places - IIRC on gup with FOLL_FORCE but I admit I have
> > very happily forgot most details.
>
> I'm more worried about the performance implications. Consider
> libc.so's data section: that's a COW mapping, and we COW it during
> zygote initialization as we load and relocate libc.so. Child processes
> shouldn't be dirtying and re-COWing those relocated pages. If I
> understand Jann's message correctly, MADV_PAGEOUT would force the
> pages corresponding to the libc.so data segment out to zram just
> because we MADV_PAGEOUT-ed a single process that happened to use libc.
> We should leave those pages in memory, IMHO.

Actually, the libc.so data section is a file mapping, so I think
can_do_pageout() would decide whether the caller is allowed to force
pageout based on whether the caller is the owner of (or capable over)
libc (in other words, root, basically). But I think the bss section,
as well as heap memory, could have pageout forced by anyone.
