Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5467EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD47206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591316681;
	bh=mdqRpyRzRhFj4mKG7HsIVWexcD/UT90uTpSNsdJPuwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMRPtlPOfZ6++0xW+mVjdLxGHOtV5eZhWeCpIyfFuUuSXnHkA5a19ZwISY+jExOR6
	 NYc5vDfWFosTwywCtVLTG66qdz83aac0irCCeOjBkBOc4u87DKb0FtM/R24ri1IUtT
	 gDIJpqi242Wrn+TPX+BqSCWbu7PT3BJN0lLLUbm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFEAYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgFEAYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:24:40 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BDC206A2;
        Fri,  5 Jun 2020 00:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591316679;
        bh=mdqRpyRzRhFj4mKG7HsIVWexcD/UT90uTpSNsdJPuwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L215KL500TjgPhYb1Q0IQJKuxcmCFrb1XZf1UmDBT0+xUOMSzQRkcpwpSLk5buV1y
         yd1zmpGbpseNnrrPR9NUte72tcA5f9F4ywZxMb6EIQhkHvVovYGDYIpy9/DdR5eTHd
         UNR63vQSO238FYf4jmDS03PFxH8a96j+1S5ASHS4=
Date:   Thu, 4 Jun 2020 17:24:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200605002433.GA148196@sol.localdomain>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604141837.GA179816@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
> On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> > The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> > got smp_call_function_single_async() subtly wrong. Even though it will
> > return -EBUSY when trying to re-use a csd, that condition is not
> > atomic and still requires external serialization.
> > 
> > The change in ttwu_queue_remote() got this wrong.
> > 
> > While on first reading ttwu_queue_remote() has an atomic test-and-set
> > that appears to serialize the use, the matching 'release' is not in
> > the right place to actually guarantee this serialization.
> > 
> > The actual race is vs the sched_ttwu_pending() call in the idle loop;
> > that can run the wakeup-list without consuming the CSD.
> > 
> > Instead of trying to chain the lists, merge them.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> ...
> > +	/*
> > +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> > +	 * for task_struct to be on the @call_single_queue.
> > +	 */
> > +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> > +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> > +
> 
> There is no guarantee in C that
> 
> 	type1 a;
> 	type2 b;
> 
> in two different data structures means that offsetof(b) - offsetof(a)
> is the same in both data structures unless attributes such as
> __attribute__((__packed__)) are used.
> 
> As result, this does and will cause a variety of build errors depending
> on the compiler version and compile flags.
> 
> Guenter

Yep, this breaks the build for me.

  CC      kernel/smp.o
In file included from ./arch/x86/include/asm/atomic.h:5,
                 from ./include/linux/atomic.h:7,
                 from ./include/linux/llist.h:51,
                 from ./include/linux/irq_work.h:5,
                 from kernel/smp.c:10:
kernel/smp.c: In function ‘smp_init’:
./include/linux/compiler.h:403:38: error: call to ‘__compiletime_assert_68’ declared with attribute error: BUILD_BUG_ON failed: offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) != offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist)
  403 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                      ^
./include/linux/compiler.h:384:4: note: in definition of macro ‘__compiletime_assert’
  384 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:403:2: note: in expansion of macro ‘_compiletime_assert’
  403 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro ‘compiletime_assert’
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
kernel/smp.c:687:2: note: in expansion of macro ‘BUILD_BUG_ON’
  687 |  BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
      |  ^~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:267: kernel/smp.o] Error 1
make: *** [Makefile:1735: kernel] Error 2
