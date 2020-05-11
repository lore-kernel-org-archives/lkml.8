Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B5BC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21812070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xde/V+Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgEKVol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgEKVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:44:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E54C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:44:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w10so536237ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi8QFxJcn8ospcUaTTL/msn/H2PnYlfa7gEDxoqIEDk=;
        b=Xde/V+AmEr9RhRI0OF3eoEMOlc1isYqe7VOjexZ9+yvqXUITqDMjYykWWvmO4V34Mf
         JOKkt+8ipvHoG6K6EnRJr+X4BE5BAeOIwVncM8mZiP+p8lL6D28UrUf9zrcUO4HYJ7Li
         /D0qRklBhVjc7H/pRd3r6sLDxIMmGPBdiSdMvnDuECFum3YPjKLEReOjRUX1lEMISjPa
         UxRo1lcjtjDBeAqBK9a6l4tU/5RJrH/CC/Tv8dqgB7LOsv/2hUPnh1rhH6QKtsylPMHk
         BdDMHIPOaPWBeuE+Acy+5O+YHoJMjaQHW8cBtfuVR6w/jN0CQ0EMrdo5tDVPzgaOXoPu
         HV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qi8QFxJcn8ospcUaTTL/msn/H2PnYlfa7gEDxoqIEDk=;
        b=aAH7qjFbGShTJCjA++kIEFaILpE3zSzGTmScdeUrseiLNQWr6MxVxmDs1gyScf7BNq
         3vnzp4TsXSuI1kvJjr56DwCTQtqaw3N1htm+3+VBBgwG4N/dUMM9BwsJXQ+MNjfKv6jh
         J3tAnvGuDHSffoLF3np78kWORBvSueqlHbkPNWV+gY+oEBxV5pb9nqOAqP9svxlU8GcB
         yM4ncwU+Y8EUVaasQNzOE/0OS0lz/sxj5pXGdvvWK6e76C3/xEJn0XQ8hPc2WnZJyQAR
         woVsA95ALHukR5ZubMGwaj3oqQiapbY/zeaPIPAaQUTynOfigyA8b8HsJOfNLltAD9kV
         KYqw==
X-Gm-Message-State: AOAM531YUAZ+ibUdxlMPlzaOqRPvnoglYF63RdFrhSUmYprBjzCK46po
        riGCUHtWCYhkcEUhHo0SJOdKkDpdB2j7UH3Nbja7Dw==
X-Google-Smtp-Source: ABdhPJyDBiceL/nRp52X70KoPTj1Z2mRtQJpKkdBDk00bdjCphFTyVenSJCXU23TcFAtFOAlthEP8MRn7HZ4gVuWRHg=
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr12277759ljj.265.1589233477493;
 Mon, 11 May 2020 14:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200507163301.229070-1-shakeelb@google.com> <20200507164653.GM6345@dhcp22.suse.cz>
 <CALvZod5TmAnDoueej1nu5_VV9rQa6VYVRXqCYuh63P5HN-o9Sw@mail.gmail.com> <20200511155646.GB306292@cmpxchg.org>
In-Reply-To: <20200511155646.GB306292@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 11 May 2020 14:44:26 -0700
Message-ID: <CALvZod7Js-3uF2QkxtizVNRB24QvoG_jobpsgkwScR3VkCHw9g@mail.gmail.com>
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:57 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, May 07, 2020 at 10:00:07AM -0700, Shakeel Butt wrote:
> > On Thu, May 7, 2020 at 9:47 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 07-05-20 09:33:01, Shakeel Butt wrote:
> > > [...]
> > > > @@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > >                               schedule_work(&memcg->high_work);
> > > >                               break;
> > > >                       }
> > > > -                     current->memcg_nr_pages_over_high += batch;
> > > > -                     set_notify_resume(current);
> > > > +
> > > > +                     if (gfpflags_allow_blocking(gfp_mask))
> > > > +                             reclaim_over_high(memcg, gfp_mask, batch);
> > > > +
> > > > +                     if (page_counter_read(&memcg->memory) <=
> > > > +                         READ_ONCE(memcg->high))
> > > > +                             break;
> > >
> > > I am half way to a long weekend so bear with me. Shouldn't this be continue? The
> > > parent memcg might be still in excess even the child got reclaimed,
> > > right?
> > >
> >
> > The reclaim_high() actually already does this walk up to the root and
> > reclaim from ones who are still over their high limit. Though having
> > 'continue' here is correct too.
>
> If reclaim was weak and failed to bring the child back in line, we
> still do set_notify_resume(). We should do that for ancestors too.
>
> But it seems we keep adding hierarchy walks and it's getting somewhat
> convoluted: page_counter does it, then we check high overage
> recursively, and now we add the call to reclaim which itself is a walk
> up the ancestor line.
>
> Can we hitchhike on the page_counter_try_charge() walk, which already
> has the concept of identifying counters with overage? Rename the @fail
> to @limited and return the first counter that is in excess of its high
> as well, even when the function succeeds?
>
> Then we could ditch the entire high checking loop here and simply
> replace it with
>
> done_restock:
>         ...
>
>         if (*limited) {
>                 if (gfpflags_allow_blocking())
>                         reclaim_over_high(memcg_from_counter(limited));
>                 /* Reclaim may not be able to do much, ... */
>                 set_notify_resume(); // or schedule_work()
>         };
>

I will try to code the above and will give a shot to the following
long-term suggestion as well.

> In the long-term, the best thing might be to integrate memory.high
> reclaim with the regular reclaim that try_charge() is already
> doing. Especially the part where it retries several times - we
> currently give up on memory.high unnecessarily early. Make
> page_counter_try_charge() fail on high and max equally, and after
> several reclaim cycles, instead of invoking the OOM killer, inject the
> penalty sleep and force the charges. OOM killing and throttling is
> supposed to be the only difference between the two, anyway, and yet
> the code diverges far more than that for no apparent reason.
>
> But I also appreciate that this is a cleanup beyond the scope of this
> patch here, so it's up to you how far you want to take it.

Thanks,
Shakeel
