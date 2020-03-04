Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAAEC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC69217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMlNxvw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgCDRv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:51:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45760 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgCDRv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:51:56 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so3000794ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNmYTdVs4qTjcpOHaFCDG9lMzg7DV7Ms/v+9XIwuIGE=;
        b=FMlNxvw/mFoSTw4SFRsvhdq3n0NJd7joqeCVB8hSW9MH702maqdyhG7vBvZoPpQEKZ
         FxN77FB5CXo1240CRzIeXmjrsKrBvGKUK+y1DPbYyaBUS4NZu0C8UgTUpHUQpyYDxyIO
         6s5anltgnr5LLC32sSdbs+3EyFHfdcpKecr/EkQLzhYbe7sb/+Otne90NvP4tl1tcjbN
         ecvP5dVsm8y5PeHltE5m8Vv94538RDX5+wnTpfhvjIc07xOz6LtnQpXdeqXga5USobwT
         ffyiLCmrSEpQop7/sY3mwMUgjTqNQozipfI8mOxfYI0J6gE8UUITGqozsYTBDV4VYf2y
         UIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNmYTdVs4qTjcpOHaFCDG9lMzg7DV7Ms/v+9XIwuIGE=;
        b=Xy14ItDMZv37gmUZkr5+W9ecs6NWYrWFFM+paSejYW1RNxq+VukQDmsd09zx//JwJh
         iE7x40qWIhYqS3/nmowNmkmS1ZnVab2d4ar2u+nf98PAKjQrDbNCM+LusdFeAxyJRyiu
         qofuuZKFLkCpci+iM1uqWMXyP/mH9SPWG/hQKX2D+EQ9PS/pueG3z+qvWwduBDkFzoQ4
         XPDEdF6W9JovckX7Jt2t/KGpUcjkB803k+oY5QfanlemzhhtXZK3PRlPV/PMcvqc5m7y
         tEGShsDi+OGp6x7qN/Os+4rl7iagM2UX/WNQwCE4Kvj1K7rkRW3HbGpiS6WJf/mLbmFR
         NLIg==
X-Gm-Message-State: ANhLgQ2JtdRT9jqVskaf3SVoxWtPEzGW4dvS5czTxtFVzHOHaNguli4b
        rJQE6vOJ//PzsmYvSw+eGOT8A9U9jyMjtab26XnwMQ==
X-Google-Smtp-Source: ADFU+vsUgyA3UCGqyesBJodj5MscfXKA1VAFFpM6BJWm6LZ6Cz9Do1bAKP/ze4i8UZqbPehm+0Da/Hi8vr2sOPZWEgY=
X-Received: by 2002:a2e:5850:: with SMTP id x16mr2498122ljd.209.1583344313497;
 Wed, 04 Mar 2020 09:51:53 -0800 (PST)
MIME-Version: 1.0
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com> <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com> <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com> <20200228163545.GA18662@vingu-book>
 <be45b190-d96c-1893-3ef0-f574eb595256@de.ibm.com> <49a2ebb7-c80b-9e2b-4482-7f9ff938417d@de.ibm.com>
 <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com> <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com> <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
In-Reply-To: <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Mar 2020 18:51:42 +0100
Message-ID: <CAKfTPtCAZ7r+Wra4mogLd+=GVo_71dtUbpPieRyoCU3dHXQa6g@mail.gmail.com>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380 enqueue_task_fair+0x328/0x440
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 at 18:42, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
>
>
> On 04.03.20 16:26, Vincent Guittot wrote:
> > On Tue, 3 Mar 2020 at 08:55, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >>
> >> On Tue, 3 Mar 2020 at 08:37, Christian Borntraeger
> >> <borntraeger@de.ibm.com> wrote:
> >>>
> >>>
> >>>
> > [...]
> >>>>>> ---
> >>>>>>  kernel/sched/fair.c | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>>> index 3c8a379c357e..beb773c23e7d 100644
> >>>>>> --- a/kernel/sched/fair.c
> >>>>>> +++ b/kernel/sched/fair.c
> >>>>>> @@ -4035,8 +4035,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >>>>>>             __enqueue_entity(cfs_rq, se);
> >>>>>>     se->on_rq = 1;
> >>>>>>
> >>>>>> +   list_add_leaf_cfs_rq(cfs_rq);
> >>>>>>     if (cfs_rq->nr_running == 1) {
> >>>>>> -           list_add_leaf_cfs_rq(cfs_rq);
> >>>>>>             check_enqueue_throttle(cfs_rq);
> >>>>>>     }
> >>>>>>  }
> >>>>>
> >>>>> Now running for 3 hours. I have not seen the issue yet. I can tell tomorrow if this fixes
> >>>>> the issue.
> >>>>
> >>>>
> >>>> Still running fine. I can tell for sure tomorrow, but I have the impression that this makes the
> >>>> WARN_ON go away.
> >>>
> >>> So I guess this change "fixed" the issue. If you want me to test additional patches, let me know.
> >>
> >> Thanks for the test. For now, I don't have any other patch to test. I
> >> have to look more deeply how the situation happens.
> >> I will let you know if I have other patch to test
> >
> > So I haven't been able to figure out how we reach this situation yet.
> > In the meantime I'm going to make a clean patch with the fix above.
> >
> > Is it ok if I add a reported -by and a tested-by you ?
>
> Sure-
> I just realized that this system has something special. Some month ago I created 2 slices
> $ head /etc/systemd/system/*.slice
> ==> /etc/systemd/system/machine-production.slice <==
> [Unit]
> Description=VM production
> Before=slices.target
> Wants=machine.slice
> [Slice]
> CPUQuota=2000%
> CPUWeight=1000
>
> ==> /etc/systemd/system/machine-test.slice <==
> [Unit]
> Description=VM production
> Before=slices.target
> Wants=machine.slice
> [Slice]
> CPUQuota=300%
> CPUWeight=100
>
>
> And the guests are then put into these slices. that also means that this test will never use more than the 2300%.
> No matter how much CPUs the system has.

Thanks for the information, I will try to see how this could impact the enqueue

>
