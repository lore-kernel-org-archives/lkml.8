Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20823C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0311206F2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgIDQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:00:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIDQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:00:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB5B113E;
        Fri,  4 Sep 2020 09:00:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.8.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F0A23F66F;
        Fri,  4 Sep 2020 09:00:14 -0700 (PDT)
Date:   Fri, 4 Sep 2020 17:00:06 +0100
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
Message-ID: <20200904160006.GA21956@C02TD0UTHF1T.local>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200901140208.GA95447@C02TD0UTHF1T.local>
 <20200901144641.GA28580@lst.de>
 <20200901145442.GC95447@C02TD0UTHF1T.local>
 <20200901150553.GA30034@lst.de>
 <20200901154629.GA882@lst.de>
 <20200902114348.GA1002@C02TD0UTHF1T.local>
 <20200902133231.GA32133@lst.de>
 <20200902172330.GB1002@C02TD0UTHF1T.local>
 <20200903065613.GA18731@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903065613.GA18731@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:56:13AM +0200, Christoph Hellwig wrote:
> On Wed, Sep 02, 2020 at 06:23:30PM +0100, Mark Rutland wrote:
> > I've pushed an initial/incomplete/WIP stab (just the kernel accessors)
> > to:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/set_fs-removal
> 
> Thanks!
> 
> > ... and doing that made it clear that the necessary arm64 rework is a
> > bit more fractal than I thought (e.g. SDEI bits), so it might be a short
> > while before I post a series.
> 
> SDEI is just forcing back a KERNEL_DS to a normal USER_DS, isn't it?
 
It's a bit more involved -- we also need to fiddle with some HW state
(PSTATE.PAN, PSTATE.UAO, and TTBR0 for SW_PAN) because SDEI isn't a real
exception, so we have to simulate what HW (or the usual exception code)
does for exception entry/return.

It's simple enough to handle, but requires some refactoring as we now
rely on force_uaccess_{begin,end}() having those HW side-effects. I'll
probably factor that out into new arm64-specific helpers for simulating
exception entry/return (which we used to open-code) since it's the only
special case and that'll be clearer than repurposing generic helpers to
do so.

> > It might be handy to have a stable branch with the common bits so that
> > the arm64 rework could go via the arm64 tree in case there's any
> > fallout.
> 
> The series will need at least one more repost, but hopefully I'll have
> s stable branch soon.

I'll keep an eye out!

Mark.
