Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC0AC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D0C2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDJBMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:12:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39282 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgDJBMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:12:06 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03A1BYn0032116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 21:11:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4500142013D; Thu,  9 Apr 2020 21:11:34 -0400 (EDT)
Date:   Thu, 9 Apr 2020 21:11:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-ID: <20200410011134.GG45598@mit.edu>
References: <20200409114940.GT21484@bombadil.infradead.org>
 <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
 <20200409111604.c778ff091c00fab5db095e48@linux-foundation.org>
 <CAHk-=wiU77DeNxQsU4XrDCk59asyTs=Hn+mnTx6-SHB1_fA2NQ@mail.gmail.com>
 <20200409121250.d6bba6965b86c8dfcf325fbc@linux-foundation.org>
 <CAHk-=wgy3XRiyRP7vdfF6bHwWGaB1RwyWJmyphh+Q3qYk6w27w@mail.gmail.com>
 <20200409195633.GZ21484@bombadil.infradead.org>
 <CAHk-=wi50jKXOFpsRkxrqu4upNnEKm1oRZ_SG1yJB9QVh=VJZQ@mail.gmail.com>
 <20200409202751.GA7976@gmail.com>
 <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj64Uw1O9-f=XYCraLgbqBqqBHSdyO1JG80smvC-01Nug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 01:34:18PM -0700, Linus Torvalds wrote:
> > FWIW, the issue of "syzbot report sent and ignored for months/years" is actually
> > a much broader one which applies to all bugs, not just build / test breakages.
> 
> I don't  know what to do about that, but it may be that people just
> don't judge the bugs interesting or assume that they are old.

Syzkaller bugs which requuire (a) root privileges to trigger, or (b)
require a deliberately corrupted file system are things which I don't
consider super interesting.  (For the latter, I'll usually wait for
some other file system fuzzer to find it, such as Hydra, because
Syzkaller makes it painful extract out the file system image, where as
other file system fuzzers are *much* more file system developer
friendly.)

This shouldn't be a surprise to Dmitry, because I've given these
feedbacks to him before.

It would be nice if there was some way we could triage Syzkaller bugs
into different buckets (requires root, lower to P2; requires a
corrupted file system image, lower to P2).  Unfortunately, that would
require Syzkaller to have some kind of login system and way to track
state, and Dmitry doesn't want to replicate the functionality of a bug
tracker.

> That's what made bugzilla so useless - being flooded with stale bugs
> that might not be worth worrying about, and no way to really tell.

At least with Bugzilla, it becomes possible to attach priorities and
flags to them, instead of trying to assume that developers should
treat all Syzkaller bugs as the same priority.  Because when you do
insist that all bugs be treated as high priority, many people will
just treat them *all* as a P2 bug, especially when there are so many.

      	   	       	    	       	     	- Ted
