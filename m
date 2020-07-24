Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E653CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4122086A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXXNj3mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGXAHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbgGXAHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:07:45 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D78FC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:07:45 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id t12so1473536ooc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=qBujHwaGJCw1P6JdNgGCLPuEf10oBiRobzBG3EaDAig=;
        b=PXXNj3mXqSvNjasml6R5Hi5qDcF7fW14Ck6nRxwkEqfHid/XLbbxiYx3nnsR0TSmCf
         38Y9QVxWK7AuUOCYWZBPQL9VwahHXVfU55bea8yUqtxyClD6JlqM4EDQ3Miz444HpFwe
         ZAR15l3fXJsKaUdfCXB5aJy33D2KgQNzuY7excItMx3FSeDGKOVfgaz846WtFVCQxA7j
         oQgFEikrqDiXt9pITWrgzDTNxhG5Sjxwl9XSHjXuG89XRtynZJUASmrtA0kZul+71ONd
         IFuwYXITdNUHfo10M5eCrihO/dZL5Z1Trw4HztTp5TDEa5P3wm/1cKS99gEm8y7PnRkt
         z2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=qBujHwaGJCw1P6JdNgGCLPuEf10oBiRobzBG3EaDAig=;
        b=t1qxNcSqqhUcL9ZhqycMsG2prQhQ+PbjvMkN0434unMpaJDDynr/sEmIBUAwwanHPS
         DF+JM3Lz0WLQoolWuiIdH4wY20GncTR3//77YvTw77yMC5gEzUv6oK52Cl/ny1BzNaT6
         Ay7u/VJei4FB+96JfqgGOgtoU1o2AnT4I76cbGiS5on1SRBiqWfvX9CM6TNL2H763sdM
         ZI2JaGIfHNuuX/tduOdvvDQZIKOnL91SNeDlo6L85aoUr8mxQXShBLzEMUk4Q9JvoKIn
         YZnIMz49gChjxskriv+dqvlRtKnOTHRY758dkk/NCGu4RL5wPQXsqN33885ZYyJp1Wik
         c0uA==
X-Gm-Message-State: AOAM533U6tidMg63b383gXp4Eb826Q1q0xERl3XtOWt2qgIQTiPrvTwb
        2ro0ku9sf0cmApIF165sAYP/6Q==
X-Google-Smtp-Source: ABdhPJwNuCjF1TmsR9K7i9Zx7PvgDtCg0uJ3UTCj7iHaOPIGp/Uu52Z+4JIe6oXByHgyrDFVYAH4Cg==
X-Received: by 2002:a4a:e8da:: with SMTP id h26mr6946228ooe.59.1595549264015;
        Thu, 23 Jul 2020 17:07:44 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x138sm1016689oif.5.2020.07.23.17.07.41
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2020 17:07:42 -0700 (PDT)
Date:   Thu, 23 Jul 2020 17:07:27 -0700 (PDT)
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
In-Reply-To: <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2007231650170.1281@eggly.anvils>
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com> <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com> <alpine.LSU.2.11.2007221359450.1017@eggly.anvils>
 <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com> <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com> <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Linus Torvalds wrote:
> On Thu, Jul 23, 2020 at 4:11 PM Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 23 Jul 2020, Linus Torvalds wrote:
> > >
> > > I'll send a new version after I actually test it.
> >
> > I'll give it a try when you're happy with it.
> 
> Ok, what I described is what I've been running for a while now. But I
> don't put much stress on my system with my normal workload, so..
> 
> > I did try yesterday's
> > with my swapping loads on home machines (3 of 4 survived 16 hours),
> > and with some google stresstests on work machines (0 of 10 survived).
> >
> > I've not spent long analyzing the crashes, all of them in or below
> > __wake_up_common() called from __wake_up_locked_key_bookmark():
> > sometimes gets to run the curr->func() and crashes on something
> > inside there (often list_del's lib/list_debug.c:53!), sometimes
> > cannot get that far. Looks like the wait queue entries on the list
> > were not entirely safe with that patch.
> 
> Hmm. The bug Oleg pointed out should be pretty theoretical. But I
> think the new approach with WQ_FLAG_WOKEN was much better anyway,
> despite me missing that one spot in the first version of the patch.
> 
> So here's two patches - the first one does that wake_page_function()
> conversion, and the second one just does the memory ordering cleanup I
> mentioned.
> 
> I don't think the second one shouldn't matter on x86, but who knows.
> 
> I don't enable list debugging, but I find list corruption surprising.
> All of _that_ should be inside the page waiqueue lock, the only
> unlocked part was the "list_empty_careful()" part.
> 
> But I'll walk over my patch mentally one more time. Here's the current
> version, anyway.

Thanks, I'll start some tests going shortly.

I do have to "port" these patches to a different kernel, and my first
assumption on seeing crashes was that I'd screwed that up; but that
seemed much less likely once the home test on top of v5.8-rc5 crashed
in much the same way.  The latter was not a list_del() crash, but on
curr->func itself; but I take them all as just indicating that the
wait queue entry can in rare cases be freed and reused.

(And the amount of "port"ing was close to nil here: our trees did
differ on an "unlikely" that one end had added or removed, plus I
did start off by reverting two of my three patches. But perhaps I'm
missing a subtle dependence on differences elsewhere in the tree.)

I say that for full disclosure, so you don't wrack your brains
too much, when it may still turn out to be a screwup on my part.

Hugh
