Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918772068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 08:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgFOIeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 04:34:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:1590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgFOIeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:34:03 -0400
IronPort-SDR: lAullL/FbvO+TsCEL8v9QCxnA0sCmQGqtUY95hb90btF4mjhXzst0vC2y1KGFk/Sx9+c1yZmiA
 xWp56ZsjN4AQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 01:34:03 -0700
IronPort-SDR: 3aDVkJB6ADSz49M5mWcKTOkpfYjmO9ZBmLCDtKQ1/Uc3dcUfFAL+vxEkPHmSRmCjQhxSATyf3f
 9aYueu8o/Ohg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382448845"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2020 01:34:00 -0700
Date:   Mon, 15 Jun 2020 16:33:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [gup] 17839856fd: stress-ng.vm-splice.ops_per_sec
 2158.6% improvement
Message-ID: <20200615083359.GC57549@shbuild999.sh.intel.com>
References: <20200611040453.GK12456@shao2-debian>
 <CAHk-=whCjhBgJv0z6JoOKMyfnBp0WhH6oa=ayuRRLtgJxOkd5Q@mail.gmail.com>
 <CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1v1b4X5LgFya6nvi33-TWwqna_dc5jGFVosqQhdn_Nkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:32:41AM +0200, Jann Horn wrote:
> On Thu, Jun 11, 2020 at 10:24 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Jun 10, 2020 at 9:05 PM kernel test robot <rong.a.chen@intel.com> wrote:
> > >
> > > FYI, we noticed a 2158.6% improvement of stress-ng.vm-splice.ops_per_sec due to commit:
> > >
> > > commit: 17839856fd588f4ab6b789f482ed3ffd7c403e1f ("gup: document and work around "COW can break either way" issue")
> >
> > Well, that is amusing, and seeing improvements is always nice, but
> > somehow I think the test is broken.
> >
> > I can't see why you'd ever see an improvement from that commit, and if
> > you do see one, not one by a factor of 20x.
> 
> FWIW, if this is the testcase:
> <https://kernel.ubuntu.com/git/cking/stress-ng.git/tree/stress-vm-splice.c>

Yes, functionally this is the same file as what is used by 0day, though 0day
use a stable release tar ball.

Thanks,
Feng
 
> then that testcase is essentially testing how fast vmsplice() is when
> called in a loop on an uninitialized mmap() mapping. So before that
> commit, I think it will create zeropage PTEs in the first iteration
> (and zeropage PTEs are _PAGE_SPECIAL, see do_anonymous_page()). And
> get_user_pages_fast() bails out in gup_pte_range() if pte_special().
> So that testcase was always hitting the GUP slowpath.
> But now the first iteration will force the creation of a normal RW
> PTE, so all following iterations can go through the GUP fastpath.
> 
> So in summary I guess the test was just really slow up until now
> because it was hitting a slowpath that you wouldn't hit during normal
> usage? At least for vmsplice(), writing uninitialized pages doesn't
> really make a whole lot of sense...
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
