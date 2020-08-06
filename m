Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB8C433F1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2596522D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyj/A4qt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHFFVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgHFFVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:21:35 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 22:21:34 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e6so21585487oii.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NawncW6kcN7J/8qHcLn2vH5R5YQS2/laJgJm6p/2YCk=;
        b=oyj/A4qtZQFmUNx3d8X6GCw9WEuOghnm1XwugQyROixks1XkjMb3pWc838vhBkvDR+
         dQ4776yWmKpUGQKAR/vPQWeCIcnXjSdbqeaMRKbakwt6AEf94LgWKI1IyCg82bM38xKV
         V7/eANJ7VR9Lb8Y5Tlv7QYbXRG4p6FEPFNaZHUKDKGasYuXfp+t501S28LB9KgmB45Gf
         5c6BuP0WDKhsJEYi2P5UIwlvfsrzmob+gsJwOZgqgGCL36oOb1v64lzzvLvvboVs3Xst
         FeIIw7QihwkcTJNwXuQh7N/mRKJXi9E20nesrqi05PydTk8ZyPueKMlil21ChOC9pbD8
         YmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NawncW6kcN7J/8qHcLn2vH5R5YQS2/laJgJm6p/2YCk=;
        b=jDaB4kkMdZj0XPOAQIUfb63peDVPFeelKhJnekv25koC2/iGUNzRuVm0xr/lqp6fVU
         qg7RIeCzZci7cQO5gxekuwGvmC8xUrep+S6sdZQWGjNKX7wbIxhF5orqQFqvu38oq4Jv
         lawVxnI1V4KnmxNrxfzi+u7vPIcl5iYL3QbgAqNSkKjmEB/QuX/5LmtPUcfsr3TCUBZZ
         BPOxka4d667hxrhfG9hyYIClKl8fzr9ESVf1mc9wAz5+Cwc/sOuHAr/NXbs8xK6QAumr
         L9Fatua7Xu/uS61HmiRCW8nUBiZHk3XaCmX5BAzRvhvgPTRteDlS56QJU6LmD9JdZ0/a
         Ioyg==
X-Gm-Message-State: AOAM531b+egVFZVtF1jVc+pum6N9WtX4qhglSeX/V7CaqR8xVAgQRTYX
        6yKIRs18aeywsB/WGi5RtevX1A==
X-Google-Smtp-Source: ABdhPJwP0SUs4y6xBmSM+VlR4LZd/gb+f0cyUOs/WRnv2k3YOa6BUmM28Erezs7jF6n/63Hheq1okQ==
X-Received: by 2002:aca:5585:: with SMTP id j127mr5299089oib.120.1596691293575;
        Wed, 05 Aug 2020 22:21:33 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t83sm945595oot.22.2020.08.05.22.21.31
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2020 22:21:32 -0700 (PDT)
Date:   Wed, 5 Aug 2020 22:21:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
References: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com> <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils> <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice to see the +130.0% this morning.

I got back on to this on Monday, here's some follow-up.

On Sun, 26 Jul 2020, Hugh Dickins wrote:
> 
> The comparison runs have not yet completed (except for the one started
> early), but they have all got past the most interesting tests, and it's
> clear that they do not have the "failure"s seen with your patches.
> 
> From that I can only conclude that your patches make a difference.
> 
> I've deduced nothing useful from the logs, will have to leave that
> to others here with more experience of them.  But my assumption now
> is that you have successfully removed one bottleneck, so the tests
> get somewhat further and now stick in the next bottleneck, whatever
> that may be.  Which shows up as "failure", where the unlock_page()
> wake_up_page_bit() bottleneck had allowed the tests to proceed in
> a more serially sedate way.

Yes, that's still how it appears to me. The test failures, all
of them, came from fork() returning ENOSPC, which originated from
alloc_pid()'s idr_alloc_cyclic(). I did try doubling our already
large pid_max, that did not work out well, there are probably good
reasons for it to be where it is and I was wrong to dabble with it.
I also tried an rcu_barrier() and retry when getting -ENOSPC there,
thinking maybe RCU was not freeing them up fast enough, but that
didn't help either.

I think (but didn't quite make the effort to double-check with
an independent count) it was simply running out of pids: that your
change speeds up the forking enough, that exiting could not quite keep
up (SIGCHLD is SIG_IGNed); whereas before your change, the unlock_page()
in do_wp_page(), on a PageAnon stack page, slowed the forking down enough
when heavily contended.

(I think we could improve the checks there, to avoid taking page lock in
more cases; but I don't know if that would help any real-life workload -
I see now that Michal's case is do_read_fault() not do_wp_page().)

And FWIW a further speedup there is the opposite of what these tests
are wanting: for the moment I've enabled a delay to get them passing
as before.

Something I was interested to realize in looking at this: trylock_page()
on a contended lock is now much less likely to jump the queue and
succeed than before, since your lock holder hands off the page lock to
the next holder: much smaller window than waiting for the next to wake
to take it. Nothing wrong with that, but effect might be seen somewhere.

> 
> The xhci handle_cmd_completion list_del bugs (on an older version
> of the driver): weird, nothing to do with page wakeups, I'll just
> have to assume that it's some driver bug exposed by the greater
> stress allowed down, and let driver people investigate (if it
> still manifests) when we take in your improvements.

Complete red herring. I'll give Greg more info in response to his
mail, and there may be an xhci bug in there; but when I looked back,
found I'd come across the same bug back in October, and find that
occasionally it's been seen in our fleet. Yes, it's odd that your
change coincided with it becoming more common on that machine
(which I've since replaced by another), yes it's funny that it's
in __list_del_entry_valid(), which is exactly where I got crashes
on pages with your initial patch; but it's just a distraction.

> 
> One nice thing from the comparison runs without your patches:
> watchdog panic did crash one of those with exactly the unlock_page()
> wake_up_page_bit() softlockup symptom we've been fighting, that did
> not appear with your patches.  So although the sample size is much
> too small to justify a conclusion, it does tend towards confirming
> your changes.
> 
> Thank you for your work on this! And I'm sure you'd have preferred
> some hard data back, rather than a diary of my mood swings, but...
> we do what we can.
> 
> Hugh
