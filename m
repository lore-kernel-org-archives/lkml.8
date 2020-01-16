Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ABC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E8420663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcdKzD+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgAPFZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:25:58 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:37524 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAPFZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:25:58 -0500
Received: by mail-qv1-f42.google.com with SMTP id f16so8542789qvi.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYX0BPmMVMS3NYWlJclzYjEP/4D7HzUZkwyReRhJkmo=;
        b=BcdKzD+B8Di6jTXnjAjeRnImJGmnncEWUnTwNRRiviDEwWhn5tMYnSQmm6A8mX524U
         eSZTZvQkWsAo+icQ0LsVRBfhWflqnnsTOwLW29gJvPBbwyJNUskx6jVdSw/zn/VBCePB
         b/qfH9AHuwCHAm8XlECRilwH887czgJ8SzBp4nB9U3qS5JAdUSJFXSctny8s9UQsi9dq
         3Uaoo0hOmPawxxzBCO5Yuiw5ITGBrxyE7/wQelFA1pliiPFX819bW51U7cXWWEie2UTs
         1OpkQvC7edz2NP1aYotGeRV9Iyb76Nkeihd+AYEDEly5Tk6YOeMOnVww9o6tIrdTOjvw
         h4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYX0BPmMVMS3NYWlJclzYjEP/4D7HzUZkwyReRhJkmo=;
        b=nkN7GFF5PVcznY+3j5SsVAetzMLOPskAgNyfNwqK4h1zFb9FRZijYcQL3EQQWudBri
         Vky81YdKvWxshgXPuXuBmKfR+cEMdb5VL05qDgqdA5FQAETfRi0EmhP3yDbse7aL/OPZ
         U5GtdOyXfyrhlzMRPIA9EQvPGn+/diwOBBwkdOBXX7zfSr11ji3HCiQ9RCC339i3mjFe
         zmAByULfYar8uyULI7T1lNQkwco3jLNBzVtQK/0jDTmuW5sWXJhsQmITV8rlSk4HE+N5
         R4lOhG0a/j35cEw9VMh70+ZJfHifjTZQ78M9MmjWvYVACGGcqEgv6o/8rDq2W2t/xMTG
         GEsw==
X-Gm-Message-State: APjAAAUVJOnTyeaVPUFx0LV/WdxlNlP0Q8FCPW4/hP4F6bx4esqFVtqJ
        SBW2BhjuZ4jb1nLRYsczf/pmSqdL96tzRasD53ba4Q==
X-Google-Smtp-Source: APXvYqwHXjnxYNo6RxvmuABUiF05pNFJciA91ELXwmqWNMLiIdiIzZN4SqLMsXgYAQ3oAs2cOCIgxBoEuxJS4xLPLaY=
X-Received: by 2002:ad4:4810:: with SMTP id g16mr902068qvy.22.1579152357166;
 Wed, 15 Jan 2020 21:25:57 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
 <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com> <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
In-Reply-To: <CAM_iQpVtcNFeEtW15z_nZoyC1Q-_pCq+UfZ4vYBB3Lb2CMm4Mg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 06:25:46 +0100
Message-ID: <CACT4Y+YuM55YUT37jwRP163J7ha25cN03sZ5WqTUPkz3e43Ggw@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Taehee Yoo <ap420073@gmail.com>,
        syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:53 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > +Taehee, Cong,
> >
> > In the other thread Taehee mentioned the creation of dynamic keys for
> > net devices that was added recently and that they are subject to some
> > limits.
> > syzkaller creates lots of net devices for isolation (several dozens
> > per test process, but then these can be created and destroyed
> > periodically). I wonder if it's the root cause of the lockdep limits
> > problems?
>
> Very possibly. In current code base, there are 4 lockdep keys
> per netdev:
>
>         struct lock_class_key   qdisc_tx_busylock_key;
>         struct lock_class_key   qdisc_running_key;
>         struct lock_class_key   qdisc_xmit_lock_key;
>         struct lock_class_key   addr_list_lock_key;
>
> so the number of lockdep keys is at least 4x number of network
> devices.

And these are not freed/reused, right? So with dynamic keys LOCKDEP
inherently can't handle prolonged running, only O(1) work?


> I think only addr_list_lock_key is necessary as it has a nested
> locking use case, all the rest are not. Taehee, do you agree?
>
> I plan to remove at least qdisc_xmit_lock_key for net-next
> after the fix for net gets merged.
