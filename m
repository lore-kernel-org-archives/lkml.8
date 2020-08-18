Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1D32078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wv+1pa2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgHRIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgHRIbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:31:50 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61FC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:31:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so9793533lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8GP7eS1LzqVo1eId0/J96ZQfgvz1Pc6gH5ak12QY8s=;
        b=Wv+1pa2AmKmIwoKJdEL2ArgVsY1NxHFTuMHeNtykD6cHJqyOs6Ldd9+CJCFjNiNw1n
         d//IcpMHQNlTzB1i8GiRa4VxLjdUliW2WYb/GTUaK1vaDU8mAYXpoo2Jc46qsC3kP5Wm
         0pn0jblTpfNawL8JTIl/OAsSIKZMS4Sd0olHFj2Qds9nFW/nRCvT6D0zZUS+m7KgqxpJ
         O7MvpSd5P3cLMl/q2NEF24plBojGwsdc7mNKcUet6FFV5RSF4oPL4Ina3hGzvu2YYh7C
         TJKOo4Orwsi4xp3qCJiXrJvCnVL2jVGuBxHVWeLy2/eYHcNpXYbAf5wrxAilDZcXCJVk
         kfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8GP7eS1LzqVo1eId0/J96ZQfgvz1Pc6gH5ak12QY8s=;
        b=WQvVAuvkFUUHmtGhmB3OOvzUnYz3LEu/aISUhBb3/y+4D9GaELhc1EKegaI/lqbFIy
         OGdc3oKnGwGIZ80FwSOW2+ikVPPAtPzpWKcwC4K5cHRb7Ac5kjYxUS3AvriA2SKWuGhZ
         ClrY/z9L4W2CHA12S6UAMgNeWV//X3fXYiES4OA6jfaYFrjbM+qhZpV7okYLveBg4OM/
         W8gZv9L4Fzl2VM8rxpkSSdOtAK+9kre2JJOkMHVPqTU2uiZ3srYOfLjMi6hS9kl2kJS9
         YzCeM9xmXTCCS3IB1ZAAuVtbmUZjjO21HoikineiYMdmmEem1ECruyiMQBoIF1MiulT4
         QZ5g==
X-Gm-Message-State: AOAM532YgrLA+oDNmVw7lTHnIfvtgBj1PkT2etPdsxMXRcTtzvSxeYS+
        80z5ZGYhaOAsihRlkssG8UWdRx/teu99MahYKu6I2w==
X-Google-Smtp-Source: ABdhPJwOK2qkpFlid8UNu4o909xNlNZeU/CcgMi47GISHCDqEJo0W4B9K2Dvq8R5VeBxjw2o4Ig7Cozq0ziLwGTgteY=
X-Received: by 2002:a19:4844:: with SMTP id v65mr9475947lfa.184.1597739506937;
 Tue, 18 Aug 2020 01:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-5-jannh@google.com>
 <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
In-Reply-To: <CAHk-=wiOqR-4jXpPe-5PBKSCwQQFDaiJwkJr6ULwhcN8DJoG0A@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Aug 2020 10:31:20 +0200
Message-ID: <CAG48ez3pMcPTHrbgjeVbCAV1n7VQW1tqJw8kNsL4wgRxV_Fr9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] binfmt_elf, binfmt_elf_fdpic: Use a VMA list snapshot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Aug 17, 2020 at 11:13 PM Jann Horn <jannh@google.com> wrote:
> >
> >         /*
> >          * If this looks like the beginning of a DSO or executable mapping,
> > +        * we'll check for an ELF header. If we find one, we'll dump the first
> > +        * page to aid in determining what was mapped here.
> > +        * However, we shouldn't sleep on userspace reads while holding the
> > +        * mmap_lock, so we just return a placeholder for now that will be fixed
> > +        * up later in vma_dump_size_fixup().
>
> I still don't like this.
>
> And I still don't think it's necessary.
>
> The whole - and only - point of "check if it's an ELF header" is that
> we don't want to dump data that could just be found by looking at the
> original binary.
>
> But by the time we get to this point, we already know that
>
>  (a) it's a private mapping with file backing, and it's the first page
> of the file
>
>  (b) it has never been written to and it's mapped for reading
>
> and the choice at this point is "don't dump at all", or "dump just the
> first page".
>
> And honestly, that whole "check if it has the ELF header" signature
> was always just a heuristic. Nothing should depend on it anyway.
>
> We already skip dumping file data under a lot of other circumstances
> (and perhaps equally importantly, we already decided to dump it all
> under other circumstances).
>
> I think this DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER hackery is worse than
> just changing the heuristic.
>
> So instead, just say "ok, if the file was executable, let's dump the
> first page".
>
> The test might be as simple as jjust checking
>
>        if (file_inode(vma->vm_file)->i_mode & 0111)
>
> and you'd be done. That's likely a _better_ heuristic than the "let's
> go look at the random first word in memory".
>
> Your patches look otherwise fine, but I really really despise that
> DUMP_SIZE_MAYBE_ELFHDR_PLACEHOLDER, and I don't think it's even
> necessary.

Yeah, good point, it's a pretty ugly hack. I'll make a new version
along the lines of what you suggested.
