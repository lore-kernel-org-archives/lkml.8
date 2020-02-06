Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEBA214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UxuR6NNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFRQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:16:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46115 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:16:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so5312588oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+Jg3oYjYPhlt3pP3rA+Wq6ivbf9LPTqafp8/8ynRmA=;
        b=UxuR6NNzVqlQaJrSLkDO3DJXOSlWTlu7R/p7g2zdtffN5tGATXtxPL8Kf3G5c6DY1t
         4+5W2lLyuneut30txEk0W17j4OJVktgb/quU7ZyJ+Owdb3bXI/o9qeib5PvzuHAhIFZb
         mXsE2hsLgIcLSRn7r/8AWjSwEEKN89vpkmBwjuo4UxUx8yuxIpyMtpVvrreogiKqfwAh
         thctvtTk8Tb6yH3JBWlunYVgbQr2FTU+7vtHpDw7Sfkt8TMC4ieo9QqRsW5W6CysUoJU
         14og9n1Ap1SDGuK+NoWUEcXGWyPH7QSqr3bWSrPoIpwO6eNVC8blkXoKfm2ah61INu85
         uV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+Jg3oYjYPhlt3pP3rA+Wq6ivbf9LPTqafp8/8ynRmA=;
        b=UMXJb0u6GLMEeUbQnOIOUyblT14jYv/UEyUXnTW5989COHpbua3OpsqonFa7OFIDju
         8KD2yHSW9Z4fQwoBTMU6azWqO51dUtL47PpofuDDrd+mJ7hCBnFO+cf0yR02s7w0tYPf
         BszKu6M7349bPbDd+2uu6qj/VjlfCp5xWJEirx0TccNqp3wsWlt9clydrZI2Y88EXujf
         VCvaeMsOmqSLH+dPqNDak20KyzmjjLJqyHcuhTiUkS4vKy8j0pDMiE3ScicXen0rrs1p
         pMW9TRV+DSc4hwi1LAExNAhQyUSY/qSVig97cqD/DRNOF4tbTadUGPhzDdaShO+oE53z
         12uQ==
X-Gm-Message-State: APjAAAWT87H4ixeLkHprzhbS5xuGup4kX9ZdxY4iRI0vl9rVfpjruy65
        /qDm2LbxHIHGGvhvvQfv0ESoKqU1lrKuUGMq046O8g==
X-Google-Smtp-Source: APXvYqx1VVsPuxDNq7h5DVZ64q2HR55kXOIntYw2CUb1UyIz/XuetWNKZnyJ+eF+wiPqYfbS2Vc9HN4we2qFRged1JM=
X-Received: by 2002:aca:b187:: with SMTP id a129mr7775530oif.175.1581009382423;
 Thu, 06 Feb 2020 09:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20200128072740.21272-1-frextrite@gmail.com> <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable> <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable> <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
 <20200206013251.GC55522@google.com> <CAG48ez2+7L8YwejaLcm5MN7Z2DZ4d4H5CV6cUyo+j5S9b=tAtQ@mail.gmail.com>
 <20200206164938.GD55522@google.com>
In-Reply-To: <20200206164938.GD55522@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Feb 2020 18:15:56 +0100
Message-ID: <CAG48ez26b54UpPhrTn=HGtyPd+fWeVHE5rq37Ots95i8gemTVQ@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 5:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Thu, Feb 06, 2020 at 12:28:42PM +0100, Jann Horn wrote:
> [snip]
> > > > > > > > task_struct.cred doesn't actually have RCU semantics though, see
> > > > > > > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > > > > > > it would probably be more correct to remove the __rcu annotation?
> > > > > > >
> > > > > > > Hi Jann,
> > > > > > >
> > > > > > > I went through the commit you mentioned. If I understand it correctly,
> > > > > > > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > > > > > > flag was introduced, which determined if the clean-up should wait for
> > > > > > > RCU grace-periods or not. And since, the changes were 'thread local'
> > > > > > > there was no need to wait for an entire RCU GP to elapse.
> > > > > >
> > > > > > Yeah.
> > > > > >
> > > > > > > The commit too, as you said, mentions the removal of __rcu annotation.
> > > > > > > However, simply removing the annotation won't work, as there are quite a
> > > > > > > few instances where RCU primitives are used. Even get_current_cred()
> > > > > > > uses RCU APIs to get a reference to ->cred.
> > > > > >
> > > > > > Luckily, there aren't too many places that directly access ->cred,
> > > > > > since luckily there are helper functions like get_current_cred() that
> > > > > > will do it for you. Grepping through the kernel, I see:
> > > > [...]
> > > > > > So actually, the number of places that already don't use RCU accessors
> > > > > > is much higher than the number of places that use them.
> > > > > >
> > > > > > > So, currently, maybe we
> > > > > > > should continue to use RCU APIs and leave the __rcu annotation in?
> > > > > > > (Until someone who takes it on himself to remove __rcu annotation and
> > > > > > > fix all the instances). Does that sound good? Or do you want me to
> > > > > > > remove __rcu annotation and get the process started?
> > > > > >
> > > > > > I don't think it's a good idea to add more uses of RCU APIs for
> > > > > > ->cred; you shouldn't "fix" warnings by making the code more wrong.
> > > > > >
> > > > > > If you want to fix this, I think it would be relatively easy to fix
> > > > > > this properly - as far as I can tell, there are only seven places that
> > > > > > you'll have to change, although you may have to split it up into three
> > > > > > patches.
> > > > >
> > > > > Thank you for the detailed analysis. I'll try my best and send you a
> > > > > patch.
> > >
> > > Amol, Jann, if I understand the discussion correctly, objects ->cred
> > > point (the subjective creds) are never (or never need to be) RCU-managed.
> > > This makes sense in light of the commit Jann pointed out
> > > (d7852fbd0f0423937fa287a598bfde188bb68c22).
[...]
> > > 3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
> > >    which places that task-synchronously use ->cred can overwrite. Callers
> > >    doing such accesses like access() can use this API instead.
> >
> > That's wrong, don't do that.
> >
> > ->cred is a reference without RCU semantics, ->real_cred is a
> > reference with RCU semantics. If there have never been any references
> > with RCU semantics to a specific instance of struct cred, then that
> > instance can indeed be freed without an RCU grace period. But it would
> > be possible for some filesystem code to take a reference to
> > current->cred, and assign it to some pointer with RCU semantics
> > somewhere, then drop that reference with put_cred() immediately before
> > you reach put_cred_non_rcu(); with the result that despite using
> > put_cred(), the other side doesn't get RCU semantics.
> >
> > Just leave the whole ->non_rcu thing exactly as it was.
>
> Can you point to an example in the kernel that actually uses ->cred this way?
> I'm just curious. That is, reads task's ->cred pointer, and assigns it to an
> RCU managed pointer?

I'm almost sure that there are no such cases at the moment. However,
from a maintainability standpoint, I'm still very twitchy about this
change; the current API encapsulates the RCU weirdness in the standard
helper functions, but with your proposal, suddenly taking f_cred from
somewhere and using it as a new task's subjective creds, or something
like that, would be unsafe.

> I think such an example would be the point that the commit you mentioned
> addresses. The commit basically says "as long as nobody does get_cred() on
> the task_struct ->cred, we are good, but if somebody does do it, then we have
> to deferred-free it".  But I could not find such an example.
>
> That said, I agree the removal of non_rcu can be considered out of scope for
> this patch.
