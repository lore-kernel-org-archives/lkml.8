Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1EC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9392D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584086754;
	bh=WyB4mJrbgT8e+kqQre4PVnZSOCbkaH3nSa5SDct+WQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zHcadeD1LRsk5aE1KwoEmRt74s7Y/8K5kvieJj8o13KtANjpU1zRZnKA+YqbZ//hW
	 k+Y4bvfcq6UfqviLzJcVKovNwhJI9wwYmB8i4/wIv3kvh+X1w8zC2lUhHqnoCoSZvP
	 M+gCfGgaTJBMglSXPMbBsmSR0+b+5xPBiQJuBN9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCMIFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:05:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42033 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMIFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:05:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so10843097wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQIOitXv3I5pRGgA4gJJvh9qLRp63SkIhEeNZmb4v4Y=;
        b=S+Op498HRNjJ0EUiiRcQ3Gx5zw61rwtUCHDFQ691jJp48RRvrmLnup1g8E50YaM0qn
         GtIwV37Vs6DU82n7VvYbOoTL2XRya+dW1OLbvF/tseCDkfqR60Wfe8pRwpsGbaLYaPLs
         M3dXoWHtK0/c4rUL1kyYGDnAPxc+R6gMbvq7lalVOlgDcpYFwA2gO/Wmc/cqQlIPg0+b
         Fi5YaGpqIX1hjy66h9nCuCZ7lKg3PIbilkryLhf7MyvEmgwBHTI4nFbDjnHfNQuVAvRQ
         PPrnNRdj5fzo2yu9WNqZcy+ph0cAEQxqkNeAAFgCNfTSjf/pg7nldELXsMcoR0CFq/yj
         WQqg==
X-Gm-Message-State: ANhLgQ2oM7q4MxGrIxVfFf/wv8M9MIGsfN2FoxE7k4Jdjpw4XTqwo1Gx
        9HIFLZjPIAu2eGkyYaz5GJQ=
X-Google-Smtp-Source: ADFU+vtTyV3NvKc+L2hMQ/BBBqjMU3ksdfo2QGEY4XxgRncswglhQHcuaxtLB7TyTXalsxzeF1WkFA==
X-Received: by 2002:a5d:6150:: with SMTP id y16mr16406894wrt.352.1584086749914;
        Fri, 13 Mar 2020 01:05:49 -0700 (PDT)
Received: from localhost (ip-37-188-247-35.eurotel.cz. [37.188.247.35])
        by smtp.gmail.com with ESMTPSA id 133sm16541367wmd.5.2020.03.13.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 01:05:49 -0700 (PDT)
Date:   Fri, 13 Mar 2020 09:05:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200313080546.GA21007@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313020851.GD68817@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 19:08:51, Minchan Kim wrote:
> On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> > On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > [...]
> > > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > > From: Michal Hocko <mhocko@suse.com>
> > > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > > 
> > > > Jann has brought up a very interesting point [1]. While shared pages are
> > > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > > performance problems outlined by Daniel [2]. There are runtime
> > > > environments where there is a substantial memory shared among security
> > > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > > in for the parent process which might be more privileged or even open
> > > > side channel attacks. The feasibility of the later is not really clear
> > > 
> > > I am not sure it's a good idea to mention performance stuff because
> > > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > > early draft which had shared page filtering out logic due to performance
> > > reason. You guys suggested the shared pages has higher chance to be touched
> > > so that if it's really hot pages, that whould keep in the memory. I agree.
> > 
> > Yes, the hot memory is likely to be referenced but the point was an
> > unexpected latency because of the major fault. I have to say that I have
> 
> I don't understand your point here. If it's likely to be referenced
> among several processes, it doesn't have the major fault latency.
> What's your point here?

a) the particular CoW page might be cold enough to be reclaimed and b)
nothing really prevents the MADV_PAGEOUT to be called faster than the
reference bit being readded.

> > underestimated the issue because I was not aware of runtimes mentioned
> > in the referenced links. Essentially a lot of CoW memory shared over
> > security domains.
> 
> I tend to agree about security part in the description, but still don't
> agree with performance concern in the description so I'd like to remove
> it in the description. Current situation is caused by security concern
> unfortunately, not performance reason.

Well, I have to admit that I haven't seen any actual numbers here but
considering zygote like workload I would rather not even risk it. Even
if the risk is theoretical I would rather put the restriction and
mention it in the changelog. If somebody would like to drop this
restriction it is at least more clear what to test for.

-- 
Michal Hocko
SUSE Labs
