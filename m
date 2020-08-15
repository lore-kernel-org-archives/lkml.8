Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540EFC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C4D1205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgHOWKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:10:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:40989 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgHOWKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:12 -0400
IronPort-SDR: gv3mEkCv6tYwT1VdKj8/7yq+A+vzvlz1M9eKIk7XkdWPk21w+Z2qxoTzWdwnfdozSrnR5Za8cb
 TsCQ+sRuPBWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="142150815"
X-IronPort-AV: E=Sophos;i="5.76,316,1592895600"; 
   d="scan'208";a="142150815"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2020 05:48:41 -0700
IronPort-SDR: Ida5F9v1M5Pd+SNeHkfOib7YrT84GrHz32jp6JY/tIEwC+nNhpqBKYFo9ytJTEuNjkBzUB4xEh
 7zQlqCys45AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,316,1592895600"; 
   d="scan'208";a="333651251"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Aug 2020 05:48:36 -0700
Date:   Sat, 15 Aug 2020 20:45:47 +0800
From:   Philip Li <philip.li@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Pekka Enberg <penberg@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [mm] 3e38e0aaca:
 WARNING:at_mm/memcontrol.c:#mem_cgroup_alloc
Message-ID: <20200815124547.GA21072@intel.com>
References: <20200814141327.GJ7488@shao2-debian>
 <CAHk-=wj8oc=wCvqcMdpKM8cceEYmicpf++rNDWC_5A6qYDP9QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj8oc=wCvqcMdpKM8cceEYmicpf++rNDWC_5A6qYDP9QQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:00:44AM -0700, Linus Torvalds wrote:
> On Fri, Aug 14, 2020 at 7:14 AM kernel test robot <lkp@intel.com> wrote:
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 3e38e0aaca9eafb12b1c4b731d1c10975cbe7974 ("mm: memcg: charge memcg percpu memory to the parent cgroup")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> This should have already been fixed by commit 9f457179244a ("mm:
> memcontrol: fix warning when allocating the root cgroup").
Thanks Linus for this info, usually the test bot checks the head
of fbc's branch to validate the bisection. If the head fixes
the issue, the bot shall not send out such fbc report. We will
double check this bisection process to resolve any logical issue.

> 
> But I forget what the syntax is to report that to the kernel test
> robot. Would it be possible for lkp automatically look for "Fixes:"
> tags, perhaps?
Got it, we will investigate this which should be quite helpful, e.g. if
we want to check whether an upstream commit had fixes in other
repo like linux-next.

Thanks

> 
>                  Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
