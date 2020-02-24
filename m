Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C853C35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEAA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBXB6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:58:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:10201 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgBXB6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:58:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 17:58:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,478,1574150400"; 
   d="scan'208";a="349819289"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2020 17:58:09 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        <andi.kleen@intel.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops -5.5% regression
References: <20200205123216.GO12867@shao2-debian>
        <20200205125804.GM14879@hirez.programming.kicks-ass.net>
        <20200221080325.GA67807@shbuild999.sh.intel.com>
        <20200221132048.GE652992@krava>
        <20200223141147.GA53531@shbuild999.sh.intel.com>
        <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
        <20200224003301.GA5061@shbuild999.sh.intel.com>
        <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
Date:   Mon, 24 Feb 2020 09:58:09 +0800
In-Reply-To: <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 23 Feb 2020 17:06:33 -0800")
Message-ID: <87lfosd9vy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Feb 23, 2020 at 4:33 PM Feng Tang <feng.tang@intel.com> wrote:
>>
>> From the perf c2c data, and the source code checking, the conflicts
>> only happens for root_user.__count, and root_user.sigpending, as
>> all running tasks are accessing this global data for get/put and
>> other operations.
>
> That's odd.
>
> Why? Because those two would be guaranteed to be in the same cacheline
> _after_ you've aligned that user_struct.
>
> So if it were a false sharing issue between those two, it would
> actually get _worse_ with alignment. Those two fields are basically
> next to each other.
>
> But maybe it was straddling a cacheline before, and it caused two
> cache accesses each time?
>
> I find this as confusing as you do.
>
> If it's sigpending vs the __refcount, then we almost always change
> them together. sigpending gets incremented by __sigqueue_alloc() -
> which also does a "get_uid()", and then we decrement it in
> __sigqueue_free() - which also does a "free_uid().
>

One way to verify this is to change the layout of user_struct (or
root_user) to make __count and sigpending fields to be in 2 separate
cache lines explicitly.

Best Regards,
Huang, Ying
