Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFBBC2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AA4206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaDvjcGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgELPtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgELPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:49:46 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98D0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:49:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i68so11451756qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pK+4BJTjJjfcs5Luhl3I/0D6vtqlSzzqhFI0harskdY=;
        b=kaDvjcGevCgGbxVXAgEnCZsfj5UOf8oWOL7OfYa7+cQrQ4GBZFZNvB3N1g0jsvHHba
         AwbhmbLFaJS7OFfaqeo6muPspnUsP5MOLmVGvNIKhCLFncjkOMAxYAMtjK1w7ahqOIhC
         Z6c84ojmDWmqInRBsUrLZt9uHUXqvfhVWp5q9vkycCa3lMHutrDRyCuOzrqK3znuErx7
         SQwGtis/NK+0HqKA/dX7YV08OctGVGL7jiFeTyYSOUMjGAlRUZC39Nkt/AXkigZ9PLLc
         G0ro4+ocK/NY1X3wb7x2W9HDVliltVgQjrzb7QC9brkA0jPE4qE1a3UH5S1UXx05KTUH
         M1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pK+4BJTjJjfcs5Luhl3I/0D6vtqlSzzqhFI0harskdY=;
        b=O5+sASc6zTo2IioqWZYxRZedx6uiBqnEbzs1ZbR2OoB7q0wlGF4jTNm9TWcG7wLEu7
         aK7a84mNHDQviJdsThFMq3yUKKszl4SbdlSca2zAxOQXsBF2+JQ9r2GzdhjbSY0QXA58
         +jz2jw0D/1nCzasfb7neSrE7ft7vSYxS/pKuPMr+DfXSB8mnb6FbBbMXhLz/8H8MdC0j
         5OZ93CAcTEYweSDnekYRZ6vtI4Go3yWy67Sf+sbnHuB6XMDeleLmtLcEv9+aYjIlhjor
         BI+jXuUxIruid+XT6leF7aNrxFciDn9LZcyJ8f2e7OMabWGztA0sSmVnOUhFcIQ1Ti/A
         vUUQ==
X-Gm-Message-State: AOAM530cQoT6IfmxtMq1vbP2WimHtZ+cXKqB6yyjE3+EniEMC6YAT/Ye
        OZIxi1gPswgUreZQJZmpoiU+BrBCvckpWl/LK+q28SrI
X-Google-Smtp-Source: ABdhPJwIgpXmgCmWWESYLxeJ1HjN6UwWEz6IvBtfcgmPMm5bs3ZiBBqstYOlcwWmTphAhuGajF7bihfHxc98/8diw6w=
X-Received: by 2002:aed:2967:: with SMTP id s94mr7784274qtd.278.1589298583628;
 Tue, 12 May 2020 08:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200508111612.GA252673@google.com> <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com> <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com> <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com> <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
 <20200512135813.GA101124@google.com> <CAJZ5v0hN708uvurZ-3oo90qUJFw3=Eg0OmtTaOKXQgNPXhCkFg@mail.gmail.com>
 <20200512151120.GB101124@google.com> <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
In-Reply-To: <CAJZ5v0inoge=nWQtv-rU_ReQUMZA5w-PZXuSpHHj1UHn-S7aSA@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 12 May 2020 11:49:32 -0400
Message-ID: <CAJWu+oqVc16B8nf-317Yyf9befPsjBohfG=GOdoBZyuVz==bmQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:30 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
[...]
> > The end goal with GKI is the following: Google will release a single
> > binary kernel image (signed, etc etc) that all devices using a given
> > Android version will be required to use. That image is however going to
> > be only for the core of the kernel (no drivers or anything of the sort).
> > Vendors and OEMs, on their end, will be responsible to build and ship
> > GKI-compatible modules for their respective devices. So, Android devices
> > will eventually ship with a Google-issued GKI, plus a bunch of
> > vendor-provided modules loaded during boot.
>
> If that is the case, then I absolutely think that schedutil should be
> part of the GKI.
>
> Moreover, that would have been my opinion even if it had been modular
> in the first place.
>
> > This is a significant shift from the current model where vendors
> > completely own the kernel, and are largely free to use the kernel config
> > they want. Today, those who don't use schedutil are free to turn the
> > config off, for example.
>
> So why is this regarded as a good thing?
>
> > But GKI changes that. The 'core' GKI config is effectively imposed to
> > the entire ecosystem. As of now, because it is 'bool' we have no choice
> > but to compile schedutil in the core GKI as some (most) partners use it.
> > But as you can imagine, that is not the preferred option of those who
> > _don't_ use schedutil.
>
> OTOH, it may as well be an incentive for them to switch over and
> report problems with it that they see.
>
> I absolutely would like to make schedutil the clearly preferred option
> and IMO avoiding to use it, especially for non-technical reasons,
> should be clearly less attractive.

Also, does this series make it easier for vendors / oems / whoever to
carry out-of-tree schedutil hacks saying that's "Ok" because that's
not part of the core GKI? That would definitely be a bad thing to
encourage as well. schedutil should pretty much be considered a part
of the core GKI if the goal is to encourage everyone to move to it,
IMO.

- Joel
