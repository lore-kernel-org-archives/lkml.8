Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F381C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063F720684
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgIAOE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:04:56 -0400
Received: from foss.arm.com ([217.140.110.172]:41984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgIAOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:02:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AACA1045;
        Tue,  1 Sep 2020 07:02:20 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.10.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853903F66F;
        Tue,  1 Sep 2020 07:02:17 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:02:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901140208.GA95447@C02TD0UTHF1T.local>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:50:06AM -0500, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
> 
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
> 
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
> 
> Remove all existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing.
> 
> barrier_nospec() is now unused, and can be removed.

One thing to consider is whether you need a speculation barrier after
set_fs(). Otherwise for code like:

| fs = get_fs();
| if (cond)
|	set_fs(KERNEL_DS);
| copy_to_user(...)
| set_fs(fs)

... the set_fs() can occur speculatively, and may be able to satisfy
the masking logic if forwarded within the cpu.

See arm64 commit:

  c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use of the current addr_limit")

Thanks,
Mark.
