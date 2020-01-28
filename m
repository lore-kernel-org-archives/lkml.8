Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB6C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258442173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580199768;
	bh=QHVV8DnKPEoaSpy+FhBJ1ceOPLcnR9b/B2qbwbzlOSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vyBnbs2KF+5u61RXCZOm+qzbyR8Da9sYz1nTr3cnhB55tF6WFaLyXGwD1+9UFAhxB
	 OA2MU03Dork2qacGwQBgQ9sXLL3IWO2b7255SYjnsWxwPxttpy1t1eaEHTuT1wmze+
	 G1iWTxfpjzKocOyfqYmch4g/ugWyLNj/A0eqwo6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgA1IWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:22:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33348 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgA1IWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:22:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so14939820wrq.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nXDl2/Asnx+mICo1O3D2WuzV1151WkKx4NKIvu/y1N0=;
        b=qwfdLgXsOxjq66vPFuJ3JmYdHq0YnW/E2YjQpIm7W8FeFEamUVmOMTn58/C/d859ds
         +HXpAZPhTO3Gw+EBXQPml4Ll2+hxJoZpCAPOSDWOMxQH9igDWAlJNvnroKuw+QM/bM6V
         jLQQkylpd2aKVKy9Z4bGTfaHIaSNneNjHD4QkRAlU///5/ujZB7uuRniIMXOWz8H5zFX
         uvnrGQqlT42xQgTA01EAJi4wynPxG3WLPoW/5LNg640OgP3LVTtIdj9JG+jqKOMuFAb2
         VUUeesqCyReSCLqpKeeJuI7M3GhjzXv0jI54fb8Mm1KDkXrZdiFC1LP2zXuAG/Vz4czF
         svag==
X-Gm-Message-State: APjAAAVXiLm5rCLp5D/d497rLRqyZ88MQInjLXVjemy3s7mz5eUVoTu8
        DxVrKb6rkiZhw8A3szWC2l4=
X-Google-Smtp-Source: APXvYqz7RYQHrUxIUHM3XwD+z0O1dvbvppVqMhwZB2G00KVhSEaienFUbeuchGv/mRn+OrUz+1lSYQ==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr28344090wrl.117.1580199765022;
        Tue, 28 Jan 2020 00:22:45 -0800 (PST)
Received: from localhost (37-48-13-185.nat.epc.tmcz.cz. [37.48.13.185])
        by smtp.gmail.com with ESMTPSA id i10sm25066813wru.16.2020.01.28.00.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 00:22:44 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:22:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128082243.GB18145@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <20200110073822.GC29802@dhcp22.suse.cz>
 <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200127144931.GM1183@dhcp22.suse.cz>
 <CAM_iQpXGqGse1pybMW+dCi_vp05W9GTRWtS-3O2hdsY-hR=Yng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXGqGse1pybMW+dCi_vp05W9GTRWtS-3O2hdsY-hR=Yng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-01-20 16:46:16, Cong Wang wrote:
> On Mon, Jan 27, 2020 at 6:49 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Sun 26-01-20 11:53:55, Cong Wang wrote:
> > > On Tue, Jan 21, 2020 at 1:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 20-01-20 14:48:05, Cong Wang wrote:
> > > > > It got stuck somewhere along the call path of mem_cgroup_try_charge(),
> > > > > and the trace events of mm_vmscan_lru_shrink_inactive() indicates this
> > > > > too:
> > > >
> > > > So it seems that you are condending on the page lock. It is really
> > > > unexpected that the reclaim would take that long though. Please try to
> > > > enable more vmscan tracepoints to see where the time is spent.
> > >
> > > Sorry for the delay. I have been trying to collect more data in one shot.
> > >
> > > This is a a typical round of the loop after enabling all vmscan tracepoints:
> > >
> > >            <...>-455450 [007] .... 4048595.842992:
> > > mm_vmscan_memcg_reclaim_begin: order=0 may_writepage=1
> > > gfp_flags=GFP_NOFS|__GFP_HIGHMEM|__GFP_HARDWALL|__GFP_MOVABLE
> > > classzone_idx=4
> > >            <...>-455450 [007] .... 4048595.843012:
> > > mm_vmscan_memcg_reclaim_end: nr_reclaimed=0
> >
> > This doesn't tell us much though. This reclaim round has taken close to
> > no time. See timestamps.
> >
> > > The whole trace output is huge (33M), I can provide it on request.
> >
> > Focus on reclaim rounds that take a long time and see where it gets you.
> 
> I reviewed the tracing output with my eyes, they all took little time.
> But of course I can't review all of them given the size is huge.

Sure, I would simply use a script to check for exessive reclaims rounds.
Also it is important to find out whether the page of your interest is
locked outside of the reclaim or inside.
-- 
Michal Hocko
SUSE Labs
