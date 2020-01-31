Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E4C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79252206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580486517;
	bh=zJ3whwCOn2Fu/3s7uy/4141lvnl61qc5tjHNWTZ0weM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XdN4WoP7dxfvjxg8IhXZ7FQWyO4qVj4nfgR1JfRbJ/j6yAGYW4qjVezshFK0uJlau
	 Zr4F3/SGCsusyjeV1VsbF3fFaZ4f1X3Jx1c3okKx9b0irwRx5/VeVh7ve96QCl++wY
	 jCzJGESju4QbEtToYs6RQGnxqHf8AV9BALyeMK4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgAaQB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:01:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35748 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgAaQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:01:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so9268158wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hfD+a+L2dxb7XwM4BrTUPq0v1gyUGRH/2kK3KgUx3U=;
        b=fnPnbB/ARfrFiNxpo509AXL6qFppPiF3BYstlb8VSE1mbFaQn0x+g0fzYbmnHdBINR
         ymrTya+bCnUuMwErQZV4r+QbOOYQjpB8rCpNmntZoB+fZHq7adF2u8e7TGGgSMFPrlcA
         hxsoKNp8bgvNDFIJeHJ/+S5dskflb3lg1lxhwurCVlFMTV2xZ+Zca1Ie/eFBrRjwjCBg
         kf9yQHV/+JBAXvD0tz8ccy23VHzJtkwt3ZhKH8f7dAXPSzFhkLdhN6WMaAbp2NDDVOEs
         MalgjCa417wFchciJ72yy0ZQFII34G1baAbz0IQv0c1ZVfps+SAuU2+zfDigiiiQaA3V
         MMRA==
X-Gm-Message-State: APjAAAXXl3qc89xywHm7fkJMFp4vjtwZac2/XMN4xy1mdwL0juuVpUCN
        +dvmPx98UP8moM4OtRW55jo=
X-Google-Smtp-Source: APXvYqwmnZwvGFTziucXbfEgzg/Yf/xRwiRsszjeLcoGlAbiusYEE8q3z+TQJFkFc2ZyPjcYRe5S8w==
X-Received: by 2002:adf:dfcf:: with SMTP id q15mr12712122wrn.404.1580486513732;
        Fri, 31 Jan 2020 08:01:53 -0800 (PST)
Received: from localhost (ip-37-188-238-177.eurotel.cz. [37.188.238.177])
        by smtp.gmail.com with ESMTPSA id s8sm11591855wrt.57.2020.01.31.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 08:01:52 -0800 (PST)
Date:   Fri, 31 Jan 2020 17:01:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: Allocate shrinker_map on appropriate NUMA node
Message-ID: <20200131160151.GB4520@dhcp22.suse.cz>
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
 <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-01-20 18:49:24, Kirill Tkhai wrote:
> On 31.01.2020 18:47, Michal Hocko wrote:
> > On Fri 31-01-20 18:00:51, Kirill Tkhai wrote:
> > [...]
> >> @@ -333,8 +333,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
> >>  		/* Not yet online memcg */
> >>  		if (!old)
> >>  			return 0;
> >> -
> >> -		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
> >> +		/* See comment in alloc_mem_cgroup_per_node_info()*/
> >> +		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : NUMA_NO_NODE;
> >> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> >>  		if (!new)
> >>  			return -ENOMEM;
> > 
> > I do not think this is a good pattern to copy. Why cannot you simply use
> > kvmalloc_node with the given node? The allocator should fallback to the
> > closest node if the given one doesn't have any memory.
> 
> Hm, why isn't the same scheme used in alloc_mem_cgroup_per_node_info() then?

Dunno, it's an old code. Probably worth cleaning up.
-- 
Michal Hocko
SUSE Labs
