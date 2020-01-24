Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F49C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2620718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eARPA8yF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAXU4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:56:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44001 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgAXU4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:56:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id dc19so3952936edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4ZdmmJJv8GfnBEMbf9uXBjOiPRB0YjA/HBRBr4CfsY=;
        b=eARPA8yF6JojNtxks+7zAry63ilMHt6B62RxCWkHQPk+LAK0bg9r5sF7nKBxSW7JXI
         piU8JAHpc9IbRfdAEu9R1ZZOMCSk/etFJKXI5sfi+Z7eMuKxEC1J9vhh2+bKJUCOVBhp
         94qla833CrD0v2mrmpOzdzDFsmoa6IJw7aCpHhhETvrhefVHBIWjIoLJ4Ta66dgN3/NV
         ub1az5wrQ1JwJM5U+N2HCH4R/X8wLZYpSmIErU0CWCtmUeAj7jQ9dLCbafCZWXMMwcl0
         SoN8VRSPzdSM6MiuUCei50N3luIOnz0fo8ep13wgKqFX2a4nRO/c6o3bbAoObqSNFClp
         Mfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4ZdmmJJv8GfnBEMbf9uXBjOiPRB0YjA/HBRBr4CfsY=;
        b=MlNuWPxT2NpisyVFiRYl/uHk+vWL75KVSruipjbhV3oreqg+gJVk60wTNh6x2Qw618
         FhijMJzdHo6lvJSYa+wnrM8q4QorO0C6aLO7eugokF5vp/F3oICNZYDBvRUNRPSIbinA
         FNXXsGdif0X5DwEtm+VMF/9DWgwME7dQvuRxkFACeY88RTSP/h9YLhS6lA/MlHjuMKND
         Hdhu8rij9BfOMGxyVjw8PruYiLqHmsTuwOe8ZT94nSgpWqXbRBNHohC8rZI8p3B80SFV
         YjHUX9Vy9EGYMxtpsjsYrqv8oqL1YNBjhXNCK3dZTxG2b062IBpzrxb6VB6V1TbwI0YA
         QIbQ==
X-Gm-Message-State: APjAAAVigb6bZvtS5qKwPi+6+XEgrGSQXlfzzwz/6T06l0UlHtckyii8
        rEVrm6k//LDZrWLsVY78U6ukOPhYC8Bd5VvjKkKyHQ==
X-Google-Smtp-Source: APXvYqzJix7ua+f4voOAuIBwKF8tdiKhxeyHGUvuWhroWMpq62yAOE+TDAE/tfeWiq+DsFpRGWPnWyt+yVVXFJvF/Cc=
X-Received: by 2002:aa7:c402:: with SMTP id j2mr4356509edq.51.1579899367037;
 Fri, 24 Jan 2020 12:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20200124002811.228334-1-wvw@google.com> <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com> <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
 <20200124113050.i6ovkibcmutypm3q@e107158-lin>
In-Reply-To: <20200124113050.i6ovkibcmutypm3q@e107158-lin>
From:   Wei Wang <wvw@google.com>
Date:   Fri, 24 Jan 2020 12:55:55 -0800
Message-ID: <CAGXk5yrTc2-k5oDjGyAwYn2KTroQy0JtEYQzSeOizjg_hyMGkg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
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

On Fri, Jan 24, 2020 at 3:30 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/24/20 11:01, Valentin Schneider wrote:
> > On 24/01/2020 09:51, Quentin Perret wrote:
> > >>> +static inline bool iowait_boosted(struct task_struct *p)
> > >>> +{
> > >>> + return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
> > >>
> > >> I think this is overloading the usage of util clamp. You're basically using
> > >> cpu.uclamp.min to temporarily switch iowait boost on/off.
> > >>
> > >> Isn't it better to add a new cgroup attribute to toggle this feature?
> > >>
> > >> The problem does seem generic enough and could benefit other battery-powered
> > >> devices outside of the Android world. I don't think the dependency on uclamp &&
> > >> energy model are necessary to solve this.
> > >
> > > I think using uclamp is not a bad idea here, but perhaps we could do
> > > things differently. As of today the iowait boost escapes the clamping
> > > mechanism, so one option would be to change that. That would let us set
> > > a low max clamp in the 'background' cgroup, which in turns would limit
> > > the frequency request for those tasks even if they're IO-intensive.
> > >
> >
> > So I'm pretty sure we *do* want tasks with the default clamps to get iowait
> > boost'd. What we don't want are background tasks driving up the frequency,
> > and that should be via uclamp.max (as Quentin is suggesting) rather than
> > uclamp.min (as is suggested in the patch).
> >
> > Now, whether that is overloading the usage of uclamp... I'm not sure.
> > One of the argument for uclamp was actually frequency selection, so if
> > we just make iowait boost respect that, IOW not boost further than
> > uclamp.max (which is a bit better than a simple on/off switch), that
> > wouldn't be too crazy I think.
>
> Capping iowait boost value in schedutil based on uclamp makes sense indeed.
>
> What didn't make sense to me is the use of uclamp as a switch to toggle iowait
> boost on/off.
>
> Cheers
>
> --
> Qais Yousef


Sounds like we all agree on adding a new toggle, so will move forward
with that then.
For capping iowait boost, it should be a seperate patch. I am not sure
if we want to apply what's the current max clamp on the rq but I do
see the per-task iowait boost makes sense.
