Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725CC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF18A2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIH2qv/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgAJBYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:24:14 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:36306 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbgAJBYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:24:14 -0500
Received: by mail-ot1-f45.google.com with SMTP id 19so431043otz.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 17:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p5CvVBITV/7iIb1FweihqnfezWv+H3UpbGbYpDE3BQ=;
        b=kIH2qv/O3jWeNzXQU8RaVvJM5gVeYQvPhTEDy3ZPyjeqIvkwJFbK7elYCnfjpBiHNw
         /TQCPU4EGepXMiOFIG/lDifQmo7iunKLhI2rD/8Vh8HWBra5JsFOYqGbgHVqPcwuOiED
         5LtHhAIclYGfc31yYSa8Ie0pWPB+MTusy3r5gt34nZ9nEFweueFxH0KH1cp6vPIdgTqQ
         C3eiQYj6wMqtLgIVAUFCQkyaS/bpEHst5ZUHA2JpqGYbQ0YYZ/BCK2nJEwFb3cslol68
         Lp6cOWkCsXehxKjAdX1daiIpjOXC1nT4HYvtF4ljq1CCGxg/VxBBHmco0c4G1Mhysn8s
         lxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p5CvVBITV/7iIb1FweihqnfezWv+H3UpbGbYpDE3BQ=;
        b=P+VDoguJdzYcSuzQdcJd5baPbfVNHndVbzSWXdana94LIhVUL5T8+naP/YhSX26xvq
         1f5mXnCHSKracCCh/vvH+a/ddiqS/f8Qovv2g96KGSNtowylN5O2O5xizE0qjI9O99tI
         YnvE4IqmqmOifEqCq7AdHRLbaYEKQNSwtb06lCy9CCPph77BAiiK4LNmq59BQsIe8Ot+
         EMIqMYrqovFHr4WKXC/FHVcQJRwWlD8Ntv/PstszmlRdNJffm0CV9FdTp8Iecj5Oyrn5
         RS/czm7Fb7DZLAyUq7/hDHE0XhJXXqNRD5RJ7odkiQXlRXf6QS5jDnGR7EbZPWDHOEBg
         Vnkw==
X-Gm-Message-State: APjAAAV6hkajF3+bsihaksJu/YL1JYlyhjaNiZaQWYzWrU0Ihk5JE5HM
        Nv29JxKtkHlmCkt+Cwb20acjFrFwozKXSy2+ibaG1w==
X-Google-Smtp-Source: APXvYqxc0snYfiF+IX/G27NrB4pKpPlSuIDaut4DKW6QITSOu0SuBFzdwYbgTJADgKbPtMgnZzhY2smDsV+8GcxufNo=
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr597097otn.191.1578619452866;
 Thu, 09 Jan 2020 17:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20200107204412.GA29562@amd> <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz> <20200109212516.GA23620@dhcp22.suse.cz> <20200109224845.GA1220@amd>
In-Reply-To: <20200109224845.GA1220@amd>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 Jan 2020 17:24:01 -0800
Message-ID: <CALvZod6v==Fq4=W5_71msn4rE+6m49B4ShoJaMSs0iaihuc3UA@mail.gmail.com>
Subject: Re: OOM killer not nearly agressive enough?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 2:49 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > > Do we agree that OOM killer should have reacted way sooner?
> > > >
> > > > This is impossible to answer without knowing what was going on at the
> > > > time. Was the system threshing over page cache/swap? In other words, is
> > > > the system completely out of memory or refaulting the working set all
> > > > the time because it doesn't fit into memory?
> > >
> > > Swap was full, so "completely out of memory", I guess. Chromium does
> > > that fairly often :-(.
> >
> > The oom heuristic is based on the reclaim failure. If the reclaim makes
> > some progress then the oom killer is not hit. Have a look at
> > should_reclaim_retry for more details.
>
> Thanks for pointer.
>
> I guess setting MAX_RECLAIM_RETRIES to 1 is not something you'd
> recommend? :-).
>
> > > PSI is completely different system, but I guess
> > > I should attempt to tweak the existing one first...
> >
> > PSI is measuring the cost of the allocation (among other things) and
> > that can give you some idea on how much time is spent to get memory.
> > Userspace can implement a policy based on that and act. The kernel oom
> > killer is the last resort when there is really no memory to
> > allocate.
>
> So what I'm seeing is system that is unresponsive, easily for an hour.
>
> Sometimes, I'm able to log in. When I could do that, system was
> absurdly slow, like ps printing at more than 10 seconds per line.
> ps on my system takes 300msec, estimate in the slow case would be 2000
> seconds, that is slowdown by factor of 6000x. That would be X terminal
> opening in like two hours... that's not really usable.
>
> DRAM is in 100nsec range, disk is in 10msec range; so worst case
> slowdown is somewhere in 100000x range. (Actually, in the worst case
> userland will do no progress at all, since you can need at 4+ pages in
> single CPU instruction, right?)
>
> But kernel is happy; system is unusable and will stay unusable for
> hour or more, and there's not much user can do. (Besides sysrq, thanks
> for the hint).
>
> Can we do better? This is equivalent of system crash, and it is _way_
> too easy to trigger. Should we do better by default?
>
> Dunno. If user moved the mouse, and cursor did not move for 10
> seconds, perhaps it is time for oom kill?
>
> Or should I add more swap? Is it terrible to place swap on SSD?
>

What's the kernel version? How much memory is anon and file pages?
What's your swap to DRAM ratio? Are you using in-memory compression
based swap? Have you tried to disable swap completely?

Shakeel
