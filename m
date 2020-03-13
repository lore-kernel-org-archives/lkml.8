Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55AEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3C620736
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584065337;
	bh=wg5KqU2C89V9sg161ELK0XjctmpbtMv04NWPVqqLNgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDXDaB4pBPBf3hnvraoPuegIswA5yv4LTTCZyrGITLYdy/NsFFeQRJ0mIbkiMhzl+
	 O8Hc9tyTk5Y1jk2EqAFq2RXx+NOZzCLYrYjLUzrUtWrmuSBkUIVb/H5WelBMhrVVPh
	 Sl3cy8rmbM/NDWFJqLsl13Di7QDKUvhYwVjukpcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgCMCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:08:56 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52623 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:08:56 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so3346004pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6UIHhrii+PcyoxAnOQshJ7x6jz3aQd0Zby/DnhIzfq0=;
        b=CLo7Mw1jrvzDulQDPztJ+80D+fkpsgE9fgeAlZToS71hqAFmlUB2sMLuTZpIjRUHkF
         qK4kmVqlBe/kk0lgE/0sCQFKRzMO6Jdop/e9tKZt4PvMZK2etnPssklgsHxOmy4fQig6
         A7HrO0sNttqTddmNTsA+XxDYe57quskTKvBzhDGy8jlkSgZe3R8S8tFpXTFNUYYwGzdI
         Kr+U6dB7YrUY6eVdNKg2yNJyGNgAYYTmeP6/NibTHLvkOXynIhpyyX8pWH7mnEbi3QoC
         9EoCwBcLvovwnfpAMdFENFMeM5la+R39m2I+t2vV9uucaY+aqPDg1/ZrSa7HKwM1gm7T
         tjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6UIHhrii+PcyoxAnOQshJ7x6jz3aQd0Zby/DnhIzfq0=;
        b=sRIwSSzsS+ryl8WCEvjZ8+3Pka5sEW9QOr/VrGMBbmZB0jgY1jv5ki5ItXdzOyMno7
         /b5kIhOcGPMqzrAEv2bjPnEMfsrOc1VuKuVubhSBhQ1b29laJGqYxd1+U1RyVYuh//DM
         a7B4bOSwkuuT2rQU4rmQKir0LE+/EhGaB0zFnbMhuCaTbrCqWGAasRDLc2boVF09WeAB
         au2jUKIBECFSe3ymJFvxQ6S2cmt/7fsAPaWagmrltVuE+qJTvTKdJoS++KqPTS64Hxum
         i9dP2YvI1ZX9hfD9saLGZRMY4J8JJMkO+lDwZr5Fzi1l9OWRNAnv/gRxaleH0DfCVsxv
         Rj/w==
X-Gm-Message-State: ANhLgQ0JsjC4syLsTDp5SeT7OWT0pXK9yaaYCtX/G95Bk1pnpFewLdoU
        iJIFCBAsrSGdhbNHoF0OjOQ=
X-Google-Smtp-Source: ADFU+vuutzwBmcIdOCi8oQVsDTjhXluTb57K0NN9SVwUs1eLvmIYsApAiIHBj/rV/kBV+HB5FJcjJg==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr11018356plo.45.1584065334674;
        Thu, 12 Mar 2020 19:08:54 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o126sm9027476pfb.140.2020.03.12.19.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 19:08:53 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:08:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200313020851.GD68817@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312204155.GE23944@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> [...]
> > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > From: Michal Hocko <mhocko@suse.com>
> > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > 
> > > Jann has brought up a very interesting point [1]. While shared pages are
> > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > performance problems outlined by Daniel [2]. There are runtime
> > > environments where there is a substantial memory shared among security
> > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > in for the parent process which might be more privileged or even open
> > > side channel attacks. The feasibility of the later is not really clear
> > 
> > I am not sure it's a good idea to mention performance stuff because
> > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > early draft which had shared page filtering out logic due to performance
> > reason. You guys suggested the shared pages has higher chance to be touched
> > so that if it's really hot pages, that whould keep in the memory. I agree.
> 
> Yes, the hot memory is likely to be referenced but the point was an
> unexpected latency because of the major fault. I have to say that I have

I don't understand your point here. If it's likely to be referenced
among several processes, it doesn't have the major fault latency.
What's your point here?

> underestimated the issue because I was not aware of runtimes mentioned
> in the referenced links. Essentially a lot of CoW memory shared over
> security domains.

I tend to agree about security part in the description, but still don't
agree with performance concern in the description so I'd like to remove
it in the description. Current situation is caused by security concern
unfortunately, not performance reason.

> 
> > I think the only reason at this moment is just vulnerability.
> > 
> > > to me TBH but there is no real reason for exposure at this stage. It
> > > seems there is no real use case to depend on reclaiming CoW memory via
> > > madvise at this stage so it is much easier to simply disallow it and
> > > this is what this patch does. Put it simply MADV_{PAGEOUT,COLD} can
> > > operate only on the exclusively owned memory which is a straightforward
> > > semantic.
> > > 
> > > [1] http://lkml.kernel.org/r/CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com
> > > [2] http://lkml.kernel.org/r/CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com
> > > 
> > > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > > ---
> > >  mm/madvise.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 43b47d3fae02..4bb30ed6c8d2 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -335,12 +335,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> > >  		}
> > >  
> > >  		page = pmd_page(orig_pmd);
> > > +
> > > +		/* Do not interfere with other mappings of this page */
> > 
> > 
> > How about this?
> > /*
> >  * paging out only single mapped private pages for anonymous mapping,
> >  * otherwise, it opens a side channel.
> >  */
> 
> I am not sure this is much more helpful without a larger context. I
> would stick with the wording unless you insist.

The comment you provides explain what code does, not *why*.
Comment is always lack of explaining the whole story but we try to
demonstrate a certain context to make reader careful.
Havind said, I will not insist on it.

Thanks.
