Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CD5C433ED
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0F9206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0Y/7PYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGZUav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 16:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGZUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 16:30:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41483C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:30:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so13558189qka.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=eJ8N3m9hHBs2DJD7AGqPgD7eK30TwK2EzEcmU7vvZK0=;
        b=F0Y/7PYeOQN/imu6lHcT+ttXXOTbRaMB1OK3HA/5JWKeD6itG1Hf7Yr0bEtbxGz+4a
         hBNuZYLSFlQOr3i+ct6+B9bwbAPeWPeNyRNys4WiX4ubFK/A3ULA/2DLgWCfYpbCWh6M
         w27ps7vjILtS+jXWpt8g2PTvl8dHkHr2lNRnPCOm9aUdXN/qViAfSiecm4Ny/k6CHxip
         CKuR2EmgRyYACEs3QR8NGD53y7LhqaY6x0hilcBgheHsBUxoQwGxqA4iH7fEyxg6rsgF
         ai2JTaQG3nZs3v1DIzspKwPqgVR6+yJ/7w6/1XX0eAMXTzoPoV8NzwdVCKMDdqZGsQAy
         Y1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=eJ8N3m9hHBs2DJD7AGqPgD7eK30TwK2EzEcmU7vvZK0=;
        b=e1Hfy6A3VJgDiT5nCKmIRV0Wa8RILc+vD5c9fY5HDdmw7lUJlFZ/XNwQxohdTwuPAy
         xh9c5cYBq0wS9gj6HetP00/aEsb0fiwJrlFef58g99Lah+ra34Flh0kBEaVDRqMb4GPV
         UG8tBentl23viq0HVkwsnFwW3vH/TIMZ22uLQU1HK5Q9VS8n5JlRHsRJrTRT1WLs6G9/
         0QPooHYw08+W4MSmuZyjcrtzpo8/hfZ1/PoTTq6LV850LdXq8md4B2fv7JAY6g3ibcTV
         0HG+Z1aqQFGqK44VQgRcKmNoDoU1sZNe3XRDYxujlBo8dW3Vgzli2/6Tw27hzRmIvUOj
         Qyew==
X-Gm-Message-State: AOAM531xOs+SI4ScJFu1W+QTtOuhvTSbNR2wyN0QI+OWHqczV6hIRVft
        hU+CXJT8AeGkWyEB7gab2ThSlw==
X-Google-Smtp-Source: ABdhPJyizh6pIuMdA1aNv4N31IYvAMG4NiMFI2wCeELIs+WEQHTandpa6FxJf9lqHa8pIvHW0CJo9A==
X-Received: by 2002:a37:62d4:: with SMTP id w203mr19681461qkb.463.1595795449848;
        Sun, 26 Jul 2020 13:30:49 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w8sm16821218qka.52.2020.07.26.13.30.47
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 26 Jul 2020 13:30:48 -0700 (PDT)
Date:   Sun, 26 Jul 2020 13:30:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com> <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020, Hugh Dickins wrote:
> On Sat, 25 Jul 2020, Hugh Dickins wrote:
> > On Sat, 25 Jul 2020, Linus Torvalds wrote:
> > > On Sat, Jul 25, 2020 at 3:14 AM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >
> > > > Heh. I too thought about this. And just in case, your patch looks correct
> > > > to me. But I can't really comment this behavioural change. Perhaps it
> > > > should come in a separate patch?
> > > 
> > > We could do that. At the same time, I think both parts change how the
> > > waitqueue works that it might as well just be one "fix page_bit_wait
> > > waitqueue usage".
> > > 
> > > But let's wait to see what Hugh's numbers say.
> > 
> > Oh no, no no: sorry for getting your hopes up there, I won't come up
> > with any numbers more significant than "0 out of 10" machines crashed.
> > I know it would be *really* useful if I could come up with performance
> > comparisons, or steer someone else to do so: but I'm sorry, cannot.
> > 
> > Currently it's actually 1 out of 10 machines crashed, for the same
> > driverland issue seen last time, maybe it's a bad machine; and another
> > 1 out of the 10 machines went AWOL for unknown reasons, but probably
> > something outside the kernel got confused by the stress.  No reason
> > to suspect your changes at all (but some unanalyzed "failure"s, of
> > dubious significance, accumulating like last time).
> > 
> > I'm optimistic: nothing has happened to warn us off your changes.
> 
> Less optimistic now, I'm afraid.
> 
> The machine I said had (twice) crashed coincidentally in driverland
> (some USB completion thing): that machine I set running a comparison
> kernel without your changes this morning, while the others still
> running with your changes; and it has now passed the point where it
> twice crashed before (the most troublesome test), without crashing.
> 
> Surprising: maybe still just coincidence, but I must look closer at
> the crashes.
> 
> The others have now completed, and one other crashed in that
> troublesome test, but sadly without yielding any crash info.
> 
> I've just set comparison runs going on them all, to judge whether
> to take the "failure"s seriously; and I'll look more closely at them.

The comparison runs have not yet completed (except for the one started
early), but they have all got past the most interesting tests, and it's
clear that they do not have the "failure"s seen with your patches.

From that I can only conclude that your patches make a difference.

I've deduced nothing useful from the logs, will have to leave that
to others here with more experience of them.  But my assumption now
is that you have successfully removed one bottleneck, so the tests
get somewhat further and now stick in the next bottleneck, whatever
that may be.  Which shows up as "failure", where the unlock_page()
wake_up_page_bit() bottleneck had allowed the tests to proceed in
a more serially sedate way.

The xhci handle_cmd_completion list_del bugs (on an older version
of the driver): weird, nothing to do with page wakeups, I'll just
have to assume that it's some driver bug exposed by the greater
stress allowed down, and let driver people investigate (if it
still manifests) when we take in your improvements.

One nice thing from the comparison runs without your patches:
watchdog panic did crash one of those with exactly the unlock_page()
wake_up_page_bit() softlockup symptom we've been fighting, that did
not appear with your patches.  So although the sample size is much
too small to justify a conclusion, it does tend towards confirming
your changes.

Thank you for your work on this! And I'm sure you'd have preferred
some hard data back, rather than a diary of my mood swings, but...
we do what we can.

Hugh
