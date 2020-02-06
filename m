Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03C6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3720730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrFQwEl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbgBFL3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:29:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40672 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:29:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so4218972oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LOcb8MY6mnGMOkw5o9OHiVJZqqoYe5yVwQN2zYkKLg=;
        b=QrFQwEl7g9MnWr9VvEcb/sCcX4RY/t3UHs5G2mHmckEcgWv9ZjbrTiqjg4+pY/aPF0
         xbDHD74WDaBaQ0XIXaSFrZhM8HGOFuTdhlzhYHjoIze1f2vT0JQLzn4x+SPw9qpukcU1
         K09tRWDU6NRRCZQI0k8q3KgFBQXfZSHGqpJniU7ng9+I+1nf/j9EppB0onpSSsn7k3Nt
         +8EZTW2qF1u6K/k3LkEX5LtVrtqV4AMOIqD0IJB/3V39Nf68AKXh/MiF9aVk6oyoE7pu
         4gDTgbzlK2CwQE+/DUfkUSwCjo4HEhypduKjERXUnaA/UG66109Z/rc/h+aWN8mDzVXt
         Lcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LOcb8MY6mnGMOkw5o9OHiVJZqqoYe5yVwQN2zYkKLg=;
        b=SW7+K9/rZy4ekK3V6dtTCN/GSsNnWinQ0SBHeZOgRXCKufC/R9XJnJMObDpEbiKaKQ
         5bkviGSzYAw3OFgf1IodOi2FarOHY3m5jqA3ZBxG78bqtif2g+6a5UshjTCocycaowji
         OUuUJBd+9+cvnpjb0WuB/S5gnzGMj2Mm6sRiOlPq0WAhplZN0KcfCUAOOVYNsIsLv2Pi
         trTef5r0mmhpe+HlwH3n3j782oqrOQ6VTZxT9JWikrkf9DW9YGg7RJHcCmTRl48M8FO+
         G/j5DuRB/NLb2krQWgGINyTOEm/JTbKbbCw2D4YbtEBsXiO87ll47uxwTNApv5cbsROd
         np7w==
X-Gm-Message-State: APjAAAXmjst4siFOiQRVu1dx5uekCrK/CWjBXLu/TFVnI9Ai+x7sKyUM
        WRCdZLGE6cQELKXwL2RL1tzx1/p6ZHlL5a6FbM7N7Q==
X-Google-Smtp-Source: APXvYqzlXUwReQiQ7QaDb2/khWr0uJbvXUqawl258pPAvjPXGpxxs29kYGBokCGXHPHAd2kkH1Do9TH/W4iGNWCQt58=
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr6575954oif.157.1580988548436;
 Thu, 06 Feb 2020 03:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20200128072740.21272-1-frextrite@gmail.com> <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable> <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable> <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
 <20200206013251.GC55522@google.com>
In-Reply-To: <20200206013251.GC55522@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Feb 2020 12:28:42 +0100
Message-ID: <CAG48ez2+7L8YwejaLcm5MN7Z2DZ4d4H5CV6cUyo+j5S9b=tAtQ@mail.gmail.com>
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 2:32 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Jan 29, 2020 at 03:14:56PM +0100, Jann Horn wrote:
> > On Wed, Jan 29, 2020 at 7:57 AM Amol Grover <frextrite@gmail.com> wrote:
> > > On Tue, Jan 28, 2020 at 08:09:17PM +0100, Jann Horn wrote:
> > > > On Tue, Jan 28, 2020 at 6:04 PM Amol Grover <frextrite@gmail.com> wrote:
> > > > > On Tue, Jan 28, 2020 at 10:30:19AM +0100, Jann Horn wrote:
> > > > > > On Tue, Jan 28, 2020 at 8:28 AM Amol Grover <frextrite@gmail.com> wrote:
> > > > > > > task_struct.cred and task_struct.real_cred are annotated by __rcu,
> > > > > >
> > > > > > task_struct.cred doesn't actually have RCU semantics though, see
> > > > > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > > > > it would probably be more correct to remove the __rcu annotation?
> > > > >
> > > > > Hi Jann,
> > > > >
> > > > > I went through the commit you mentioned. If I understand it correctly,
> > > > > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > > > > flag was introduced, which determined if the clean-up should wait for
> > > > > RCU grace-periods or not. And since, the changes were 'thread local'
> > > > > there was no need to wait for an entire RCU GP to elapse.
> > > >
> > > > Yeah.
> > > >
> > > > > The commit too, as you said, mentions the removal of __rcu annotation.
> > > > > However, simply removing the annotation won't work, as there are quite a
> > > > > few instances where RCU primitives are used. Even get_current_cred()
> > > > > uses RCU APIs to get a reference to ->cred.
> > > >
> > > > Luckily, there aren't too many places that directly access ->cred,
> > > > since luckily there are helper functions like get_current_cred() that
> > > > will do it for you. Grepping through the kernel, I see:
> > [...]
> > > > So actually, the number of places that already don't use RCU accessors
> > > > is much higher than the number of places that use them.
> > > >
> > > > > So, currently, maybe we
> > > > > should continue to use RCU APIs and leave the __rcu annotation in?
> > > > > (Until someone who takes it on himself to remove __rcu annotation and
> > > > > fix all the instances). Does that sound good? Or do you want me to
> > > > > remove __rcu annotation and get the process started?
> > > >
> > > > I don't think it's a good idea to add more uses of RCU APIs for
> > > > ->cred; you shouldn't "fix" warnings by making the code more wrong.
> > > >
> > > > If you want to fix this, I think it would be relatively easy to fix
> > > > this properly - as far as I can tell, there are only seven places that
> > > > you'll have to change, although you may have to split it up into three
> > > > patches.
> > >
> > > Thank you for the detailed analysis. I'll try my best and send you a
> > > patch.
>
> Amol, Jann, if I understand the discussion correctly, objects ->cred
> point (the subjective creds) are never (or never need to be) RCU-managed.
> This makes sense in light of the commit Jann pointed out
> (d7852fbd0f0423937fa287a598bfde188bb68c22).
>
> How about the following diff as a starting point?
>
> 1. Remove all ->cred accessing happening through RCU primitive.

Sounds good.

> 2. Remove __rcu from task_struct ->cred

Sounds good.

> 3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
>    which places that task-synchronously use ->cred can overwrite. Callers
>    doing such accesses like access() can use this API instead.

That's wrong, don't do that.

->cred is a reference without RCU semantics, ->real_cred is a
reference with RCU semantics. If there have never been any references
with RCU semantics to a specific instance of struct cred, then that
instance can indeed be freed without an RCU grace period. But it would
be possible for some filesystem code to take a reference to
current->cred, and assign it to some pointer with RCU semantics
somewhere, then drop that reference with put_cred() immediately before
you reach put_cred_non_rcu(); with the result that despite using
put_cred(), the other side doesn't get RCU semantics.

Just leave the whole ->non_rcu thing exactly as it was.
