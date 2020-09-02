Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D32C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105D720684
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIBRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:23:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBRXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:23:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46621045;
        Wed,  2 Sep 2020 10:23:35 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E05F3F66F;
        Wed,  2 Sep 2020 10:23:32 -0700 (PDT)
Date:   Wed, 2 Sep 2020 18:23:30 +0100
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
Message-ID: <20200902172330.GB1002@C02TD0UTHF1T.local>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200901140208.GA95447@C02TD0UTHF1T.local>
 <20200901144641.GA28580@lst.de>
 <20200901145442.GC95447@C02TD0UTHF1T.local>
 <20200901150553.GA30034@lst.de>
 <20200901154629.GA882@lst.de>
 <20200902114348.GA1002@C02TD0UTHF1T.local>
 <20200902133231.GA32133@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902133231.GA32133@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 03:32:31PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 02, 2020 at 12:43:48PM +0100, Mark Rutland wrote:
> > I'll see what I can do.
> > 
> > At first glance it looks like we might need to flesh out or refactor the
> > arm64 kernel maccess routines first (since we want the user maccess
> > routines to use LDTR/STTR instructions that can't access kernel memory),
> > but after that I think the rest is largely mechanical.
> 
> Yes, the first thing is to implement __get_kernel_nofaul and
> __put_kernel_nofault.  I think they should mostly look like the existing
> non-UAO versions of get_user and put_user with a fixed address space
> limit.

I've pushed an initial/incomplete/WIP stab (just the kernel accessors)
to:

https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/set_fs-removal

... and doing that made it clear that the necessary arm64 rework is a
bit more fractal than I thought (e.g. SDEI bits), so it might be a short
while before I post a series.

It might be handy to have a stable branch with the common bits so that
the arm64 rework could go via the arm64 tree in case there's any
fallout.

Thanks for all of this!

Mark.
