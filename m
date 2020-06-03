Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEA0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E2FD20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591142926;
	bh=Bvw7ta+8yXtDruHwIqmG1lpokg0cCz02Wn1FrM7aELY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OGuyJ8218Boq0BCXTlZ+aE+++vVnm2CfMipqh0nzND0q1ab/VdIrV+OefppUB9kcv
	 VU4UL0Tzo6XZlJkuaF0AbRlBberbKC1h7F3s5ODwfq77m1/dwf26a6ED5vZXmlWTmN
	 rITZwXyGLCjsoZhDCmZ/dXWZfv4Fup+PYFecVOJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFCAIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFCAIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:08:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E46C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:08:44 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 202so162642lfe.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PazKvjjbmAQeUYiZad4yyf2QZKpFBXiEaJOc1KsToFM=;
        b=cxQ3fmuQWsQSr6abyNc9/tsWVhRgX+CIskaA0+9tWleBkBxH+nD83NbhOrLA4+l62q
         IHd7DWRbt8QX/EQhJmNdBB/KVbcm3z19PVF4njNDsJ2EVCzILIGOTxNV+HKYvlu2vYC2
         U0ZUjz234y+0uLMwggsMalqWy5B+hZTC5aMVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PazKvjjbmAQeUYiZad4yyf2QZKpFBXiEaJOc1KsToFM=;
        b=MbLujEcE6ustWQXNBHc55E6hxdripAc8d4iAJWUlFM7ROVYqnh6rDTVMpygOL5q1bp
         GaupN/aKtNL/pwoGXOkwkYZEkbDIhuR3BGoKe9xx97urKILhODvftRyTODhF4k8cz1pX
         jaCApZvEJE2zKv7qpE1ulr51drEtlo3OjEm5yx680Q9VIqgJxri2SRX0XXyfJhEKcNh3
         1oSXUpD363efc3IgwWXqbn79FcmDzukNXZl4zpS3nI5971dxk4z6s1IISsm1rGDqz9Vu
         CoBEVXRNWwddTBqMUzT1bETYBOuCl8c1ZHGOUOwH2+xVHLSDB1joaHqKnUgE550Jm3Md
         PPQg==
X-Gm-Message-State: AOAM531z6zBoDvKjp8rR+x7cHm5wIZA5KEwR0/VralbSKgV8rIGOXZCO
        +FGUX+PAAoeShwaEkIvZQDzqOOH9KcA=
X-Google-Smtp-Source: ABdhPJys34OkXuVJykEerQOZkKMG9bPCTgRuTRh+5dwDhUTmJofS40uvouVOb4GR/GnLKVGRyIqcUg==
X-Received: by 2002:a19:8447:: with SMTP id g68mr958190lfd.132.1591142921356;
        Tue, 02 Jun 2020 17:08:41 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id v28sm85908ljv.40.2020.06.02.17.08.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 17:08:40 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z206so159631lfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:08:39 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr947879lfn.10.1591142919097;
 Tue, 02 Jun 2020 17:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com> <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
In-Reply-To: <20200602233355.zdwcfow3ff4o2dol@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 17:08:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
Message-ID: <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 4:33 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> >
> > And maybe this _did_ get mentioned last time, and I just don't find
> > it. I also don't see anything like that in the patches, although the
> > flags argument is there.
>
> I spent some good time digging and I couldn't find this mentioned
> anywhere so maybe it just never got sent to the list?

It's entirely possible that it was just a private musing, and you
re-opening this issue just resurrected the thought.

I'm not sure how simple it would be to implement, but looking at it it
shouldn't be problematic to add a "max_fd" argument to unshare_fd()
and dup_fd().

Although the range for unsharing is obviously reversed, so I'd suggest
not trying to make "dup_fd()" take the exact range into account.

More like just making __close_range() do basically something like

        rcu_read_lock();
        cur_max = files_fdtable(files)->max_fds;
        rcu_read_unlock();

        if (flags & CLOSE_RANGE_UNSHARE) {
                unsigned int max_unshare_fd = ~0u;
                if (cur_max >= max_fd)
                        max_unshare_fd = fd;
                unshare_fd(max_unsgare_fd);
        }

        .. do the rest of __close_range() here ..

and all that "max_unsgare_fd" would do would be to limit the top end
of the file descriptor table unsharing: we'd still do the exact range
handling in __close_range() itself.

Because teaching unshare_fd() and dup_fd() about anything more complex
than the above doesn't sound worth it, but adding a way to just avoid
the unnecessary copy of any high file descriptors sounds simple
enough.

But I haven't thought deeply about this. I might have missed something.

            Linus
