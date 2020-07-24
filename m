Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33467C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F52520709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="LGBa/mwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGXDW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGXDW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:22:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD874C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:22:25 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id b24so2522306uak.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 20:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvFWn/1JCosuktFTpXt71BPZd5GcGPpKpGz+xAWCarU=;
        b=LGBa/mwCnw7hgzeMQ1yOE4W3LBvHtBnCXxv2as5aZkYuE4RqRV/vLj2uJX63HFs0F/
         fa7muY3QhSIGQTSC36CVRF6GjJ0agjGwzbpUn1HdI0gvJyUW/elwi7I6C4V6bQow5xd4
         gVcXd+fDhD4cDECAxsJNiZ40XCWrQTQItFdL4EW+g9U/0o2O39bUGosRsNlCZOgk3EQo
         iAeLxxyeaXtgF48MZZsLSJONGHTC87K4eH+sa3OO0tpR700GXnHuxB74kfyQDGZxJe9h
         k2pmP/tpabqutJiE1vfraNfy6a9xFQIcuS+ZtNaBVahrMedLufCQ2HqscQOogJcRWfWP
         xqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvFWn/1JCosuktFTpXt71BPZd5GcGPpKpGz+xAWCarU=;
        b=hKCbJPiZTnG3glWmcbq0hxCc+WbQWCPufz5u2ehKJBoi+rWf8eSP76006vKw9zPoiX
         /o4ToV5DUhFSJM4ZXZd0/Hqyz2z7MWdB+F0lRzR7LYCJtqoEItQPEfOhi64rN1twweP4
         w7gVzoYjdlb//idsQkJn+UveNkiOa7HfEpPMRHmVAZSvgsXybp1dZZr2S1xKMqtMEIG5
         7CgXQgJxBxkDy3NpjkECexpFm13B4KFlYGNG3/rwyFimM0kHLvbHAOFSZ0C73Teo+sSx
         dUxRjz967lq735OVbDq1uClr6vppBRnTdI9b01lv9OATwlnwLbIGuLojUpCOPdXD0t6j
         hW4g==
X-Gm-Message-State: AOAM532izQ+/Y3PeupPN8kQ5B7MdiYWejO7cwglBpQgimst6pa79bIPk
        Dxe8V9YO8lFXkDqQDB/rsIaES9zsgk1N2cYUT6m3kg==
X-Google-Smtp-Source: ABdhPJzqKlfP56NY95KSCdGmlRatcL3kd19M+Z7t/LpLTqfaVTGFRmgBpwGiMv1Fn5SIu4odbJaG5M01/eMs+1eqAlM=
X-Received: by 2002:ab0:22cf:: with SMTP id z15mr6706030uam.52.1595560944996;
 Thu, 23 Jul 2020 20:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200722234538.166697-1-posk@posk.io> <20200722234538.166697-2-posk@posk.io>
 <20200723112757.GN5523@worktop.programming.kicks-ass.net> <CAFTs51UJhC9TmXkzz8VbDNmkSEyZE29=dRdUi65TDpSYqoK5vw@mail.gmail.com>
 <00ec99e0-2164-123e-44ed-229c52119d7e@redhat.com>
In-Reply-To: <00ec99e0-2164-123e-44ed-229c52119d7e@redhat.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 23 Jul 2020 20:22:14 -0700
Message-ID: <CAFTs51XVbZ4y5NrHrcfBBb5shrQRcX4y8SAjvm76T_=EbxDiYA@mail.gmail.com>
Subject: Re: [PATCH for 5.9 1/3] futex: introduce FUTEX_SWAP operation
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 8:00 PM Waiman Long <longman@redhat.com> wrote:
>
> On 7/23/20 8:25 PM, Peter Oskolkov wrote:
> > On Thu, Jul 23, 2020 at 4:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Thanks a lot for your comments, Peter! My answers below.
> >
> >> On Wed, Jul 22, 2020 at 04:45:36PM -0700, Peter Oskolkov wrote:
> >>> This patchset is the first step to open-source this work. As explained
> >>> in the linked pdf and video, SwitchTo API has three core operations: wait,
> >>> resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
> >>> that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
> >>> on top of which user-space threading libraries can be built.
> >> The PDF and video can go pound sand; you get to fully explain things
> >> here.
> > Will do. Should I expand the cover letter or the commit message? (I'll probably
> > split the first patch into two in the latter case).
>
> You should put it mostly in the commit message which will be part of the
> git log history. The cover letter, on the other hand, is not part of the
> git log.

Ack. (Networking/David Miller usually includes the cover letter in the
git log, so this
is context dependent, I guess).

>
>
> >
> >> What worries me is how FUTEX_SWAP would interact with the future
> >> FUTEX_LOCK / FUTEX_UNLOCK. When we implement pthread_mutex with those,
> >> there's very few WAIT/WAKE left.
> > [+cc Waiman Long]
> >
> > I've looked through the latest FUTEX_LOCK patchset I could find (
> > https://lore.kernel.org/patchwork/cover/772643/ and related), and it seems
> > that FUTEX_SWAP and FUTEX_LOCK/FUTEX_UNLOCK patchsets
> > address the same issue (slow wakeups) but for different use cases:
> >
> > FUTEX_LOCK/FUTEX_UNLOCK uses spinning and lock stealing to
> > improve futex wake/wait performance in high contention situations;
> > FUTEX_SWAP is designed to be used for fast context switching with
> > _no_ contention by design: the waker that is going to sleep, and the wakee
> > are using different futexes; the userspace will have a futex per thread/task,
> > and when needed the thread/task will either simply sleep on its futex,
> > or context switch (=FUTEX_SWAP) into a different thread/task.
>
> I agree that it is a different use case. I just hope that you keep the
> possible future extension to support FUTEX_LOCK/UNLOCK in mind so that
> they won't conflict with each other.

Ack. Will do. :)

Thanks,
Peter

>
> Cheers,
> Longman
>
