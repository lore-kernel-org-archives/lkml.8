Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7589C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1E62075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 19:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oa94JIt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392242AbgAXTNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:13:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34383 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbgAXTNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 14:13:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id r18so3640881edl.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnshRx+yfJVL9rNOvojgRi7jn44CYdJG0KWpqXP4zPQ=;
        b=Oa94JIt5CKbuWnjPvbSVRCesgEW9ckySl83l9PgWm734fJW2xI/a4R8GiX9sQUosa1
         Akh31uBTvqxq9EtfFrLdlrP22Gb/k0LLypBBgu4QLVVmy1Sno1nqxI3UGREXMzQJ3iuA
         uVdVM2EQcNmv0jpSDIirPfZTQtMxmJlqGVNURO5Am9MTCoIYQAdLsmgDF/AdJXffDjus
         g8w6Lcvt6OF+QAGF9Hh4i/G+26lg3r/5tJsdyZMWtsPv4RhHens0kamZFmK4WvQPOE1b
         v0vhWkodgp9ZhxSCd1ioRsK7ihL8j7uttGuCiAPjemwZ01Iye+9skD5XcZrscNagWcsa
         Uh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnshRx+yfJVL9rNOvojgRi7jn44CYdJG0KWpqXP4zPQ=;
        b=s+E3BgPjjEQ6+Htx5o6kcIxAKvGkDPZO8uFhaYlbtwhpT8WGV8UYnPKZljGpMNaH6L
         ACD85qJPnBYR1wbIIggtE+kOFmPGoOLCnK6kYw1tIAlFKpZSMaUUoR14XHLp5UNVPDG2
         jRBqU67y3RoPqwuL+jZOYFQzv+rHrjTx+4DcYZMoLTmXUDzIdZNTd5DxPULsO5j54lSK
         kH6yvQ0ivjlweFH3+PRWFN9lz9QRr92JOVpjZR8X7xl91usLGxh4op063hpLeXCALEpa
         V88r5pPD5d5Y4vqnh9+JAZYHcl2rH5MWE9z4Ee91GqmmXmjH4eRFJhlSu3h4gvn6jcRp
         PI8A==
X-Gm-Message-State: APjAAAUoI6nlNEe4l5AihOOsomsQ9hueqSOJzHrJSHTqA3E9z2npWB08
        +1vckE6+E51gDXQTRfF/eYWxpIyGdsNKglxLubnmFw==
X-Google-Smtp-Source: APXvYqzGpON1aI0Lf+lLvktGOy8Ophajy9UFe0tazZYf/p9pmaYSV4PgsqxnDQnVSimg2RY8Ba3anholFuufP5c/sMI=
X-Received: by 2002:a50:ef1a:: with SMTP id m26mr3881337eds.289.1579893190505;
 Fri, 24 Jan 2020 11:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20200124002811.228334-1-wvw@google.com> <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com> <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
In-Reply-To: <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
From:   Wei Wang <wvw@google.com>
Date:   Fri, 24 Jan 2020 11:12:58 -0800
Message-ID: <CAGXk5yri3DjjDvJMaCiwcYkz7gmq2Pae4HHpfHf7zRV93kNsfQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Wei Wang <wei.vince.wang@gmail.com>, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 3:01 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 24/01/2020 09:51, Quentin Perret wrote:
> >>> +static inline bool iowait_boosted(struct task_struct *p)
> >>> +{
> >>> +   return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
> >>
> >> I think this is overloading the usage of util clamp. You're basically using
> >> cpu.uclamp.min to temporarily switch iowait boost on/off.
> >>
> >> Isn't it better to add a new cgroup attribute to toggle this feature?
> >>
> >> The problem does seem generic enough and could benefit other battery-powered
> >> devices outside of the Android world. I don't think the dependency on uclamp &&
> >> energy model are necessary to solve this.
> >
> > I think using uclamp is not a bad idea here, but perhaps we could do
> > things differently. As of today the iowait boost escapes the clamping
> > mechanism, so one option would be to change that. That would let us set
> > a low max clamp in the 'background' cgroup, which in turns would limit
> > the frequency request for those tasks even if they're IO-intensive.
> >

Something we see e.g. is f2fs's gc thread, and my thought on this is
instead of chasing everything down, it is a lot easier for us to only
boost what we know in foreground (and on Android we sort of have that
information on hand from framework).
I was hesitant to introduce a new switch ( e.g. Android's older EAS
kernel prefer_idle toggle ) but would be happy to do that if someone
supports that idea.

>
>
>
> So I'm pretty sure we *do* want tasks with the default clamps to get iowait
> boost'd. What we don't want are background tasks driving up the frequency,
> and that should be via uclamp.max (as Quentin is suggesting) rather than
> uclamp.min (as is suggested in the patch).
>
> Now, whether that is overloading the usage of uclamp... I'm not sure.
> One of the argument for uclamp was actually frequency selection, so if
> we just make iowait boost respect that, IOW not boost further than
> uclamp.max (which is a bit better than a simple on/off switch), that
> wouldn't be too crazy I think.
>
>
> > That'll have to be done at the RQ level, but figuring out what's the
> > current max clamp on the rq should be doable from sugov I think.
> >
> > Wei: would that work for your use case ?
> >
> > Also, the iowait boost really should be per-task and not per-cpu, so it
> > can be taken into account during wake-up balance on big.LITTLE. That
> > might also help on SMP if a task doing a lot of IO migrates, as the
> > boost would migrate with it. But that's perhaps for later ...
> >
> > Thanks,
> > Quentin
> >
