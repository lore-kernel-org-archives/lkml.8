Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7EC2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGFBnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:43:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:11124 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgGFBnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:43:18 -0400
IronPort-SDR: ag5V6HbAViY+CkPJE665DDz4HzcJljPD8RH9PfPy42LA7Y3zNr8VzgSd3fVP1NPP2CQ39eAtP5
 1iotGj1Of5Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="134803047"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="134803047"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 18:43:18 -0700
IronPort-SDR: tI7NthIGo8GW+RU/lbxxRFrecLwMUGm2L4cRXYSupUl97TkEau6NhFp69DN4TjqiQNOs1/RH0Z
 uTeZY0DjHPrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="296850630"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2020 18:43:13 -0700
Date:   Mon, 6 Jul 2020 09:43:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200706014313.GB66252@shbuild999.sh.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705155232.GA608@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 11:52:32AM -0400, Qian Cai wrote:
> On Sun, Jul 05, 2020 at 08:58:54PM +0800, Feng Tang wrote:
> > On Sun, Jul 05, 2020 at 08:15:03AM -0400, Qian Cai wrote:
> > > 
> > > 
> > > > On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
> > > > 
> > > > I did reproduce the problem, and from the debugging, this should
> > > > be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
> > > > that loosing the batch cause some accuracy problem, and the solution of
> > > > adding some sync is still needed, which is dicussed in
> > > 
> > > Well, before taking any of those patches now to fix the regression,
> > > we will need some performance data first. If it turned out the
> > > original performance gain is no longer relevant anymore due to this
> > > regression fix on top, it is best to drop this patchset and restore
> > > that VM_WARN_ONCE, so you can retry later once you found a better
> > > way to optimize.
> > 
> > The fix of adding sync only happens when the memory policy is being
> > changed to OVERCOMMIT_NEVER, which is not a frequent operation in
> > normal cases.
> > 
> > For the performance improvment data both in commit log and 0day report
> > https://lore.kernel.org/lkml/20200622132548.GS5535@shao2-debian/
> > it is for the will-it-scale's mmap testcase, which will not runtime
> > change memory overcommit policy, so the data should be still valid
> > with this fix.
> 
> Well, I would expect people are perfectly reasonable to use
> OVERCOMMIT_NEVER for some workloads making it more frequent operations.

In my last email, I was not saying OVERCOMMIT_NEVER is not a normal case,
but I don't think user will too frequently runtime change the overcommit
policy. And the fix patch of syncing 'vm_committed_as' is only called when
user calls 'sysctl -w vm.overcommit_memory=2'.

> The question is now if any of those regression fixes would now regress
> performance of OVERCOMMIT_NEVER workloads or just in-par with the data
> before the patchset?

For the original patchset, it keeps vm_committed_as unchanged for
OVERCOMMIT_NEVER policy and enlarge it for the other 2 loose policies
OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS, and I don't expect the "OVERCOMMIT_NEVER
workloads" performance  will be impacted. If you have suggetions for this
kind of benchmarks, I can test them to better verify the patchset, thanks!

- Feng

> 
> Given now this patchset has had so much churn recently, I would think
> "should be still valid" is not really the answer we are looking for.
> 
> > 
> > Thanks,
> > Feng
> > 
> > 
