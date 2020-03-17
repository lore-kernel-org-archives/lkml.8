Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA084C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892BD20663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584429165;
	bh=GOWo0DpIKsVYWlFPqLvvRi10oEaaiiiQZ/vxOVP+NFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Pw7W2rbd5lL93PCJBXny3NCnzvEdtwDBtG8nH36zCuZ6x7ptSs1xg/7BhiS777qz
	 y3B+oiAQFRTO3LJyi6tI6rqcMR4lzRxPPEY9YuKvfKSPuOdABY9la0zPZJEMWbFHDP
	 O+x68o3SMQAytccqZPBzv4V1Y8/K22pYNBuylcIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgCQHMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:12:44 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33039 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgCQHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:12:44 -0400
Received: by mail-wr1-f53.google.com with SMTP id a25so24210917wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgNGQw6qu/GqhOoQ4W2/EShkjIEq6enz5IIfSPkXGhg=;
        b=dc86Q0wnhjNufU64gRZAX5recKi60kWj5oBRplksU7A/7xeJVDM3yoGHwS24dYT38g
         twprhkMgPhtHjI0J/5e4C2B2mdkwTyyLJn6o3CSYPhYDi3mw2YnRpeW/yGzP9a/Y45Ym
         J7vpQyYAbDFjik1gYoJ1onSFwMFK97fNugbqx5BVZBBGTbVBMOEzWfKh0llYV4JvuBJj
         h12TWrYe7E/v/d65cQK8M1L1+NEH3P3PZPi9MYUrU5QQOg0w88VZNrefsnuUZSHvHYla
         gd4O+s1MoZEFLTvrELQMCpNSr1pY6A6AAb6QPBih8hqDWhpi6bgSc2VZ+l+H0rC4YJwI
         E2Ig==
X-Gm-Message-State: ANhLgQ2OxNDcawNdnreS0ZLuFj5wPEGppOVogWXu53NLrWzRXEG+CUuf
        yr7hZUvv6enMFnkhNVKk0Zg=
X-Google-Smtp-Source: ADFU+vuMvxdoDP1eI6p0pPIIbGtAK4Mir0ISAuLnuscKA5ADGvrivvORk/ec1/GcFZL09WZDkHoZlQ==
X-Received: by 2002:a5d:654e:: with SMTP id z14mr4137791wrv.274.1584429162083;
        Tue, 17 Mar 2020 00:12:42 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id i1sm3532242wrs.18.2020.03.17.00.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 00:12:40 -0700 (PDT)
Date:   Tue, 17 Mar 2020 08:12:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200317071239.GB26018@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
 <20200313205941.GA78185@google.com>
 <20200316092052.GD11482@dhcp22.suse.cz>
 <20200317014340.GA73302@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317014340.GA73302@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-03-20 18:43:40, Minchan Kim wrote:
> On Mon, Mar 16, 2020 at 10:20:52AM +0100, Michal Hocko wrote:
> > On Fri 13-03-20 13:59:41, Minchan Kim wrote:
> > > On Fri, Mar 13, 2020 at 09:05:46AM +0100, Michal Hocko wrote:
> > > > On Thu 12-03-20 19:08:51, Minchan Kim wrote:
> > > > > On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> > > > > > On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > > > > > > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > > > > > [...]
> > > > > > > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > > > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > > > > > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > > > > > > 
> > > > > > > > Jann has brought up a very interesting point [1]. While shared pages are
> > > > > > > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > > > > > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > > > > > > performance problems outlined by Daniel [2]. There are runtime
> > > > > > > > environments where there is a substantial memory shared among security
> > > > > > > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > > > > > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > > > > > > in for the parent process which might be more privileged or even open
> > > > > > > > side channel attacks. The feasibility of the later is not really clear
> > > > > > > 
> > > > > > > I am not sure it's a good idea to mention performance stuff because
> > > > > > > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > > > > > > early draft which had shared page filtering out logic due to performance
> > > > > > > reason. You guys suggested the shared pages has higher chance to be touched
> > > > > > > so that if it's really hot pages, that whould keep in the memory. I agree.
> > > > > > 
> > > > > > Yes, the hot memory is likely to be referenced but the point was an
> > > > > > unexpected latency because of the major fault. I have to say that I have
> > > > > 
> > > > > I don't understand your point here. If it's likely to be referenced
> > > > > among several processes, it doesn't have the major fault latency.
> > > > > What's your point here?
> > > > 
> > > > a) the particular CoW page might be cold enough to be reclaimed and b)
> > > 
> > > If it is, that means it's *cold* so it's really worth to be reclaimed.
> > > 
> > > > nothing really prevents the MADV_PAGEOUT to be called faster than the
> > > > reference bit being readded.
> > > 
> > > Yeb, that's undesirable. I should admit it was not intended when I implemented
> > > PAGEOUT. The thing is page_check_references clears access bit of pte for every
> > > process are sharing the page so that two times MADV_PAGEOUT from a process could
> > > evict the page. That's the really bug.
> > 
> > I do not really think this is a bug. This is a side effect of the
> > reclaim process and we do not really want MADV_{PAGEOUT,COLD} behave
> 
> No, that's the bug since we didn't consider the side effect.
> 
> > differently here because then the behavior would be even harder to
> 
> No, I do want to have difference because it's per-process hint. IOW,
> what he know is for only his context, not others so it shouldn't clean
> others' pte. That makes difference between LRU aging and the hint.

Just to make it clear, are you really suggesting to special case
page_check_references for madvise path?

-- 
Michal Hocko
SUSE Labs
