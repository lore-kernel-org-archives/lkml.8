Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16D6C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99962467B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgBYEx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:53:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:17213 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbgBYEx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:53:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 20:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; 
   d="scan'208";a="255826497"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2020 20:53:50 -0800
Date:   Tue, 25 Feb 2020 12:53:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jiri Olsa <jolsa@redhat.com>,
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
Message-ID: <20200225045349.GD63065@shbuild999.sh.intel.com>
References: <20200223141147.GA53531@shbuild999.sh.intel.com>
 <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com>
 <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
 <20200224021915.GC5061@shbuild999.sh.intel.com>
 <CAHk-=wjkSb1OkiCSn_fzf2v7A=K0bNsUEeQa+06XMhTO+oQUaA@mail.gmail.com>
 <CAHk-=wifdJHrfnmwwzPpH-0X6SaZxtdmRWpSNwf8xsXD2iE4dA@mail.gmail.com>
 <CAHk-=wgbR4ocHAOiaj7x+V7dVoYr-mD2N7Y_MRPJ+Q+GohDYeg@mail.gmail.com>
 <20200225025748.GB63065@shbuild999.sh.intel.com>
 <CAHk-=wisa2xZHaCV=kh3seU-1kFDTjyWW9Ak3w5HH8nDvv7Snw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisa2xZHaCV=kh3seU-1kFDTjyWW9Ak3w5HH8nDvv7Snw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Feb 24, 2020 at 07:15:15PM -0800, Linus Torvalds wrote:
> On Mon, Feb 24, 2020 at 6:57 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > Thanks for the optimization patch for signal!
> >
> > It makes a big difference, that the performance score is tripled!
> > bump from original 17000 to 54000. Also the gap between 5.0-rc6 and
> > 5.0-rc6+Jiri's patch is reduced to around 2%.
> 
> Ok, so what I think is happening is that the exact same issue still
> exists, but now with less contention it's not quite as noticeable.

I thought that too. 

Since we have the reproducable platform, we will keep an eye on it,
and report back if anything found.

You've mentioned the patch's effect on small system in another mail,
I ran the benchmark on a 4 core Skylake desktop, and it only brought
2% performance gain, as expected.

> 
> Can you find some Intel CPU hardware person who could spend a moment
> on that odd 32-byte sub-block issue?
> 
> Considering that this effect apparently doesn't happen on any other
> platform you've tested, and this Cascade Lake platform is the newly
> released current Intel server platform, I think it's worth looking at.
 
I'll try to reach some silicon people, and get back if found anything.


> That microbenchmark is not important on its own, but the odd timing
> behaviour it has would be good to have explained.
> 
> And while the signal sending microbenchmark is not likely to be very
> relevant to much anything else, I guess I'll apply the patch. Even if
> it's just a microbenchmark, it's not like we haven't used those before
> to pinpoint some very specific behavior. We used lmbench (and whatever
> that odd page cache benchmark was) to do some fairly fundamental
> optimizations back in the days.

Thanks again for the patch.

- Feng
> 
> If you fix the details on all the microbenchmarks you find, eventually
> you probably do well on real loads too..
> 
>            Linus
