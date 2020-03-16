Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F37BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2670D20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584350466;
	bh=StKgYhLmzzo9iHBRxaSPH2TD8e0rrZXRaxuxRG7eXog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fazi9KV/c3xmyIGqY3biXSQQnSeeOlz2UPWdJG8pWv9TCikoPDeqjOFrm5saMsLsz
	 act7QejxdEvAZRKjzG+TB/bDtgedxNqZS7c0pqOjAZt+fnU+jP6bsjubLttVz/ySD8
	 qrARvSdgglXKg2dIxIvuDRM1N0zfgufMXfNGndeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgCPJVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:21:04 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38786 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgCPJVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:21:03 -0400
Received: by mail-wm1-f48.google.com with SMTP id t13so10754379wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gpxt45thOiwYDJ5g1pO2m1tlgc7KWRmLIsWLSSokj8o=;
        b=a34CS7VoB/TMeaBCvOm5KPRVQ+kQOgBW5lUv9LIO0wMHGpr50KckMKs0tKeurgba22
         HQxFUfG9e/LxImo6MrouP5kDzJtqv7lw5I4kv+YchBihVrDfoTaxuJVEhTIAZvD1MvLk
         Peplh3z0NSLbUqZIzehc3qIt4NHQKxiIUZ3GYVWuMys+scCe6RPPOWa3qWcGMmcdFk9b
         rZNl5hABVyS3nI4oGv3vPRI9cMGfS188D1d9Ysis40SW/pb5EG+55y6WhJhEgcQ8mcOQ
         k5+l2Iedzk2MBaw+JyvK8HceDeckILLUvD1T52+oMPFYj53/cRo7K2K04WLO6dWUJM6E
         Gt5w==
X-Gm-Message-State: ANhLgQ2ta6La9oVd22KDKxpOUyscLU3cXaSlHYuYmGYgruGxrZRRKHry
        m/DamKMZE4Qw0v2qSR5sKyvqXVdP
X-Google-Smtp-Source: ADFU+vtaeMCR2Ww10SJIeSbFOcdwi1jjYcl9WBPQwNgDIPmCJSXZrB0Fv0sl5MK4g5sOxGhivEEOWw==
X-Received: by 2002:a1c:156:: with SMTP id 83mr27637518wmb.151.1584350460481;
        Mon, 16 Mar 2020 02:21:00 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id b5sm22221872wrw.86.2020.03.16.02.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:20:59 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:20:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200316092052.GD11482@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
 <20200313205941.GA78185@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313205941.GA78185@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-03-20 13:59:41, Minchan Kim wrote:
> On Fri, Mar 13, 2020 at 09:05:46AM +0100, Michal Hocko wrote:
> > On Thu 12-03-20 19:08:51, Minchan Kim wrote:
> > > On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> > > > On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > > > > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > > > [...]
> > > > > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > > > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > > > > 
> > > > > > Jann has brought up a very interesting point [1]. While shared pages are
> > > > > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > > > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > > > > performance problems outlined by Daniel [2]. There are runtime
> > > > > > environments where there is a substantial memory shared among security
> > > > > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > > > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > > > > in for the parent process which might be more privileged or even open
> > > > > > side channel attacks. The feasibility of the later is not really clear
> > > > > 
> > > > > I am not sure it's a good idea to mention performance stuff because
> > > > > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > > > > early draft which had shared page filtering out logic due to performance
> > > > > reason. You guys suggested the shared pages has higher chance to be touched
> > > > > so that if it's really hot pages, that whould keep in the memory. I agree.
> > > > 
> > > > Yes, the hot memory is likely to be referenced but the point was an
> > > > unexpected latency because of the major fault. I have to say that I have
> > > 
> > > I don't understand your point here. If it's likely to be referenced
> > > among several processes, it doesn't have the major fault latency.
> > > What's your point here?
> > 
> > a) the particular CoW page might be cold enough to be reclaimed and b)
> 
> If it is, that means it's *cold* so it's really worth to be reclaimed.
> 
> > nothing really prevents the MADV_PAGEOUT to be called faster than the
> > reference bit being readded.
> 
> Yeb, that's undesirable. I should admit it was not intended when I implemented
> PAGEOUT. The thing is page_check_references clears access bit of pte for every
> process are sharing the page so that two times MADV_PAGEOUT from a process could
> evict the page. That's the really bug.

I do not really think this is a bug. This is a side effect of the
reclaim process and we do not really want MADV_{PAGEOUT,COLD} behave
differently here because then the behavior would be even harder to
understand.

-- 
Michal Hocko
SUSE Labs
