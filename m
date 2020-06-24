Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59313C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3753D20885
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592992057;
	bh=ZbhwDk8zK/eWB5vr5J8R6CaE49jkxXNPHGXx8QOmvTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0oeATUJrpNbhJIXOPPILXtBbEEDoxZCikb3xzrPSWr78I0eR6SFDlz+qEL3pu73jJ
	 r/oVtDoUJW1jEBOtzh2jXR5lPeVE0rGuHQIiFMnrI+HtAR2Ks9AZ2NxrsyuZdqRktJ
	 y8bQhL/4hxNmx8Fk4fnlL7yzauhdDYa9XgGT+Lr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbgFXJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:47:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38247 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbgFXJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:47:35 -0400
Received: by mail-ed1-f65.google.com with SMTP id cy7so1014619edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 02:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sM2oWwoDBtn4yXPlxoFaATCDPS2GuuFuvEzIEsjdUnI=;
        b=g+qX/+pzVwXBT6osZkheGdLTlO+26DeGeUJZhSmw5qDrFuls12iNIMlzcykmPIl7O0
         FqfSciMNwgY8gDSXwSrEOWirb5STXxZDkWWBU5R2HhWyngB4RpmsclZ7Qb8VBhMmeCZZ
         S1aQNMBx+VcnzC/5peIALmXhWAFLPev4V7q+ZNu0ygPGnxEB9Yp0Ny2ZzJsWZoKM9tqY
         mXihYkREta58lHDcgbc3+051bdCyxWK8YVl4IgEfpHMgG1KOi6xbCO6nwWSVu8yx2MoC
         VYT1EBh3XyfircKJrVKH0c/ZlEd1rMIS7jlL9axf9t2ystwbdj8LWq7rxTssCAfN5X2p
         xS4Q==
X-Gm-Message-State: AOAM53208Gd4EC5IFDqANv3LQU38e9uY7WRa7GYww+k0HAw+PjuL5msV
        lAyjFo5R3/76neRtJ7jFWP/c8cqX
X-Google-Smtp-Source: ABdhPJzMLr63mqGrkFdxdRTARyOnbogYQGWZNhsvMCY17e7Zt06rYikB9+H4/+7lUOw2QkbuquWIYQ==
X-Received: by 2002:aa7:c756:: with SMTP id c22mr26316545eds.239.1592992052986;
        Wed, 24 Jun 2020 02:47:32 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id fi29sm3416940ejb.83.2020.06.24.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 02:46:01 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:45:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Feng Tang <feng.tang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200624094552.GI1320@dhcp22.suse.cz>
References: <1592725000-73486-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592725000-73486-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I do not see these patches in mmotm tree. Is there anything
blocking them? There used to be v3 in the tree
(http://lkml.kernel.org/r/1589611660-89854-4-git-send-email-feng.tang@intel.com)
but that one got dropped due some failures. I haven't seen any failures
for this one.

On Sun 21-06-20 15:36:37, Feng Tang wrote:
> When checking a performance change for will-it-scale scalability
> mmap test [1], we found very high lock contention for spinlock of
> percpu counter 'vm_committed_as':
> 
>     94.14%     0.35%  [kernel.kallsyms]         [k] _raw_spin_lock_irqsave
>     48.21% _raw_spin_lock_irqsave;percpu_counter_add_batch;__vm_enough_memory;mmap_region;do_mmap;
>     45.91% _raw_spin_lock_irqsave;percpu_counter_add_batch;__do_munmap;
> 
> Actually this heavy lock contention is not always necessary. The
> 'vm_committed_as' needs to be very precise when the strict
> OVERCOMMIT_NEVER policy is set, which requires a rather small batch
> number for the percpu counter.
> 
> So keep 'batch' number unchanged for strict OVERCOMMIT_NEVER policy,
> and enlarge it for not-so-strict  OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS
> policies.
> 
> Benchmark with the same testcase in [1] shows 53% improvement on a
> 8C/16T desktop, and 2097%(20X) on a 4S/72C/144T server. And for that
> case, whether it shows improvements depends on if the test mmap size
> is bigger than the batch number computed.
> 
> We tested 10+ platforms in 0day (server, desktop and laptop). If we
> lift it to 64X, 80%+ platforms show improvements, and for 16X lift,
> 1/3 of the platforms will show improvements.
> 
> And generally it should help the mmap/unmap usage,as Michal Hocko
> mentioned:
> 
> : I believe that there are non-synthetic worklaods which would benefit
> : from a larger batch. E.g. large in memory databases which do large
> : mmaps during startups from multiple threads.
> 
> Note: There are some style complain from checkpatch for patch 3,
> as sysctl handler declaration follows the similar format of sibling
> functions
> 
> [1] https://lore.kernel.org/lkml/20200305062138.GI5972@shao2-debian/
> 
> patch1: a cleanup for /proc/meminfo
> patch2: a preparation patch which also improve the accuracy of
>         vm_memory_committed
> patch3: main change
> 
> This is against today's linux-mm git tree on github.
> 
> Please help to review, thanks!
> 
> - Feng
> 
> ----------------------------------------------------------------
> Changelog:
> 
>   v5:
>     * rebase after 5.8-rc1
>     * remove the 3/4 patch in v4  which is merged in v5.7
>     * add code comments for vm_memory_committed() 
> 
>   v4:
>     * Remove the VM_WARN_ONCE check for vm_committed_as underflow,
>       thanks to Qian Cai for finding and testing the warning
> 
>   v3:
>     * refine commit log and cleanup code, according to comments
>       from Michal Hocko and Matthew Wilcox
>     * change the lift from 16X and 64X after test 
>   
>   v2:
>     * add the sysctl handler to cover runtime overcommit policy
>       change, as suggested by Andres Morton 
>     * address the accuracy concern of vm_memory_committed()
>       from Andi Kleen 
> 
> Feng Tang (3):
>   proc/meminfo: avoid open coded reading of vm_committed_as
>   mm/util.c: make vm_memory_committed() more accurate
>   mm: adjust vm_committed_as_batch according to vm overcommit policy
> 
>  fs/proc/meminfo.c    |  2 +-
>  include/linux/mm.h   |  2 ++
>  include/linux/mman.h |  4 ++++
>  kernel/sysctl.c      |  2 +-
>  mm/mm_init.c         | 18 ++++++++++++++----
>  mm/util.c            | 19 ++++++++++++++++++-
>  6 files changed, 40 insertions(+), 7 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
Michal Hocko
SUSE Labs
