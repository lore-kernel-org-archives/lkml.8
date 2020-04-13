Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEEBC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9F320678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgDMJAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:00:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgDMJAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:00:07 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jNuwj-00027A-Av
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 09:00:01 +0000
Received: by mail-wr1-f71.google.com with SMTP id o10so6359261wrj.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqaVgDuR+jsoqCcuhbWmbCJxWXz5zIXCT9Qm1oMFDEg=;
        b=C6dZx3D7Enxto7WhH7tlYp6wPP4nz0IMozQFIy0ZNN7YIZM1s4d4CCdzyTxh9BfSOY
         1YyEuJjiX/wGbhABg8AUevr/KNr1C4pZ7DJ9qveQW3sM72WT79FTeBgtWVK81q25EJnT
         v89ZAffc2jqAFCvXNZp2hCCqO45o8lbUFS53qqWCaPGHCmO4IAjv2HpP15tSiZtxbI4q
         nGuCoUQxEjajPw4B/jgtkxHhAepExZ14KMPoYFn0afIWh1Ks6FKaouseTookhJylK1xU
         80aqdMU1vYR5SfSWXOqlMXzmOknvl2aWu38V2jNmxgMpQElzJVxLoOutsjzbrwDQmK5v
         kEFw==
X-Gm-Message-State: AGi0Pua+D1vgudSkbjWHMniqI/qol+EZOXK6R7NPBcGBhmeYpq7iLCfb
        SCEEHjR6W5Ivi72/LNyZMa48GhoPUggLWtNOUpVKuvaerQY2ZShIGGzWQkTxzxJZvkMJ7lBuoaQ
        w4GYVAQ5ScScHWwxKkStEwS75ifxxYcr0uE0cAuzDbA==
X-Received: by 2002:a05:600c:29c2:: with SMTP id s2mr6231405wmd.111.1586768400904;
        Mon, 13 Apr 2020 02:00:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6ZEAMCe4PeQmXuzneBQEL00VI+kt+86GcGd2t8+RrOemXQ9+gOPyd/IPCHDxWNN6beyUQRA==
X-Received: by 2002:a05:600c:29c2:: with SMTP id s2mr6231381wmd.111.1586768400509;
        Mon, 13 Apr 2020 02:00:00 -0700 (PDT)
Received: from localhost (host123-127-dynamic.36-79-r.retail.telecomitalia.it. [79.36.127.123])
        by smtp.gmail.com with ESMTPSA id m15sm13477488wmc.35.2020.04.13.01.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 02:00:00 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:59:58 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: introduce fixed-size readahead policy
Message-ID: <20200413085958.GA777469@xps-13>
References: <20200412150449.GA740985@xps-13>
 <87d08c89fl.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d08c89fl.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:24:14AM +0800, Huang, Ying wrote:
> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> > Introduce a new fixed-size swap-in readahead policy that can be selected
> > at run-time.
> >
> > The global swap-in readahead policy takes in account the previous access
> > patterns, using a scaling heuristic to determine the optimal readahead
> > chunk dynamically.
> >
> > This works pretty well in most cases, but like any heuristic there are
> > specific cases when this approach is not ideal, for example the swapoff
> > scenario.
> >
> > During swapoff we just want to load back into memory all the swapped-out
> > pages and for this specific use case a fixed-size readahead is more
> > efficient.
> >
> > This patch introduces a new sysfs interface
> > (/sys/kernel/mm/swap/swap_ra_policy) that can be set as following:
> >
> >  - 0: current scaling swap-in readahead policy (default)
> >  - 1: fixed-size readahead policy (size is determined by
> >       vm.page-cluster)
> >
> > The specific use case this patch is addressing is to improve swapoff
> > performance when a VM has been hibernated, resumed and all memory needs
> > to be forced back to RAM by disabling swap (see the test case below).
> 
> I don't know whether the use case is important or not.  Usually the
> performance of swapoff doesn't matter.  Maybe you can provide some
> information on this.

In general yes, I agree, swapoff performance is not that important.

This particular optimization has been tested a lot in the Ubuntu AWS
kernel and it seems to speed up consistently the resume of hibernated
EC2 instances (see also [1]).

So we were considering to upstream this, if we find a way to make it
more suitable for mainline inclusion.

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html

> 
> Even if it's important, I don't think we really need to add another ABI.
> You can just optimize the swapoff performance inside kernel.  And we may
> not even need to add a new policy, just use cluster readahead and
> increase swapin_readahead_hits in swapoff if cluster readahead is used.

OK, instead of adding a new ABI I can make this optimization directly in
the kernel, so that when swapoff runs it can automatically use the
fixed-size cluster readahead and continue using the default readahead
for everything else.

I'll play a bit with this and will send a new patch.

Thanks!
-Andrea
