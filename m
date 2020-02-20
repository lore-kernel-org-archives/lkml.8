Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F3FC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CF1208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582187365;
	bh=ZebiJDWQAcplpLQYOd5lEDYWwQlgeKCH5PTtGSAP74I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EJcS/od399ceBoVRW0X+dLf0qZqnwiiWJ784+KgaD2Qrx2x7MlfUsG9R7+G7L2/ho
	 X8N/V3cJetEOzcpFsPjbGt2uH6JdeBJNK9qKcQcOcZFiiWTEemy3CD8dRuXZjMrBHJ
	 4lit2yo9VOL/vB9bkZDa3W5M0ZT7M5HJKRCWZ6/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBTI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:29:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgBTI3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:29:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id e8so3584391wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pcVb7tYtjd5vJy2GdOdQXq1b2D4fCTq0JpAZZtr5yr0=;
        b=SvhgGKg0zhNAYvi8E1HKvGl2fXLxJveVVsHR+Wf737kBQhBZcBq09u12VCFTB+I0Fo
         YKTmElL5sG/Gwze/4LAVJgD586SFm/qGMuZ7YrVpkF9N4kYC0/vepCMeNsGPwxncM7w2
         z/nkJmNCfRdlfrPj4FdnKdbkkcI68nj2Io42NZ5YuRub14sFH4QtxTEDp1o1ZTZCOtmW
         igEICm+X71KGPxu/n6r/JAMmjfT4XpmeL8+dSAhawvWnZkYdd+l3eqeqqMmDlGqUi4yY
         haJahYVY9dnhGNzhcfgFFa3nqhGU6nLsCCc9s07aEWKFeIkaB5Suk0dVJev60OtfbqmZ
         mkmA==
X-Gm-Message-State: APjAAAXOHkEmhM0u+rrboGl5tQDmaYX8gUpqyY7WLucz5fyCC/sv838b
        veuWM9UYFBS+Wn1X2yNtQ7A=
X-Google-Smtp-Source: APXvYqznloAc7/YvN2REE3Ur5hUHLeUc0Ogh8t5kKphHGasqgO/VXOdODTu2+evN2nivuKVMKGzQBA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr40472712wru.353.1582187361702;
        Thu, 20 Feb 2020 00:29:21 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id h128sm3895837wmh.33.2020.02.20.00.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:29:20 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:29:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200220082919.GC20509@dhcp22.suse.cz>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219204220.GA3488@sultan-book.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-02-20 12:42:20, Sultan Alsawaf wrote:
> On Wed, Feb 19, 2020 at 09:05:27PM +0100, Michal Hocko wrote:
[...]
> > Again, do you have more details about the workload and what was the
> > cause of responsiveness issues? Because I would expect that the
> > situation would be quite opposite because it is usually the direct
> > reclaim that is a source of stalls visible from userspace. Or is this
> > about a single CPU situation where kswapd saturates the single CPU and
> > all other tasks are just not getting enough CPU cycles?
> 
> The workload was having lots of applications open at once. At a certain point
> when memory ran low, my system became sluggish and kswapd CPU usage skyrocketed.

Could you provide more details please? Is kswapd making a forward
progress? Have you checked why other precesses are slugish? They do not
get CPU time or they are blocked on something?

> I added printks into kswapd with this patch, and my premature exit in kswapd
> kicked in quite often.
> 
> > > On systems with more memory I tested (>=4G), kswapd becomes more expensive to
> > > run at its higher scan depths, so stopping kswapd prematurely when there aren't
> > > any memory allocations waiting for it prevents it from reaching the *really*
> > > expensive scan depths and burning through even more resources.
> > > 
> > > Combine a large amount of memory with a slow CPU and the current problematic
> > > behavior of kswapd at high memory pressure shows. My personal test scenario for
> > > this was an arm64 CPU with a variable amount of memory (up to 4G RAM + 2G swap).
> > 
> > But still, somebody has to put the system into balanced state so who is
> > going to do all the work?
> 
> All the work will be done by kswapd of course, but only if it's needed.
> 
> The real problem is that a single memory allocation failure, and free memory
> being some amount below the high watermark, are not good heuristics to predict
> *future* memory allocation needs. They are good for determining how to steer
> kswapd to help satisfy a failed allocation in the present, but anything more is
> pure speculation (which turns out to be wrong speculation, since this behavior
> causes problems).

Well, you might be right that there might be better heuristics than the
existing watermark based one. After all nobody can predict the future.
The existing heuristic aims at providing min_free_kbytes of free memory
as much as possible and that tends to work reasonably well for a large
set of workloads.

> If there are outstanding failed allocations that won't go away, then it's
> perfectly reasonable to keep kswapd running until it frees pages up to the high
> watermark. But beyond that is unnecessary, since there's no way to know if or
> when kswapd will need to fire up again. This makes sense considering how kswapd
> is currently invoked: it's fired up due to a failed allocation of some sort, not
> because the amount of free memory dropped below the high watermark.

Very broadly speaking (sorry if I am stating obvious here), the kswapd
is woken up when the allocator hits low watermark or the reguested high
order pages are depleted. Then allocator enters its slow path. That
means that the background reclaim then aims at reclaiming the high-low
watermark gap or invokes compaction to keep the balance. It takes to
consume that gap to wake the kswapd again for order-0 (most common)
requests. So this is usually not about a single allocation to trigger
the background reclaim and counting failures on low watermark attempts
is unlikely to work with the current code as you suggested.
-- 
Michal Hocko
SUSE Labs
