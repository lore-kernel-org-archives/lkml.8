Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29498C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC49C217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IZJsW0zY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFSIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:08:31 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44804 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:08:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id w8so5197964qts.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTs8wgYfod9EDeeOT5qAoSn8Dpf7YckZeXY0U9/3ciE=;
        b=IZJsW0zY0kjjUU/73e88/EBmqEKyvdTQals5hhotYge5FjZOAyJZJ9n4CA0gBPKUpX
         DXDYrQOXmlvqpnFRWU25EZQmAKd6tzW/qkFQST6f235pb0DvJ6oZuFbhlX3d/bvRmSxi
         Hw1Tqn1/KfYmGoSquXwBdTuZ4mBNSzPW1fwJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTs8wgYfod9EDeeOT5qAoSn8Dpf7YckZeXY0U9/3ciE=;
        b=tUVWQFpMTIDS9sc51gujA1TMOQYu3FwkYYXZDyUsVk/i02U5i7zIkAuMPfza7lScLq
         3BbY1v3RUXlf7KBTWdez+3MSHH6Vydp4GL8HJBS7n9KOdSu1Rgzgn6G53tuVZNmvT2QH
         DcjK4xBG5Cav6FjT4lYIs6m5mS3OuWzNBKLwoQE7EohNWsWc7WDT1bDZseEjVTzjcxR0
         xCoTw9IqsKYJEcgaDrvp/02RDPHiyu1+Fth0cq0VfI6UnEfysn0qBcn+/MrYayGD9qaK
         YVCrqIP3aMcffGg9G3OP7JtZkGmQ1OiGL2q0nss/nU8E+bsOZhqvnpBuCM7nDr9SNYaA
         qvKg==
X-Gm-Message-State: APjAAAXwcTaEy08p44WR/m8q+lyA6uKOafLPnEE6gqjwxnzs9KS4RpE6
        z3MEWSRCoi5os0w4sHTK/gvDoA==
X-Google-Smtp-Source: APXvYqzNFcs9A8AKnIMRsZeO0mKRnEprozd4KO/d66OgD/OZ3IJ/9gxLSuwf4YgwxYxjQwa6Bi5oxg==
X-Received: by 2002:ac8:4542:: with SMTP id z2mr3740785qtn.324.1581012509150;
        Thu, 06 Feb 2020 10:08:29 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j206sm24818qke.54.2020.02.06.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 10:08:28 -0800 (PST)
Date:   Thu, 6 Feb 2020 13:08:28 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jann Horn <jannh@google.com>
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
Subject: Re: [PATCH] cred: Use RCU primitives to access RCU pointers
Message-ID: <20200206180828.GA36876@google.com>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
 <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable>
 <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
 <20200206013251.GC55522@google.com>
 <CAG48ez2+7L8YwejaLcm5MN7Z2DZ4d4H5CV6cUyo+j5S9b=tAtQ@mail.gmail.com>
 <20200206164938.GD55522@google.com>
 <CAG48ez26b54UpPhrTn=HGtyPd+fWeVHE5rq37Ots95i8gemTVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez26b54UpPhrTn=HGtyPd+fWeVHE5rq37Ots95i8gemTVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 06:15:56PM +0100, Jann Horn wrote:
> On Thu, Feb 6, 2020 at 5:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > On Thu, Feb 06, 2020 at 12:28:42PM +0100, Jann Horn wrote:
> > [snip]
> > > > > > > > > task_struct.cred doesn't actually have RCU semantics though, see
> > > > > > > > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > > > > > > > it would probably be more correct to remove the __rcu annotation?
> > > > > > > >
> > > > > > > > Hi Jann,
> > > > > > > >
> > > > > > > > I went through the commit you mentioned. If I understand it correctly,
> > > > > > > > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > > > > > > > flag was introduced, which determined if the clean-up should wait for
> > > > > > > > RCU grace-periods or not. And since, the changes were 'thread local'
> > > > > > > > there was no need to wait for an entire RCU GP to elapse.
> > > > > > >
> > > > > > > Yeah.
> > > > > > >
> > > > > > > > The commit too, as you said, mentions the removal of __rcu annotation.
> > > > > > > > However, simply removing the annotation won't work, as there are quite a
> > > > > > > > few instances where RCU primitives are used. Even get_current_cred()
> > > > > > > > uses RCU APIs to get a reference to ->cred.
> > > > > > >
> > > > > > > Luckily, there aren't too many places that directly access ->cred,
> > > > > > > since luckily there are helper functions like get_current_cred() that
> > > > > > > will do it for you. Grepping through the kernel, I see:
> > > > > [...]
> > > > > > > So actually, the number of places that already don't use RCU accessors
> > > > > > > is much higher than the number of places that use them.
> > > > > > >
> > > > > > > > So, currently, maybe we
> > > > > > > > should continue to use RCU APIs and leave the __rcu annotation in?
> > > > > > > > (Until someone who takes it on himself to remove __rcu annotation and
> > > > > > > > fix all the instances). Does that sound good? Or do you want me to
> > > > > > > > remove __rcu annotation and get the process started?
> > > > > > >
> > > > > > > I don't think it's a good idea to add more uses of RCU APIs for
> > > > > > > ->cred; you shouldn't "fix" warnings by making the code more wrong.
> > > > > > >
> > > > > > > If you want to fix this, I think it would be relatively easy to fix
> > > > > > > this properly - as far as I can tell, there are only seven places that
> > > > > > > you'll have to change, although you may have to split it up into three
> > > > > > > patches.
> > > > > >
> > > > > > Thank you for the detailed analysis. I'll try my best and send you a
> > > > > > patch.
> > > >
> > > > Amol, Jann, if I understand the discussion correctly, objects ->cred
> > > > point (the subjective creds) are never (or never need to be) RCU-managed.
> > > > This makes sense in light of the commit Jann pointed out
> > > > (d7852fbd0f0423937fa287a598bfde188bb68c22).
> [...]
> > > > 3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
> > > >    which places that task-synchronously use ->cred can overwrite. Callers
> > > >    doing such accesses like access() can use this API instead.
> > >
> > > That's wrong, don't do that.
> > >
> > > ->cred is a reference without RCU semantics, ->real_cred is a
> > > reference with RCU semantics. If there have never been any references
> > > with RCU semantics to a specific instance of struct cred, then that
> > > instance can indeed be freed without an RCU grace period. But it would
> > > be possible for some filesystem code to take a reference to
> > > current->cred, and assign it to some pointer with RCU semantics
> > > somewhere, then drop that reference with put_cred() immediately before
> > > you reach put_cred_non_rcu(); with the result that despite using
> > > put_cred(), the other side doesn't get RCU semantics.
> > >
> > > Just leave the whole ->non_rcu thing exactly as it was.
> >
> > Can you point to an example in the kernel that actually uses ->cred this way?
> > I'm just curious. That is, reads task's ->cred pointer, and assigns it to an
> > RCU managed pointer?
> 
> I'm almost sure that there are no such cases at the moment. However,
> from a maintainability standpoint, I'm still very twitchy about this
> change; the current API encapsulates the RCU weirdness in the standard
> helper functions, but with your proposal, suddenly taking f_cred from
> somewhere and using it as a new task's subjective creds, or something
> like that, would be unsafe.

I agree with you. I talked to Amol and he will remove that part of the diff
when he sends patches. I believe he needs to also split into separate patches
as needed.

thanks,

 - Joel

