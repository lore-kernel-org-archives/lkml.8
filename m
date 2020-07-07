Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E65C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238DF20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGGFl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:41:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:23108 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGGFlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:41:25 -0400
IronPort-SDR: pvE1meqStglqeqmBLwmoMCQS/57BBUZ7zDJbmAlPXbvtxJc5ZXpKVVd9RcZok8UM0hCNrNDlvo
 FQayTIGKZYuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127628928"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="127628928"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 22:41:25 -0700
IronPort-SDR: FSNhW8VrQIYxVDuURu1WYzQeuKzoq5PkkMeyvVkFPYE7Bnx91dYtbXg4fQc8qLYQNQuiSNl9l0
 ve7HLN6ylEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="305536538"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2020 22:41:20 -0700
Date:   Tue, 7 Jul 2020 13:41:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707054120.GC21741@shbuild999.sh.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
 <20200706133434.GA3483883@tassilo.jf.intel.com>
 <20200707023829.GA85993@shbuild999.sh.intel.com>
 <87zh8c7z5i.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh8c7z5i.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 12:00:09PM +0800, Huang, Ying wrote:
> Feng Tang <feng.tang@intel.com> writes:
> 
> > On Mon, Jul 06, 2020 at 06:34:34AM -0700, Andi Kleen wrote:
> >> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> >> > -	if (ret == 0 && write)
> >> > +	if (ret == 0 && write) {
> >> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> >> > +			schedule_on_each_cpu(sync_overcommit_as);
> >> 
> >> The schedule_on_each_cpu is not atomic, so the problem could still happen
> >> in that window.
> >> 
> >> I think it may be ok if it eventually resolves, but certainly needs
> >> a comment explaining it. Can you do some stress testing toggling the
> >> policy all the time on different CPUs and running the test on
> >> other CPUs and see if the test fails?
> >
> > For the raw test case reported by 0day, this patch passed in 200 times
> > run. And I will read the ltp code and try stress testing it as you
> > suggested.
> >
> >
> >> The other alternative would be to define some intermediate state
> >> for the sysctl variable and only switch to never once the schedule_on_each_cpu
> >> returned. But that's more complexity.
> >
> > One thought I had is to put this schedule_on_each_cpu() before
> > the proc_dointvec_minmax() to do the sync before sysctl_overcommit_memory
> > is really changed. But the window still exists, as the batch is
> > still the larger one. 
> 
> Can we change the batch firstly, then sync the global counter, finally
> change the overcommit policy?

These reorderings are really head scratching :)

I've thought about this before when Qian Cai first reported the warning
message, as kernel had a check: 

	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
			-(s64)vm_committed_as_batch * num_online_cpus(),
			"memory commitment underflow");

If the batch is decreased first, the warning will be easier/earlier to be
triggered, so I didn't brought this up when handling the warning message.

But it might work now, as the warning has been removed.

Thanks,
Feng



