Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EF6C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790852064A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajkpcdKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgBYNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:41:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36513 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgBYNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:41:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so9803832lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2eUbbm1oRy7OOPHOrmqua/Spxc0JbIrywqKutB/I+kY=;
        b=ajkpcdKIqqASbCxtUHfVVEMguuuwpNuwBQJG/BVEghYERm6E5sS3zxY+NYCQWcYogy
         jio4xa5PAnXbjUB8deWMMTV427VkoUn9HJ4p6LhBILYawIlw9upEVcgCQ0uDbirScgBm
         4MeIXWOWYdIqzvEF4Lgo+HFrrpduGyAwvFHNDrU9wfJKAZQvURj8Kjdso86hqTk38+e7
         o+9sjJDVEPzjbWjUo5MoOnLOiPsPScKMi4xVDvbvGmcMNzKijDVgCr5SLRv259ZOM9De
         O0ZBvphKRKv/EnhJvynw2Y1oAxIVIyaOHovF/Ve/uwAhQ1bfY2Jsrjt05T3av/9sx7Fj
         DqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eUbbm1oRy7OOPHOrmqua/Spxc0JbIrywqKutB/I+kY=;
        b=U81fzdV4rC3859oGC5pxDW1HLstZRvCMpcASJ5818vz4AJ5BfSMF1VxyKdRQLivQv5
         CPErcOsLsxeHe3ioEw4WqdPinfmrqVQDzUSELSLXRheuBjEDp47x9ibi1rDhQKtt/j44
         Zo2JhjZNxmP+6RtdC7NlDn3S3s6tS0a5ITStf+I2xt4TZRyu08yr6Hbq8xEBuUHezqbf
         BSTvDlsfpGyJQlKXfV1v1clfYwhUZwpSdzTkudb7j+kHEhcQ9pP2shVF+uSzgETXbDG+
         QzF3Y5qhZvZiKMmLD2u8o9MaQNYpVdIGAVQtymCGFaxzod8sa9PByqyalmB9jqzrR9Ck
         AjHg==
X-Gm-Message-State: APjAAAUFmIatGZ7iCQDkpcSiCCkz2YTaDNcc6fkxUPu7QZKI8aUzwUEk
        XJq6mypzybTcjQHd5+I84+D7ZLHx3RFHR4S41IQ=
X-Google-Smtp-Source: APXvYqw1BxRtaMIA6ShrJOOEqwYyqUtOuDec5qab6qX/YCYoj8+0RM1YLKuwGUlhX3VBnoIS+jLXYmAtGAeofrenTK8=
X-Received: by 2002:ac2:5339:: with SMTP id f25mr2246977lfh.84.1582638100610;
 Tue, 25 Feb 2020 05:41:40 -0800 (PST)
MIME-Version: 1.0
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
 <20200225073446.GA618392@ziqianlu-desktop.localdomain> <CAERHkrtraNqWj+RZnUFBaR8Cxk_cprQnzyKEgZ=6K+1mb1Jifw@mail.gmail.com>
 <20200225112153.GA618752@ziqianlu-desktop.localdomain>
In-Reply-To: <20200225112153.GA618752@ziqianlu-desktop.localdomain>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 25 Feb 2020 21:41:28 +0800
Message-ID: <CAERHkrsNYnJOdhb1ecgwXHfWMNEU5CkS7CcuS-X9Wo6gE=KgHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 7:22 PM Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 06:40:02PM +0800, Aubrey Li wrote:
> > On Tue, Feb 25, 2020 at 3:34 PM Aaron Lu <aaron.lwe@gmail.com> wrote:
> > >
> > > On Tue, Feb 25, 2020 at 01:32:35PM +0800, Aubrey Li wrote:
> > > > Aaron - did you test this before? In other words, if you reset repo to your
> > > > last commit:
> > >
> > > I did this test only recently when I started to think if I can use
> > > coresched to boost main workload's performance in a colocated
> > > environment.
> > >
> > > >
> > > > - 5bd3c80 sched/fair : Wake up forced idle siblings if needed
> > > >
> > > > Does the problem remain? Just want to check if this is a regression
> > > >  introduced by the subsequent patchset.
> > >
> > > The problem isn't there with commit 5bd3c80 as the head, so yes, it
> > > looks like indeed a regression introduced by subsequent patchset.
> > >
> > > P.S. I will need to take a closer look if each cgA's task is running
> > > on a different core later but the cpu usage of cgA is back to 800% with
> > > commit 5bd3c80.
> >
> > Hmm..., I went through the subsequent patches, and I think this one
> >
> > - 4041eeb8f3 sched/fair: don't migrate task if cookie not match
> >
> > is probably the major cause, can you please revert this one to see
> > if the problem is gone?
>
> Yes, reverting this one fixed the problem.

okay, but this patch also contributed the improvement of a few benchmarks
on my side. So we need a way to fix your case, my quick thought is allowing
task migration in this case(sounds like a workaround). Need take a deep look
at CPU resource controlled code path when core scheduling enabled.

Any ideas?

Thanks,
-Aubrey
