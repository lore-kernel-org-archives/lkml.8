Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A1DC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF97C206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a72v2Ahl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgEKPDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:03:11 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F9AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:03:10 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id c124so15122008oib.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7qV0qj2vY3QMnSRpzrXrBmdMrKIn2fose2w49TIcUwA=;
        b=a72v2AhlK0RMWvywkFLjZmfhzZvIhJmPEoTvBRAk/SnK/GdMXVYpYNlhlUjfan9HTI
         AYtNSsKZ6jFvdDP3utjWR5R1FanExkscDVG4oyyb4sjLyrHCghImpPzcEV6eLXWps7gE
         LW8KG+jisGg9a8JULKt2vAZ1gfNW/YVyhRCxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7qV0qj2vY3QMnSRpzrXrBmdMrKIn2fose2w49TIcUwA=;
        b=GHeue4DeMonQCgXw/Q0V4GsIgNGs5Jo3Uhe6ZI/1XDv9K9XzqYWaPQDg6E/F5qUnem
         EOqPTIJZJpqDQWjshQt1JYR3tGf1wBQJjHjhb8zGoo7zB4n/AESt9qFovNl54BmSg38F
         dafXTPlA4llX0ouSeJLkindJFmAX5heJiqZaWLa7kOgiWyc+vtkGhccNcJX2U762F8h7
         ZP3JaZykQT3XoNkMPSXJPqo7Ytu1QvCYfwjAP4T8+f8SVjsgP/E0Q9/DCM0KGokUR/P5
         GRTTjrwOeI6Qa15XsIxOrMBJtzZ5DyAPI8PenCmmt7Rp4W6ewlGlWk3BeYi/ieLxBaQz
         jjDw==
X-Gm-Message-State: AGi0PuYrf/DESggcw0VH7rVZDYEzgBsHGhczXnseUdEbm5a8mtWRnQ+X
        DnsMqNc151PgoAaeB0WgZp8wZYxo1UFwihYyUVKneA==
X-Google-Smtp-Source: APiQypJyBxpFVBJJmxojQB9sRbIOUW8mGmPu1/0vDgQqL0jXLAatzNPx3bnAkXEfHiEEDH2+PiwShECoXmBHDelm2zs=
X-Received: by 2002:aca:52d5:: with SMTP id g204mr19998120oib.14.1589209389691;
 Mon, 11 May 2020 08:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204751.155488-1-lyude@redhat.com> <20200508204751.155488-2-lyude@redhat.com>
 <20200511144935.GD16815@mtj.duckdns.org>
In-Reply-To: <20200511144935.GD16815@mtj.duckdns.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 11 May 2020 17:02:58 +0200
Message-ID: <CAKMK7uFDp_9SWUtMOfKaSLu3FNq5w=HWDo9FOeRsD204eR327g@mail.gmail.com>
Subject: Re: [RFC v4 01/12] kthread: Add kthread_queue_flush_work()
To:     Tejun Heo <tj@kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Liang Chen <cl@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, May 08, 2020 at 04:46:51PM -0400, Lyude Paul wrote:
> > +bool kthread_queue_flush_work(struct kthread_work *work,
> > +                           struct kthread_flush_work *fwork);
> > +void __kthread_flush_work_fn(struct kthread_work *work);
>
> As an exposed interface, this doesn't seem great. What the user wants to say
> is "wait for the current instance of this guy" and the interface is asking
> them to queue an extra work item whose queueing return state should be
> checked and depending on that result wait on its internal completion.
>
> I'm skeptical this is a good idea in general given that unless you define
> "this instance" at the time of queueing the work item which is being
> waited-upon, there's no way to guarantee that the instance you're queueing
> the flush work item on is the instance you want unless the queuer is holding
> external synchronization which prevents the instance from running. That's a
> really confusing semantics to expose in the interface.
>
> What the above means is that the ordering that you want is only defined
> through your own locking and that maybe suggests that the sequencing should
> be implemented on that side too. It may be a bit more code but a sequence
> counter + wait queue might be the better solution here.

Aside from this, flush_$stuff interfaces are very easy to deadlock.
That's why e.g. flush_work() for normal workqueues has lockdep
annotations (lockdep doesn't see through wait/wake_up dependencies
without some help because cross-release didn't land for real). So I
think if we need something like this, it needs to be a lot more
explicit, and come with the right lockdep annotations.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
