Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C332C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DF0214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMNJk8Mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBFNKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:10:06 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40802 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBFNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:10:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id 12so2531797pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y4Pa1L5RARQgqvzqz59p+CvaGETvYZ1UCLM+Mc5CN84=;
        b=vMNJk8MfX7MLWGNRzhL/SmImsM+kmBcpOPmAlsdIRKsmSKG9yfmkajIS9O6Xs7iTOD
         RO807KsIZSZff/TYq/lxeYvIlIpfghegRdOIXk/DMH0+m6y2h/fWmV//y6lYeqJt2KYG
         NGYhXSrpFHYZSQHsLhr3mGaY8V6OpaloCpHlnVWoXcEnENl+7tSyuG8Za5tuXyu8btMZ
         JWhcJGT/zZNQq62O/S/Ih3VI/eB7g+z7yEhuddQ9JwTP3f3xVx7nIK1JSMD3lQicJ/Oc
         /ATPSFnPEhtn6Rk8+slgmgP2zgBQKiZVe6Xv2E8m/6loSQDTtQj/PRpibC8VCpff2+Bs
         DoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y4Pa1L5RARQgqvzqz59p+CvaGETvYZ1UCLM+Mc5CN84=;
        b=rKVI+j7xPNY2PxOLbdejNLdfaTdyKM3b06bslPaawa7ev9CJU5zRbj9Pr3YVqhEHDK
         Vs6VqgjuUwKPzbvXhqy27JtOT2Y0E3PkNvd9m784qeA2GLCFOEA9pozr1s0fqqhoXHiE
         Zu4u1u+LIq3Y9F4kSsAqm8gVPAcDOM5tCCXeNbTQl72F4PTHS2ZPU7lu+UFh67MQxfXe
         UfMySum+x9dtJW1N56cL7SZeKhoPQ2ZuyMVzG2/0+s/BShXpet3QMKVoobyp9xYtx6wx
         o2QZOOOpJkhYGBYTrSINJuEIbyHLnxAM6D0Fy77XwqGSFW0OdTF66MfzJuFkYh4n6I5i
         ItpA==
X-Gm-Message-State: APjAAAXJv7CYLMN8aBz++e8SlFFiAUTLbEHJ9XKKEV5UHWecRVFStyXT
        7yJsNBIqCvJb4n8AMcvJza8=
X-Google-Smtp-Source: APXvYqwxOLxWA1l6OErju8aIUZL86BPGQWlMbFRKo5hSrHBWS6v4iWDEq2Kdys62jBSDVrAnzH+DbQ==
X-Received: by 2002:a17:902:9f88:: with SMTP id g8mr3709690plq.100.1580994603439;
        Thu, 06 Feb 2020 05:10:03 -0800 (PST)
Received: from workstation-portable ([103.211.17.39])
        by smtp.gmail.com with ESMTPSA id t15sm2370459pgr.60.2020.02.06.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:10:02 -0800 (PST)
Date:   Thu, 6 Feb 2020 18:39:55 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
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
Message-ID: <20200206130955.GA3917@workstation-portable>
References: <20200128072740.21272-1-frextrite@gmail.com>
 <CAG48ez3ZcO+kVPJVG6XpCPyGUKF2o4UJ6AVdgZXGQ6XJJpcdmg@mail.gmail.com>
 <20200128170426.GA10277@workstation-portable>
 <CAG48ez3bLC3dzXn7Ep0YmBENg7wp6TMrocGa6q2RLtYoOdUSxg@mail.gmail.com>
 <20200129065738.GA17486@workstation-portable>
 <CAG48ez2Yc-J1gV4=sTMizySmeFkiZGU+j1NTnZaqyPPo1mYQ=Q@mail.gmail.com>
 <20200206013251.GC55522@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206013251.GC55522@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:32:51PM -0500, Joel Fernandes wrote:
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
> 2. Remove __rcu from task_struct ->cred
> 3. Also I removed the whole non_rcu flag, and introduced a new put_cred_non_rcu() API
>    which places that task-synchronously use ->cred can overwrite. Callers
>    doing such accesses like access() can use this API instead.
> 
> I have only build tested the below diff and it is likely buggy but Amol you
> can use it as a starting point, or we can discuss more on this thread.
> 

Thank you for starting this Joel! This will make our lives easier! I'll
go through it once and get back to Jann's latest reply.

Thanks
Amol
