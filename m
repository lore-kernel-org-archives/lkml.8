Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC591C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 754D720829
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599793525;
	bh=6dxg0/dP+dTaPbHXj01hi/DRAhMYMpwbXhFlK+Zr9MM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vxmVvQxVNXeIItrf/EhHDdvg/aSg2kG4kj20QThvBrF9X0Vp/D2yn0OvoGUSId0Lk
	 u1kdl7wX6rVzJuFDkhb8OxlYEWERH5cLWdklsExEIu/lro1LGvuWMIvcskxHHfVd8Z
	 +2dcyUHDnMEgRr+axkfOaMHHhqEqeMzthyX+X8D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgIKDFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:05:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52823 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:05:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id q9so3053023wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRvgh7xT8c341pFXvQMf59Y/vyKAqow7gzK3SkaD0gA=;
        b=o79YzdfLur5u+sxsKsXZRs2ChTE21mrR347nnRY8b25tSQjUQ7xmB7i3yRzv2oPa/C
         +oSyw3v8x1lo0zU2wCaYmfhPEc6R5BJ+76o5rM7EIdNFF06nI9CUhB4NfEq26BZJBVoS
         FbieYILSJyq9Wf22+cMUTB6m4KEmdfLitRPvHvy1jSkfczPVfMQz0TO4PYyWxYgPeR/q
         nvC9yC6IfBkKLAEhXbJrJnFIv3Ct3m7nDzBMBArKT4KlMOZ7r7MhzzegoPpFFpTQf0e1
         0DRE0ZKamHgY29yWDWz9JsFwUD0d0zSQPfiRVlFYu47zy2oy1XeqT+D7ahnZz5a9gmeJ
         IkPg==
X-Gm-Message-State: AOAM5334MGSwRQBUEl9Ei77MgC+3/NjAljRerPv5w2HihcbIkdk9nQKi
        rgkz26rirO0I3tpaMQqkw3Hj69Oz7roSfCDTqwE=
X-Google-Smtp-Source: ABdhPJyStEmlGUEtXywXUbOSoydCcgLWj59nbougouX9u8g/ctB3jl2feFzabMXJ+gzVF5vMGSZ3s1eAwYYnj52HHXc=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr2922917wmi.168.1599793521756;
 Thu, 10 Sep 2020 20:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104153.1672460-1-jolsa@kernel.org> <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
In-Reply-To: <20200910144744.GA1663813@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Sep 2020 12:05:10 +0900
Message-ID: <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix race in perf_mmap_close function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Wade Mealing <wmealing@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Sep 10, 2020 at 11:50 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Sep 10, 2020 at 10:48:02PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > >   _do_fork+0x83/0x3a0
> > >   __do_sys_wait4+0x83/0x90
> > >   __do_sys_clone+0x85/0xa0
> > >   do_syscall_64+0x5b/0x1e0
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >
> > > Using atomic decrease and check instead of separated calls.
> > > This fixes CVE-2020-14351.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/events/core.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 7ed5248f0445..29313cc54d9e 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -5903,8 +5903,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> > >                 mutex_unlock(&event->mmap_mutex);
> > >         }
> > >
> > > -       atomic_dec(&rb->mmap_count);
> > > -
> > >         if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > >                 goto out_put;
> >
> > But when it takes the goto, rb->mmap_count won't decrement anymore..
>
> event->mmap_count is per event, so if we have have race in here,
> 2 threads can go through with each event->mmap_count reaching zero

Maybe I'm missing something.

But as far as I can see, perf_mmap_close() always decremented both
rb->mmap_count and event->mmap_count.  But with this change,
it seems not decrement rb->mmap_count when event->mmap_count
doesn't go to zero, right?

Thanks
Namhyung
