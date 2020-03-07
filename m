Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E2EC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27505206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHA7XKgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCGDOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:14:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42302 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgCGDOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:14:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so1953591pgs.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JLaY/mwaUY5Lw3+X8HHyKsKco3Sn1Zy97OVjrAF44zg=;
        b=PHA7XKguacwBINKxP1kYumjzpt88nlSoF/bQ1UrLVpBLfk1AxhV43/VCSJ/G5gt7uM
         N4EZgwScVyjs+P9plXz8u5YyHRRxYlwiKPvfAqXKn8hYj+SsOcV/R1WO217ZNg37cxH8
         0baSMt7bS/D322XiSv8+nNo8zZbz9j57Fpg52BuJYgqbFDXDXKWyoRbJIUNfSBFRJOzf
         bK/V2GgeWno9hW5qCfa7mzZ2mLssw49ONERCUFRwqo9B2SiddXO37y9xT8ahekO/+kCy
         ROpPdSbRcw0JYyzYsbN6KgLSL09HEpTZ34YFzzIJjccsy7sfBulqrYMFa7pTAglZXxfU
         MSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLaY/mwaUY5Lw3+X8HHyKsKco3Sn1Zy97OVjrAF44zg=;
        b=R3hg4a9njjYIbZcUZuyBbEPgpDX7fbjFdX8vtiI1exKUug4/+cM0ONXiu6H5K9+0fW
         j+lT2he9qF2F0Ps6W+sv7IYeGU0p94H4kKhorQQOA82KEG5Hvc0+ZvaO6SoPIJDHjHKe
         8uz3p/mGScfYusNQkGciOEMk10JjNNoFNlZYuUQ4J086aSprWlIz8UlhDLHOn+UIKktm
         sv+kRTAHDRfxdkCLC0iTHswORghHTSWb2TSPOeE9RxgCKR+3vQbL/FIPqU7FthM7wO5y
         hSifbyISsz1Cwhs6/JL+3BnEdtQJOUH4cqxCFnUXSde60f0gsPTJ3+6ANDVj3LxEOpTl
         QrzA==
X-Gm-Message-State: ANhLgQ1KWSFIlCu4KZA+jRMih6+HqodQzUOnwkjj/vQdnLoGU5Dy2HXf
        2nMeBN4yBUB3i8Y3l9mxg8w=
X-Google-Smtp-Source: ADFU+vswFrjlVf8UdNcR2Cz7hZrcblVbc2RW0rVxR3WGbS8yzKY35UsHs64fff9cum5JZWCo1ayu8w==
X-Received: by 2002:aa7:9726:: with SMTP id k6mr6838588pfg.196.1583550839714;
        Fri, 06 Mar 2020 19:13:59 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id 9sm32532232pge.65.2020.03.06.19.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 19:13:58 -0800 (PST)
Date:   Sat, 7 Mar 2020 11:13:50 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Phil Auld <pauld@redhat.com>, Aubrey Li <aubrey.intel@gmail.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200307031312.GA8101@ziqianlu-desktop.localdomain>
References: <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain>
 <20200227141032.GA30178@pauld.bos.csb>
 <20200228025405.GA634650@ziqianlu-desktop.localdomain>
 <CAERHkrunq=BqB=NmS2b_BfjePX2+nNpbv1EfTWw5rExbvYHyJw@mail.gmail.com>
 <20200306024116.GA16400@ziqianlu-desktop.localdomain>
 <98719a4e-f620-dc8c-f29f-fd63c43e1597@linux.intel.com>
 <20200306183340.GC23145@pauld.bos.csb>
 <9bf44d68-de78-66d5-ea8c-6cc8a30d90c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf44d68-de78-66d5-ea8c-6cc8a30d90c0@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 01:44:08PM -0800, Tim Chen wrote:
> On 3/6/20 10:33 AM, Phil Auld wrote:
> > On Fri, Mar 06, 2020 at 10:06:16AM -0800 Tim Chen wrote:
> >> On 3/5/20 6:41 PM, Aaron Lu wrote:
> >>
> >>>>> So this appeared to me like a question of: is it desirable to protect/enhance
> >>>>> high weight task performance in the presence of core scheduling?
> >>>>
> >>>> This sounds to me a policy VS mechanism question. Do you have any idea
> >>>> how to spread high weight task among the cores with coresched enabled?
> >>>
> >>> Yes I would like to get us on the same page of the expected behaviour
> >>> before jumping to the implementation details. As for how to achieve
> >>> that: I'm thinking about to make core wide load balanced and then high
> >>> weight task shall spread on different cores. This isn't just about load
> >>> balance, the initial task placement will also need to be considered of
> >>> course if the high weight task only runs a small period.
> >>>
> >>
> >> I am wondering why this is not happening:  
> >>
> >> When the low weight task group has exceeded its cfs allocation during a cfs period, the task group
> >> should be throttled.  In that case, the CPU cores that the low
> >> weight task group occupies will become idle, and allow load balance from the
> >> overloaded CPUs for the high weight task group to migrate over.  
> >>
> > 
> > cpu.shares is not quota. I think it will only get throttled if it has and 
> > exceeds quota.  Shares are supposed to be used to help weight contention
> > without providing a hard limit. 
> > 
> 
> Ah yes.  cpu.quota is not set in Aaron's test case.  
> 
> That said, I wonder if the time consumed is getting out of whack with the 
> cpu shares assigned, we can leverage the quota mechanism to throttle
> those cgroup that have overused their shares of cpu.  Most of the stats and machinery
> needed are already in the throttling mechanism.  

cpu.quota is not work conserving IIUC, it will reduce noise workload's
performance when real workload has no demand for CPU.

Also, while not exceeding quota, the noise workload can still hurt real
workload's performance. To protect real workload from noise, cpu.shares
and SCHED_IDLE seems appropriate but the implementation may not be
enough as of now.

> 
> I am hoping that allowing task migration with task group mismatch
> under large load imbalance between CPUs will be good enough.

I also hope so :-)
