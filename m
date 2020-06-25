Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FCDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7F820767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593097955;
	bh=GtkQDVRl4dJJvJE0FAxDDNtvgX3tNb3dQjlSNXK990c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bzYgGuq+Ju43Ii4O6x9cMKxbyYgx+ljmtMzhUi+no3j3PC4H9MUzdYpdyN5MckZjg
	 ZsEK0cZUIX4/9cTlf7O/Zm+bYmq4i2aGXQxnpv/D7NAtRYoGqH8QjCw2ScPt5xzZRz
	 y5aFbwo2Dy5ieoBVV394XXXpsF1TypH1jQ6FeI1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405578AbgFYPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:12:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39119 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405425AbgFYPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:12:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id q5so6225373wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 08:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdxVf6vP79BMfcPB59swOSXedDJpX0cQVnYY/hZ9KZQ=;
        b=L+0Yx6pKgp3oJDf0EFfdPK5ZOlYvtduV8dsIu6CXoC4udoXiOPFohGhujHqkKlz9nb
         lwJik+BgfredJAannvumZhGOomFIjNKFHXSYRGag4Kvz8SQoxW/x0+rOQjI560ovxgOI
         9J+YT1EOaceYlsue1OZ7hckhRAzh7Lv8gG917hEyedPKcUJp7FlfPHjMOH6+GlNCEdep
         I9DxfTeOMIsBPBPTfzZnX6sLL7OboS20gE8GRRBqvfO9AcSPO/D4QM7mS5VdcBMu0vJU
         qHcVPU1KwMA7uqtdMVDwXS3imzuZADGpqnHGzKkmGi1pMG2XfoaL9GR1smMNrdSCcKac
         BhPQ==
X-Gm-Message-State: AOAM5301PosXL6koJ0u6Js3CzlkS04LjkwrTBJ3eMMTVqo98BHgsRw9N
        vCIkm2RwyOruVAdXMJXkSTo=
X-Google-Smtp-Source: ABdhPJwGVQIqx5ePGDHbr6RmWFkkyWM9E3xiJlzfuHlZjnvupf4cZ5UBiAyLNuseyyaLSlxPtcPRrA==
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr1554369wrs.365.1593097949960;
        Thu, 25 Jun 2020 08:12:29 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id t2sm12315490wma.43.2020.06.25.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 08:12:28 -0700 (PDT)
Date:   Thu, 25 Jun 2020 17:12:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625151227.GP1320@dhcp22.suse.cz>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200625075725.GC1320@dhcp22.suse.cz>
 <159308284703.4527.16058577374955415124@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159308284703.4527.16058577374955415124@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-06-20 12:00:47, Chris Wilson wrote:
> Quoting Michal Hocko (2020-06-25 08:57:25)
> > On Wed 24-06-20 20:14:17, Chris Wilson wrote:
> > > A general rule of thumb is that shrinkers should be fast and effective.
> > > They are called from direct reclaim at the most incovenient of times when
> > > the caller is waiting for a page. If we attempt to reclaim a page being
> > > pinned for active dma [pin_user_pages()], we will incur far greater
> > > latency than a normal anonymous page mapped multiple times. Worse the
> > > page may be in use indefinitely by the HW and unable to be reclaimed
> > > in a timely manner.
> > > 
> > > A side effect of the LRU shrinker not being dma aware is that we will
> > > often attempt to perform direct reclaim on the persistent group of dma
> > > pages while continuing to use the dma HW (an issue as the HW may already
> > > be actively waiting for the next user request), and even attempt to
> > > reclaim a partially allocated dma object in order to satisfy pinning
> > > the next user page for that object.
> > 
> > You are talking about direct reclaim but this path is shared with the
> > background reclaim. This is a bit confusing. Maybe you just want to
> > outline the latency in the reclaim which is more noticeable in the
> > direct reclaim to the userspace. This would be good to be clarified.
> > 
> > How much memory are we talking about here btw?
> 
> It depends. In theory, it is used sparingly. But it is under userspace
> control, exposed via Vulkan, OpenGL, OpenCL, media and even old XShm. If
> all goes to plan the application memory is only pinned for as long as the
> HW is using it, but that is an indefinite period of time and an indefinite
> amount of memory. There are provisions in place to impose upper limits
> on how long an operation can last on the HW, and the mmu-notifier is
> there to ensure we do unpin the memory on demand. However cancelling a
> HW operation (which will result in data loss and often process
> termination due to an unfortunate sequence of events when userspace
> fails to recover) for a try_to_unmap on behalf of the LRU shrinker is not
> a good choice.

OK, thanks for the clarification. What and when should MM intervene to
prevent potential OOM?
  
[...]
> > Btw. overall intention of the patch is not really clear to me. Do I get
> > it right that this is going to reduce latency of the reclaim for pages
> > that are not reclaimable anyway because they are pinned? If yes do we
> > have any numbers for that.
> 
> I can plug it into a microbenchmark ala cycletest to show the impact...
> Memory filled with 64M gup objects, random utilisation of those with
> the GPU; background process filling the pagecache with find /; reporting
> the time difference from the expected expiry of a timer with the actual:
> [On a Geminilake Atom-class processor with 8GiB, average of 5 runs, each
> measuring mean latency for 20s -- mean is probably a really bad choice
> here, we need 50/90/95/99]
> 
> direct reclaim calling mmu-notifier:
> gem_syslatency: cycles=2122, latency mean=1601.185us max=33572us
> 
> skipping try_to_unmap_one with page_maybe_dma_pinned:
> gem_syslatency: cycles=1965, latency mean=597.971us max=28462us
> 
> Baseline (background find /; application touched all memory, but no HW
> ops)
> gem_syslatency: cycles=0, latency mean=6.695us max=77us
> 
> Compare with the time to allocate a single THP against load:
> 
> Baseline:
> gem_syslatency: cycles=0, latency mean=1541.562us max=52196us
> Direct reclaim calling mmu-notifier:
> gem_syslatency: cycles=2115, latency mean=9050.930us max=396986us
> page_maybe_dma_pinned skip:
> gem_syslatency: cycles=2325, latency mean=7431.633us max=187960us
> 
> Take with a massive pinch of salt. I expect, once I find the right
> sequence, to reliably control the induced latency on the RT thread.
> 
> But first, I have to look at why there's a correlation with HW load and
> timer latency, even with steady state usage. That's quite surprising --
> ah, I had it left to PREEMPT_VOLUNTARY and this machine has to scan
> every request submitted to HW. Just great.
> 
> With PREEMPT:
> Timer:
> Base:    gem_syslatency: cycles=0, latency mean=8.823us max=83us
> Reclaim: gem_syslatency: cycles=2224, latency mean=79.308us max=4805us
> Skip:    gem_syslatency: cycles=2677, latency mean=70.306us max=4720us
> 
> THP:
> Base:    gem_syslatency: cycles=0, latency mean=1993.693us max=201958us
> Reclaim: gem_syslatency: cycles=1284, latency mean=2873.633us max=295962us
> Skip:    gem_syslatency: cycles=1809, latency mean=1991.509us max=261050us
> 
> Earlier caveats notwithstanding; confidence in results still low.
> 
> And refine the testing somewhat, if at the very least gather enough
> samples for credible statistics.

OK, so my understanding is that the overall impact is very low. So what
is the primary motivation for the patch? Prevent from a pointless work -
aka invoke the notifier?

-- 
Michal Hocko
SUSE Labs
