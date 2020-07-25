Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1235C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973372067D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 02:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsXuB/GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGYCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 22:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGYCIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 22:08:41 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 19:08:41 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k6so9614814oij.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 19:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8RDgSawLErxUlyj8g5FqkrjgTL8CRL7VApm1SCEC0YY=;
        b=XsXuB/GB7oTa1AwzArH3m6lXpMObJ+CX63nrk2497zUG+wXizcF0Gh415whJ/hOiws
         /pesNOfXYJarmG8SOprlPGpbvLvhQ9Hcuo5zsBNSxjM0+6mfPby0pSzc/Ghg7DX/kQyj
         D9FL7BaL0nsUY2VqxDwuHSw9ZVsf/IPxBFH4zkPETxbZKJCiyIa2DkSy7E9eKZ2OLBRj
         dH4fs13OgxrsDgYjn8gU+jv/rfo/0ACpxXtNC2hPRtPGPj7tJ3ioMBKmsCGNukqt4ag0
         0kDrVmV1r5VcWxcl9gK3Hrq/MB1z/Jxc4KrZAvyS2HBmu4xVVrGsNAREJfotSvQneRtM
         +zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8RDgSawLErxUlyj8g5FqkrjgTL8CRL7VApm1SCEC0YY=;
        b=GM+H8Ss5mvJl3dtdrCsDc4kaJFNpIxKs/NqtrkX1LvHRd364T9tzM4y0qj/Cue6DI7
         /Eq9Tx/NJGoS7gDN/gVvuCCBCJhq/w9SN1f0lUZimtYd+PHBXmozVnzOOwn337L/gYG/
         SwQeZ0I8DuR91Fn1EIfsHbR36XYyulYC2e10Ce/tR56cqNd7kdswZ8xgNEuRDBnC1bnu
         0dlIq0QjwT7UeuEGJXAFayB42oRCxN2l8ylftWEfEJpPqKbYEfSzT7QS4bAUe7YnrLA/
         IO4heZjEY/2FaV2BUhFp1av8X2h3k7l6cw/Kv89bdglK0E+p7xC+NX7nisXuQjYHlANP
         vYzg==
X-Gm-Message-State: AOAM533LLLNuNIcO+bwpAKSpMXXf08srwVKGH66KEk9/NshYyadD9FI5
        Yw1mFelAT/IaLhVesxVRHHj0sA==
X-Google-Smtp-Source: ABdhPJyAXTaI/fCDQpvRVf6azMTLrIClfPDqSQ7+f191lw7sRb7lCe+O9pjjlGWEnCzohvt8EiZC+A==
X-Received: by 2002:aca:58c3:: with SMTP id m186mr10620330oib.18.1595642920545;
        Fri, 24 Jul 2020 19:08:40 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z2sm1746950otq.17.2020.07.24.19.08.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 24 Jul 2020 19:08:38 -0700 (PDT)
Date:   Fri, 24 Jul 2020 19:08:24 -0700 (PDT)
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
In-Reply-To: <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007241848300.8192@eggly.anvils>
References: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com> <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com> <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com> <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020, Linus Torvalds wrote:

> On Fri, Jul 24, 2020 at 10:32 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Ok, that makes sense. Except you did it on top of the original patch
> > without the fix to set WQ_FLAG_WOKEN for the non-wakeup case.
> 
> Hmm.
> 
> I just realized that one thing we could do is to not even test the
> page bit for the shared case in the wakeup path.
> 
> Because anybody who uses the non-exclusive "wait_on_page_locked()" or
> "wait_on_page_writeback()" isn't actually interested in the bit state
> any more at that point. All they care about is that somebody cleared
> it - not whether it was then re-taken again.
> 
> So instead of keeping them on the list - or stopping the waitqueue
> walk because somebody else got the bit - we could just mark them
> successfully done, wake them up, and remove those entries from the
> list.
> 
> That would be better for everybody - less pointless waiting for a new
> lock or writeback event, but also fewer entries on the wait queues as
> we get rid of them more quickly instead of walking them over and over
> just because somebody else re-took the page lock.
> 
> Generally "wait_on_page_locked()" is used for two things
> 
>  - either wait for the IO to then check if it's now uptodate
> 
>  - throttle things that can't afford to lock the page (eg page faults
> that dropped the mm lock, and as such need to go through the whole
> restart logic, but that don't want to lock the page because it's now
> too late, but also the page migration things)
> 
> In the first case, waiting to actually seeing the locked bit clear is
> pointless - the code only cared about the "wait for IO in progress"
> not about the lock bit itself.
> 
> And that second case generally might want to retry, but doesn't want
> to busy-loop.
> 
> And "wait_on_page_writeback()" is basically used for similar reasons
> (ie check if there were IO errors, but also possibly to throttle
> writeback traffic).
> 
> Saying "stop walking, keep it on the list" seems wrong. It makes IO
> error handling and retries much worse, for example.
> 
> So it turns out that the wakeup logic and the initial wait logic don't
> have so much in common after all, and there is a fundamental
> conceptual difference between that "check bit one last time" case, and
> the "we got woken up, now what" case..
> 
> End result: one final (yes, hopefully - I think I'm done) version of
> this patch-series.
> 
> This not only makes the code cleaner (the generated code for
> wake_up_page() is really quite nice now), but getting rid of extra
> waiting might help the load that Michal reported.
> 
> Because a lot of page waiting might be that non-exclusive
> "wait_on_page_locked()" kind, particularly in the thundering herd kind
> of situation where one process starts IO, and then other processes
> wait for it to finish.
> 
> Those users don't even care if somebody else then did a "lock_page()"
> for some other reason (maybe for writeback). They are generally
> perfectly happy with a locked page, as long as it's now up-to-date.
> 
> So this not only simplifies the code, it really might avoid some problems too.

That set of tests I started yesterday has now completed: no crashes
due to your changes (though, one machine crashed with an entirely
unrelated list_del corruption: over in driverland, just a coincidence).

I do see more of these stresstests reporting failure than I remember
from the last time I ran them, and I wasn't quickly able to work out
why (usually I just care about not crashing or hanging, rarely delve
deeper into what they actually call success).  The most likely cause
would be some internal infrastructural oddity, and nothing for you
to worry about; but there is a possibility that it's meaningful.

But whatever, what happens on the next run, with these latest patches,
will be more important; and I'll follow this next run with a run on
the baseline without them, to compare results.

Hugh
