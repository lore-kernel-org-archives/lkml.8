Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFC8C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3BB2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXCTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:19:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:28260 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXCTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:19:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 18:19:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="435762537"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2020 18:19:16 -0800
Date:   Mon, 24 Feb 2020 10:19:15 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
Message-ID: <20200224021915.GC5061@shbuild999.sh.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com>
 <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 05:06:33PM -0800, Linus Torvalds wrote:
 
> >      ffffffff8225b580 d types__ptrace
> >      ffffffff8225b5c0 D root_user
> >      ffffffff8225b680 D init_user_ns
> 
> I'm assuming this is after the alignment patch (since that's 64-byte
> aligned there).
> 
> What was it without the alignment?

For 5.0-rc6: 
	ffffffff8225b4c0 d types__ptrace
	ffffffff8225b4e0 D root_user
	ffffffff8225b580 D init_user_ns

For 5.0-rc6 + 81ec3f3c4c4
	ffffffff8225b580 d types__ptrace
	ffffffff8225b5a0 D root_user
	ffffffff8225b640 D init_user_ns

The sigpending and __count are in the same cachline.

> 
> > No, it's not the biggest, I tried another machine 'Xeon Phi(TM) CPU 7295',
> > which has 72C/288T, and the regression is not seen. This is the part
> > confusing me :)
> 
> Hmm.
> 
> Humor me - what  happens if you turn off SMT on that Cascade Lake
> system?  Maybe it's about the thread ID bit in the L1? Although again,
> I'd have expected things to get _worse_ if it's the two fields that
> are now in the same cachline thanks to alignment.

I'll try it and report back.
 
> The Xeon Phi is the small-core setup, right? They may be slow enough
> to not show the issue as clearly despite having more cores. And it
> wouldn't show effects of some out-of-order speculative cache accesses.

Yes, seems the Xeon Phi is using 72 Silvermont cores. And the less bigger
platform I tested was a 2 sockets 48C/96T Cascadelake platform which
doesn't reproduce the regression.

Thanks,
Feng
