Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C98C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E42072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584634610;
	bh=s4auXPFGhqXkaZ6kGgZOfjVD+IS6QTcU36WvedUF6e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QlqOtI+ENlXTxUDrVLu+EkpisoBFn2QMRawVBoWOk1r0R5HK1m0L2ZG3OU+VV48Dq
	 Ik83AnZ6SwPJ6z5K9bDsUFR/w+wIwbVNaal8cE45kjgxvZacg2kymhhlDIPVB1/RGD
	 Ylwr4lCSkQCDz6X0JubX8FFsek2zqS9r1KixvNAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgCSQQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:16:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50301 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgCSQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:16:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id z13so3188934wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPTln5B3sexFE9RG59KkUGJksK/x876CRm/hBQhYswk=;
        b=L1YcBxWiZAGktiM9T/kVvoOaJtYEKE6rkl3mhLVRUhJUu+hVfsvff3hPIWc2FQ8p2z
         lnOWXMl2XI9dzX1vc0Muk+mrJxsR8rrMyq+DALhHd0Jpb3hD93MO/Rp2lS0relBZYzhX
         kmIcrSxS/lKNdgBSTY9fbqGAT9HtylTiJe5yowj2hDvobGIir0KBcBp8qdMXA6YxnDX0
         BeCOiztFKuAsCgiUETLFQkaRDiYgNPAUZuciUczKuKZJEnXeurCmh1AKC4D369JV1oLc
         NBwbFGVz5b40iUxRrkVNFNDaWqy142738pVuUiL8JXcFA0sooCfdCLH8n2NAdvJJ8FCn
         r/0Q==
X-Gm-Message-State: ANhLgQ0laO9zycbTXVuqa0i409kwIwMMKeHUS0NpibD4u0ec8WRUabOE
        GJG3FkG8c6B9V+fPFyw+XK8=
X-Google-Smtp-Source: ADFU+vvzMUCkCdznfIsApgN3Ujz0TAy3SkeVhx2NsB1/wICHclRQ1FeLUIegJBP7PW8hFBbOc7gfTg==
X-Received: by 2002:a05:600c:11:: with SMTP id g17mr4542705wmc.142.1584634606754;
        Thu, 19 Mar 2020 09:16:46 -0700 (PDT)
Received: from localhost (ip-37-188-140-107.eurotel.cz. [37.188.140.107])
        by smtp.gmail.com with ESMTPSA id p16sm3693176wmi.40.2020.03.19.09.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:16:45 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:16:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH] mm: hugetlb: fix hugetlb_cma_reserve() if CONFIG_NUMA
 isn't set
Message-ID: <20200319161644.GH20800@dhcp22.suse.cz>
References: <20200318153424.3202304-1-guro@fb.com>
 <20200318161625.GR21362@dhcp22.suse.cz>
 <20200318175529.GA6263@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318175529.GA6263@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-03-20 10:55:29, Roman Gushchin wrote:
> On Wed, Mar 18, 2020 at 05:16:25PM +0100, Michal Hocko wrote:
> > On Wed 18-03-20 08:34:24, Roman Gushchin wrote:
> > > If CONFIG_NUMA isn't set, there is no need to ensure that
> > > the hugetlb cma area belongs to a specific numa node.
> > > 
> > > min/max_low_pfn can be used for limiting the maximum size
> > > of the hugetlb_cma area.
> > > 
> > > Also for_each_mem_pfn_range() is defined only if
> > > CONFIG_HAVE_MEMBLOCK_NODE_MAP is set, and on arm (unlike most
> > > other architectures) it depends on CONFIG_NUMA. This makes the
> > > build fail if CONFIG_NUMA isn't set.
> > 
> > CONFIG_HAVE_MEMBLOCK_NODE_MAP has popped out as a problem several times
> > already. Is there any real reason we cannot make it unconditional?
> > Essentially make the functionality always enabled and drop the config?
> 
> It depends on CONFIG_NUMA only on arm, and I really don't know
> if there is a good justification for it. It not, that will be a much
> simpler fix.

I have checked the history and the dependency is there since NUMA was
introduced in arm64. So it would be great to double check with arch
maintainers.

> > The code below is ugly as hell. Just look at it. You have
> > for_each_node_state without any ifdefery but the having ifdef
> > CONFIG_NUMA. That just doesn't make any sense.
> 
> I don't think it makes no sense:
> it tries to reserve a cma area on each node (need for_each_node_state()),
> and it uses the for_each_mem_pfn_range() to get a min and max pfn
> for each node. With !CONFIG_NUMA the first part is reduced to one
> iteration and the second part is not required at all.

Sure the resulting code logic makes sense. I meant that it doesn't make
much sense wrt readability. There is a loop over all existing numa nodes
to have ifdef for NUMA inside the loop. See?

> I agree that for_each_mem_pfn_range() here looks quite ugly, but I don't know
> of a better way to get min/max pfns for a node so early in the boot process.
> If somebody has any ideas here, I'll appreciate a lot.

The loop is ok. Maybe we have other memblock API that would be better
but I am not really aware of it from top of my head. I would stick with
it. It just sucks that this API depends on HAVE_MEMBLOCK_NODE_MAP and
that it is not generally available. This is what I am complaining about.
Just look what kind of dirty hack it made you to create ;)

> I know Rik plans some further improvements here, so the goal for now
> is to fix the build. If you think that enabling CONFIG_HAVE_MEMBLOCK_NODE_MAP
> unconditionally is a way to go, I'm fine with it too.

This is not the first time HAVE_MEMBLOCK_NODE_MAP has been problematic.
I might be missing something but I really do not get why do we really
need it these days. As for !NUMA, I suspect we can make it generate the
right thing when !NUMA.
-- 
Michal Hocko
SUSE Labs
