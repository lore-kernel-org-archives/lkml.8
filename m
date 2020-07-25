Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E37C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E4F20738
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 21:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiQbHcw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgGYVUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgGYVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 17:20:03 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA1CC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 14:20:03 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so746404qvb.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q3pXJWvqYv2PwCVcBEiyQuUZc+6aMPazhjDam8Vbwso=;
        b=JiQbHcw2+4jpoPbh77ibRmDOgWQcZkZzuS8Dn9PIimC21my883B0SL+o88BKMHq6BZ
         rccBq2coxS///bma6PFRUj/ZpJa3nID6c8w8TCgEK9f+5sOfw38N6IH/ToxZjj9/rQg0
         n86Yp0Keq+nzPwKru/5qTBZ3aPAxjy7JbDtI+uv3sAu50Qbfpa7xRiJ5SVswE2giAzBb
         9mIkAepypfA5R7wtYMfEBzvHykgfc1jrbr3IpIZmer8kzMJykv8YIxCXXe3C105pPPm3
         hbE5xPSiOeI6SQf5YL364/HmSzUWni8jGhGBhvQJxGaIF0EEnkxfs1rU/XaNfl0MvLm0
         BrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q3pXJWvqYv2PwCVcBEiyQuUZc+6aMPazhjDam8Vbwso=;
        b=csLmBq53XkPeRdPHlcT1w8zlcreQqfEDzS9lX5TCQ8qngiJ/h4Qb31N9RqvMy8QUte
         wogDxKNREY7fOPBpH3NHRmHEYe3FJYIkokeSfD7p3SpBuGigU3iHo+W9vF+VGPka0QSh
         LwDHsnYp1H1LoQM9FOt0sD2YtAlJHq9Zn+61CFARFYSt2vUzqBaKKOskTYC1RzBgRifS
         TuaXK9lrn7iETtwrnagc2GOtClo5TCfE++ezM18Erk8CdeHg05o+Jrr39dOVzfuHGl68
         9gj5ZFAoxts+WhZj2/aA3itT0T+gXOFPQwyIPc/x2eIlzt00ZANDF6OinyUyLqPU5wbM
         x5eA==
X-Gm-Message-State: AOAM530RMas5m7K9u1tCZLd0rMcNEz2DrzskBm87NfcCCBeqSDTvUKmx
        kT/H6WixXK6u8GHnc6cgqQoAdg==
X-Google-Smtp-Source: ABdhPJzU76zdM8W6qeOkRMrjtgf6zK5MeakRJQK9lNvkPyG5ovyErF2WOlwlQZXBbCNoNrVoo+U7DQ==
X-Received: by 2002:ad4:424a:: with SMTP id l10mr15932830qvq.29.1595712001864;
        Sat, 25 Jul 2020 14:20:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 205sm11163498qkj.19.2020.07.25.14.19.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 25 Jul 2020 14:20:00 -0700 (PDT)
Date:   Sat, 25 Jul 2020 14:19:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Oleg Nesterov <oleg@redhat.com>, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007251343370.3804@eggly.anvils>
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com> <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020, Linus Torvalds wrote:
> On Sat, Jul 25, 2020 at 3:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Heh. I too thought about this. And just in case, your patch looks correct
> > to me. But I can't really comment this behavioural change. Perhaps it
> > should come in a separate patch?
> 
> We could do that. At the same time, I think both parts change how the
> waitqueue works that it might as well just be one "fix page_bit_wait
> waitqueue usage".
> 
> But let's wait to see what Hugh's numbers say.

Oh no, no no: sorry for getting your hopes up there, I won't come up
with any numbers more significant than "0 out of 10" machines crashed.
I know it would be *really* useful if I could come up with performance
comparisons, or steer someone else to do so: but I'm sorry, cannot.

Currently it's actually 1 out of 10 machines crashed, for the same
driverland issue seen last time, maybe it's a bad machine; and another
1 out of the 10 machines went AWOL for unknown reasons, but probably
something outside the kernel got confused by the stress.  No reason
to suspect your changes at all (but some unanalyzed "failure"s, of
dubious significance, accumulating like last time).

I'm optimistic: nothing has happened to warn us off your changes.

And on Fri, 24 Jul 2020, Linus Torvalds had written:
> So the loads you are running are known to have sensitivity to this
> particular area, and are why you've done your patches to the page wait
> bit code?

Yes. It's a series of nineteen ~hour-long tests, of which about five
exhibited wake_up_page_bit problems in the past, and one has remained
intermittently troublesome that way.  Intermittently: usually it does
get through, so getting through yesterday and today won't even tell
us that your changes fixed it - that we shall learn over time later.

Hugh
