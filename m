Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E472C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C1721655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTRhK5wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCJUTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:19:50 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:45932 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJUTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:19:49 -0400
Received: by mail-lf1-f53.google.com with SMTP id b13so12013038lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 13:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ph0vbxjhiVWxt5rg3nkX2vAEthsG0dcjm7RlaAwg098=;
        b=FTRhK5wRW+NRGmaoV4Ks4Odxss3oisU/sts3+fM0oGm2ippT+eDkr1IaNE6RESk+lr
         uP42CT/VBEM8RxZzRhXu7OdoPtl5ghIZEFU0Sv2IQsJ3dsb3HDE68bjkrG/0JEnJJzf0
         h6OdM2SCHqYO8CccNpImf0UM6jUH0ewQIPYtbBJzBYWqxTlfX+DXwC0GZqRBGhDFShoh
         XCfYyNmsQDQ3gC5kkVw7Uuas1zPz/IW24F0I0iX7Q/Ik/pIlrdUPuv0Qa8NVg21pd4QD
         oVdancEdjuYHMTQh2nox/OksTwzF4NxKTaM0bkelHD5AejJfdXyGtde0aTBYJcvQlxAN
         WqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ph0vbxjhiVWxt5rg3nkX2vAEthsG0dcjm7RlaAwg098=;
        b=lZO5HNySNoa4M9KBOLwVKIyjif9Gq8rUyd9zs1NWlvDxIPOId1WU0TOvavowUW/X1S
         jKKnqpxuY8gFB4Q6Xm/J7eBNDzPEhl6ugYJeMSewfg0Cd036Hiex+Y/nEs7ILt1lzjgM
         Gcp+ayrtTxk4ZpG7J1yVygxVb2sl3NoGbpovZ6G/fDqMxSvxaVPONfPWqDLQK+xJUSvh
         GIRO9giUx4DJq3y2ibD2oGFEuG8qPmRo2azfkxTK1An2WIMd426LDwfr+3vR53s1txBn
         qmwhnb4Vbbq0qCmjaPtOkdp0hfuCfgDQ6Y2SlxQfMpvTRIJcslVux2JW1kvPDYdYm09+
         9VoQ==
X-Gm-Message-State: ANhLgQ0KBhBxO/yw/gve7GbJXaj+J9nI6iGL/FUFCWnLPJIQL6Uui8TW
        6gxrMFLilB4PdVH+jFkr15ZLkYQo+s0vJSepjTzPfQ==
X-Google-Smtp-Source: ADFU+vtmwZqppStJchtpo+FXaK2zYi5y4NF4w2GV6ag8hGufCvRmr98qaLuzObauOhshhDxAZdF9relJA+CJ5k6OMUc=
X-Received: by 2002:a05:6512:68a:: with SMTP id t10mr13869220lfe.126.1583871586843;
 Tue, 10 Mar 2020 13:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
In-Reply-To: <20200310184814.GA8447@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 10 Mar 2020 13:19:09 -0700
Message-ID: <CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:48 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 10-03-20 19:08:28, Jann Horn wrote:
> > Hi!
> >
> > >From looking at the source code, it looks to me as if using
> > MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> > possible, even if other processes still have the same page mapped. Is
> > that correct?
> >
> > If so, that's probably bad in environments where many processes (with
> > different privileges) are forked from a single zygote process (like
> > Android and Chrome), I think? If you accidentally call it on a CoW
> > anonymous mapping with shared pages, you'll degrade the performance of
> > other processes. And if an attacker does it intentionally, they could
> > use that to aid with exploiting race conditions or weird
> > microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> > talks about "the assumption that attackers can provoke page faults or
> > microcode assists for (arbitrary) load operations in the victim
> > domain").
> >
> > Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> > pages with mapcount>1, or something like that? Or does it already do
> > that, and I just missed the check?
>
> I have brought up side channel attacks earlier [1] but only in the
> context of shared page cache pages. I didn't really consider shared
> anonymous pages to be a real problem. I was under impression that CoW
> pages shouldn't be a real problem because any security sensible
> applications shouldn't allow untrusted code to be forked and CoW
> anything really important. I believe we have made this assumption
> in other places - IIRC on gup with FOLL_FORCE but I admit I have
> very happily forgot most details.

I'm more worried about the performance implications. Consider
libc.so's data section: that's a COW mapping, and we COW it during
zygote initialization as we load and relocate libc.so. Child processes
shouldn't be dirtying and re-COWing those relocated pages. If I
understand Jann's message correctly, MADV_PAGEOUT would force the
pages corresponding to the libc.so data segment out to zram just
because we MADV_PAGEOUT-ed a single process that happened to use libc.
We should leave those pages in memory, IMHO.
