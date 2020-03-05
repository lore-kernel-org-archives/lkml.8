Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27920C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89FD2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvFLP/U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCEIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:52:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33485 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCEIwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:52:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so2454864pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yatntrVjNOH1cXxg+TyXWzHXHNZ3Frt3LUgsMEJ4bhU=;
        b=WvFLP/U+fscJa5vPYQE/Fwi8f27OCyGk4eUdtqujYSC7uYLK5F8PK8gNPwtxTslqpt
         r9FBQ4agIhISu0sC0nZOMXVEX3/7Gd4j07piAZ2KddM4otZY37lN0NBRVDJ89lWL9Q+n
         rZDAEvzjqR8m/0nHMgLaiMvXR4EbclNXPaGgiijF9zjoBsKdcjGfDWGkYzFaG/h+xnLs
         ZDI0y1AA4B8XBeJmVUUZLdqJhJtt90RPSdjGRwx7aM4MrEErKIs9W3vmo6fL0Mnm0oBI
         muZEakjmaFskim/faSKLydvWw31sCZnF/87JTKplvbTKsr9+T02VTaHO+4BveC1IFOl5
         Y9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yatntrVjNOH1cXxg+TyXWzHXHNZ3Frt3LUgsMEJ4bhU=;
        b=ruohP5S5ZQYD3rVB6q9wqjSkjWNrJZXbX+qnJ33Lzs/l5SlZZgt2REY0Iwv7XU6ONV
         WlvuiTrdo4eQldQOtCM1e/p6PtpjMuPO2dZdX5/w7H0TX8qGJfHyakTzbhvahnmE7jQx
         Z2DRs0VOz+SRZ7OktRnvSaWpfnSthAW0LH8ixllMjPe14+4drYjPOwHbQQ8eIoj3tQ6S
         maZ0gttWPkryA1JYOkCkvnJ3v8Mp1vDrCVwgPq1d5qOLn8uCbUaJzI4thQwuBP79A/3C
         uwW1cXvj6qDXIZWYxwxCSbs1jJ52/sSNt/RxeVGtvHsW8QhHxe10jHUOAi7wO7ANG7Gn
         y5Gw==
X-Gm-Message-State: ANhLgQ2o8349k+3q8J8bLmWpryvOnwfQtkg5DrV9JFDjeXHAG/6IRvWJ
        hauQONEbUdafPtxidUtQRBDYiQS5MVA=
X-Google-Smtp-Source: ADFU+vt3mj/FmV9NiPYvblYuLd+6KCu943rdxYVaPWQmzCv+FJ5In40PK8mWsJuj+aM6sMuJ+q3j1g==
X-Received: by 2002:a63:7a02:: with SMTP id v2mr6471878pgc.13.1583398361211;
        Thu, 05 Mar 2020 00:52:41 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id m59sm5588671pjb.41.2020.03.05.00.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 00:52:40 -0800 (PST)
Date:   Thu, 5 Mar 2020 16:52:31 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200305085231.GA12108@ziqianlu-desktop.localdomain>
References: <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com>
 <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
 <bcd601e7-3f15-e340-bebe-a6ca3635dacb@linux.intel.com>
 <a55bb7a5-bb20-d3f3-e634-4dfda1ac6005@linux.intel.com>
 <67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com>
 <20200305043330.GA8755@ziqianlu-desktop.localdomain>
 <b386bd08-112d-df30-256c-dee85780abbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b386bd08-112d-df30-256c-dee85780abbc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:10:36PM +0800, Li, Aubrey wrote:
> On 2020/3/5 12:33, Aaron Lu wrote:
> > On Wed, Mar 04, 2020 at 07:54:39AM +0800, Li, Aubrey wrote:
> >> On 2020/3/3 22:59, Li, Aubrey wrote:
> >>> On 2020/2/29 7:55, Tim Chen wrote:
> > ...
> >>>> In Vinnet's fix, we only look at the currently running task's weight in
> >>>> src and dst rq.  Perhaps the load on the src and dst rq needs to be considered
> >>>> to prevent too great an imbalance between the run queues?
> >>>
> >>> We are trying to migrate a task, can we just use cfs.h_nr_running? This signal
> >>> is used to find the busiest run queue as well.
> >>
> >> How about this one? the cgroup weight issue seems fixed on my side.
> > 
> > It doesn't apply on top of your coresched_v4-v5.5.2 branch, so I
> > manually allied it. Not sure if I missed something.
> 
> Here is a rebase version on coresched_v5 Vineeth released this morning:
> https://github.com/aubreyli/linux/tree/coresched_V5-v5.5.y-rc1
> 
> > 
> > It's now getting 4 cpus in 2 cores. Better, but not back to normal yet..
> 
> I always saw higher weight tasks getting 8 cpus in 4 cores on my side.
> Are you still running 8+16 sysbench cpu threads? 

I used the wrong workload for high weight cgroup. After using sysbench
for high weight cgroup, I also see the problem fixed. Sorry for the noise.

P.S. I used redis-server as the high weight workload this morning, it has
some softirq processing and I guess that makes things not as expected.

Thanks,
Aaron

> 
> I replicated your setup, the cpuset with 8cores 16threads, cpu mode 8 sysbench
> threads with cpu.shares=10240, 16 sysbench threads with cpu.shares=2, and here
> is the data on my side.
> 
> 				weight(10240)		weight(2)
> coresched disabled		324.23(eps)		356.43(eps)
> coresched enabled		340.74(eps)		311.62(eps)
> 
> It seems higher weight tasks win this time and lower weight tasks have ~15%
> regression(not big deal?), did you see anything worse?
> 
> Thanks,
> -Aubrey
