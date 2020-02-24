Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C39FC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB32B20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBXAdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:33:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:4472 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXAdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:33:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 16:33:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="230972832"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2020 16:33:02 -0800
Date:   Mon, 24 Feb 2020 08:33:01 +0800
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
Message-ID: <20200224003301.GA5061@shbuild999.sh.intel.com>
References: <20200205123216.GO12867@shao2-debian>
 <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com>
 <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sun, Feb 23, 2020 at 09:37:06AM -0800, Linus Torvalds wrote:
> On Sun, Feb 23, 2020 at 6:11 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > I tried to use perf-c2c on one platform (not the one that show
> > the 5.5% regression), and found the main "hitm" points to the
> > "root_user" global data, as there is a task for each CPU doing
> > the signal stress test, and both __sigqueue_alloc() and
> > __sigqueue_free() will call get_user() and free_uid() to inc/dec
> > this root_user's refcount.
> 
> What's around it for you?
> 
> There might be that 'uidhash_lock' spinlock right next to it, and
> maybe that exacerbates the issue?

The system map shows:

	ffffffff8225b520 d __syscall_meta__ptrace
	ffffffff8225b560 d args__ptrace
	ffffffff8225b580 d types__ptrace
	ffffffff8225b5c0 D root_user
	ffffffff8225b680 D init_user_ns
	ffffffff8225b880 d ratelimit_state.56624
	ffffffff8225b8c0 d event_exit__sigsuspend

I also searched the uidhack_lock, 
	ffffffff82b04c80 b uidhash_lock
 
> > Then I added some alignement inside struct "user_struct" (for
> > "root_user"), then the -5.5% is gone, with a +2.6% instead.
> 
> Do you actually need to align things inside the struct, or is it
> sufficient to just align the structure itself?

Initially I justed add the ____cacheline_aligned after the definition
of struct 'user_struct', which only makes the following 'init_user_ns'
aligned, and test result doesn't show much change.

Then I added
	
	 struct user_struct {
	 +       char dummy[0] ____cacheline_aligned;

to make 'root_user' itself aligned. 


> IOW, is the cache conflicts _within_ the user_struct itself, or is it
> with some nearby data (like that uidhash_lock or whatever?)

From the perf c2c data, and the source code checking, the conflicts
only happens for root_user.__count, and root_user.sigpending, as
all running tasks are accessing this global data for get/put and
other operations.

> > One thing I don't understand is, this -5.5% only happens in
> > one 2 sockets, 96C/192T Cascadelake platform, as we've run
> > the same test on several different platforms. In therory,
> > the false sharing may also take effect?
> 
> Is that the biggest machine you have access to?
> 
> Maybe it just isn't noticeable with smaller core counts. A lot of
> conflict loads tend to have "exponential" behavior - when things get
> overloaded, performance plummets because it just makes things worse as
> everybody gets slower at that contention point and now it gets even
> more contended...

No, it's not the biggest, I tried another machine 'Xeon Phi(TM) CPU 7295',
which has 72C/288T, and the regression is not seen. This is the part
confusing me :)

Also I've tried to limit the concurrent task number from 192 to 96/48/24/6/1,
and the regression number did get smaller following the task decrease. 

Thanks,
Feng
 
>              Linus
