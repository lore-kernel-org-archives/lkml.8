Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCABBC7657B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14EB24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpqIqnJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgB0Ohh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:37:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41185 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgB0Ohe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:37:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id y17so2250862lfe.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcYL8SCs4mY/P4RQdp+0RxyVx6nbM+UHppPJThzz0ak=;
        b=RpqIqnJz/hzb5sr/fE5lKqIxanX/QvNCaDDuyFXtqcMVjdJmqfAIsXUSQQwkCYrY/J
         FNSedxYoVKXzx0UlYS/StW2w9ICZ2mOLJB68NaR9xRZBfMu8gaeVUR2GcDDOmqcXRtFB
         k9jm2fQtwets6TkXYU9iQBlog0FBQhN4TGvjuwu+QaEQn52hK37CdRNI+wM/M+zNIud4
         lUSSYVuy00iLlo10Snm/MkRLdEbSWTcTjwYzdwCZf+zRO5AHzjLpsC0XDEoXPvuPhVXh
         NiDeopd7QdvzhvfdoF1Y0DcPtzyguWdzqJSiQnLBw2XYvnssYVz3U7Aql/1YHV2j9jf3
         mMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcYL8SCs4mY/P4RQdp+0RxyVx6nbM+UHppPJThzz0ak=;
        b=ncmhA8fATjn4+zBSSWT6keId1zLOZK2jIGnyvCYwvXujCTWr5oshieRsdK+Fq1xYtY
         V6wd6ia+HsHJ6uhjnF0QaPJ5cYDocvQkAdNQAWaVEW6lFKNLAIzyji4XSIGRB8veKgxD
         QLLlnzj3ALE8Gb7Vo97u5GNRGVvn2Ot6FQpMwUkAkhBtqa0JheTssXxYlAAZuvXe2dLg
         FUdFLVJ+PPNdYa5jqTIO5bel7GmFxZx3ysnpiTmXkoxVVPYvYdtS4QbgbRSAXJ+AkRjx
         iTuZyvQiuPpQI0GoCvvTe8XsXoqU35sOXCrZYP7mPwuugedwbbWH/r93/4hf8uN7iXKU
         iw2g==
X-Gm-Message-State: ANhLgQ3UvCQ4onfWGklTDbtkz75RkqfLHjq0h4JDBrDs17OiwYla3dDZ
        ceUqGU0ISyh/UlUgCY96tMSpGryxH0ZG0ST+eTw=
X-Google-Smtp-Source: ADFU+vuC3XzlRWFGpQwtS8g++F+CcBuYTPCc87hQgBEaxqKTAdOuHFeoURTMjbZnBKllPt5O1u3PZNDkA2G6uu5pTnA=
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr1848583lfe.23.1582814252239;
 Thu, 27 Feb 2020 06:37:32 -0800 (PST)
MIME-Version: 1.0
References: <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com> <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain> <20200227141032.GA30178@pauld.bos.csb>
In-Reply-To: <20200227141032.GA30178@pauld.bos.csb>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 27 Feb 2020 22:37:20 +0800
Message-ID: <CAERHkrtyAaEQqqMpV6HMKyHa47HNFwxs5peq4LQJem2z=DO1hg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Phil Auld <pauld@redhat.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:10 PM Phil Auld <pauld@redhat.com> wrote:
>
> Hi Aaron,
>
> On Thu, Feb 27, 2020 at 10:04:32AM +0800 Aaron Lu wrote:
> > On Tue, Feb 25, 2020 at 03:51:37PM -0500, Vineeth Remanan Pillai wrote:
> > > On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> > > > threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> > > > into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> > > > socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> > > > cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> > > > the real workload).
> > > >
> > > > I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> > >
> > > The expected behaviour could also be that 8 processes share 4 cores and
> > > 8 hw threads right? This is what we are seeing mostly
> >
> > I expect the 8 cgA tasks to spread on each core, instead of occupying
> > 4 cores/8 hw threads. If they stay on 4 cores/8 hw threads, than on the
> > core level, these cores' load would be much higher than other cores
> > which are running cgB's tasks, this doesn't look right to me.
> >
>
> I don't think that's a valid assumption, at least since the load balancer rework.
>
> The scheduler will be looking much more at the number of running task versus
> the group weight. So in this case 2 running tasks, 2 siblings at the core level
> will look fine. There will be no reason to migrate.

Can this be replicated?

>
> > I think the end result should be: each core has two tasks queued, one
> > cgA task and one cgB task(to maintain load balance on the core level).
> > The two tasks are queued on different hw thread, with cgA's task runs
> > most of the time on one thread and cgB's task being forced idle most
> > of the time on the other thread.
> >
>
> With the core scheduler that does not seem to be a desired outcome. I think
> grouping the 8 cgA tasks on the 8 cpus of 4 cores seems right.
>
Especially, if the load of cgA task + cgB task > cpu capacity, grouping cgA
tasks can avoid forced idle completely. Maintaining core level balance seems
not the best result. I guess that's why with core scheduler enabled we saw
10-20% improvement in some cases against the default core scheduler disabled.

Thanks,
-Aubrey
