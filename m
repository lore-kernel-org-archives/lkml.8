Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C3320835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLAIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:08:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:43945 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgFLAIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:08:10 -0400
IronPort-SDR: qjxm5hOmsZlLIm/0efie+PCu+6i/007anO7Cvb15Ct0OYi5PYsbNC+mMUex/agDbFN99/dLOeo
 xrMt/vVemDYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 17:08:10 -0700
IronPort-SDR: SChgA/m6icPmV5QRr9zntSHPzlPC2L09Himj6iC2lnq0FM0aKGzhTw+6cPOyKTNjjBU7r4XKup
 sGclRox0Mjtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="448119325"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga005.jf.intel.com with ESMTP; 11 Jun 2020 17:08:06 -0700
Date:   Fri, 12 Jun 2020 08:07:32 +0800
From:   Philip Li <philip.li@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec
 2158.6% improvement
Message-ID: <20200612000732.GA23169@intel.com>
References: <20200611040453.GK12456@shao2-debian>
 <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 01:24:09PM -0700, Linus Torvalds wrote:
> On Wed, Jun 10, 2020 at 9:05 PM kernel test robot <rong.a.chen@intel.com> wrote:
> >
> > FYI, we noticed a 2158.6% improvement of stress-ng.vm-splice.ops_per_sec due to commit:
> >
> > commit: 17839856fd588f4ab6b789f482ed3ffd7c403e1f ("gup: document and work around "COW can break either way" issue")
> 
> Well, that is amusing, and seeing improvements is always nice, but
> somehow I think the test is broken.
> 
> I can't see why you'd ever see an improvement from that commit, and if
> you do see one, not one by a factor of 20x.
got it, we will double check again, that we go through the data
and it can be reproduced in our environment before sending out report.

> 
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > | testcase: change | stress-ng: stress-ng.vm-splice.ops_per_sec 372.8% improvement        |
> > | testcase: change | stress-ng: stress-ng.vm-splice.ops_per_sec 2052.7% improvement       |
> 
> Ok, so it's affecting other runs of the same test, and the smaller
> ("only" 378%) improvement seems to be just from using fewer threads.
> 
> So maybe forcing the COW ends up avoiding some very specific cache
> thrashing case.
> 
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         bin/lkp install job.yaml  # job file is attached in this email
> >         bin/lkp run     job.yaml
> 
> Is there some place where you'd actually _see_ what
> "stress-ng.vm-splice.ops_per_sec" actually means and does?
> 
> Yeah, I can go and find the actual stress-ng git repo, and take a
> look. I kind of did. But the step from your "to reproduce" to actually
> figuring out what is going on is pretty big.
> 
> It would be nice to know what it actually does - do you have a
> database of descriptions for the different tests and how to run them
> individually or anything like that?
Hi Linus, it is currently embedded in different scripts, like tests/stress-ng,
but it now depends on up level script like lkp run to call them to pass the
parameters from job.yaml. It can provide some basic information. Meanwhile
we try to generate a reproduce script for test running, I add more info
in below reply, kindly check.

> 
> IOW, rather than the above "just run all fo the lkp scripts",
> something like how to run the actual individual test would be good.
> 
> IOW how do those yaml files translate into _actually_ running the
> 'stress-ng' program?
Thanks Linus for your feedback, we will improve this to provide
more clear reproduce information.

In the attachment, there's a reproduce script with content like below,
which is another way to directly run the stress-ng. This helps to show
which parameters we are using when having this report. Would you mind to
have a look?

for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "30" "--times" "--verify" "--metrics-brief" "--sequential" "96" "--class" "pipe" "--exclude" "spawn,exec,swap"

Thanks

> 
>                 Linus
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
