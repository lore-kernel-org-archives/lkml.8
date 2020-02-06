Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6176C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55C218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="U4I19q1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBFQtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:49:42 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52929 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBFQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:49:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so214425pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F2D9TyKC428lbsn4cOSkHZILE4+aGh4V0YXpbG4yTNE=;
        b=U4I19q1PYKZgogEkFwqG/WZCgBsYOMFfbDIYFIVQJJ03KIP/ldqwtEwKxnpiu51/el
         ZpQP69wgGSBlgFvEW0v/o31/EwZg8bht11Yu9ENzxaMBARNyIrgHsMLoWJWH6ANVP+xl
         0ugwC1auDwF6n2+cy1JPmmSa3M1WXj+RSYeJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2D9TyKC428lbsn4cOSkHZILE4+aGh4V0YXpbG4yTNE=;
        b=fELWA7TvngDcdAFB82mhovZsJujsFzbCP01ZKuJfq6LETWd606WnaB85ngQ2rbN89Z
         TOdaY63wGFndvBfcZEKO4EGqAN9AK/t4QOxUQ9kVh1QhH7XtRChB9gHyW3t2WAjY6HQP
         O4qKGlPwhWPO40/DewZTzlYoG3DPH5XLowgZahohZYKGy8YwnqTf8gU53jPFnZXrj3wr
         /Z/Cn9aQc394k6BWAbCfCuUpnY1c/09m83CAA2rWxhDoHB8SbbFSKFy4V2A9gOqFKjL8
         O7ioCI3oe6y/R28uFjK4s5oEWel5JvI4cKCc2a4LKL8Y5EDZFT1q947JrzThSbYI4i3W
         4A4Q==
X-Gm-Message-State: APjAAAVwhQcxZlfue+xSmQh0X5+3h9AwiAwC63znueg+2qxf53OCzmkZ
        IbyOl8fnW3Ks9vJ0GmBZwAQJ1Q==
X-Google-Smtp-Source: APXvYqzI3O0gS5rpCI7xJ8epJrB+LE43OEPQuIGFwJhT965v8/YZdDbXHbqOWzlQFWeDeuNtumnyMg==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr5702550pjv.73.1581007780413;
        Thu, 06 Feb 2020 08:49:40 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j21sm3965775pji.13.2020.02.06.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 08:49:39 -0800 (PST)
Date:   Thu, 6 Feb 2020 11:49:38 -0500
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
Message-ID: <20200206164938.GD55522@google.com>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
 <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable>
 <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
 <20200206013251.GC55522@google.com>
 <CAG48ez2+7L8YwejaLcm5MN7Z2DZ4d4H5CV6cUyo+j5S9b=tAtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2+7L8YwejaLcm5MN7Z2DZ4d4H5CV6cUyo+j5S9b=tAtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:28:42PM +0100, Jann Horn wrote:
[snip]
> > > > > > > task_struct.cred doesn't actually have RCU semantics though, see
> > > > > > > commit d7852fbd0f0423937fa287a598bfde188bb68c22. For task_struct.cred,
> > > > > > > it would probably be more correct to remove the __rcu annotation?
> > > > > >
> > > > > > Hi Jann,
> > > > > >
> > > > > > I went through the commit you mentioned. If I understand it correctly,
> > > > > > ->cred was not being accessed concurrently (via RCU), hence, a non_rcu
> > > > > > flag was introduced, which determined if the clean-up should wait for
> > > > > > RCU grace-periods or not. And since, the changes were 'thread local'
> > > > > > there was no need to wait for an entire RCU GP to elapse.
> > > > >
> > > > > Yeah.
> > > > >
> > > > > > The commit too, as you said, mentions the removal of __rcu annotation.
> > > > > > However, simply removing the annotation won't work, as there are quite a
> > > > > > few instances where RCU primitives are used. Even get_current_cred()
> > > > > > uses RCU APIs to get a reference to ->cred.
> > > > >
> > > > > Luckily, there aren't too many places that directly access ->cred,
> > > > > since luckily there are helper functions like get_current_cred() that
> > > > > will do it for you. Grepping through the kernel, I see:
> > > [...]
> > > > > So actually, the number of places that already don't use RCU accessors
> > > > > is much higher than the number of places that use them.
> > > > >
> > > > > > So, currently, maybe we
> > > > > > should continue to use RCU APIs and leave the __rcu annotation in?
> > > > > > (Until someone who takes it on himself to remove __rcu annotation and
> > > > > > fix all the instances). Does that sound good? Or do you want me to
> > > > > > remove __rcu annotation and get the process started?
> > > > >
> > > > > I don't think it's a good idea to add more uses of RCU APIs for
> > > > > ->cred; you shouldn't "fix" warnings by making the code more wrong.
> > > > >
> > > > > If you want to fix this, I think it would be relatively easy to fix
> > > > > this properly - as far as I can tell, there are only seven places that
> > > > > you'll have to change, although you may have to split it up into three
> > > > > patches.
> > > >
> > > > Thank you for the detailed analysis. I'll try my best and send you a
> > > > patch.
> >
> > Amol, Jann, if I understand the discussion correctly, objects ->cred
> > point (the subjective creds) are never (or never need to be) RCU-managed.
> > This makes sense in light of the commit Jann pointed out
> > (d7852fbd0f0423937fa287a598bfde188bb68c22).
> >
> > How about the following diff as a starting point?
> >
> > 1. Remove all ->cred accessing happening through RCU primitive.
> 
> Sounds good.
> 
> > 2. Remove __rcu from task_struct ->cred
> 
> Sounds good.
> 
> > 3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
> >    which places that task-synchronously use ->cred can overwrite. Callers
> >    doing such accesses like access() can use this API instead.
> 
> That's wrong, don't do that.
> 
> ->cred is a reference without RCU semantics, ->real_cred is a
> reference with RCU semantics. If there have never been any references
> with RCU semantics to a specific instance of struct cred, then that
> instance can indeed be freed without an RCU grace period. But it would
> be possible for some filesystem code to take a reference to
> current->cred, and assign it to some pointer with RCU semantics
> somewhere, then drop that reference with put_cred() immediately before
> you reach put_cred_non_rcu(); with the result that despite using
> put_cred(), the other side doesn't get RCU semantics.
> 
> Just leave the whole ->non_rcu thing exactly as it was.

Can you point to an example in the kernel that actually uses ->cred this way?
I'm just curious. That is, reads task's ->cred pointer, and assigns it to an
RCU managed pointer?

I think such an example would be the point that the commit you mentioned
addresses. The commit basically says "as long as nobody does get_cred() on
the task_struct ->cred, we are good, but if somebody does do it, then we have
to deferred-free it".  But I could not find such an example.

That said, I agree the removal of non_rcu can be considered out of scope for
this patch.

thanks,

 - Joel

