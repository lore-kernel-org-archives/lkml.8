Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A360C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5623920CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQxT1hRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTI7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:59:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725959AbgDTI67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587373137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bz93CG5tgmLS8pJDkO23pSfLYauBKXmOP1VWfhP+LYw=;
        b=aQxT1hRtQGyPIMj2Pfy8IFUnex+XVkj6ZCx0kaPk690G4TUyFGbuOXpuZc/sofBPJa9YHa
        r4+CWUV0wbUEcEOooOni9hJ3oshgm1i4g2zHO3wDPs+oPZTuqV09THa3VFKc1iGAFq0sNP
        Fo1fNyPjVAbJdP6948FXk9K8Dyta/sU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-TtXea8YEM1Wt7GgfmbBbvQ-1; Mon, 20 Apr 2020 04:58:52 -0400
X-MC-Unique: TtXea8YEM1Wt7GgfmbBbvQ-1
Received: by mail-qv1-f69.google.com with SMTP id dc4so9541438qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bz93CG5tgmLS8pJDkO23pSfLYauBKXmOP1VWfhP+LYw=;
        b=RcPAG7VV/lnodCS25kolo+s8Ik5dG3WTT+CznIwzHbtNXGbiTRxnABKX5FlVLnHCWw
         W2LIgwnWkwb0l57eQb5OkSjg/JKG7OU9Aks1HM+zSaR9wwz62itcejVh0BsMl9SqtCB7
         BFjZAFPGfnX3aE5LH0/QXwwhh/C6JnWufb5dGzp3NgKYIoe+0chEAjHB1WIOKNLw/q9T
         eNwE8FwiPucaLbohVUVce8c6z8vK20Kvn061HE884P76j7kdV2YR4O66BjBLmuVFAeKo
         dU8GbX2Gw3zaCADNy83BRuWU9AqIkn+VggYicmQyhsojFrWAJcmJYJ5pQtqVAxya5Od2
         qsUA==
X-Gm-Message-State: AGi0PubYoi3VBak9oUe95NizNz/WakwqHtrXjl1XaXOyxt/Q6ctvvJtX
        al9J8XoOGb+wAey4sGT4lkhZ58Wty5XfwKAuRiHMUjWQY3vfTwJSx4m1Uww4GbPaex2Q9KvN+bO
        ONGteolLJ3HOGDr5zlsy5puLgoguY4FdHXnpw37cU
X-Received: by 2002:ae9:ed92:: with SMTP id c140mr8007661qkg.29.1587373131729;
        Mon, 20 Apr 2020 01:58:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjRvIlDDg57MantknXiQ5Jwc+acww2bCZ5DeZC+XsS6aRa5FxXy575F8K7vkHScc9X0dsku5X4PlBNJJp3zz0=
X-Received: by 2002:ae9:ed92:: with SMTP id c140mr8007648qkg.29.1587373131491;
 Mon, 20 Apr 2020 01:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416143532.11743-1-mszeredi@redhat.com> <c47459a5-3323-121e-ec66-4a8eb2a8afca@samba.org>
 <CAOssrKe7RNyReAFLoQGBDm79qMdXEubhP5QhG_+UmGZXgeXBkA@mail.gmail.com> <3dce8811-a54e-1f74-c7ed-715b97a4652c@samba.org>
In-Reply-To: <3dce8811-a54e-1f74-c7ed-715b97a4652c@samba.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 20 Apr 2020 10:58:40 +0200
Message-ID: <CAOssrKcVddL5URQ0Vy79eQOscqTTK115Ro0Eqe8Q9kdkNJspCg@mail.gmail.com>
Subject: Re: [PATCH] vfs: add faccessat2 syscall
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 10:23 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> Am 18.04.20 um 21:00 schrieb Miklos Szeredi:
> > On Sat, Apr 18, 2020 at 8:36 PM Stefan Metzmacher <metze@samba.org> wrote:
> >>
> >> Hi Miklos,
> >>
> >>> POSIX defines faccessat() as having a fourth "flags" argument, while the
> >>> linux syscall doesn't have it.  Glibc tries to emulate AT_EACCESS and
> >>> AT_SYMLINK_NOFOLLOW, but AT_EACCESS emulation is broken.
> >>>
> >>> Add a new faccessat(2) syscall with the added flags argument and implement
> >>> both flags.
> >>>
> >>> The value of AT_EACCESS is defined in glibc headers to be the same as
> >>> AT_REMOVEDIR.  Use this value for the kernel interface as well, together
> >>> with the explanatory comment.
> >>
> >> It would be nice if resolv_flags would also be passed in addition to the
> >> at flags.
> >> See:https://lore.kernel.org/linux-api/CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com/
> >>
> >> We should avoid expecting yet another syscall in near future.
> >
> > What is the objection against
> >
> > openat(... O_PATH)
> > foobarat(fd, AT_EMPTY_PATH, ...)
>
> openat2(), foobarat(), close() are 3 syscalls vs. just one.

That's not a good argument.  We could have a million specialized
syscalls that all do very useful things.  Except it would be a
nightmare in terms of maintenance...

"do one thing and do it well"

> As we have the new features available, I think it would be
> good to expose them to userspace for all new syscalls, so
> that applications can avoid boiler plate stuff around each syscall
> and get better performance in a world where context switches are not for
> free.

The io-uring guys are working on that problem, AFAIK.

Thanks,
Miklos

