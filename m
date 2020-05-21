Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35261C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039E72070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="P3kdIdXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgEUUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUUUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:20:23 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1ADC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:20:22 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a68so6527920otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tv5bFwSlR96fvSk6klDReH++Tj6oAHdVjmUeTXqcL5A=;
        b=P3kdIdXRz4jlhGZbbBstm6oFq+VHAjMwqep/H3KDUi1qaq2QlYiqri8vpd8Ow8Q9RE
         3JO8MrtIeBn77XQhnUjF3JzTwNJLMPczjh1kf/GDb/cl+zAe9Q0WWQ2MYQIgwI8jehA1
         NuHY4EmjKV1iyFJpQZGIKWdL8N1UfeL9vi2io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tv5bFwSlR96fvSk6klDReH++Tj6oAHdVjmUeTXqcL5A=;
        b=p4aC26nTYeA6bdCrGNWFdvgA+A3IoA2MLVDyzmNBBekmdJCVcz9ZiMgkITKYqJp/sU
         7I1MwbN7xCbJ4vzHFsDzDzU/kSFfGpxcTsyoI+epu8O0VZSnksVsjpHKDG1nV5jmhl4c
         izlxZOJWXD1a2VamMgipBSx3+qbv8StjGK4A/GAX9/kJvOfKWfHUJXWiu+095TAyt81Z
         J93wlzg62cFvh/R+XAUKq1QK7OyA+sA8B8+Nsleaucf30+9yOe1wwmB350KfF1E/1ta9
         u+OsyyfrQ8nFpdSM8Oo4hO07FjUo8eKo0zvCN+Wh7kxetaTKnburtRPFwUfTdZoTZTyW
         kQcg==
X-Gm-Message-State: AOAM531PD4yrufoHflD4FUzdAh7PAFqQTnACH55Tp1+g5ejmr+FVevdz
        by022QgLS5oNuwF97lzgO0m+oyXmSOES9Zy9u/GiZQ==
X-Google-Smtp-Source: ABdhPJyDMOFrvrbCYdvMgD2I6hSlRBoSkLIvbFP87rjxkuAryIRBLpQJNf1mpbK5Ylp6/QZxH1Fz7ZMIM81cUB0H9Po=
X-Received: by 2002:a9d:6f89:: with SMTP id h9mr8657870otq.75.1590092421807;
 Thu, 21 May 2020 13:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org> <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
In-Reply-To: <20200521134705.GA140701@google.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Thu, 21 May 2020 16:20:10 -0400
Message-ID: <CANaguZCy018R=XPETT4GRBjuUYx-xbxncnYG9Z5LfGmBYHG2=w@mail.gmail.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 9:47 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > It doens't allow tasks for form their own groups (by for example setting
> > the key to that of another task).
>
> So for this, I was thinking of making the prctl pass in an integer. And 0
> would mean untagged. Does that sound good to you?
>
On a similar note, me and Joel were discussing about prctl and it came up
that, there is no mechanism to set cookie from outside a process using
prctl(2). So, another option we could consider is to use sched_setattr(2)
and expand sched_attr to accomodate a u64 cookie. User could pass in a
cookie to explicitly set it and also use the same cookie for grouping.

Haven't prototyped it yet. Will need to dig deeper and see how it would
really look like.

Thanks,
Vineeth
