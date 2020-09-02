Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D07F20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIBLoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:44:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBLoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:44:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA18D6E;
        Wed,  2 Sep 2020 04:44:01 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81B383F66F;
        Wed,  2 Sep 2020 04:43:58 -0700 (PDT)
Date:   Wed, 2 Sep 2020 12:43:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200902114348.GA1002@C02TD0UTHF1T.local>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200901140208.GA95447@C02TD0UTHF1T.local>
 <20200901144641.GA28580@lst.de>
 <20200901145442.GC95447@C02TD0UTHF1T.local>
 <20200901150553.GA30034@lst.de>
 <20200901154629.GA882@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901154629.GA882@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:46:29PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 01, 2020 at 05:05:53PM +0200, Christoph Hellwig wrote:
> > > Is there anything in particular that's tricky, or do you just want
> > > someone to look generally? From a quick grep arch/arm64/* looks clean, but
> > > I suspect that's misleading.
> > 
> > Yes, it should be mostly trivial.  I just bet the maintainers are
> > better at optimizing the low-level assembly code with the variable
> > address limit gone than I am.  (See Linus comments on the x86 version
> > for example).  And I don't have a physical arm64 to test with so I'd
> > have to rely on qemu for any testing.

Makes sense.

I'll take a look if Will doesn't beat me to it, and I'm happy to test
the result regardless.

> So I looked at the arm64 code and I don't think it is entirely trivial,
> due to the orig_addr_limit saving in the syscall entry path, and due
> to all the UAO stuff.  On the plus side it looks to me like
> CONFIG_ARM64_UAO and all the code relate to it can go away entirely
> if set_fs() is gone.

I *think* removing that should be largely mechanical for someone
for someone familiar with it, and it'd be nice to see it go.

> So if I can trick you guys into submiting a patch on top of:
> 
>    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-removal
> 
> that would make my life a lot simpler.

I'll see what I can do.

At first glance it looks like we might need to flesh out or refactor the
arm64 kernel maccess routines first (since we want the user maccess
routines to use LDTR/STTR instructions that can't access kernel memory),
but after that I think the rest is largely mechanical.

Mark.
