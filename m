Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8444C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C05206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGJBi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:38:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:54468 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGJBi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:38:57 -0400
IronPort-SDR: gc5Vh39+QKVzEaM/NkbBAVfRAKApDI3Cs3T3Yi07aWoQyEFM9iETrVx7lSfcTRy5QlFIdJQxwz
 QCG8V6kKrpFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213026005"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="213026005"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 18:38:57 -0700
IronPort-SDR: DUNzVXPVrW3IdxBt0PFf/u4qSk0qUtQG8ygfohLI7A7qxQgeztZpE0n08k4DUvTjVTG60Iq2Pe
 4s3EFmeff8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="268908898"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 18:38:52 -0700
Date:   Fri, 10 Jul 2020 09:38:52 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200710013852.GB81727@shbuild999.sh.intel.com>
References: <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
 <20200706133434.GA3483883@tassilo.jf.intel.com>
 <20200707023829.GA85993@shbuild999.sh.intel.com>
 <87zh8c7z5i.fsf@yhuang-dev.intel.com>
 <20200707054120.GC21741@shbuild999.sh.intel.com>
 <20200709045554.GA56190@shbuild999.sh.intel.com>
 <20200709134040.GA1110@lca.pw>
 <20200709141519.GA81727@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709141519.GA81727@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:15:19PM +0800, Feng Tang wrote:
> Hi Qian Cai,
> 
> On Thu, Jul 09, 2020 at 09:40:40AM -0400, Qian Cai wrote:
> > > > > Can we change the batch firstly, then sync the global counter, finally
> > > > > change the overcommit policy?
> > > > 
> > > > These reorderings are really head scratching :)
> > > > 
> > > > I've thought about this before when Qian Cai first reported the warning
> > > > message, as kernel had a check: 
> > > > 
> > > > 	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> > > > 			-(s64)vm_committed_as_batch * num_online_cpus(),
> > > > 			"memory commitment underflow");
> > > > 
> > > > If the batch is decreased first, the warning will be easier/earlier to be
> > > > triggered, so I didn't brought this up when handling the warning message.
> > > > 
> > > > But it might work now, as the warning has been removed.
> > > 
> > > I tested the reorder way, and the test could pass in 100 times run. The
> > > new order when changing policy to OVERCOMMIT_NEVER:
> > >   1. re-compute the batch ( to the smaller one)
> > >   2. do the on_each_cpu sync
> > >   3. really change the policy to NEVER.
> > > 
> > > It solves one of previous concern, that after the sync is done on cpuX,
> > > but before the whole sync on all cpus are done, there is a window that
> > > the percpu-counter could be enlarged again.
> > > 
> > > IIRC Andi had concern about read side cost when doing the sync, my
> > > understanding is most of the readers (malloc/free/map/unmap) are using
> > > percpu_counter_read_positive, which is a fast path without involving lock.
> > > 
> > > As for the problem itself, I agree with Michal's point, that usually there
> > > is no normal case that will change the overcommit_policy too frequently.
> > > 
> > > The code logic is mainly in overcommit_policy_handler(), based on the
> > > previous sync fix. please help to review, thanks!
> > > 
> > > int overcommit_policy_handler(struct ctl_table *table, int write, void *buffer,
> > > 		size_t *lenp, loff_t *ppos)
> > > {
> > > 	int ret;
> > > 
> > > 	if (write) {
> > > 		int new_policy;
> > > 		struct ctl_table t;
> > > 
> > > 		t = *table;
> > > 		t.data = &new_policy;
> > > 		ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
> > > 		if (ret)
> > > 			return ret;
> > > 
> > > 		mm_compute_batch(new_policy);
> > > 		if (new_policy == OVERCOMMIT_NEVER)
> > > 			schedule_on_each_cpu(sync_overcommit_as);
> > > 		sysctl_overcommit_memory = new_policy;
> > > 	} else {
> > > 		ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > > 	}
> > > 
> > > 	return ret;
> > > }
> > 
> > Rather than having to indent those many lines, how about this?
> 
> Thanks for the cleanup suggestion.
> 
> > t = *table;
> > t.data = &new_policy;
> 
> The input table->data is actually &sysctl_overcommit_memory, so
> there is a problem for "read" case, it will return the 'new_policy'
> value instead of real sysctl_overcommit_memory.
> 
> It should work after adding a check
> 	if (write)
> 		t.data = &new_policy;
> 
> > ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> 			    --> &t
 
Give it a second thought, my previous way has more indents and lines,
but it is easier to be understood that we have special handling for
'write' case. So I would prefer using it. 

Thoughts?

Thanks,
Feng

> Thanks,
> Feng
> 	
> > if (ret || !write)
> > 	return ret;
> > mm_compute_batch(new_policy);
> > if (new_policy == OVERCOMMIT_NEVER)
> > 	schedule_on_each_cpu(sync_overcommit_as);
> > 
> > sysctl_overcommit_memory = new_policy;
> > return ret;
