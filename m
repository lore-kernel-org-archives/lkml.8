Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9CCC54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2393206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgELOPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:15:45 -0400
Received: from foss.arm.com ([217.140.110.172]:55872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgELOPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:15:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B69A530E;
        Tue, 12 May 2020 07:15:42 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DBB263F71E;
        Tue, 12 May 2020 07:15:41 -0700 (PDT)
Date:   Tue, 12 May 2020 15:15:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200512141535.GA14943@gaia>
References: <20200507171607.GD3180@gaia>
 <40B2408F-05DD-4A82-BF97-372EA09FA873@lca.pw>
 <20200509094455.GA4351@gaia>
 <3F734E14-8E37-4967-B080-A25D0C58199C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F734E14-8E37-4967-B080-A25D0C58199C@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 05:27:41PM -0400, Qian Cai wrote:
> On May 9, 2020, at 5:44 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, May 07, 2020 at 01:29:04PM -0400, Qian Cai wrote:
> >> On May 7, 2020, at 1:16 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >>> I don't mind adding additional tracking info if it helps with debugging.
> >>> But if it's for improving false positives, I'd prefer to look deeper
> >>> into figure out why the pointer reference graph tracking failed.
> >> 
> >> No, the task struct leaks are real leaks. It is just painful to figure
> >> out the missing or misplaced put_task_struct() from the kmemleak
> >> reports at the moment.
> > 
> > We could log the callers to get_task_struct() and put_task_struct(),
> > something like __builtin_return_address(0) (how does this work if the
> > function is inlined?). If it's not the full backtrace, it shouldn't slow
> > down kmemleak considerably. I don't think it's worth logging only the
> > first/last calls to get/put. You'd hope that put is called in reverse
> > order to get.
> > 
> > I think it may be better if this is added as a new allocation pointed to
> > from kmemleak_object rather than increasing this structure since it will
> > be added on a case by case basis. When dumping the leak information, it
> > would also dump the get/put calls, in the order they were called. We
> > could add some simple refcount tracking (++ for get, -- for put) to
> > easily notice any imbalance.
> > 
> > I'm pretty busy next week but happy to review if you have a patch ;).
> 
> I am still thinking about a more generic way for all those
> refcount-based leaks without needing of manual annotation of all those
> places. Today, I had another one,
> 
> unreferenced object 0xe6ff008924f28500 (size 128):
>   comm "qemu-kvm", pid 4835, jiffies 4295141828 (age 6944.120s)
>   hex dump (first 32 bytes):
>     01 00 00 00 6b 6b 6b 6b 00 00 00 00 ad 4e ad de  ....kkkk.....N..
>     ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
>   backtrace:
>     [<000000005ed1a868>] slab_post_alloc_hook+0x74/0x9c
>     [<00000000c65ee7dc>] kmem_cache_alloc_trace+0x2b4/0x3d4
>     [<000000009efa9e6e>] do_eventfd+0x54/0x1ac
>     [<000000001146e724>] __arm64_sys_eventfd2+0x34/0x44
>     [<0000000096fc3a61>] do_el0_svc+0x128/0x1dc
>     [<000000005ae8f980>] el0_sync_handler+0xd0/0x268
>     [<0000000043f2c790>] el0_sync+0x164/0x180
> 
> That is eventfd_ctx_fileget() / eventfd_ctx_put() pairs.

In this case it uses kref_get() to increment the refcount. We could add
a kmemleak_add_trace() which allocates a new array and stores the stack
trace, linked to the original object. Similarly for kref_put().

If we do this for each inc/dec call, I'd leave it off as default and
only enable it explicitly by cmdline argument or
/sys/kerne/debug/kmemleak when needed. In most cases you'd hope there is
no leak, so no point in tracking additional metadata. But if you do hit
a problem, just enable the additional tracking to help with the
debugging.

-- 
Catalin
